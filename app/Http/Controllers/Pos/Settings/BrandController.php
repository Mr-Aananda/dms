<?php

namespace App\Http\Controllers\Pos\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\BrandRequest;
use App\Models\Brand;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class BrandController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $brand_query = Brand::query();
        //search
        if (\request()->name) {
            $brand_query->where('name', 'LIKE', '%' . request()->name . '%');
        }
        $brands = $brand_query->latest()->paginate(30)->withQueryString();

        return view('pos.brand.index', compact('brands'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.brand.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BrandRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;

        Brand::create($data);
        return redirect()->back()->withSuccess('Brand create successfully');
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
        $brand = Brand::query()
            ->findOrFail($id);
        return view('pos.brand.edit', compact('brand'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(BrandRequest $request, string $id)
    {
        $brand = Brand::query()
            ->findOrFail($id);
        $data = $request->validated();;

        $brand->update($data);

        return redirect()
            ->back()
            ->withSuccess('Brand updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $brand = Brand::query()
            ->findOrFail($id);

        $brand->delete();

        return redirect()->route('brand.index')->withSuccess('Brand deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $brands = Brand::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.brand.trash', compact('brands'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Brand::withTrashed()->find($id)->restore();

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
        $brand = Brand::withTrashed()->findOrFail($id);
        $brand->forceDelete();

        return redirect()->back()->withSuccess('Brand deleted permanently.');
    }
}
