<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Helpers\QuantityHelper;
use App\Http\Requests\ProductRequest;
use App\Models\Branch;
use App\Models\Brand;
use App\Models\Category;
use App\Models\Product;
use App\Models\Unit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class ProductController extends Controller
{
    use QuantityHelper;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $products = Product::query();

        // $products = $products->where('barcode', 'like' , '%' . 'bar-' . '%')->get();

        // foreach($products as $product) {
        //     $product->update([
        //         'barcode' => Str::replaceFirst('bar-', '', $product->barcode)
        //     ]);
        // }

        // return back();

        if (\request('barcode')) {
            $products = $products->where('barcode', 'like', '%' . request('barcode') . '%');
        }
        if (\request('product_id')) {
            $products = $products->where('id', \request('product_id'));
        }
        if (\request('category_id')) {
            $products = $products->where('category_id', \request('category_id'));
        }
        if (request()->brand_id) {
            $products = $products->where('brand_id', request()->brand_id);
        }
        if (request('status') !== null) {
            $products = $products->where('status', '=', request()->status);
        }

        $products = $products
        ->latest()
        ->addTotalProductQuantity()
        ->addTotalProductQuantityBranchWise()
        ->addUnitLabel()
        ->addUnitRelation()
        ->with('brand', 'category', 'unit')
        ->withCount(['details','productiondetails'])
        ->paginate(30)
        ->withQueryString();

        // $categories = Category::all();
        $categories = Category::select('id', 'name')
        ->where('active', 1)
        ->whereNull('parent_id')
        ->orWhereIn('id', function ($query) {
            $query->select('parent_id')
            ->from('categories')
            ->whereNotNull('parent_id');
        })
            ->get();
        $brands = Brand::all();
        $searchProducts = Product::select('id','name')->get();


        return view('pos.product.index', compact('categories', 'brands', 'products', 'searchProducts'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $data = [];
        // $data['categories'] = Category::with('subCategory')->select('id', 'name')->where('active', 1)->get();
        $data['categories'] = Category::with('subCategory')
        ->select('id', 'name','active')
        ->where('active', 1)
        ->whereNull('parent_id')
        ->orWhereIn('id', function ($query) {
            $query->select('parent_id')
            ->from('categories')
            ->whereNotNull('parent_id');
        })
            ->get();
        $data['brands'] = Brand::select('id', 'name')->get();
        $data['units'] = Unit::all();
        return view('pos.product.create')->with($data);

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ProductRequest $request)
    {
        // return $request->all();
        $data = $request->validated();
        $unit = Unit::findOrFail($request->unit_id);
        $data['divisor_number'] = $this->getDivisorNumber($unit, $request->price_type);
        // $productBarcode = 'bar' . '-' . str_pad(Product::withTrashed()->max('id') + 1, 8, '0', STR_PAD_LEFT);
        $productBarcode = str_pad(Product::withTrashed()->max('id') + 1, 8, '0', STR_PAD_LEFT);
        $data['barcode'] = $request->barcode ? $request->barcode : $productBarcode;
        $data['user_id'] = Auth::user()->id;
        $data['purchase_price'] = $request->purchase_price ? $request->purchase_price : 0;
        $data['sale_price'] = $request->sale_price ? $request->sale_price : 0;
        $data['wholesale_price'] = $request->wholesale_price ? $request->wholesale_price : 0;
        $data['stock_alert'] = $request->stock_alert ? $request->stock_alert : 0;
        $data['branch_id'] = Auth::user()->branch_id;

       $product = Product::create($data);
        // $branches = Branch::all();
        // $quantities = [];
        // foreach ($branches as $branch) {
        //     $quantities[$branch->id] = [
        //         'quantity'   => 0,
        //         'purchase_price' => $product->purchase_price,
        //         'divisor_number' => $product->divisor_number,
        //         'created_at' => now(),
        //         'updated_at' => now()
        //     ];
        // }
        // $product->branches()->sync($quantities);

        return redirect()
            ->route('product.index')
            ->withSuccess('Product has been created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $product = Product::
            addCategoryName()
            ->addSubCategoryName()
            ->addBrandName()
            ->addUnitName()
            ->addUnitLabel()
            ->addUnitRelation()
            ->findOrFail($id);

        return view('pos.product.show', compact('product'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $product = Product::findOrFail($id);
        $data = [];
        // $data['categories'] = Category::with('subCategory')->select('id', 'name')->get();
        $data['categories'] = Category::with('subCategory')
        ->select('id', 'name')
        ->where('active', 1)
        ->whereNull('parent_id')
        ->orWhereIn('id', function ($query) {
            $query->select('parent_id')
            ->from('categories')
            ->whereNotNull('parent_id');
        })
            ->get();
        $data['brands'] = Brand::select('id', 'name')->get();
        $data['units'] = Unit::all();

        return view('pos.product.edit',compact('product'))->with($data);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ProductRequest $request, string $id)
    {
        $data = $request->validated();
        $product = Product::findOrFail($id);
        $unit = Unit::findOrFail($request->unit_id);
        $data['divisor_number'] = $this->getDivisorNumber($unit, $request->price_type);
        $productBarcode = str_pad($product->id , 8, '0', STR_PAD_LEFT);
        $data['barcode'] = $request->barcode ? $request->barcode : $productBarcode;
        $data['purchase_price'] = $request->purchase_price ? $request->purchase_price : 0;
        $data['sale_price'] = $request->sale_price ? $request->sale_price : 0;
        $data['wholesale_price'] = $request->wholesale_price ? $request->wholesale_price : 0;
        $data['stock_alert'] = $request->stock_alert ? $request->stock_alert : 0;
        $data['branch_id'] = Auth::user()->branch_id;
        $data['user_id'] = Auth::user()->id;

        $product->update($data);

        return redirect()
            ->route('product.index')
            ->withSuccess('Product has been updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        Product::find($id)->delete();
        return redirect()
            ->back()
            ->with('success', 'Product delete successfully');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $products = Product::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.product.trash', compact('products'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Product::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Product restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $product = Product::withTrashed()->findOrFail($id);
        $product->forceDelete();

        return redirect()->back()->withSuccess('Product deleted permanently.');
    }
}
