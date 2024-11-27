<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Helpers\Converter;
use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\Damage;
use App\Models\Detail;
use App\Models\DueManage;
use App\Models\Party;
use App\Models\Product;
use App\Models\ProductionDetails;
use App\Models\Purchase;
use App\Models\PurchaseReturn;
use App\Models\Sale;
use App\Models\SaleReturn;
use Illuminate\Http\Request;
use ProtoneMedia\LaravelCrossEloquentSearch\Search;


class LedgerController extends Controller
{
    public $data = [];

    /**
     * customer ledger details
     *
     */
    public function customerLedger()
    {
        $this->data['parties'] = Party::customer()->get();
        $this->data['total_debit'] = 0;
        $this->data['total_credit'] = 0;
        $this->data['total_adjustment'] = 0;
        $this->data['total_discount'] = 0;

        $this->data['party'] = Party::where('id', request()->party_id)->first();
        $this->data['party_balance'] = $this->data['party']->balance ?? 0;

        $sale_query = Sale::query()
            ->where('party_id', request()->party_id)
            ->selectRaw("*, 'sale' as 'type'");

        $sale_return_query = SaleReturn::query()
            ->where('party_id', request()->party_id)
            ->selectRaw("*, 'sale_return' as 'type'");

        $due_management_query = DueManage::query()
            ->where('party_id', request()->party_id)
            ->selectRaw("*, 'due_manage' as 'type'");

        if (request()->from_date) {
            $sale_query->whereDate('date', '>=', request()->from_date);
            $sale_return_query->whereDate('date', '>=', \request('from_date'));
            $due_management_query->whereDate('date', '>=', request()->from_date);
        }

        if (request()->to_date) {
            $sale_query->whereDate('date', '<=', request()->to_date);
            $sale_return_query->whereDate('date', '<=', \request('to_date'));
            $due_management_query->whereDate('date', '<=', request()->to_date);
        }

        $this->data['party_ledgers'] =
        Search::add($sale_query)
            ->orderBy('date')
            ->add($sale_return_query)
            ->orderBy('date')
            ->add($due_management_query)
            ->orderBy('date')
            ->search();


        foreach ($this->data['party_ledgers'] as $ledger) {
            $this->data['total_discount'] += $ledger->discount;
            $this->data['total_debit'] += ($ledger->grand_total + $ledger->return_total_paid);
            $this->data['total_credit'] += ($ledger->total_paid + $ledger->return_grand_total);
            if ($ledger->type == 'due_manage') {
                $this->data['total_adjustment'] += $ledger->adjustment;
                if ($ledger->amount <= 0) {
                    $this->data['total_debit'] += abs($ledger->amount);
                } else {
                    $this->data['total_credit'] += $ledger->amount + $ledger->adjustment;
                }
            }
        }
        // return $this->data;
        return view('pos.reports.ledger.customer-ledger')->with($this->data);
    }

    /**
     * supplier ledger details
     *
     */
    public function supplierLedger()
    {
        $this->data['parties'] =  Party::supplier()->get();
        $this->data['total_debit'] = 0;
        $this->data['total_credit'] = 0;
        $this->data['total_adjustment'] = 0;
        $this->data['total_discount'] = 0;

        $this->data['party'] = Party::where('id', request()->party_id)->first();
        $this->data['party_balance'] = $this->data['party']->balance ?? 0;

        $purchase_query = Purchase::query()
            ->where('party_id', request()->party_id)
            ->selectRaw("*, 'purchase' as 'type'");

        $purchase_return_query = PurchaseReturn::query()
            ->where('party_id', request()->party_id)
            ->selectRaw("*, 'purchase_return' as 'type'");

        $supplier_due_management_query = DueManage::query()
            ->where('party_id', request()->party_id)
            ->selectRaw("*, 'due_manage' as 'type'");

        if (\request('from_date')) {
            $purchase_query->whereDate('date', '>=', \request('from_date'));
            $purchase_return_query->whereDate('date', '>=', \request('from_date'));
            $supplier_due_management_query->whereDate('date', '>=', \request('from_date'));
        }

        if (\request('to_date')) {
            $purchase_query->whereDate('date', '<=', \request('to_date'));
            $purchase_return_query->whereDate('date', '<=', \request('to_date'));
            $supplier_due_management_query->whereDate('date', '<=', \request('to_date'));
        }

        $this->data['party_ledgers'] =
        Search::add($purchase_query)
            ->orderBy('date')
            ->add($purchase_return_query)
            ->orderBy('date')
            ->add($supplier_due_management_query)
            ->orderBy('date')
            ->search();

        // dd($this->data['party_ledgers']);
        foreach ($this->data['party_ledgers'] as $ledger) {
            $this->data['total_discount'] += $ledger->discount;
            $this->data['total_debit'] += $ledger->grand_total + $ledger->return_total_paid;
            $this->data['total_credit'] += ($ledger->return_grand_total + $ledger->total_paid);

            if ($ledger->type == 'due_manage') {
                $this->data['total_adjustment'] += $ledger->adjustment;
                if ($ledger->amount <= 0) {
                    $this->data['total_credit'] += abs($ledger->amount);
                } else {
                    $this->data['total_debit'] += abs($ledger->amount);
                }
            }

            // dd($ledger->return_total_paid);

        }

        // return $this->data;

        return view('pos.reports.ledger.supplier-ledger')->with($this->data);
    }


    /**
     * Supplier ledger details
     */
    public function productLedger()
    {
        // Fetch products and branches
        $this->data['products'] = Product::select('id', 'name')->where('status', 1)->get();
        $this->data['branches'] = Branch::select('id', 'name')->where('active', 1)->get();

        // Get request parameters
        $product_id = request('product_id');
        $from_date = request('from_date');
        $to_date = request('to_date');
        $branch_id = request('branch_id');

        // Fetch ledger details
        $ledgerDetails = Detail::with('detailable')
            ->where('product_id', $product_id)
            ->when($from_date, function ($query) use ($from_date) {
                return $query->where('date', '>=', $from_date);
            })
            ->when($to_date, function ($query) use ($to_date) {
                return $query->where('date', '<=', $to_date);
            })
            ->when($branch_id, function ($query) use ($branch_id) {
                return $query->whereHas('detailable', function ($subQuery) use ($branch_id) {
                    $subQuery->where('branch_id', $branch_id);
                });
            })
            ->orderBy('date')
            ->get();

        // Fetch production details
        $productionDetails = ProductionDetails::where('product_id', $product_id)
            ->when($from_date, function ($query) use ($from_date) {
                return $query->whereHas('production', function ($subQuery) use ($from_date) {
                    $subQuery->where('date', '>=', $from_date);
                });
            })
            ->when($to_date, function ($query) use ($to_date) {
                return $query->whereHas('production', function ($subQuery) use ($to_date) {
                    $subQuery->where('date','<=', $to_date);
                });
            })
            ->when($branch_id, function ($query) use ($branch_id) {
                return $query->whereHas('production', function ($subQuery) use ($branch_id) {
                    $subQuery->where('branch_id', $branch_id);
                });
            })
            ->orderBy('created_at')
            ->get();

        // Initialize variables
        $formattedDetails = [];
        $remainingQuantity = 0;

        $totalSale = 0;
        $totalPurchase = 0;
        $totalSaleReturn = 0;
        $totalPurchaseReturn = 0;
        $totalDamage = 0;
        $totalProduction = 0;

        // Find product details
        $findProduct = Product::addUnitLabel()->addUnitRelation()->find($product_id);

        // Process ledger details
        foreach ($ledgerDetails as $detail) {
            $quantity = floatval($detail->quantity);

            if ($detail->detailable instanceof Purchase) {
                // Handle purchase details
                $totalPurchase += $quantity;
                $remainingQuantity += $quantity;
                $status = 'Purchase';
                $invoice_voucher = $detail->detailable->voucher_no;
            } elseif ($detail->detailable instanceof Sale) {
                // Handle sale details
                $totalSale += $quantity;
                $remainingQuantity -= $quantity;
                $status = 'Sale';
                $invoice_voucher = $detail->detailable->invoice_no;
            } elseif ($detail->detailable instanceof Damage) {
                // Handle damage details
                $totalDamage += $quantity;
                $remainingQuantity -= $quantity;
                $status = 'Damage';
                $invoice_voucher = $detail->detailable->damage_no;
            } elseif ($detail->detailable instanceof PurchaseReturn) {
                // Handle purchase return details
                $totalPurchaseReturn += $quantity;
                $remainingQuantity -= $detail->detailable->return_type == 'stock_return' ? $quantity : 0;
                $status =  $detail->detailable->return_type == 'stock_return' ? 'Purchase Return (Stock)' : 'Purchase Return (Damage)';
                $invoice_voucher = 'Purchase ' . $detail->detailable->return_no;
            } elseif ($detail->detailable instanceof SaleReturn) {
                // Handle sale return details
                $totalSaleReturn += $quantity;
                $remainingQuantity += $quantity;
                $status = 'Sale Return';
                $invoice_voucher = 'Sale ' . $detail->detailable->return_no;
            } else {
                $status = "Something Went Wrong";
            }

            // Format details and add to the array
            $formattedDetails[] = [
                'date' => $detail->date,
                'status' => $status,
                'invoice_voucher' => $invoice_voucher,
                'quantity' => Converter::convertToUpperUnit($quantity, $findProduct->unit_label, $findProduct->unit_relation),
                'remaining_quantity' => Converter::convertToUpperUnit($remainingQuantity, $findProduct->unit_label, $findProduct->unit_relation),
            ];
        }

        // Process production details
        foreach ($productionDetails as $productionDetail) {
            $quantity = floatval($productionDetail->quantity);

            // Handle production details
            if ($productionDetail->production_type == 'raw_product') {
                $totalProduction += $quantity;
                $remainingQuantity -= $quantity;
            } else {
                $totalProduction += $quantity;
                $remainingQuantity += $quantity;
            }

            // Format details and add to the array
            $formattedDetails[] = [
                'date' => $productionDetail->production->date->format('Y-m-d'),
                'status' => $productionDetail->production_type == 'raw_product' ? 'Production (Cut Quantity)' : 'Production (Add Quantity)',
                'invoice_voucher' => $productionDetail->production->production_no,
                'quantity' => Converter::convertToUpperUnit($quantity, $findProduct->unit_label, $findProduct->unit_relation),
                'remaining_quantity' => Converter::convertToUpperUnit($remainingQuantity, $findProduct->unit_label, $findProduct->unit_relation),
            ];
        }

        // Add total quantities to the view data
        if (request()->search) {
            $this->data['totalSale'] = Converter::convertToUpperUnit($totalSale, $findProduct->unit_label, $findProduct->unit_relation);
            $this->data['totalPurchase'] = Converter::convertToUpperUnit($totalPurchase, $findProduct->unit_label, $findProduct->unit_relation);
            $this->data['totalSaleReturn'] = Converter::convertToUpperUnit($totalSaleReturn, $findProduct->unit_label, $findProduct->unit_relation);
            $this->data['totalPurchaseReturn'] = Converter::convertToUpperUnit($totalPurchaseReturn, $findProduct->unit_label, $findProduct->unit_relation);
            $this->data['totalDamage'] = Converter::convertToUpperUnit($totalDamage, $findProduct->unit_label, $findProduct->unit_relation);
            $this->data['totalProduction'] = Converter::convertToUpperUnit($totalProduction, $findProduct->unit_label, $findProduct->unit_relation);
        }

        // Add formatted details to the view data
        $this->data['ledgerDetails'] = $formattedDetails;

        // Return the view
        return view('pos.reports.ledger.product-ledger')->with($this->data);
    }



}
