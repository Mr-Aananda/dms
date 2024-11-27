<?php

namespace App\Http\Controllers\Pos\Payroll;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoanInstallmentRequest;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Loan;
use App\Models\LoanInstallment;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoanInstallmentController extends Controller
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
        return view('pos.payroll.installment.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(LoanInstallmentRequest $request)
    {
        // return $request->all();
        $data = $request->validated();
        $transactionable = null;
        $data['user_id'] = Auth::user()->id;

        $loan = Loan::find($request->loan_id);
        if ($loan->amount > 0) {
            $data['amount'] = -1 * $request->amount;
            $data['adjustment'] = -1 * $request->adjustment;
        } else {
            $data['amount'] = $request->amount;
            $data['adjustment'] = $request->adjustment;
        }

        // identify payment method
        if ($request->payment_method == 'cash') {
            $transactionable = Cash::find($request->transactionable_id);
        } else {
            $transactionable = BankAccount::find($request->transactionable_id);
        }

        DB::transaction(function () use ($data, $request, $transactionable) {
            $transactionable->loanInstallments()->create($data);
            $transactionable->increment('balance', $data['amount']);
        });

        return redirect()->route('loan.show', $loan->id)->with('success', 'Loan installment added successfully.');
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
        $loanInstallment = LoanInstallment::query()
            ->select('*')
            ->with('transactionable')
            ->addPaymentMethod()
            ->findOrFail($id);
        return view('pos.payroll.installment.edit',compact('loanInstallment'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(LoanInstallmentRequest $request, string $id)
    {
        $data = $request->validated();
        $loan_installment = LoanInstallment::query()
            ->with('transactionable')
            ->find($id);

        $loan = Loan::find($loan_installment->loan_id);
        if ($loan->amount > 0) {
            $data['amount'] = -1 * $request->amount;
            $data['adjustment'] = -1 * $request->adjustment;
        } else {
            $data['amount'] = $request->amount;
            $data['adjustment'] = $request->adjustment;
        }

        // check payment method is updated or not
        $oldPaymentMethod = $loan_installment->payment_method;
        if ($oldPaymentMethod == $request->payment_method) {
            // payment method is same
            // get the different
            $diff =  $data['amount'] - $loan_installment->amount;

            // query safer
            DB::transaction(function () use ($diff, $loan_installment, $data) {
                // adjust the balance
                $loan_installment->transactionable->increment('balance', $diff);
                // update loan_installment
                $loan_installment->update($data);
            });
        } else {
            // payment method is not same
            // query safer
            DB::transaction(function () use ($loan_installment, $request, $data) {
                // add previous amount in previous payment method
                $loan_installment->transactionable->decrement('balance', $loan_installment->amount);

                // identify payment method
                if ($request->payment_method == 'cash') {
                    $trasactionable = Cash::find($request->transactionable_id);
                } else {
                    $trasactionable = BankAccount::find($request->transactionable_id);
                }

                // decrement amount from current transactionable
                $trasactionable->increment('balance', $data['amount']);

                // update payment method in loan_installment
                $loan_installment->update($data + [
                    'transactionable_type' => $trasactionable->getMorphClass(),
                    'transactionable_id' => $trasactionable->id,
                ]);

            });
        }

        // return redirect()->route('loan.show', $loan->id)->with('success', 'Loan installment update successfully.');
        return redirect()->back()->with('success', 'Loan installment update successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $loanInstallment = LoanInstallment::findOrFail($id);
        $loanInstallment->transactionable->decrement('balance', $loanInstallment->amount);
        $loanInstallment->delete();

        return redirect()->back()->with('success', 'Loan installment deleted successfully.');
    }


    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $installments = LoanInstallment::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.payroll.installment.trash', compact('installments'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        LoanInstallment::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Installment restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $installment = LoanInstallment::withTrashed()->findOrFail($id);
        $installment->forceDelete();

        return redirect()->back()->withSuccess('Installment deleted permanently.');
    }

}
