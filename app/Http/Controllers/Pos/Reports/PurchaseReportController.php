<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\Detail;
use App\Models\Party;
use App\Models\Product;
use App\Models\Purchase;
use Illuminate\Http\Request;

class PurchaseReportController extends Controller
{
    public $data = [];

    /**
     * Purchase qty report
     */
    public function purchaseQtyReport()
    {
        // Fetch products and branches
        $this->data['products'] = Product::select('id', 'name')->where('status', 1)->get();
        $this->data['branches'] = Branch::select('id', 'name')->where('active', 1)->get();

        $purchaseDetails = Detail::query();

        if (\request()->search) {
            if (request()->from_date) {
                $purchaseDetails->whereBetween('details.date', [request()->from_date, request()->to_date]);
            }

            if (\request()->branch_id) {
                $purchaseDetails->where('detailable_type', Purchase::class)->join('purchases', 'details.detailable_id', '=', 'purchases.id')
                    ->where('purchases.branch_id', \request()->branch_id);
            }

            if (\request()->product_id) {
                $purchaseDetails->where('product_id', \request()->product_id);
            }
        }

        // Add condition to filter only purchase details
        $purchaseDetails->where('detailable_type', Purchase::class);

        $this->data['purchase_details'] = $purchaseDetails
        ->selectRaw('product_id, details.date, sum(quantity) as total_quantity, sum(quantity * purchase_price) as total_price')
        ->groupBy('product_id', 'details.date')
        ->with(['product' => function ($query) {
            $query->select('id', 'name', 'divisor_number', 'unit_id', 'purchase_price')
            ->addCategoryName()
            ->addBrandName()
            ->addUnitName()
            ->addUnitLabel()
            ->addUnitRelation();
        }])
        ->paginate(30)->withQueryString();

        return view('pos.reports.purchase.purchase-qty-report')->with($this->data);
    }




    /**
     * Purchase voucher report
     */
    public function purchaseVoucherReport()
    {
        // Fetch products and branches
        $this->data['products'] = Product::select('id', 'name')->where('status', 1)->get();
        $this->data['branches'] = Branch::select('id', 'name')->where('active', 1)->get();
        $this->data['parties'] = Party::supplier()->select('id', 'name','phone')->where('active', 1)->get();

        $purchases= Purchase::query();
        if (\request()->search) {
            if (request()->from_date) {
                $purchases = $purchases->whereBetween('date', [request()->from_date, request()->to_date]);
            }
            if (\request()->party_id) {
                $purchases = $purchases->where('party_id', \request()->party_id);
            }

            if (\request()->branch_id) {
                $purchases = $purchases->where('branch_id', \request()->branch_id);
            }

            if (\request()->product_id) {
                $purchases = $purchases->with(['details' => function ($query) {
                    $query->where('product_id', request()->product_id);
                }])
                ->whereHas('details', function ($query) {
                    $query->where('product_id', request()->product_id);
                });
            }
        }

        $this->data['purchases'] = $purchases->with('party')->orderByDesc('id')->paginate(30)->withQueryString();

        return view('pos.reports.purchase.purchase-voucher-report')->with($this->data);
    }
}
