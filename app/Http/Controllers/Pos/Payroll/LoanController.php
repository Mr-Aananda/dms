<?php

namespace App\Http\Controllers\Pos\Payroll;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoanRequest;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Loan;
use App\Models\LoanAccount;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoanController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $loans = Loan::query();

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
                    $loans = $loans->whereBetween('date', $date);
                }
            }
        }
        if (request('loan_account_id')) {
            $loans->where('loan_account_id', request('loan_account_id'));
        }

        $loans = $loans->with('transactionable')
            // ->withCount('loanInstallments')
            ->withCount(['loanInstallments' => function ($query) {
                $query->withTrashed(); // Include soft deleted records in the count
            }])
            ->addLoanAccountName()
            ->addAdjustment()
            ->addPaid()
            ->addDue()
            ->addPaymentMethod()
            ->latest()
            ->paginate(30)
            ->withQueryString();

        $loanAccounts = LoanAccount::select('id','name')->get();

        return view('pos.payroll.loan.index', compact('loans', 'loanAccounts'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $loanAccounts = LoanAccount::query()
            ->orderBy('name')
            ->get();
        return view('pos.payroll.loan.create',compact('loanAccounts'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(LoanRequest $request)
    {
        // return $request->all();
        $data = $request->validated();
        $transactionable = null;

        if ($request->loan_type === "give") {
            $data['amount'] = -1 * $request->amount;
        } else {
            $data['amount'] = $request->amount;
        }

        // identify payment method
        if ($request->payment_method == 'cash') {
            $transactionable = Cash::find($request->transactionable_id);
        } else {
            $transactionable = BankAccount::find($request->transactionable_id);
        }

        $data['user_id'] = Auth::user()->id;
        $data['profit'] = $request->profit ?? 0;

        DB::transaction(function () use ($data, $request, $transactionable) {
            $transactionable->loans()->create($data);
            $transactionable->increment('balance', $data['amount']);
        });

        return redirect()->back()->with('success', 'Loan created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $loan = Loan::query()
            ->with([
                'loanInstallments' => function (HasMany $query) {
                    $query->select('*')
                        ->addPaymentMethod()
                        ->latest('date');
                },
                'loanInstallments.transactionable',
                'loanAccount',
            ])
            ->addLoanAccountName()
            ->addAdjustment()
            ->addPaid()
            ->addDue()
            ->addPaymentMethod()
            ->findOrFail($id);

        return view('pos.payroll.loan.show', compact('loan'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        // get the specified resource
        $loan = Loan::query()
            ->select('*')
            ->with('transactionable')
            ->addPaymentMethod()
            ->findOrFail($id);
        $loanAccounts = LoanAccount::query()
            ->orderBy('name')
            ->get();
        return view('pos.payroll.loan.edit', compact('loanAccounts', 'loan'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(LoanRequest $request, string $id)
    {
        // return $request->all();
        $data = $request->validated();
        $loan = Loan::query()
            ->with('transactionable')
            ->find($id);

        if ($request->loan_type == "give") {
            $data['amount'] = -1 * $request->amount;
        } else {
            $data['amount'] = $request->amount;
        }

        $oldPaymentMethod = $loan->payment_method;
        if ($oldPaymentMethod == $request->payment_method) {
            // Same payment method
            $diff =  $loan->amount - $data['amount'];

            DB::transaction(function () use ($diff, $loan, $data) {
                // adjust the balance
                $loan->transactionable->increment('balance', $diff);
                // update loan
                $loan->update($data);
            });
        } else {
            // payment method is not same
            DB::transaction(function () use ($loan, $request, $data) {
                // add previous amount in previous payment method
                $loan->transactionable->decrement('balance', $loan->amount);

                // identify payment method
                if ($request->payment_method == 'cash') {
                    $transactionable = Cash::find($request->transactionable_id);
                } else {
                    $transactionable = BankAccount::find($request->transactionable_id);
                }

                 // decrement amount from current transactionable
                $transactionable->increment('balance', $data['amount']);

                // update payment method in loan
                $loan->update($data + [
                    'transactionable_type' => $transactionable->getMorphClass(),
                    'transactionable_id' => $transactionable->id,
                ]);
            });
        }

        return redirect()
            ->back()
            ->with('success', 'Loan updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $loan = Loan::query()
            ->with('transactionable')
            ->find($id);

        if ($loan->loanInstallments()->count()) {
            return redirect()->back()->with('errors', 'Failed to delete loan. Loan account has some installments.');
        }

        // restore balance
        // $loan->transactionable->decrement('balance', $loan->amount);

        $loan->delete();

        return redirect()->back()->with('success', 'Loan deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $loans = Loan::query()
            ->onlyTrashed()
            ->with('transactionable')
            ->withCount('loanInstallments')
            ->addLoanAccountName()
            ->addAdjustment()
            ->addPaid()
            ->addDue()
            ->addPaymentMethod()
            ->latest()
            ->paginate(30)
            ->withQueryString();


        return view('pos.payroll.loan.trash', compact('loans'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Loan::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Loan restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $loan = Loan::withTrashed()->findOrFail($id);
        // restore balance
        $loan->transactionable->decrement('balance', $loan->amount);
        $loan->forceDelete();

        return redirect()->back()->withSuccess('Loan deleted permanently.');
    }
}
