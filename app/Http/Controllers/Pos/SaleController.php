<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\SaleRequest;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Party;
use App\Models\Product;
use App\Models\Sale;
use Illuminate\Http\Request;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class SaleController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $sales = Sale::query();
        $parties = Party::customer()->select('id', 'name','phone')->get();

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
                    $sales = $sales->whereBetween('date', $date);
                }
            }
        }

        if (\request('party_id')) {
            $sales = $sales->where('party_id', \request('party_id'));
        }

        if (\request('invoice_no')) {
            $sales = $sales->where('invoice_no', \request('invoice_no'));
        }

        $sales = $sales->with('party')
            ->addPartyName()
            ->latest()
            ->paginate(30)->withQueryString();

        return view('pos.sale.index', compact('sales', 'parties'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.sale.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(SaleRequest $request)
    {
        // dd($request->all());
        $sale_data = $request->validated();
        $sale_data['user_id'] = Auth::user()->id;
        // $sale_data['invoice_no'] = $this->generateInvoiceNumber();
        $sale_data['invoice_no'] = 'Invoice' . '-' . str_pad(Sale::max('id') + 1, 8, '0', STR_PAD_LEFT);
        DB::beginTransaction();
        try {
            if ($request->customer_type == 'oldCustomer') {
                $customer = Party::findOrFail($request->party_id);
                $sale_data['party_id'] = $request->party_id;
            } else {
                $customer_data = [
                    'name' => $request->name,
                    'phone' => $request->phone,
                    'address' => $request->address,
                    'genus' => 'customer',
                ];
                $customer = Party::create($customer_data);
                $sale_data['party_id'] = $customer->id;
            }
            // create new sale
            $sale = Sale::create($sale_data);

            //Update customer balance
            $this->updatePartyBalance($request,$customer);
            // update cash or bank balance
            $this->updateCashBankBalance($request);
            // save sale details
            $this->saveSaleDetails($request, $sale);
            // Save purchase payment
            $this->saveSalePayment($request, $sale);

            DB::commit();
            return response()->json($sale, 200);
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
        }, 'party', 'payments' => function ($query) {
            $query->addPaymentMethod()
                ->addPaymentBy();
        }])
            ->addPartyName()
            ->addMrpTotal()
            ->findOrFail($id);
        return view('pos.sale.show', compact('sale'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $sale = Sale::with(['details.product', 'payments' => function ($query) {
            $query->where('is_first_payment', true)->first();
        }])->findOrFail($id);
        $sale['formatted_date'] = $sale->date->format('Y-m-d');

        return view('pos.sale.edit', compact('sale'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(SaleRequest $request, string $id)
    {
        $sale_data = $request->validated();

        DB::beginTransaction();
        try {
            $oldSale = Sale::findOrFail($id);

            $this->updateOldSaleProductQuantity($oldSale);
            $this->updateOldSaleCashBankBalance($oldSale);
            $this->updateOldPartyBalance($oldSale);

            $customer = Party::findOrFail($request->party_id);
            $sale_data['party_id'] = $request->party_id;

            if ($request->party_id == $oldSale->party_id) {
                $increment_balance = (($request->subtotal + $request->labour_cost + $request->transport_cost) - $request->discount) - $request->paid;
                $customer->increment('balance', $increment_balance);
            } else {
                $this->updatePartyBalance($request, $customer);
            }

            $oldSale->update($sale_data);
            // update cash or bank balance
            $this->updateCashBankBalance($request);
            // save sale details
            $this->saveSaleDetails($request, $oldSale);
            // Save purchase payment
            $this->saveSalePayment($request, $oldSale, 'update');

            DB::commit();
            return response()->json($oldSale, 200);
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
        Sale::findOrFail($id)->delete();
        return redirect()->route('sale.index')->withSuccess('Sale delete successfully!');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $sales = Sale::latest()->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.sale.trash', compact('sales'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Sale::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Sale restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $sale = Sale::withTrashed()->findOrFail($id);

        $this->updateOldSaleProductQuantity($sale);
        $this->updateOldSaleCashBankBalance($sale);
        $this->updateOldPartyBalance($sale);

        $sale->payments()->delete();

        $sale->forceDelete();

        return redirect()->back()->withSuccess('Sale deleted permanently.');
    }

    /**
     * generate a random order number
     * with time
     * with last order id + 1
     * with 6 random number
     * @return string
     */
    public function generateInvoiceNumber(): string
    {
        $prefix = 'Invoice';
        $timestamp = now()->format('YmdHis'); // Get the current timestamp in the format: YearMonthDayHourMinutesSeconds
        $saleID = Sale::withTrashed()->max('id') + 1; // last order id + 1
        $randomString = rand(1, 100000); // generate 6 random number

        return $prefix . $timestamp . $saleID . $randomString;
    }

    /**
     * update supplier balance
     * @param $request
     * @return void
     */
    public function updatePartyBalance($request,$customer)
    {
        if ($request->due > 0) {
            $customer->balance = $request->due;
        } else {
            // $customer->balance = (-1 * $request->change);
            $customer->balance = 0;
        }
        $customer->save();
    }

    /**
     * update cash or bank balance for purchase paid amount
     * @param $request
     * @return void
     */
    public function updateCashBankBalance($request)
    {
        if ($request->payment_type == 'cash') {
            Cash::findOrFail($request->cash_id)->increment('balance', $request->paid);
        } else {
            BankAccount::findOrFail($request->bank_account_id)->increment('balance', $request->paid);
        }
    }

    /**
     * store sale details product
     * @param $request
     * @param $sale
     * @return void
     */
    public function saveSaleDetails($request, $sale)
    {
        $products = json_decode($request->input('products'), true);
        foreach ($products as $product) {
            $filterProduct = Product::findOrFail($product['id']);
            $sale_details_data = [
                'date' => $sale->date,
                'product_id' => $product['id'],
                // 'branch_id' => $sale->branch_id,
                'quantity' => $product['quantity'],
                'purchase_price' => $product['purchase_price'],
                'sale_price' => $product['sale_price'],
                'wholesale_price' => $product['wholesale_price'],
                'discount' => $product['discount'],
                // 'quantity_in_unit' => json_encode($product['quantity_in_unit']),
                'quantity_in_unit' => $product['quantity_in_unit'],
            ];
            // create sale details
            $sale->details()->create($sale_details_data);

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
                    $sale->branch_id =>  [
                        'quantity' => -1 * $product['quantity'],
                        'purchase_price' => $product['purchase_price'],
                        'divisor_number' => $filterProduct->divisor_number,
                        'created_at' => now(),
                        'updated_at' => now()
                    ]
                ]);
            }
        }
    }

    /**
     * save purchase payment details
     * @param $request
     * @param $purchase
     * @return void
     */
    public function saveSalePayment($request, $sale, $from = 'create')
    {
        $payment_data = [
            'cash_id' => $request->cash_id,
            'bank_account_id' => $request->bank_account_id,
            'user_id' => Auth::user()->id,
            'date' => $request->date,
            'amount' => $request->paid,
            'is_first_payment' => true,
        ];

        if ($from === 'create') {
            $sale->payments()->create($payment_data);
        } else {
            $payment = $sale->payments()
                ->where('is_first_payment', true)
                ->first();

            if ($payment) {
                $payment->update($payment_data);
            } else {
                // Handle the case where the payment doesn't exist for the purchase
                // You might want to create it here if needed
            }
        }
    }

    /**
     * remove sales product & update quantity
     * @param $sale
     * @return void
     */
    public function updateOldSaleProductQuantity($sale)
    {
        if (count($sale->details) > 0) {
            foreach ($sale->details as $detail) {
                // get product
                $product = Product::findOrFail($detail->product_id);
                $previousStock = $product->branches
                    ->where('id', $sale->branch_id)
                    ->where('stock.purchase_price', $detail->purchase_price)
                    ->first();

                // dd($previousStock);

                if ($previousStock) {
                    $previousStock->stock->increment('quantity', $detail->quantity);
                } else { // no previous warehouse exists
                    //add new stock in for products
                    $product->branches()->attach([
                        $sale->branch_id =>  [
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

    /**
     * update previously paid amount in cash or bank
     * @param $old_sale
     * @return void
     */
    public function updateOldSaleCashBankBalance($oldSale)
    {
        $payment = $oldSale->payments()
            // ->where('paymentable_id', $old_purchase->id)
            ->where('is_first_payment', true)
            ->first();

        if ($payment) {
            if ($payment->cash_id) {
                $payment->cash()->decrement('balance', $payment->amount);
            } else {
                $payment->bankAccount()->decrement('balance', $payment->amount);
            }
        }
    }

    public function updateOldPartyBalance($oldSale)
    {
        $payment = $oldSale->payments()
            // ->where('paymentable_id', $purchase->id)
            ->where('is_first_payment', true)
            ->first();

        if ($payment) {
            $sale_due = $oldSale->grand_total - $payment->amount;
            $oldSale->party()->decrement('balance', $sale_due);
        }
    }
}
