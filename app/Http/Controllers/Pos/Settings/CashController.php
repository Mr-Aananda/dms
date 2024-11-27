<?php

namespace App\Http\Controllers\Pos\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\CashRequest;
use App\Models\Branch;
use App\Models\Cash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CashController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $cash_query = Cash::query();
        //search
        if (\request()->name) {
            $cash_query->where('name', 'LIKE', '%' . request()->name . '%');
        }
        $cashes = $cash_query
        ->latest()
        ->withCount('transaction')
        ->paginate(30)
        ->withQueryString();

        return view('pos.cash.index', compact('cashes'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $branches = Branch::all();
        return view('pos.cash.create',compact('branches'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(CashRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;
        $data['balance'] = $request->balance ?? 0;

        Cash::create($data);
        return redirect()->back()->withSuccess('Cash create successfully');
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
        $cash = Cash::query()
            ->findOrFail($id);
        $branches = Branch::all();
        return view('pos.cash.edit', compact('cash', 'branches'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(CashRequest $request, string $id)
    {
        $cash = Cash::query()
            ->findOrFail($id);
        $data = $request->validated();;

        $data['active'] = $request->active;
        $cash->update($data);

        return redirect()
            ->back()
            ->withSuccess('Cash updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $cash = Cash::query()
            ->findOrFail($id);

        $cash->delete();

        return redirect()->route('cash.index')->withSuccess('Cash deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $cashes = Cash::latest()
        ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.cash.trash', compact('cashes'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Cash::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Cash restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $cash = Cash::withTrashed()->findOrFail($id);
        $cash->forceDelete();

        return redirect()->back()->withSuccess('Cash deleted permanently.');
    }
}
