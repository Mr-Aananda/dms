<?php

namespace App\Http\Controllers\Pos\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\ExpenseCategoryRequest;
use App\Models\ExpenseCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ExpenseCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $category_query = ExpenseCategory::query();
        //search
        if (\request()->name) {
            $category_query->where('name', 'LIKE', '%' . request()->name . '%');
        }
        $categories = $category_query->latest()->paginate(30)->withQueryString();

        return view('pos.expense.category.index', compact('categories'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $categories = ExpenseCategory::tree();
        $existingCategoryId = "";
        return view('pos.expense.category.create', compact('categories', 'existingCategoryId'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ExpenseCategoryRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;

        ExpenseCategory::create($data);
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
        $category = ExpenseCategory::query()->findOrFail($id);
        $categories = ExpenseCategory::tree()->reject(function ($item) use ($category) {
            return $item->id == $category->id;
        });
        // Get the names of existing categories excluding the current category being edited
        $existingCategoryId = ExpenseCategory::where('id', $category->id)->value('id');


        return view('pos.expense.category.edit', compact('categories', 'category', 'existingCategoryId'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ExpenseCategoryRequest $request, string $id)
    {
        $category = ExpenseCategory::query()->findOrFail($id);
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
        $category = ExpenseCategory::query()->findOrFail($id);
        $category->delete();

        return redirect()->route('expense-category.index')->withSuccess('Category deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $categories = ExpenseCategory::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.expense.category.trash', compact('categories'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        ExpenseCategory::withTrashed()->find($id)->restore();

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
        $category = ExpenseCategory::withTrashed()->findOrFail($id);
        $category->forceDelete();

        return redirect()->back()->withSuccess('Category deleted permanently.');
    }
}
