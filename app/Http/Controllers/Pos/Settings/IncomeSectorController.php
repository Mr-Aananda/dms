<?php

namespace App\Http\Controllers\Pos\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\IncomeSectorRequest;
use App\Models\IncomeSector;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class IncomeSectorController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $incomeSectors = IncomeSector::query();
        //search
        if (\request()->name) {
            $incomeSectors->where('name', 'LIKE', '%' . request()->name . '%');
        }
        $incomeSectors = $incomeSectors->latest()->paginate(30)->withQueryString();

        return view('pos.income-sector.index', compact('incomeSectors'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.income-sector.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(IncomeSectorRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;

        IncomeSector::create($data);
        return redirect()->back()->withSuccess('Income sector create successfully');
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
        $incomeSector = IncomeSector::query()
            ->findOrFail($id);
        return view('pos.income-sector.edit', compact('incomeSector'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(IncomeSectorRequest $request, string $id)
    {
        $incomeSector = IncomeSector::query()
            ->findOrFail($id);
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;

        $incomeSector->update($data);

        return redirect()
            ->back()
            ->withSuccess('Income sector updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $incomeSector = IncomeSector::query()
            ->findOrFail($id);
        $incomeSector->delete();

        return redirect()->route('income-sector.index')->withSuccess('Sector deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $incomeSectors = IncomeSector::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.income-sector.trash', compact('incomeSectors'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        IncomeSector::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Sector restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $incomeSector = IncomeSector::withTrashed()->findOrFail($id);
        $incomeSector->forceDelete();

        return redirect()->back()->withSuccess('Income sector deleted permanently.');
    }
}
