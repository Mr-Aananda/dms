<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\Category;
use App\Models\Product;
use Carbon\Carbon;
use Illuminate\Http\Request;

class StockReportController extends Controller
{
    public $data = [];

    /**
     * Production report
     */
    public function index()
    {
        // $from_date = request()->date ?? now()->toDateString();
        // $to_date = now()->toDateString();

        // return request()->all();

        $products_query = Product::query();
        if (\request()->search) {
            $this->data['product_id'] = request()->product_id;
            $this->data['date'] = request()->date;
            $this->data['branch_id'] = request()->branch_id;
            if (\request()->product_id) {
                $products_query = $products_query->where('id', \request()->product_id);
            }
            if (\request()->category_id) {
                $products_query = $products_query->where('category_id', \request()->category_id);
            }
            if (\request()->branch_id) {
                $products_query = $products_query->with(['branches' => function ($query) {
                    $query->where('branch_id', request()->branch_id);
                }])
                    ->whereHas('branches', function ($query) {
                        $query->where('branch_id', request()->branch_id);
                    });
            }

            $products_query = $products_query->with([
                'details' => function ($query) {
                    $query->where('date', request()->date);
                },
                'productionDetails' => function ($query) {
                    $query->where('date', request()->date);
                },
            ]);

        }

        $this->data['products_query'] = $products_query
        ->where('status', 1)
        ->addTotalProductQuantity()
        ->addTotalProductQuantityBranchWise()
        ->addDamageQuantity()
        ->addUnitLabel()
        ->addUnitRelation()
        ->paginate(25)
        ->withQueryString();


        $this->data['branches'] = Branch::select('id', 'name')->where('active', 1)->get();
        $this->data['products'] = Product::select('id', 'name')->where('status', 1)->get();
        $this->data['categories'] = Category::select('id', 'name')->get();
        return view('pos.reports.stock.index')->with($this->data);
    }

}
