<?php

namespace App\Http\Controllers\Pos\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\BankAccountRequest;
use App\Models\Bank;
use App\Models\BankAccount;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class BankAccountController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $account_query = BankAccount::query();
        //search
        if (\request()->account_name) {
            $account_query->where('account_name', 'LIKE', '%' . request()->account_name . '%');
        }
        if (\request()->account_number) {
            $account_query->where('account_number', 'LIKE', '%' . request()->account_number . '%');
        }
        if (\request()->bank_id) {
            $account_query->where('bank_id', request()->bank_id);
        }
        $accounts = $account_query->latest()->paginate(30)->withQueryString();
        $banks = Bank::where('active', 1)->select('id', 'name')->get();

        return view('pos.bank.bank-account.index', compact('accounts', 'banks'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $banks = Bank::where('active', 1)->select('id','name')->get();
        return view('pos.bank.bank-account.create',compact('banks'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BankAccountRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;
        $data['balance'] = $request->balance ? $request->balance : 0.00 ;

        BankAccount::create($data);
        return redirect()->back()->withSuccess('Account created successfully');
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
        $account = BankAccount::query()
            ->findOrFail($id);
        $banks = Bank::where('active', 1)->select('id', 'name')->get();
        return view('pos.bank.bank-account.edit', compact('account', 'banks'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(BankAccountRequest $request, string $id)
    {
        $account = BankAccount::query()
            ->findOrFail($id);

        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;
        $data['balance'] = $request->balance ? $request->balance : 0.00;

        $account->update($data);
        return redirect()->back()->withSuccess('Account updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $account = BankAccount::query()
            ->findOrFail($id);
        $account->delete();
        return redirect()->route('bank-account.index')->withSuccess('Account deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $bank_accounts = BankAccount::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.bank.bank-account.trash', compact('bank_accounts'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        BankAccount::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Bank Account restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $bank_account = BankAccount::withTrashed()->findOrFail($id);
        $bank_account->forceDelete();

        return redirect()->back()->withSuccess('Bank Account deleted permanently.');
    }
}
