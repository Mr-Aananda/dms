<?php

namespace App\Http\Controllers\Pos\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\BankRequest;
use App\Models\Bank;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class BankController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $bank_query = Bank::query();
        //search
        if (\request()->name) {
            $bank_query->where('name', 'LIKE', '%' . request()->name . '%');
        }
        $banks = $bank_query->withCount('bankAccounts')->latest()->paginate(30)->withQueryString();

        return view('pos.bank.index', compact('banks'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.bank.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BankRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;

        Bank::create($data);
        return redirect()->back()->withSuccess('Bank create successfully');
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
        $bank = Bank::query()
            ->findOrFail($id);
        return view('pos.bank.edit', compact('bank'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(BankRequest $request, string $id)
    {
        $bank = Bank::query()
            ->findOrFail($id);
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;
        $data['active'] = $request->active;
        $bank->update($data);

        return redirect()
            ->back()
            ->withSuccess('Bank updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $bank = Bank::query()
            ->findOrFail($id);

        $bank->delete();

        return redirect()->route('bank.index')->withSuccess('Bank deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $banks = Bank::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.bank.trash', compact('banks'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Bank::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Brand restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $bank = Bank::withTrashed()->findOrFail($id);
        $bank->forceDelete();

        return redirect()->back()->withSuccess('Bank deleted permanently.');
    }
}
