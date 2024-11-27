<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\PurchaseReturnRequest;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Party;
use App\Models\Product;
use App\Models\PurchaseReturn;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Exception;
use Illuminate\Support\Facades\DB;

class PurchaseReturnController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $returns = PurchaseReturn::query();
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
                    $returns = $returns->whereBetween('date', $date);
                }
            }
        }

        if (\request('party_id')) {
            $returns = $returns->where('party_id', \request('party_id'));
        }

        if (\request('return_no')) {
            $returns = $returns->where('return_no', \request('return_no'));
        }

        $returns = $returns->addPartyName()
            ->latest()
            ->paginate(30)->withQueryString();

        return view('pos.purchase.return.index', compact('returns', 'parties'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.purchase.return.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(PurchaseReturnRequest $request)
    {
        // return $request->all();
        $purchase_return_data = $request->validated();
        $purchase_return_data['user_id'] = Auth::user()->id;
        $purchase_return_data['return_no'] = 'Return-' . str_pad(PurchaseReturn::max('id') + 1, 8, 0, STR_PAD_LEFT);

        DB::beginTransaction();
        try {
            // create new purchase
            $purchase_return = PurchaseReturn::create($purchase_return_data);

            $this->updatePartyBalance($request);

            // update cash or bank balance
            $this->updateCashBankBalance($request);

            // save purchase details
            $this->savePurchaseReturnDetails($request, $purchase_return);
            // dd($purchase_return);
            // Save purchase payment
            $this->savePurchaseReturnPayment($request, $purchase_return);

            DB::commit();
            return response()->json($purchase_return, 200);
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
        $return = PurchaseReturn::with(['details' => function ($query) {
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
        ->findOrFail($id);
        return view('pos.purchase.return.show', compact('return'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $return = PurchaseReturn::with(['details.product', 'payments' => function ($query) {
            $query->where('is_first_payment', true)->first();
        }])->findOrFail($id);
        $return['formatted_date'] = $return->date->format('Y-m-d');

        return view('pos.purchase.return.edit', compact('return'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(PurchaseReturnRequest $request, string $id)
    {
        $purchase_return_data = $request->validated();

        DB::beginTransaction();
        try {
            $purchase_return = PurchaseReturn::findOrFail($id);

            $this->updateOldPurchaseReturnProductQuantity($purchase_return);
            $this->updateOldPurchaseReturnCashBankBalance($purchase_return);
            $this->updateOldPartyBalance($purchase_return);

            $purchase_return->update($purchase_return_data);

            $this->updatePartyBalance($request);

            // update cash or bank balance
            $this->updateCashBankBalance($request);

            // save purchase details
            $this->savePurchaseReturnDetails($request, $purchase_return);
            // dd($purchase_return);
            // Save purchase payment
            $this->savePurchaseReturnPayment($request, $purchase_return, 'update');

            DB::commit();
            return response()->json($purchase_return, 200);
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
        PurchaseReturn::findOrFail($id)->delete();

        return redirect()->route('purchase-return.index')->withSuccess('Purchase return delete successfully!');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $returns = PurchaseReturn::latest()->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.purchase.return.trash', compact('returns'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        PurchaseReturn::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Purchase return restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $return = PurchaseReturn::withTrashed()->findOrFail($id);

        $this->updateOldPurchaseReturnProductQuantity($return);
        $this->updateOldPurchaseReturnCashBankBalance($return);
        $this->updateOldPartyBalance($return);

        $return->payments()->delete();

        $return->forceDelete();

        return redirect()->back()->withSuccess('Purchase return deleted permanently.');
    }

    /**
     * update supplier balance
     * @param $request
     * @return void
     */
    public function updatePartyBalance($request)
    {
        // get supplier
        $supplier = Party::findOrFail($request->party_id);
        $supplier->balance = $request->party_remaining_balance;
        $supplier->save();
    }

    public function updateOldPartyBalance($return)
    {
        // $payment = $return->payments()
        //     // ->where('paymentable_id', $purchase->id)
        //     ->where('is_first_payment', true)
        //     ->first();

        // if ($payment) {
        //     $purchase_due = $return->grand_total + $payment->amount;
        //     $return->party()->decrement('balance', $purchase_due);
        // }

        if ($return->return_due > 0) {
            $return->party()->decrement('balance', $return->return_due);
        } else {
            $return->party()->increment('balance', ($return->return_total_paid - $return->return_grand_total));
        }
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
     * save purchase details
     * @param $request
     * @param $purchase
     * @return void
     */
    public function savePurchaseReturnDetails($request, $return)
    {
        $products = json_decode($request->input('products'), true);
        foreach ($products as $product) {
            $filterProduct = Product::findOrFail($product['id']);

            $previousStock = $filterProduct->branches
                ->where('id', $request->branch_id)
                ->where('stock.purchase_price', $product['purchase_price'])
                ->first();
            //if exists branch
            if ($previousStock) {
                if ($request->return_type == 'stock_return') {
                    $previousStock->stock->decrement('quantity', $product['quantity']);
                } else {
                    $previousStock->stock->decrement('damage_quantity', $product['quantity']);
                }
            }
            else{
                // throw new \Exception('Please select a valid branch or purchase price for ' . $filterProduct->name);
                $filterProduct->branches()->attach([
                    $return->branch_id =>  [
                        'quantity' => -1 * $return->return_type == 'stock_return' ? $product['quantity'] : 0,
                        'damage_quantity' => $request->return_type == 'stock_return' ? 0 : $product['damage_quantity'],
                        'purchase_price' => $product['purchase_price'],
                        'divisor_number' => $filterProduct->divisor_number,
                        'created_at' => now(),
                        'updated_at' => now()
                    ]
                ]);
            }

            $purchase_return_details_data = [
                'date' => $return->date,
                'product_id' => $product['id'],
                // 'branch_id' => $return->branch_id,
                'quantity' => $product['quantity'],
                'purchase_price' => $product['purchase_price'],
                'return_price' => $product['return_price'],
                // 'quantity_in_unit' => json_encode($product['quantity_in_unit']),
                'quantity_in_unit' => $product['quantity_in_unit'],
            ];
            $return->details()->create($purchase_return_details_data);
        }
    }

    /**
     * save purchase payment details
     * @param $request
     * @param $purchase
     * @return void
     */
    public function savePurchaseReturnPayment($request, $purchase, $from = 'create')
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
                // You might want to create it here if needed
            }
        }
    }

    public function updateOldPurchaseReturnProductQuantity($return)
    {
        if (count($return->details) > 0) {
            foreach ($return->details as $detail) {
                // get product
                $product = Product::findOrFail($detail->product_id);
                $previousStock = $product->branches
                    ->where('id', $return->branch_id)
                    ->where('stock.purchase_price', $detail->purchase_price)
                    ->first();

                // dd($previousStock);

                if ($previousStock) {
                    if ($return->return_type == 'stock_return') {

                        $previousStock->stock->increment('quantity', $detail->quantity);
                    }
                    else{
                        $previousStock->stock->increment('damage_quantity', $detail->quantity);
                    }
                } else { // no previous branch exists
                    //add new stock in for products
                    $product->branches()->attach([
                        $return->branch_id =>  [
                            'quantity' => $return->return_type == 'stock_return' ? $detail->quantity : 0,
                            'damage_quantity' => $return->return_type == 'stock_return' ? 0 : $detail->quantity,
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
     * @param $return
     * @return void
     */
    public function updateOldPurchaseReturnCashBankBalance($return)
    {
        $payment = $return->payments()
            // ->where('paymentable_id', $return->id)
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

}
