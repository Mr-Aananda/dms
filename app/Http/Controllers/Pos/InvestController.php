<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\InvestRequest;
use App\Models\BankAccount;
use App\Models\Branch;
use App\Models\Cash;
use App\Models\Invest;
use App\Models\Investor;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class InvestController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $invests = Invest::query();

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
                    $invests = $invests->whereBetween('date', $date);
                }
            }
        }
        if (request('investor_id')) {
            $invests->where('investor_id', request('investor_id'));
        }

        $invests = $invests
            ->withCount('investWithdraws')
            ->addInvestorName()
            ->addPaymentMethod()
            ->latest()
            ->paginate(30)
            ->withQueryString();

        $investors = Investor::select('id', 'name')->get();

        return view('pos.investment.invest.index', compact('invests', 'investors'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $investors = Investor::query()
            ->orderBy('name')
            ->get();
        $branches = Branch::select('id', 'name')->where('active', 1)->get();
        return view('pos.investment.invest.create', compact('investors', 'branches'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(InvestRequest $request)
    {
        // return $request->all();
        $data = $request->validated();
        $transactionable = null;

        // identify payment method
        if ($request->payment_method == 'cash') {
            $transactionable = Cash::find($request->transactionable_id);
        } else {
            $transactionable = BankAccount::find($request->transactionable_id);
        }

        $data['user_id'] = Auth::user()->id;
        $data['profit'] = $request->profit ?? 0;

        DB::transaction(function () use ($data, $request, $transactionable) {
            // Increment the balance of the transactionable entity (Cash or BankAccount)
            $transactionable->increment('balance', $data['amount']);

            // Create the invest record
            $investment = $transactionable->invests()->create($data);

            // Increment the investor's balance
            $investor = Investor::find($request->investor_id); // Assuming you have an Investor model
            $investor->balance += $data['amount']; // Assuming 'amount' is the field representing the investment amount
            $investor->save();
        });

        return redirect()->route("invest.index")->with('success', 'Invest created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        // get the specified resource
        $invest = Invest::query()
                ->with([
                    'investWithdraws' => function (HasMany $query) {
                        $query->select('*')
                            ->addPaymentMethod()
                            ->latest();
                    },
                    'investWithdraws.transactionable',
                    'investor',
                ])
            ->addInvestorName()
            ->addPaymentMethod()
            ->findOrFail($id);
        return view('pos.investment.invest.show', compact('invest'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        // get the specified resource
        $invest = Invest::query()
            ->select('*')
            ->with('transactionable')
            ->addPaymentMethod()
            ->findOrFail($id);
        $investors = Investor::query()
            ->orderBy('name')
            ->get();
        $branches = Branch::select('id', 'name')->where('active', 1)->get();
        return view('pos.investment.invest.edit', compact('investors', 'invest', 'branches'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(InvestRequest $request, string $id)
    {
        // return $request->all();
        $data = $request->validated();
        $invest = Invest::query()
            ->with('transactionable')
            ->find($id);

        $oldPaymentMethod = $invest->payment_method;
        if ($oldPaymentMethod == $request->payment_method) {
            // Same payment method
            $diff = $invest->amount - $request->amount;

            DB::transaction(function () use ($diff, $invest, $data) {
                // adjust the balance
                $invest->transactionable->increment('balance', $diff);
                // update invest
                $invest->update($data);
            });
        } else {
            // payment method is not same
            DB::transaction(function () use ($invest, $request, $data) {
                $invest->transactionable->decrement('balance', $invest->amount);

                if ($request->payment_method == 'cash') {
                    $transactionable = Cash::find($request->transactionable_id);
                } else {
                    $transactionable = BankAccount::find($request->transactionable_id);
                }

                $transactionable->increment('balance', $request->amount);

                $invest->update($data + [
                    'payment_method' => $request->payment_method,
                    'transactionable_type' => $transactionable->getMorphClass(),
                    'transactionable_id' => $transactionable->id,
                ]);
            });
        }

        return redirect()
            ->back()
            ->with('success', 'Invest updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $invest = Invest::query()
            ->with('transactionable')
            ->find($id);

        // restore balance
        // $invest->transactionable->decrement('balance', $invest->amount);

        $invest->delete();

        return redirect()->back()->with('success', 'Invest deleted successfully.');
    }

    private function updateInvestorBalance($amount)
    {
        $investor = Investor::find(request()->investor_id);
        $investor->balance += $amount;
        $investor->save();
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $invests = Invest::query()
            ->onlyTrashed()
            ->with('transactionable')
            ->addInvestorName()
            ->addPaymentMethod()
            ->latest()
            ->paginate(30)
            ->withQueryString();


        return view('pos.investment.invest.trash', compact('invests'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Invest::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Invest restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $invest = Invest::withTrashed()->findOrFail($id);
        // restore balance
        $invest->transactionable->decrement('balance', $invest->amount);
        $invest->forceDelete();

        return redirect()->back()->withSuccess('Invest deleted permanently.');
    }

    public function toggleAutomatic($id)
    {
        $invest = Invest::findOrFail($id);
        $invest->isAutomatic = !$invest->isAutomatic;
        $invest->save();

        return redirect()->back()->withSuccess('Automatic status updated successfully.');
    }

}
