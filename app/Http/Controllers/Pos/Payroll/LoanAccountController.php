<?php

namespace App\Http\Controllers\Pos\Payroll;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoanAccountRequest;
use App\Models\LoanAccount;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoanAccountController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $loanAccounts = LoanAccount::query();
        // search by customer name
        if (request('name')) {
            $loanAccounts->where('name', 'like', '%' . request('name') . '%');
        }
        // search by mobile no
        if (request('phone')) {
            $loanAccounts->where('phone', request()->phone);
        }

        $loanAccounts = $loanAccounts
            ->withCount(['loans' => function ($query) {
                $query->withTrashed(); // Include soft deleted records in the count
            }])
            ->addTotalLoan()
            ->addTotalPaid()
            ->addTotalAdjustment()
            ->addTotalDue()
            ->latest()
            ->paginate(30)
            ->withQueryString();
        return view('pos.payroll.loan-account.index',compact('loanAccounts'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.payroll.loan-account.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(LoanAccountRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;

        LoanAccount::create($data);
        return redirect()->back()->withSuccess('Account create successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $loanAccount = LoanAccount::query()
                                ->addTotalLoan()
                                ->addTotalPaid()
                                ->addTotalAdjustment()
                                ->addTotalDue()
                                ->findOrFail($id);
        return view('pos.payroll.loan-account.show', compact('loanAccount'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $loanAccount = LoanAccount::query()
            ->findOrFail($id);
        return view('pos.payroll.loan-account.edit', compact('loanAccount'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(LoanAccountRequest $request, string $id)
    {
        $loanAccount = LoanAccount::query()
            ->findOrFail($id);
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;
        $loanAccount->update($data);

        return redirect()
            ->back()
            ->withSuccess('Account updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $loanAccount = LoanAccount::query()
            ->findOrFail($id);

        $loanAccount->delete();

        return redirect()->route('loan-account.index')->withSuccess('Account deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $loanAccounts = LoanAccount::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.payroll.loan-account.trash', compact('loanAccounts'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        LoanAccount::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Account restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $loanAccount = LoanAccount::withTrashed()->findOrFail($id);
        $loanAccount->forceDelete();

        return redirect()->back()->withSuccess('Account deleted permanently.');
    }
}
