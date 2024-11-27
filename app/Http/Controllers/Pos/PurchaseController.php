<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\PurchaseRequest;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Party;
use App\Models\Product;
use App\Models\Purchase;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PurchaseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $purchases = Purchase::query();
        $parties = Party::supplier()->select('id', 'name')->get();

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
                    $purchases = $purchases->whereBetween('date', $date);
                }
            }
        }

        if (\request('party_id')) {
            $purchases = $purchases->where('party_id', \request('party_id'));
        }

        if (\request('voucher_no')) {
            $purchases = $purchases->where('voucher_no', \request('voucher_no'));
        }

        $purchases = $purchases->with('purchaseCost')
            ->addPartyName()
            ->latest()
            ->paginate(30)
            ->withQueryString();

        return view('pos.purchase.index', compact('purchases', 'parties'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.purchase.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(PurchaseRequest $request)
    {

        $purchase_data = $request->validated();
        $purchase_data['user_id'] = Auth::user()->id;
        $purchase_data['voucher_no'] = 'Voucher' . '-' . str_pad(Purchase::max('id') + 1, 8, '0', STR_PAD_LEFT);

        DB::beginTransaction();
        try {
            $this->updatePartyBalance($request);
            // $party = Party::findOrFail($request->party_id);
            // $party->balance = (-1 * $request->party_remaining_balance);
            // $party->save();

            // create new purchase
            $purchase = Purchase::create($purchase_data);

            // update cash or bank balance
            $this->updateCashBankBalance($request);
            // save purchase cost
            $this->savePurchaseCost($request, $purchase);
            // save purchase details
            $this->savePurchaseDetails($request, $purchase);
            // Save purchase payment
            $this->savePurchasePayment($request, $purchase);

            DB::commit();
            return response()->json($purchase, 200);
        } catch (Exception $exception) {
            DB::rollback();
            return response()->json(['error' => $exception->getMessage()], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $purchase = Purchase::with(['details' => function ($query) {
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
        ->addSaleTotal()
        ->findOrFail($id);
        return view('pos.purchase.show', compact('purchase'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $purchase = Purchase::with(['details.product', 'purchaseCost', 'payments' => function ($query) {
            $query->where('is_first_payment', true)->first();
        }])->findOrFail($id);
        $purchase['formatted_date'] = $purchase->date->format('Y-m-d');

        return view('pos.purchase.edit', compact('purchase'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(PurchaseRequest $request, string $id)
    {
        // dd($request->all());
        $purchase_data = $request->validated();

        DB::beginTransaction();
        try {
            $purchase = Purchase::findOrFail($id);

            $this->updateOldPurchaseProductQuantity($purchase);
            $this->updateOldPurchaseCashBankBalance($purchase);
            $this->updateOldPartyBalance($purchase);

            $purchase->update($purchase_data);

            $this->updatePartyBalance($request);
            // update cash or bank balance
            $this->updateCashBankBalance($request);
            // save purchase cost
            $this->savePurchaseCost($request, $purchase);
            // save purchase details
            $this->savePurchaseDetails($request, $purchase);
            // Save purchase payment
            $this->savePurchasePayment($request, $purchase, 'update');

            DB::commit();
            return response()->json($purchase, 200);
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
        Purchase::findOrFail($id)->delete();

        return redirect()->route('purchase.index')->withSuccess('Purchase delete successfully!');
    }


    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $purchases = Purchase::latest()->onlyTrashed()
        ->paginate(30)
        ->withQueryString();

        return view('pos.purchase.trash', compact('purchases'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Purchase::withTrashed()->find($id)->restore();
        // view
        return redirect()->back()->withSuccess('Purchase restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $purchase = Purchase::withTrashed()->findOrFail($id);

        $this->updateOldPurchaseProductQuantity($purchase);
        $this->updateOldPurchaseCashBankBalance($purchase);
        $this->updateOldPartyBalance($purchase);

        $purchase->payments()->delete();

        $purchase->forceDelete();

        return redirect()->back()->withSuccess('Purchase deleted permanently.');
    }

    /**
     * update supplier balance
     * @param $request
     * @return void
     */
    public function updatePartyBalance($request)
    {
        // get supplier
        $party = Party::findOrFail($request->party_id);
        $party->balance = (-1 * $request->party_remaining_balance);
        $party->save();
    }

    /**
     * update cash or bank balance for purchase paid amount
     * @param $request
     * @return void
     */
    public function updateCashBankBalance($request)
    {
        if ($request->payment_type == 'cash') {
            Cash::findOrFail($request->cash_id)->decrement('balance', $request->paid);
        } else {
            BankAccount::findOrFail($request->bank_account_id)->decrement('balance', $request->paid);
        }
    }

    /**
     * save purchase cost
     * @param $request
     * @param $purchase
     * @return void
     */
    public function savePurchaseCost($request, $purchase)
    {
        // dd($request);
        $purchase_cost_data = $request->validate([
            'transport_cost' => 'nullable|numeric',
            // 'transport_cost_adjust_to_supplier' => 'required|boolean',
            'transport_cost_adjust_to_supplier' => 'required',
            'labour_cost' => 'nullable|numeric',
            // 'labour_cost_adjust_to_supplier' => 'required|boolean',
            'labour_cost_adjust_to_supplier' => 'required',
        ]);

        $purchase_cost_data['transport_cost_adjust_to_supplier'] = $request->transport_cost_adjust_to_supplier == "true" ? true : false;
        $purchase_cost_data['labour_cost_adjust_to_supplier'] = $request->labour_cost_adjust_to_supplier == "true" ? true : false;

        $existingPurchaseCost = $purchase->purchaseCost;

        // dd($existingPurchaseCost);

        if ($existingPurchaseCost) {
            // If a purchase cost record already exists, update it.
            $existingPurchaseCost->update($purchase_cost_data);
        } else {
            // If no purchase cost record exists, create a new one.
            $purchase->purchaseCost()->create($purchase_cost_data);
        }
    }


    /**
     * save purchase details
     * @param $request
     * @param $purchase
     * @return void
     */
    public function savePurchaseDetails($request, $purchase)
    {
        $products = json_decode($request->input('products'), true);
        foreach ($products as $product) {
            $filterProduct = Product::findOrFail($product['id']);

            $product_data = [
                'purchase_price' => $product['purchase_price'],
                'sale_price' => $product['sale_price'],
                'wholesale_price' => $product['wholesale_price'],
            ];
            $filterProduct->update($product_data);
            //select branch and same purchase price
            $previousStock = $filterProduct->branches
                            ->where('id', $request->branch_id)
                            ->where('stock.purchase_price', $product['purchase_price'])
                            ->first();

            //if exists branch
            if ($previousStock) {
                $previousStock->stock->increment('quantity', $product['quantity']);
            } else { // no previous branch exists
                //add new stock in for products
                $filterProduct->branches()->attach([
                    $request->branch_id =>  [
                        'quantity' => $product['quantity'],
                        'purchase_price' => $product['purchase_price'],
                        'divisor_number' => $filterProduct->divisor_number,
                        'created_at' => now(),
                        'updated_at' => now()
                    ]
                ]);
            }
            $purchase_details_data = [
                'date' => $purchase->date,
                'product_id' => $product['id'],
                // 'branch_id' =>$purchase->branch_id,
                'quantity' => $product['quantity'],
                'purchase_price' => $product['purchase_price'],
                'sale_price' => $product['sale_price'],
                'wholesale_price' => $product['wholesale_price'],
                'discount' => $product['discount'],
                // 'quantity_in_unit' => json_encode($product['quantity_in_unit']),
                'quantity_in_unit' => $product['quantity_in_unit'],
            ];
            $purchase->details()->create($purchase_details_data);
        }
    }

    /**
     * save purchase payment details
     * @param $request
     * @param $purchase
     * @return void
     */
    public function savePurchasePayment($request, $purchase, $from = 'create')
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
            $purchase->payments()->create($payment_data);
        } else {
            $payment = $purchase->payments()
                ->where('is_first_payment', true)
                ->first();

            if ($payment) {
                $payment->update($payment_data);
            } else {
                // Handle the case where the payment doesn't exist for the purchase
                throw new \Exception("Something went wrong!.Payment doesn't exist.");
            }
        }
    }

    public function updateOldPurchaseProductQuantity($purchase)
    {
        if (count($purchase->details) > 0) {
            foreach ($purchase->details as $detail) {
                // get product
                $product = Product::findOrFail($detail->product_id);
                $previousStock = $product->branches
                ->where('id', $purchase->branch_id)
                ->where('stock.purchase_price', $detail->purchase_price)
                ->first();

                // dd($previousStock);

                if ($previousStock) {
                    $stockQty = $previousStock->stock->quantity;
                    $newQuantity = $stockQty - $detail->quantity;

                    // Decrement quantity
                    if ($newQuantity == 0) {
                        $previousStock->stock->delete();
                    } else {
                        $previousStock->stock->decrement('quantity', $detail->quantity);
                    }
                    // $previousStock->stock->decrement('quantity', $detail->quantity);
                } else { // no previous warehouse exists
                    //add new stock in for products
                    $product->branches()->attach([
                        $purchase->branch_id =>  [
                            'quantity' => (-1 * $detail->quantity),
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
     * @param $old_purchase
     * @return void
     */
    public function updateOldPurchaseCashBankBalance($old_purchase)
    {
        $payment = $old_purchase->payments()
            // ->where('paymentable_id', $old_purchase->id)
            ->where('is_first_payment', true)
            ->first();

        if ($payment) {
            if ($payment->cash_id) {
                $payment->cash()->increment('balance', $payment->amount);
            } else {
                $payment->bankAccount()->increment('balance', $payment->amount);
            }
        }
    }

    public function updateOldPartyBalance($purchase)
    {
        $payment = $purchase->payments()
            // ->where('paymentable_id', $purchase->id)
            ->where('is_first_payment', true)
            ->first();

        if ($payment) {
            $purchase_due = $purchase->grand_total - $payment->amount;
            $purchase->party()->increment('balance', $purchase_due);
        }
    }
}
