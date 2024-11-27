<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\WithdrawRequest;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Withdraw;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class WithdrawController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //expense query
        $withdraws_query = Withdraw::query();

        if (request()->search) {
            // set date
            $date = [];
            if (request()->from_date != null) {
                $date[] = date(request()->from_date);

                if (request()->to_date != null) {
                    $date[] = date(request()->to_date);
                } else {
                    if (request()->from_date != null) {
                        $date[] = date('Y-m-d');
                    }
                }
                if (count($date) > 0) {
                    $withdraws_query = $withdraws_query->whereBetween('date', $date);
                }
            }
        }

        // get data
        $withdraws = $withdraws_query->latest()->paginate(30)->withQueryString();

        return view('pos.withdraw.index', compact('withdraws'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.withdraw.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(WithdrawRequest $request)
    {
        $data = $request->validated();

        $transactionable = null;

        // identify payment method
        if ($request->payment_method == 'cash') {
            $transactionable = Cash::find($request->transactionable_id);
        } else {
            $transactionable = BankAccount::find($request->transactionable_id);
        }

        $data['user_id'] = Auth::user()->id;

        DB::transaction(function () use ($data, $request, $transactionable) {
            $transactionable->withdraws()->create($data);
            $transactionable->decrement('balance', $request->amount);
        });

        return redirect()->back()->withSuccess('Withdraw create successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $withdraw = Withdraw::query()
            ->select('*')
            ->addPaymentMethod()
            ->findOrFail($id);
        return view('pos.withdraw.show', compact('withdraw'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        // get the specified resource
        $withdraw = Withdraw::query()
            ->select('*')
            ->with('transactionable')
            ->addPaymentMethod()
            ->findOrFail($id);
        //view
        return view('pos.withdraw.edit', compact('withdraw'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(WithdrawRequest $request, string $id)
    {
        $data = $request->validated();

        $withdraw = Withdraw::query()
            ->with('transactionable')
            ->find($id);

        $oldPaymentMethod = $withdraw->payment_method;

        if ($oldPaymentMethod == $request->payment_method) {
            // Same payment method
            $diff = $withdraw->amount - $request->amount;

            DB::transaction(function () use ($diff, $withdraw, $data) {
                $withdraw->transactionable->increment('balance', $diff);
                $withdraw->update($data);
            });
        } else {
            // Different payment method
            DB::transaction(function () use ($withdraw, $request, $data) {
                $withdraw->transactionable->increment('balance', $withdraw->amount);

                if ($request->payment_method == 'cash') {
                    $transactionable = Cash::find($request->transactionable_id);
                } else {
                    $transactionable = BankAccount::find($request->transactionable_id);
                }

                $transactionable->decrement('balance', $request->amount);

                $withdraw->update($data + [
                    // 'payment_method' => $request->payment_method,
                    'transactionable_type' => $transactionable->getMorphClass(),
                    'transactionable_id' => $transactionable->id,
                ]);
            });
        }

        return redirect()
            ->back()
            ->with('success', 'Withdraw updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $withdraw = Withdraw::query()
            ->with('transactionable')
            ->find($id);

        // restore balance
        // $withdraw->transactionable->increment('balance', $withdraw->amount);

        $withdraw->delete();

        return back()->with('success', 'Withdraw deleted successfully.');
    }


    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $withdraws = Withdraw::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.withdraw.trash', compact('withdraws'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Withdraw::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Withdraw restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $withdraw = Withdraw::withTrashed()->findOrFail($id);
        // restore balance
        $withdraw->transactionable->increment('balance', $withdraw->amount);
        $withdraw->forceDelete();

        return redirect()->back()->withSuccess('Withdraw deleted permanently.');
    }
}
