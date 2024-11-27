<?php

namespace App\Http\Controllers\Pos\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\UnitRequest;
use App\Models\Unit;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class UnitController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $units = Unit::query();
        if (request()->search) {
            if (request('name')) {
                $units->where('name', 'like', '%' . request('name') . '%');
            }
        }
        $units = $units->latest()
        ->withCount('products')
        ->paginate(30)
        ->withQueryString();
        return view('pos.unit.index', compact('units'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.unit.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(UnitRequest $request)
    {
        $data = $request->validated();
        $data['code'] = \str_pad(Unit::withTrashed()->max("id") + 1, 4, 0, STR_PAD_LEFT);
        $data['user_id'] = Auth::user()->id;

        Unit::create($data);
        return redirect()->back()->withSuccess('User create successfully');
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
        $unit = Unit::findOrFail($id);
        return view('pos.unit.edit',compact('unit'));

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UnitRequest $request, string $id)
    {
        $data = $request->validated();
        $unit = Unit::findOrFail($id);

        $unit->update($data);
        return redirect()->route('unit.index')->withSuccess('User updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $unit = Unit::query()
                ->findOrFail($id);

        $unit->delete();

        return redirect()->route('unit.index')->withSuccess('Unit deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $units = Unit::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.unit.trash', compact('units'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Unit::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Unit restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $unit = Unit::withTrashed()->findOrFail($id);
        $unit->forceDelete();

        return redirect()->back()->withSuccess('Unit deleted permanently.');
    }
}
