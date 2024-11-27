<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Helpers\QuantityHelper;
use App\Http\Controllers\Controller;
use App\Models\BankAccount;
use App\Models\Branch;
use App\Models\Cash;
use App\Models\Expense;
use App\Models\IncomeRecord;
use App\Models\Invest;
use App\Models\InvestWithdraw;
use App\Models\Loan;
use App\Models\Party;
use App\Models\Product;
use App\Models\Purchase;
use App\Models\Salary;
use App\Models\Sale;
use Illuminate\Http\Request;

class NetProfitReportController extends Controller
{
    private array $data = [];
    /**
     * Display the Profit Loss Report.
     */
    public function index()
    {
        $this->data['branches'] = Branch::select('id', 'name')->where('active', 1)->get();

        $this->data['totalSaleAmount'] = Sale::get()->sum('grand_total');
        $this->data['totalPurchaseAmount'] = Purchase::with('purchaseCost')->get()->sum('grand_total');
        $this->data['totalGrossProfit'] = $this->data['totalSaleAmount'] - $this->data['totalPurchaseAmount'];

        // Fetch products with related information
        $products = Product::where('status', 1)->with(['unit' => function ($query) {
            $query->select('id', 'label', 'relation');
        }, 'stock'])->select('id', 'unit_id', 'purchase_price', 'divisor_number')->get();

        // Calculate total quantity and total damage quantity for each product
        $products = $products->map(function ($product) {
            $product['totalQuantity'] = $product->stock->sum('quantity');
            return $product;
        });

        //Assets start
        // Calculate total product price and total product damage price
        $this->data['totalProductPrice'] = $products->sum(function ($product) {
            return QuantityHelper::priceQuantity($product, $product->totalQuantity) * ($product->purchase_price / $product->divisor_number);
        });

        //Customer due
        $this->data['customerDue'] = Party::customer()->where('balance', '>', 0)->sum('balance');

        // Calculate cash balance and bank balance
        $this->data['cashBalance'] = Cash::sum('balance');
        $this->data['bankBalance'] = BankAccount::sum('balance');

        //Total Partial Income
        $this->data['totalIncome'] = IncomeRecord::get()->sum('amount');
        $loans = Loan::addDue()->get();

        //Loan Given
        $this->data['loanGivenDue'] = $loans->where('amount','<', 0)->sum('due');

        $this->data['totalAsset'] = $this->data['totalProductPrice']
                                + $this->data['customerDue']
                                + $this->data['cashBalance']
                                + $this->data['bankBalance']
//                                + $this->data['totalIncome']
                                + abs($this->data['loanGivenDue']);
        //Assets end

        // Liabilities start
        //Supplier due
        $this->data['supplierDue'] = Party::supplier()->where('balance', '<', 0)->sum('balance');
        $this->data['totalInvest'] = Invest::get()->sum('amount');
        //Loan Taken
        $this->data['loanTakenDue'] = $loans->where('amount', '>', 0)->sum('due');
        $this->data['totalLiability'] = abs($this->data['supplierDue'])
                                    + $this->data['loanTakenDue']
                                    + $this->data['totalInvest'];
        // Liabilities end

        // Expenses start
        $this->data['totalExpense'] = Expense::get()->sum('amount');
        $this->data['salary'] = Salary::addTotalSalaryPaidAmount()->get();
        $this->data['totalSalary'] = $this->data['salary']->sum('total_salary_paid');
        $this->data['total_invest_withdraw_amount'] = InvestWithdraw::get()->sum('amount');
        $this->data['totalExpenseAmount'] = $this->data['totalExpense'] + $this->data['totalSalary'] + $this->data['total_invest_withdraw_amount'];
        // Expenses end

        return view('pos.reports.net-profit.index')->with($this->data);
    }
}
