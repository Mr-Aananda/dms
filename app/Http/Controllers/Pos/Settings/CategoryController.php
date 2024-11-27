<?php

namespace App\Http\Controllers\Pos\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\CategoryRequest;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
    //    return $category_query = Category::parent();
        $category_query = Category::query();
        //search
        if (\request()->name) {
            $category_query->where('name', 'LIKE', '%' . request()->name . '%');
        }
        $categories = $category_query->latest()->paginate(30)->withQueryString();

        return view('pos.category.index', compact('categories'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $categories = Category::tree();
        $existingCategoryId = "";
        return view('pos.category.create',compact('categories', 'existingCategoryId'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(CategoryRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;

        Category::create($data);
        return redirect()->back()->withSuccess('Category create successfully');
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
        $category = Category::query()->findOrFail($id);
        $categories = Category::tree()->reject(function ($item) use ($category) {
            return $item->id == $category->id;
        });
        // Get the names of existing categories excluding the current category being edited
        $existingCategoryId = Category::where('id', $category->id)->value('id');


        return view('pos.category.edit', compact('categories', 'category', 'existingCategoryId'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(CategoryRequest $request, string $id)
    {
        $category = Category::query()->findOrFail($id);
        $data = $request->validated();
        $data['active'] = $request->active;

        $category->update($data);

        return redirect()
            ->back()
            ->withSuccess('Category updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $category = Category::query()->findOrFail($id);
        $category->delete();

        return redirect()->route('category.index')->withSuccess('Category deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $categories = Category::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.category.trash', compact('categories'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Category::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Category restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $category = Category::withTrashed()->findOrFail($id);
        $category->forceDelete();

        return redirect()->back()->withSuccess('Category deleted permanently.');
    }
}
