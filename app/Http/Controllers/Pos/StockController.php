<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\Request;

class StockController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $products = Product::query();

        if (request()->search) {
            // Search by product
            if (\request('product_id')) {
                $products = $products->where('id', \request('product_id'));
            }
            // Search by warehouse
            if (request()->branch_id && !empty(request()->branch_id)) {
                $branch_id = request()->branch_id;
                $products->whereHas('branches', function ($query) use ($branch_id) {
                    $query->where('branches.id', $branch_id)->where('quantity', '!=', 0);
                });
            }

            // Search by category
            if (request()->category_id) {
                $products->where('category_id', request()->category_id);
            }

        }
        else{
            $products = $products->whereHas('branches', function ($query) {
                $query->where('quantity', '>', 0);
            });
        }

        $products = $products
        ->latest()
        ->where('status', 1)
        ->select('id', 'name', 'purchase_price', 'sale_price', 'wholesale_price', 'unit_id', 'category_id', 'divisor_number','price_type')
        ->addTotalProductQuantity()
        ->addTotalProductQuantityBranchWise()
        ->addDamageQuantity()
        ->addUnitLabel()
        ->addUnitRelation()
        ->with('branches', 'category', 'unit')
        ->paginate(30);

        $branches = Branch::select('id', 'name')->where('active', 1)->get();
        $categories = Category::select('id', 'name')->where('active', 1)->get();
        $allProducts = Product::select('id', 'name')->where('status', 1)->get();

        return view('pos.stock.index', compact('branches', 'categories', 'products', 'allProducts'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
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
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
