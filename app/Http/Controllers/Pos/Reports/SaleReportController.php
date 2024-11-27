<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\Detail;
use App\Models\Party;
use App\Models\Product;
use App\Models\Sale;
use Illuminate\Http\Request;

class SaleReportController extends Controller
{
    public $data = [];

    /**
     * Sale report
     */
    public function saleQtyReport()
    {
        // Fetch products and branches
        $this->data['products'] = Product::select('id', 'name')->where('status', 1)->get();
        $this->data['branches'] = Branch::select('id', 'name')->where('active', 1)->get();

        $saleDetails = Detail::query();

        if (\request()->search) {
            if (request()->from_date) {
                $saleDetails->whereBetween('details.date', [request()->from_date, request()->to_date]);
            }

            if (\request()->branch_id) {
                $saleDetails->where('detailable_type', Sale::class)->join('sales', 'details.detailable_id', '=', 'sales.id')
                ->where('sales.branch_id', \request()->branch_id);
            }

            if (\request()->product_id) {
                $saleDetails->where('product_id', \request()->product_id);
            }
        }
        // Add condition to filter only purchase details
        $saleDetails->where('detailable_type', Sale::class);

        $this->data['sale_details'] = $saleDetails
            ->selectRaw('product_id, details.date, sum(quantity) as total_quantity, sum(quantity * sale_price) as total_price')
            ->groupBy('product_id', 'details.date')
            ->with(['product' => function ($query) {
                $query->select('id', 'name', 'divisor_number', 'unit_id', 'sale_price')
                    ->addCategoryName()
                    ->addBrandName()
                    ->addUnitName()
                    ->addUnitLabel()
                    ->addUnitRelation();
            }])
            ->paginate(30)->withQueryString();

        return view('pos.reports.sale.sale-qty-report')->with($this->data);
    }

    /**
     * Sale voucher report
     */
    public function saleInvoiceReport()
    {
        // Fetch products and branches
        $this->data['products'] = Product::select('id', 'name')->where('status', 1)->get();
        $this->data['branches'] = Branch::select('id', 'name')->where('active', 1)->get();
        $this->data['parties'] = Party::customer()->select('id', 'name', 'phone')->where('active', 1)->get();

        $sales = Sale::query();
        if (\request()->search) {
            if (request()->from_date) {
                $sales = $sales->whereBetween('date', [request()->from_date, request()->to_date]);
            }
            if (\request()->party_id) {
                $sales = $sales->where('party_id', \request()->party_id);
            }

            if (\request()->branch_id) {
                $sales = $sales->where('branch_id', \request()->branch_id);
            }

            if (\request()->product_id) {
                $sales = $sales->with(['details' => function ($query) {
                    $query->where('product_id', request()->product_id);
                }])
                    ->whereHas('details', function ($query) {
                        $query->where('product_id', request()->product_id);
                    });
            }
        }

        $this->data['sales'] = $sales->with('party')->orderByDesc('id')->paginate(30)->withQueryString();

        return view('pos.reports.sale.sale-invoice-report')->with($this->data);
    }
}
