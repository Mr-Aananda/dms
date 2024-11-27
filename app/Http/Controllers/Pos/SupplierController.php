<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\SupplierRequest;
use App\Models\Party;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class SupplierController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $supplier_balance = 0;
        $supplier_query = Party::query();
        //search
        // search by customer name
        if (request('party_id')) {
            $supplier_query->where('id', request('party_id'));
        }
        // search by mobile no
        if (request('phone')) {
            $supplier_query->where('phone', request()->phone);
        }
        // search by status
        // search by status
        if (request('active') !== null) {
            $supplier_query->where('active', '=', request()->active);
        }

        $suppliers = $supplier_query->supplier()->withCount('purchases')->latest()->paginate(30)->withQueryString();

        foreach ($suppliers as $supplier) {
            $supplier_balance += min($supplier->balance, 0);
        }
        return view('pos.party.supplier.index',compact('suppliers', 'supplier_balance'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.party.supplier.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(SupplierRequest $request)
    {
        $data = $request->validated();

        DB::transaction(function () use ($request, $data) {
            $data['genus'] = Party::GENUS_SUPPLIER;
            $data['balance'] = $this->balanceStatus($request);
            $data['user_id'] = Auth::user()->id;
            Party::create($data);
        });
        return redirect()->back()->withSuccess('Customer has been created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        // get the specified resource
        $supplier = Party::findOrFail($id);
        return view('pos.party.supplier.show', compact('supplier'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        // get the specified resource
        $supplier = Party::findOrFail($id);
        return view('pos.party.supplier.edit', compact('supplier'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(SupplierRequest $request, string $id)
    {
        // get the specified resource
        $supplier = Party::findOrFail($id);
        $data = $request->validated();
        DB::transaction(function () use ($request, $supplier, $data) {

            $data['balance'] = $this->balanceStatus($request);
            $data['user_id'] = Auth::user()->id;
            $data['active'] = $request->active;
            $supplier->update($data);
        });
        return redirect()->route('supplier.index')->with('success', 'Supplier has been updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $supplier = Party::findOrFail($id);
        $supplier->delete();
        return redirect()->route('supplier.index')->withSuccess('Supplier deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $suppliers = Party::supplier()
            ->onlyTrashed()
            ->latest()
            ->paginate(30)
            ->withQueryString();

        return view('pos.party.supplier.trash', compact('suppliers'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Party::supplier()->withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Supplier restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $supplier = Party::supplier()->withTrashed()->findOrFail($id);
        $supplier->forceDelete();

        return redirect()->back()->withSuccess('Supplier deleted permanently.');
    }

    /**
     * @param $request
     * return supplier balance positive or negative
     * @return float|int
     */
    public function balanceStatus($request)
    {
        if ($request->balance_status == 'receivable') {
            return abs($request->balance);
        } else {
            return -1 * abs($request->balance);
        }
    }
}
