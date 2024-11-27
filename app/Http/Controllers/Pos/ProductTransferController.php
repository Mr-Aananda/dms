<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProductTransferRequest;
use App\Models\Product;
use App\Models\ProductTransfer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Exception;
use Illuminate\Support\Facades\DB;

class ProductTransferController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $productTransfers = ProductTransfer::query();

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
                    $productTransfers = $productTransfers->whereBetween('date', $date);
                }
            }
        }

        if (\request('transfer_no')) {
            $productTransfers = $productTransfers->where('transfer_no', \request('transfer_no'));
        }

        $productTransfers = $productTransfers
            ->latest()
            ->paginate(30)
            ->withQueryString();

        return view('pos.product-transfer.index', compact('productTransfers'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.product-transfer.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ProductTransferRequest $request)
    {
        // return $request->all();
        $product_transfer_data = $request->validated();
        $product_transfer_data['transfer_no'] = 'PT' . '-' . str_pad(ProductTransfer::max('id') + 1, 6, '0', STR_PAD_LEFT);
        $product_transfer_data['user_id'] = Auth::user()->id;
        DB::beginTransaction();
        try {
            // create new production
            $productTransfer = ProductTransfer::create($product_transfer_data);

            $this->saveProductTransferDetails($request, $productTransfer);
            DB::commit();
            return response()->json($productTransfer, 200);
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
        $productTransfer = ProductTransfer::with(['productTransferDetails' => function ($query) {
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

        return view('pos.product-transfer.show',compact('productTransfer'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $productTransfer = ProductTransfer::with('productTransferDetails')->findOrFail($id);
        $productTransfer['formatted_date'] = $productTransfer->date->format('Y-m-d');
        return view('pos.product-transfer.edit',compact('productTransfer'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ProductTransferRequest $request, string $id)
    {
        DB::beginTransaction();
        try {
            $old_product_transfer = ProductTransfer::findOrFail($id);
            $this->updateOldProductTransferData($old_product_transfer);

            $product_transfer_data = $request->validated();

            $old_product_transfer->update($product_transfer_data);
            $this->saveProductTransferDetails($request, $old_product_transfer);

            DB::commit();
            return response()->json($old_product_transfer, 200);
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
        ProductTransfer::findOrFail($id)->delete();

        return redirect()->route('product-transfer.index')->withSuccess('Product transfer delete successfully!');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $productTransfers = ProductTransfer::latest()->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.product-transfer.trash', compact('productTransfers'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        ProductTransfer::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Product transfer restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $old_product_transfer = ProductTransfer::withTrashed()->findOrFail($id);
        $this->updateOldProductTransferData($old_product_transfer);

        $old_product_transfer->forceDelete();

        return redirect()->back()->withSuccess('Product transfer deleted permanently.');
    }

    /**
     * save production transfer product
     * @param $request
     * @param $product_transfer
     * @return void
     */
    public function saveProductTransferDetails($request, $product_transfer)
    {
        $products = json_decode($request->input('products'), true);
        foreach ($products as $product) {
            $_product = Product::findOrFail($product['id']);

            $product_transfer_details_data = [
                'product_id' => $product['id'],
                'quantity' => $product['quantity'],
                'purchase_price' => $product['purchase_price'],
                'quantity_in_unit' => $product['quantity_in_unit'],
            ];

            $product_transfer->productTransferDetails()->create($product_transfer_details_data);

            $this->updateProductQuantity($_product, $request, $product);
        }
    }

    /**
     * update quantity for product transfer
     * @param $_product
     * @param $request
     * @param $product
     * @return void
     */
    public function updateProductQuantity($_product, $request, $product)
    {
        // get from branch
        $from_branch = $_product->branches
            ->where('id', $request->from_branch_id)
            ->where('stock.purchase_price', $product['purchase_price'])
            ->first();
        // get to branch
        $to_branch = $_product->branches
                    ->where('id', $request->to_branch_id)
                    ->where('stock.purchase_price', $product['purchase_price'])
                    ->first();

        //if exists warehouse
        if ($from_branch) {
            //update stocks
            $from_branch->stock->decrement('quantity', $product['quantity']);
        } else {
            $_product->branches()->attach([
                $request->from_branch_id =>  [
                    'quantity' => (-1 * $product['quantity']),
                    'purchase_price' => $_product->purchase_price,
                    'divisor_number' => $_product->divisor_number,
                    'created_at' => now(),
                    'updated_at' => now()
                ]
            ]);
        }
        //if exists warehouse
        if ($to_branch) {
            //update stocks
            $to_branch->stock->increment('quantity', $product['quantity']);
        } else {
            $_product->branches()->attach([
                $request->to_branch_id =>  [
                    'quantity' => $product['quantity'],
                    'purchase_price' => $_product->purchase_price,
                    'divisor_number' => $_product->divisor_number,
                    'created_at' => now(),
                    'updated_at' => now()
                ]
            ]);
        }
    }

    /**
     * update quantity of old product transfer product
     * @param $oldProduction
     * @return void
     */
    public function updateOldProductTransferData($old_product_transfer)
    {
        /**
         * decrement product quantity from to branch
         * increment product quantity from branch
         */
        foreach ($old_product_transfer->productTransferDetails as $detail) {
            $product = $detail->product;
            // get from branch
            $from_branch = $product->branches
            ->where('id', $old_product_transfer->from_branch_id)
            ->where('stock.purchase_price', $detail->purchase_price)
            ->first();
            // get to branch
            $to_branch = $product->branches
                ->where('id', $old_product_transfer->to_branch_id)
                ->where('stock.purchase_price', $detail->purchase_price)
                ->first();
            //if exists to branch
            if ($to_branch) {
                //update stocks
                $to_branch->stock->decrement('quantity', $detail->quantity);
            } else {
                $product->branches()->attach([
                    $old_product_transfer->to_branch_id =>  [
                        'quantity' => (-1 * $detail->quantity),
                        'purchase_price' => $detail->purchase_price,
                        'divisor_number' => $product->divisor_number,
                        'created_at' => now(),
                        'updated_at' => now()
                    ]
                ]);
            }

            //if exists from warehouse
            if ($from_branch) {
                //update stocks
                $from_branch->stock->increment('quantity', $detail->quantity);
            } else {
                $product->branches()->attach([
                    $old_product_transfer->from_branch_id =>  [
                        'quantity' => $detail->quantity,
                        'purchase_price' => $detail->purchase_price,
                        'divisor_number' => $product->divisor_number,
                        'created_at' => now(),
                        'updated_at' => now()
                    ]
                ]);
            }

            $detail->delete();
        }
    }

}
