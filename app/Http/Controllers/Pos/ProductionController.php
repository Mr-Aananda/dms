<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProductionRequest;
use App\Models\Branch;
use App\Models\Product;
use App\Models\Production;
use Illuminate\Support\Facades\Auth;
use Exception;
use Illuminate\Support\Facades\DB;

class ProductionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $productions = Production::query();

        if (request()->search) {
            // set date
            $date = [];
            if (request()->from_date != null) {
                $date[] = date(request()->from_date);

                if (request()->to_date != null) {
                    $date[] = date(request()->to_date);
                } else {
                    if (request()->from_date != null) {
                        $date[] = date('Y-m-d');
                    }
                }
                if (count($date) > 0) {
                    $productions = $productions->whereBetween('date', $date);
                }
            }
        }

        if (\request('production_no')) {
            $productions = $productions->where('production_no', \request('production_no'));
        }

        if (\request('branch_id')) {
            $productions = $productions->where('branch_id', \request('branch_id'));
        }

        $productions = $productions->with('branch','user')
            ->latest()
            ->paginate(30)
            ->withQueryString();

        $branches = Branch::select('id', 'name')->where('active', 1)->get();

        return view('pos.production.index', compact('productions', 'branches'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.production.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ProductionRequest $request)
    {
        // return $request->all();
        $production_data = $request->validated();
        $production_data['production_no'] = 'PROD' . '-' . str_pad(Production::max('id') + 1, 6, '0', STR_PAD_LEFT);
        $production_data['user_id'] = Auth::user()->id;
        DB::beginTransaction();
        try {
            // create new production
            $production = Production::create($production_data);

            $this->saveRawProductsDetails($request, $production);
            $this->saveFinishProductsDetails($request, $production);

            DB::commit();
            return response()->json($production, 200);
        } catch (Exception $exception) {
            DB::rollback();
            // return response()->json($exception, 500);
            return response()->json(['error' => $exception->getMessage()], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $production = Production::with(['details' => function ($query) {
            $query->addProductName()
                ->with(['product' => function ($query) {
                    $query->select('id', 'name', 'divisor_number', 'barcode', 'unit_id', 'purchase_price', 'wholesale_price', 'sale_price')
                        ->addCategoryName()
                        ->addBrandName()
                        ->addUnitName()
                        ->addUnitLabel()
                        ->addUnitRelation();
                }]);
        }])->findOrFail($id);
        return view('pos.production.show', compact('production'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $production = Production::with(['details' => function($query){
            $query->orderByDesc('production_type');
        }])->findOrFail($id);
        $production['formatted_date'] = $production->date->format('Y-m-d');
        return view('pos.production.edit', compact('production'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ProductionRequest $request, string $id)
    {
        $production_data = $request->validated();

        DB::beginTransaction();
        try {
            $production = Production::findOrFail($id);

            $this->updateOldRawProductsQuantity($production);
            $this->updateOldFinishProductsQuantity($production);

            $production->update($production_data);

            $this->saveRawProductsDetails($request, $production);
            $this->saveFinishProductsDetails($request, $production);

            DB::commit();
            return response()->json($production, 200);
        } catch (Exception $exception) {
            DB::rollback();
            // return response()->json($exception, 500);
            return response()->json(['error' => $exception->getMessage()], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        Production::findOrFail($id)->delete();

        return redirect()->route('production.index')->withSuccess('Production delete successfully!');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $productions = Production::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.production.trash', compact('productions'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Production::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Production restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $production = Production::withTrashed()->findOrFail($id);
        $this->updateOldRawProductsQuantity($production);
        $this->updateOldFinishProductsQuantity($production);
        $production->forceDelete();

        return redirect()->back()->withSuccess('Production deleted permanently.');
    }

    public function saveRawProductsDetails($request, $production)
    {
        $products = json_decode($request->input('rawProducts'), true);

        foreach ($products as $product) {
            $filterProduct = Product::with('stock')->findOrFail($product['id']);

            $production_details_data = [
                'date' => $production->date,
                // 'branch_id' => $production->branch_id,
                'product_id' => $product['id'],
                'quantity' => $product['quantity'],
                'purchase_price' => $product['purchase_price'],
                'quantity_in_unit' => $product['quantity_in_unit'],
                'production_type' => 'raw_product',
            ];

            $production->details()->create($production_details_data);

            $hasStock = $filterProduct->branches
                ->where('id', $request->branch_id)
                ->where('stock.purchase_price', $product['purchase_price'])
                ->first();
            //if exists branch
            if ($hasStock) {
                $stockQty = $hasStock->stock->quantity;
                $requestQty = $product['quantity'];
                $newQuantity = $stockQty - $requestQty;

                // Decrement quantity
                if ($newQuantity == 0) {
                    $hasStock->stock->delete();
                } else {
                    $hasStock->stock->decrement('quantity', $requestQty);
                }
            } else {
                // throw new Exception('Stock not found for this product: '. $filterProduct->name);
                $filterProduct->branches()->attach([
                    $production->branch_id =>  [
                        'quantity' => -1 * $product['quantity'],
                        'purchase_price' => $product['purchase_price'],
                        'divisor_number' => $product->divisor_number,
                        'created_at' => now(),
                        'updated_at' => now()
                    ]
                ]);
            }
        }
    }
    public function saveFinishProductsDetails($request, $production)
    {
        $products = json_decode($request->input('finishProducts'), true);
        foreach ($products as $product) {
            $_product = Product::with('stock')->findOrFail($product['id']);
            $product_data = [
                'purchase_price' => $product['purchase_price'],
                'sale_price' => $product['sale_price'],
                'wholesale_price' => $product['wholesale_price'],
            ];
            $_product->update($product_data);

            $previousStock = $_product->stock()
                            ->where('branch_id', $request->branch_id)
                            ->where('purchase_price', $product['purchase_price'])
                            ->first();

            if ($previousStock) {
                $previousStock->increment('quantity', $product['quantity']);
            }
            else{
                $_product->branches()->attach([
                    $request->branch_id =>  [
                        'quantity' => $product['quantity'],
                        'purchase_price' => $_product->purchase_price,
                        'divisor_number' => $_product->divisor_number,
                        'created_at' => now(),
                        'updated_at' => now()
                    ]
                ]);
            }

            $production_details_data = [
                'date' => $production->date,
                // 'branch_id' => $production->branch_id,
                'product_id' => $product['id'],
                'quantity' => $product['quantity'],
                'purchase_price' => $product['purchase_price'],
                'quantity_in_unit' => $product['quantity_in_unit'],
                'production_type' => 'finish_product',
            ];

            $production->details()->create($production_details_data);
        }
    }

    public function updateOldRawProductsQuantity($production)
    {
        if (count($production->details) > 0) {
            foreach ($production->details as $detail) {
                // get product
                $product = Product::findOrFail($detail->product_id);
                $previousStock = $product->branches
                ->where('id', $production->branch_id)
                ->where('stock.purchase_price', $detail->purchase_price)
                ->first();

                if ($detail->production_type == 'raw_product') {
                    if ($previousStock) {
                        $previousStock->stock->increment('quantity', $detail->quantity);
                    } else { // no previous warehouse exists
                        //add new stock in for products
                        $product->branches()->attach([
                            $production->branch_id =>  [
                                'quantity' => $detail->quantity,
                                'purchase_price' => $detail->purchase_price,
                                'divisor_number' => $product->divisor_number,
                                'created_at' => now(),
                                'updated_at' => now()
                            ]
                        ]);
                    }
                }
                $detail->delete();
            }
        }
    }

    public function updateOldFinishProductsQuantity($production)
    {
        if (count($production->details) > 0) {
            foreach ($production->details as $detail) {
                // get product
                $product = Product::findOrFail($detail->product_id);
                $previousStock = $product->branches
                ->where('id', $production->branch_id)
                ->where('stock.purchase_price',$detail->purchase_price)
                ->first();
                if ($detail->production_type == 'finish_product') {
                    if ($previousStock) {
                        $stockQty = $previousStock->stock->quantity;
                        $newQuantity = $stockQty - $detail->quantity;

                        // Decrement quantity
                        if ($newQuantity == 0) {
                            $previousStock->stock->delete();
                        } else {
                            $previousStock->stock->decrement('quantity', $detail->quantity);
                        }
                    } else { // no previous warehouse exists
                        //add new stock in for products
                        $product->branches()->attach([
                            $production->branch_id =>  [
                                'quantity' => (-1 * $detail->quantity),
                                'purchase_price' => $detail->purchase_price,
                                'divisor_number' => $product->divisor_number,
                                'created_at' => now(),
                                'updated_at' => now()
                            ]
                        ]);
                    }
                }

                $detail->delete();
            }
        }
    }
}
