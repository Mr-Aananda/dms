<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\Product;
use App\Models\Production;
use Illuminate\Http\Request;

class ProductionReportController extends Controller
{
    public $data = [];
    /**
     * Production report
     */
    public function index()
    {

        $productions= Production::query();
        if (\request()->search) {
            if (request()->from_date) {
                $productions = $productions->whereBetween('date', [request()->from_date, request()->to_date]);
            }

            if (\request()->branch_id) {
                $productions = $productions->where('branch_id', \request()->branch_id);
            }

            if (\request()->product_id) {
                $productions = $productions->with(['details' => function ($query) {
                    $query->where('product_id', request()->product_id);
                }])
                    ->whereHas('details', function ($query) {
                        $query->where('product_id', request()->product_id);
                    });
            }

        }
        $this->data['productions'] = $productions->with('details')->orderByDesc('id')->paginate(30)->withQueryString();

        $this->data['branches'] = Branch::select('id', 'name')->where('active', 1)->get();
        $this->data['products'] = Product::select('id', 'name')->where('status', 1)->get();

        return view('pos.reports.production.index')->with($this->data);

    }

}
