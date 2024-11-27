<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Http\Controllers\Controller;
use App\Models\Branch;
use App\Models\Expense;
use App\Models\IncomeRecord;
use App\Models\Invest;
use App\Models\InvestWithdraw;
use App\Models\Purchase;
use App\Models\Salary;
use App\Models\Sale;
use App\Models\SaleReturn;
use App\Models\Stock;
use Carbon\Carbon;
use Illuminate\Http\Request;

class ProfitLossReportController extends Controller
{
    private array $data = [];
    /**
     * Display the Profit Loss Report.
     */
    public function index()
    {
        $this->calculateTotalAmounts();

        $this->data['branches'] = Branch::select('id', 'name')->where('active', 1)->get();

        return view('pos.reports.profit-loss.index')->with($this->data);
    }

    /**
     * Calculate various total amounts.
     */
    private function calculateTotalAmounts()
    {
        $this->data['total_sales_amount'] = $this->totalSalesAmount();
        $this->data['total_purchase_amount'] = $this->totalPurchasesAmount();
        $this->data['total_sales_return_purchase_amount'] = $this->totalSalesReturnPurchaseAmount();
        $this->data['total_sales_return_sale_amount'] = $this->totalSalesReturnSaleAmount();
        $this->data['total_expenses_amount'] = $this->totalExpensesAmount();
        $this->data['total_income_amount'] = $this->totalIncomeAmount();
        $this->data['total_invest_amount'] = $this->totalInvestAmount();
        $this->data['total_invest_withdraw_amount'] = $this->totalInvestWithdrawAmount();
        $this->data['total_salary_paid_amount'] = $this->totalSalaryPaidAmount();
        $this->data['total_stock_price'] = $this->totalStockPrice();

    }

    /**
     * Sales data for request query.
     * Default data is running month data.
     *
     * @return mixed
     */
    public function saleQuery()
    {
        $from_date = \request()->from_date ?? Carbon::now()->startOfMonth();
        $to_date = \request()->to_date ?? Carbon::now()->endOfMonth();
        $branch_id = \request()->branch_id;
        $sales = Sale::query();
        if ($branch_id) {
            $sales = $sales->where('branch_id', $branch_id);
        }
        if ($from_date) {
            $sales = $sales->whereBetween('date', [$from_date, $to_date]);
        }
        return $sales->get();
    }
    /**
     * Sales data for request query.
     * Default data is running month data.
     *
     * @return mixed
     */
    public function purchaseQuery()
    {
        $from_date = \request()->from_date ?? Carbon::now()->startOfMonth();
        $to_date = \request()->to_date ?? Carbon::now()->endOfMonth();
        $branch_id = \request()->branch_id;
        $purchases = Purchase::query();
        if ($branch_id) {
            $purchases = $purchases->where('branch_id', $branch_id);
        }
        if ($from_date) {
            $purchases = $purchases->whereBetween('date', [$from_date, $to_date]);
        }
        return $purchases->get();
    }

    /**
     * sale return data for request query.
     * Default data is running month data.
     *
     * @return mixed
     */
    public function saleReturnQuery()
    {
        $from_date = \request()->from_date ?? Carbon::now()->startOfMonth();
        $to_date = \request()->to_date ?? Carbon::now()->endOfMonth();
        $branch_id = \request()->branch_id;
        $sale_returns = SaleReturn::query();
        if ($branch_id) {
            $sale_returns = $sale_returns->where('branch_id', $branch_id);
        }
        if ($from_date) {
            $sale_returns = $sale_returns->whereBetween('date', [$from_date, $to_date]);
        }
        return $sale_returns->addTotalPurchasePrice()->get();
    }

    /**
     * expense data for request query.
     * Default data is running month data.
     *
     * @return mixed
     */
    public function expenseQuery()
    {
        $from_date = \request()->from_date ?? Carbon::now()->startOfMonth();
        $to_date = \request()->to_date ?? Carbon::now()->endOfMonth();
        $branch_id = \request()->branch_id;
        $expenses = Expense::query();
        if ($branch_id) {
            $expenses = $expenses->where('branch_id', $branch_id);
        }
        if ($from_date) {
            $expenses = $expenses->whereBetween('date', [$from_date, $to_date]);
        }
        return $expenses->get();
    }

    /**
     * income data for request query
     * default data is running month data
     * @return mixed
     */
    public function incomeQuery()
    {
        $from_date = \request()->from_date ?? Carbon::now()->startOfMonth();
        $to_date = \request()->to_date ?? Carbon::now()->endOfMonth();
        $branch_id = \request()->branch_id;
        $incomeRecords = IncomeRecord::query();
        if ($branch_id) {
            $incomeRecords = $incomeRecords->where('branch_id', $branch_id);
        }
        if ($from_date) {
            $incomeRecords = $incomeRecords->whereBetween('date', [$from_date, $to_date]);
        }
        return $incomeRecords->get();
    }

    /**
     * income data for request query
     * default data is running month data
     * @return mixed
     */
    public function investQuery()
    {
        $from_date = \request()->from_date ?? Carbon::now()->startOfMonth();
        $to_date = \request()->to_date ?? Carbon::now()->endOfMonth();
        $branch_id = \request()->branch_id;
        $invests = Invest::query();
        if ($branch_id) {
            $invests = $invests->where('branch_id', $branch_id);
        }
        if ($from_date) {
            $invests = $invests->whereBetween('date', [$from_date, $to_date]);
        }
        return $invests->get();
    }
    /**
     * income data for request query
     * default data is running month data
     * @return mixed
     */
    public function investWithdrawQuery()
    {
        $from_date = \request()->from_date ?? Carbon::now()->startOfMonth();
        $to_date = \request()->to_date ?? Carbon::now()->endOfMonth();
        $branch_id = \request()->branch_id;
        $investWithdraws = InvestWithdraw::query();
        if ($branch_id) {
            $investWithdraws = $investWithdraws->where('branch_id', $branch_id);
        }
        if ($from_date) {
            $investWithdraws = $investWithdraws->whereBetween('date', [$from_date, $to_date]);
        }
        return $investWithdraws->get();
    }

    /**
     * income data for request query
     * default data is running month data
     * @return mixed
     */
    public function salaryPaidQuery()
    {
        $from_date = \request()->from_date ?? Carbon::now()->startOfMonth();
        $to_date = \request()->to_date ?? Carbon::now()->endOfMonth();

        $salaries = Salary::query();

        if ($from_date) {
            $salaries = $salaries->whereBetween('given_date', [$from_date, $to_date]);
        }
        else{
            $salaries = $salaries->whereBetween('given_date', [$from_date, $to_date]);
        }
        return $salaries->get();
    }

    /**
     * income data for request query
     * default data is running month data
     * @return mixed
     */
    public function stockAmountQuery()
    {
        $from_date = \request()->from_date ?? Carbon::now()->startOfMonth();
        $to_date = \request()->to_date ?? Carbon::now()->endOfMonth();

        $stocks = Stock::query();

        if ($from_date) {
            $stocks = $stocks->whereBetween('created_at', [$from_date, $to_date]);
        }
        else{
            $stocks = $stocks->whereBetween('created_at ', [$from_date, $to_date]);
        }
        return $stocks->get();
    }

    /**
     * Get sales total amount for search data.
     * Default data is running month data.
     *
     * @return mixed
     */
    public function totalSalesAmount()
    {
        if (request()->has('search')) {
        $sales = $this->saleQuery();
        return $sales->sum('grand_total');
    } else {
        $sales = $this->saleQuery()
            ->whereBetween('date', [now()->startOfMonth(), now()->endOfMonth()]);
        return $sales->sum('grand_total');
        }
    }

    /**
     * Get sales total purchase amount for search data.
     * Default data is running month data.
     *
     * @return mixed
     */
    public function totalPurchasesAmount()
    {
        if (request()->has('search')) {
            $purchases = $this->purchaseQuery();
            return $purchases->sum('grand_total');
        } else {
            $purchases = $this->purchaseQuery()
                ->whereBetween('date', [now()->startOfMonth(), now()->endOfMonth()]);
            return $purchases->sum('grand_total');
        }
    }

    /**
     * Get sale return product purchase amount.
     * Default data is running month data.
     *
     * @return mixed
     */
    public function totalSalesReturnPurchaseAmount()
    {
        if (request()->has('search')) {
            $sale_returns = $this->saleReturnQuery();
            return $sale_returns->sum('total_purchase_price');
        } else {
            $sale_returns = $this->saleReturnQuery()
                ->whereBetween('date', [now()->startOfMonth(), now()->endOfMonth()]);
            return $sale_returns->sum('total_purchase_price');
        }
    }

    /**
     * Get sale return sale price amount.
     * Default data is running month data.
     *
     * @return mixed
     */
    public function totalSalesReturnSaleAmount()
    {
        if (request()->has('search')) {
            $sale_returns = $this->saleReturnQuery();
            return $sale_returns->sum('return_grand_total');
        } else {
            $sale_returns = $this->saleReturnQuery()
                ->whereBetween('date', [now()->startOfMonth(), now()->endOfMonth()]);
            return $sale_returns->sum('return_grand_total');
        }
    }

    /**
     * Get expense amount.
     * Default data is running month data.
     *
     * @return mixed
     */
    public function totalExpensesAmount()
    {
        if (request()->has('search')) {
            $expenses = $this->expenseQuery();
            return $expenses->sum('amount');
        } else {
            $expenses = $this->expenseQuery()
                ->whereBetween('date', [now()->startOfMonth(), now()->endOfMonth()]);
            return $expenses->sum('amount');
        }
    }

    /**
     * get income amount
     * default data is running month data
     * @return mixed
     */
    public function totalIncomeAmount()
    {
        if (request()->has('search')) {
            $incomes = $this->incomeQuery();
            return $incomes->sum('amount');
        } else {
            $incomes = $this->incomeQuery()
                ->whereBetween('date', [now()->startOfMonth(), now()->endOfMonth()]);
            return $incomes->sum('amount');
        }
    }

    /**
     * get invest amount
     * default data is running month data
     * @return mixed
     */
    public function totalInvestAmount()
    {
        if (request()->has('search')) {
            $invests = $this->investQuery();
            return $invests->sum('amount');
        } else {
            $invests = $this->investQuery()
                ->whereBetween('date', [now()->startOfMonth(), now()->endOfMonth()]);
            return $invests->sum('amount');
        }
    }
    /**
     * get invest withdraw amount
     * default data is running month data
     * @return mixed
     */
    public function totalInvestWithdrawAmount()
    {
        if (request()->has('search')) {
            $investWithdraws = $this->investWithdrawQuery();
            return $investWithdraws->sum('amount');
        } else {
            $investWithdraws = $this->investWithdrawQuery()
                ->whereBetween('date', [now()->startOfMonth(), now()->endOfMonth()]);
            return $investWithdraws->sum('amount');
        }
    }

    /**
     * get invest withdraw amount
     * default data is running month data
     * @return mixed
     */
    public function totalSalaryPaidAmount()
    {
        if (request()->has('search')) {
            $salaries = $this->salaryPaidQuery();
            // dd($salaries);
            return $salaries->sum('total_salary_paid');
        } else {
            $salaries = $this->salaryPaidQuery()
                ->whereBetween('given_date', [now()->startOfMonth(), now()->endOfMonth()]);
            return $salaries->sum('total_salary_paid');
        }
    }

    /**
     * get invest withdraw amount
     * default data is running month data
     * @return mixed
     */
    public function totalStockPrice()
    {
        $stocks = $this->stockAmountQuery();

        if (!request()->has('search')) {
            $stocks = $stocks->whereBetween('created_at', [now()->startOfMonth(), now()->endOfMonth()]);
        }

        return $stocks->sum(function ($stock) {
            return ($stock->quantity / $stock->divisor_number) * $stock->purchase_price;
        });
    }
}
