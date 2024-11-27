<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Sale;
use Illuminate\Http\Request;

class BarcodeController extends Controller
{
    public function saleBarcode()
    {
        $sale = null;
        if (\request('invoice_no')) {
            $sale = Sale::with(['details' => function ($query) {
                    $query->addProductName()
                        ->with(['product' => function ($query) {
                            $query->select('id', 'name', 'divisor_number', 'barcode', 'unit_id', 'purchase_price', 'wholesale_price', 'sale_price')
                                ->addCategoryName()
                                ->addBrandName()
                                ->addUnitName()
                                ->addUnitLabel()
                                ->addUnitRelation();
                        }]);
                }])
                ->where('invoice_no', \request('invoice_no'))
                ->first();
        }
        return view('pos.barcode.sale', compact('sale'));
    }

    public function generateSaleBarcode(Request $request)
    {
        $sale = json_decode($request->input('data'), true);
        return view('pos.barcode.sale-barcode', compact('sale'));
    }


    public function singleSticker(Request $request)
    {
        $products = Product::select('id', 'name', 'wholesale_price','sale_price','purchase_price')->get(); // Assuming 'mrp' is the field name for the price.

        $stickers = [];
        if ($request->has('product_id') && $request->has('quantity')) {
            $product = Product::find($request->product_id);
            $quantity = $request->quantity;
            $importerName = $request->importer_name;

            // Prepare stickers
            for ($i = 0; $i < $quantity; $i++) {
                $stickers[] = [
                    'importer_name' => $importerName,
                    'product_name' => $product->name,
                    'mrp' => $product->wholesale_price
                ];
            }
        }

        return view('pos.barcode.single-sticker', compact('products', 'stickers'));
    }


    public function invoiceSticker()
    {
        $sale = null;
        if (\request('invoice_no')) {
            $sale = Sale::with(['details' => function ($query) {
                $query->addProductName()
                    ->with(['product' => function ($query) {
                        $query->select('id', 'name', 'divisor_number', 'barcode', 'unit_id', 'purchase_price', 'wholesale_price', 'sale_price')
                        ->addCategoryName()
                            ->addBrandName()
                            ->addUnitName()
                            ->addUnitLabel()
                            ->addUnitRelation();
                    }]);
            }])
                ->where('invoice_no', \request('invoice_no'))
                ->first();
        }
        return view('pos.barcode.invoice-sticker', compact('sale'));
    }

    public function generateInvoiceSticker(Request $request)
    {
        $sale = json_decode($request->input('data'), true);
        return view('pos.barcode.invoice-sticker-show', compact('sale'));
    }

}
