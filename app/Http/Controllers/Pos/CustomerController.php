<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\CustomerRequest;
use App\Models\Party;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CustomerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $customer_balance = 0;
        $customers_query = Party::query();
        // search by customer name
        if (request('party_id')) {
            $customers_query->where('id', request('party_id'));
        }
        // search by mobile no
        if (request('phone')) {
            $customers_query->where('phone', request()->phone);
        }
        // search by status
        // search by status
        if (request('active') !== null) {
            $customers_query->where('active', '=', request()->active);
        }

        // get all customer data
        $customers = $customers_query->customer()->withCount('sales')->latest()->paginate(30)->withQueryString();
        $totalBalance = $customers->sum('balance');

        return view('pos.party.customer.index', compact('customers', 'totalBalance' ));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.party.customer.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(CustomerRequest $request)
    {
        $data = $request->validated();
        DB::transaction(function () use ($request, $data) {
            // $data['balance'] = $request->balance ?? 0;
            $data['balance'] = $this->balanceStatus($request);
            $data['genus'] = Party::GENUS_CUSTOMER;
            $data['user_id'] = Auth::user()->id;

            Party::create($data);
        });
        // view
        return redirect()->back()->withSuccess('Customer has been created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        // get the specified resource
        $customer = Party::findOrFail($id);
        return view('pos.party.customer.show', compact('customer'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        // get the specified resource
        $customer = Party::findOrFail($id);

        return view('pos.party.customer.edit', compact('customer'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(CustomerRequest $request, string $id)
    {
        $customer = Party::findOrFail($id);
        $data = $request->validated();

        DB::transaction(function () use ($request, $data, $customer) {
            // $data['balance'] = $request->balance ?? 0;
            $data['balance'] = $this->balanceStatus($request);
            $data['user_id'] = Auth::user()->id;
            $data['active'] = $request->active;
            $customer->update($data);
        });
        // view with message
        return redirect()->route('customer.index')->with('success', 'Customer updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $customer = Party::findOrFail($id);
        $customer->delete();
        return redirect()->route('customer.index')->withSuccess('Customer deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $customers = Party::customer()
            ->onlyTrashed()
            ->latest()
            ->paginate(30)
            ->withQueryString();

        return view('pos.party.customer.trash', compact('customers'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Party::customer()->withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Customer restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $customer = Party::customer()->withTrashed()->findOrFail($id);
        $customer->forceDelete();

        return redirect()->back()->withSuccess('Customer deleted permanently.');
    }

    /**
     * @param $request
     * return customer balance positive or negative
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
