<?php

namespace App\Http\Controllers\Pos\Settings;

use App\Http\Controllers\Controller;
use App\Http\Requests\BranchRequest;
use App\Models\Branch;
use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;

class BranchController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $branch_query = Branch::query();
        //search
        if (\request()->name) {
            $branch_query->where('name', 'LIKE', '%' . request()->name . '%');
        }
        $branches = $branch_query->withCount('users')->latest()->paginate(30)->withQueryString();

        return view('pos.branch.index', compact('branches'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $users = User::all();
        return view('pos.branch.create',compact('users'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(BranchRequest $request)
    {
        $data = $request->validated();
        // $data['user_id'] = Auth::user()->id;

        Branch::create($data);
        return redirect()->back()->withSuccess('Branch create successfully');
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
        $branch = Branch::query()
                    ->findOrFail($id);
        return view('pos.branch.edit', compact('branch'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(BranchRequest $request, string $id)
    {
        $branch = Branch::query()
            ->findOrFail($id);
        $data = $request->validated();
        $data['active'] = $request->active;
;
        $branch->update($data);

        return redirect()
            ->back()
            ->withSuccess('Branch updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $branch = Branch::query()
            ->findOrFail($id);

        $branch->delete();

        return redirect()->route('branch.index')->withSuccess('Branch deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $branches = Branch::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.branch.trash', compact('branches'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Branch::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Branch restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $branch = Branch::withTrashed()->findOrFail($id);
        $branch->forceDelete();

        return redirect()->back()->withSuccess('Branch deleted permanently.');
    }

    /**
     * get business wise product
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function getProductForBranch($id)
    {
        // $products = Product::where('status', 1)->with('branches','stock')->whereHas('branches', function ($query) use ($id) {
        //         $query->where('branch_id', $id);
        //     })
        //     ->addUnitLabel()
        //     ->addUnitRelation()
        //     ->addDamageQuantity($id)
        //     ->get();
        $products = Product::where('status', 1)->with('branches','stock')
            ->addUnitLabel()
            ->addUnitRelation()
            ->addDamageQuantity($id)
            ->get();
        return response()->json($products, 200);
    }
}
