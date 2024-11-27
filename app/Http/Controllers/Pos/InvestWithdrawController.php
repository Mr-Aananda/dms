<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\InvestWithdrawRequest;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Invest;
use App\Models\InvestWithdraw;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class InvestWithdrawController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(InvestWithdrawRequest $request)
    {
        $data = $request->validated();
        $user_id = Auth::user()->id;

        // Identify payment method
        $transactionable = ($request->payment_method == 'cash') ? Cash::find($request->transactionable_id) : BankAccount::find($request->transactionable_id);

        DB::transaction(function () use ($request, $data, $user_id, $transactionable) {
            $previousInvest = Invest::findOrFail($request->invest_id);

            // Update investment amount and transactionable balance based on request type
            switch ($request->type) {
                case "profit_addition":
                    $previousInvest->increment('amount', $request->amount);
                    // $transactionable->decrement('balance', $request->amount);
                    break;
                case "invest_withdraw":
                    $previousInvest->decrement('amount', $request->amount);
                    $transactionable->decrement('balance', $request->amount);
                    break;
                case "profit_withdraw":
                    $transactionable->decrement('balance', $request->amount);
                    break;
            }

            // Update previousInvest with profit and profit_type if present in request
            if ($request->has('profit') && $request->has('profit_type')) {
                $previousInvest->update([
                    'profit' => $request->profit,
                    'profit_type' => $request->profit_type,
                ]);
            }

            // Create invest withdraw record
            $transactionable->investWithdraws()->create(array_merge($data, ['user_id' => $user_id]));
        });

        return redirect()->back()->withSuccess('Data created successfully.');
    }


    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $investWithdraw = InvestWithdraw::query()
            ->select('*')
            ->with('transactionable')
            ->addPaymentMethod()
            ->findOrFail($id);
        return view('pos.investment.withdraw.edit', compact('investWithdraw'));

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $investWithdraw = InvestWithdraw::with('transactionable')->findOrFail($id); // Retrieve the invest withdraw record

        $data = $request->validated();
        $user_id = Auth::user()->id;

        // Identify payment method
        $transactionable = ($request->payment_method == 'cash') ? Cash::find($request->transactionable_id) : BankAccount::find($request->transactionable_id);

        DB::transaction(function () use ($request, $data, $user_id, $transactionable, $investWithdraw) {
            $previousInvest = Invest::findOrFail($request->invest_id);

            // Update investment amount and transactionable balance based on request type
            switch ($request->type) {
                case "profit_addition":
                    $previousInvest->decrement('amount', $investWithdraw->amount);
                    $previousInvest->increment('amount', $request->amount);
                    // $transactionable->increment('balance', $investWithdraw->amount);
                    // $transactionable->decrement('balance', $request->amount);
                    break;
                case "invest_withdraw":
                    $previousInvest->increment('amount', $investWithdraw->amount);
                    $previousInvest->decrement('amount', $request->amount);
                    $transactionable->increment('balance', $investWithdraw->amount);
                    $transactionable->decrement('balance', $request->amount);
                    break;
                case "profit_withdraw":
                    $transactionable->increment('balance', $investWithdraw->amount);
                    $transactionable->decrement('balance', $request->amount);
                    break;
            }

            // Update previousInvest with profit and profit_type if present in request
            if ($request->has('profit') && $request->has('profit_type')) {
                $previousInvest->update([
                    'profit' => $request->profit,
                    'profit_type' => $request->profit_type,
                ]);
            }

            // Update invest withdraw record
            $investWithdraw->update(array_merge($data, ['user_id' => $user_id]));
        });

        return redirect()->back()->withSuccess('Data updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $investWithdraw = InvestWithdraw::query()
            ->with('transactionable')
            ->find($id);; // Retrieve the invest withdraw record

            $previousInvest = Invest::findOrFail($investWithdraw->invest_id);

            // Identify payment method
            if ($investWithdraw->transactionable_type === Cash::class) {
                $transactionable = Cash::find($investWithdraw->transactionable_id);
            } elseif ($investWithdraw->transactionable_type === BankAccount::class) {
                $transactionable = BankAccount::find($investWithdraw->transactionable_id);
            } else {
                throw new \Exception("Unsupported transactionable type: {$investWithdraw->transactionable_type}");
            }
            // dd($transactionable);

            DB::transaction(function () use ($investWithdraw, $previousInvest, $transactionable) {
                if ($previousInvest) {
                    switch ($investWithdraw->type) {
                        case "profit_addition":
                            $previousInvest->decrement('amount', $investWithdraw->amount);
                            break;
                        case "invest_withdraw":
                            $previousInvest->increment('amount', $investWithdraw->amount);
                            break;
                    }
                }

                if ($transactionable) {
                    switch ($investWithdraw->type) {
                        case "profit_addition":
                            // $transactionable->increment('balance', $investWithdraw->amount);
                            $transactionable->increment('balance', 0);
                            break;
                        case "invest_withdraw":
                            $transactionable->increment('balance', $investWithdraw->amount);
                            break;
                        case "profit_withdraw":
                            $transactionable->increment('balance', $investWithdraw->amount);
                            break;
                    }
                }

                // $investWithdraw->delete(); // Delete the invest withdraw record
                $investWithdraw->forceDelete();
            });

            return redirect()->back()->withSuccess('Data deleted successfully.');
        } catch (\Exception $e) {
            // Handle the exception (e.g., log, display error message)
            return redirect()->back()->withErrors('Error occurred while deleting data.');
        }
    }
}
