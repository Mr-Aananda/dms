<?php

namespace App\Services\Dashboard;

use App\Helpers\QuantityHelper;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Expense;
use App\Models\IncomeRecord;
use App\Models\Invest;
use App\Models\Party;
use App\Models\Product;
use App\Models\Purchase;
use App\Models\PurchaseReturn;
use App\Models\Sale;
use App\Models\SaleReturn;
use App\Models\Withdraw;
use Carbon\Carbon;

class DashboardService
{
    public $data;
    public function dashboardData()
    {
        // Get today's date
        $todayDate = now()->toDateString();
        // Get previous date
        $previousDate = now()->modify('-1 day')->toDateString();
        // Date count for last month
        $lastMonthStartDate = Carbon::now()->subMonth()->startOfMonth();
        $lastMonthEndDate = Carbon::now()->subMonth()->endOfMonth();

        // Date count for this month
        $thisMonthStartDate = Carbon::now()->startOfMonth();
        $thisMonthEndDate = Carbon::now()->endOfMonth();

        // Calculate cash balance and bank balance
        $this->data['cashBalance'] = Cash::sum('balance');
        $this->data['bankBalance'] = BankAccount::sum('balance');
        //Cash or bank amount withdraw
        $this->data['totalWithdrawAmount'] = Withdraw::sum('amount');
        //Invest
        $this->data['totalInvest'] = Invest::sum('amount');

        // Fetch products with related information
        $products = Product::where('status', 1)->with(['unit' => function ($query) {
            $query->select('id', 'label', 'relation');
        }, 'stock'])->select('id', 'unit_id', 'purchase_price','divisor_number')->get();

        // Hide unnecessary fields
        $products = $products->makeHidden([
            'total_product_quantity_in_unit',
            'purchase_price',
            'quantity',
            'total_product_quantity',
            'total_product_quantity_branch_wise'
        ]);

        // Calculate total quantity and total damage quantity for each product
        $products = $products->map(function ($product) {
            $product['totalQuantity'] = $product->stock->sum('quantity');
            // $product['totalDamageQuantity'] = $product->stock->sum('damage_quantity');
            return $product;
        });

        // Calculate total product price and total product damage price
        $this->data['totalProductPrice'] = $products->sum(function ($product) {
            return QuantityHelper::priceQuantity($product, $product->totalQuantity) * ($product->purchase_price/$product->divisor_number);
        });

        // $this->data['totalDamageProductPrice'] = $products->sum(function ($product) {
        //     return QuantityHelper::priceQuantity($product, $product->totalDamageQuantity) * ($product->purchase_price / $product->divisor_number);
        // });

        // Calculate all sale amounts history
        $this->data['todaySaleAmount'] = Sale::where('date', $todayDate)->get()->sum('grand_total');
        $this->data['previousDaySaleAmount'] = Sale::where('date', $previousDate)->get()->sum('grand_total');

        if ($this->data['todaySaleAmount'] >= $this->data['previousDaySaleAmount']) {
            $this->data['todaySalePercentage'] = (($this->data['todaySaleAmount'] - $this->data['previousDaySaleAmount']) / ($this->data['todaySaleAmount'] ?: 1)) * 100;
        } else {
            $this->data['todaySalePercentage'] = -1 * (($this->data['previousDaySaleAmount'] - $this->data['todaySaleAmount']) / ($this->data['previousDaySaleAmount'] ?: 1)) * 100;
        }
        $this->data['thisMonthSaleAmount'] = Sale::whereBetween('date', [$thisMonthStartDate, $thisMonthEndDate])->get()->sum('grand_total');
        $this->data['lastMonthSaleAmount'] = Sale::whereBetween('date', [$lastMonthStartDate, $lastMonthEndDate])->get()->sum('grand_total');
        if ($this->data['thisMonthSaleAmount'] >= $this->data['lastMonthSaleAmount']) {
            $this->data['monthSalePercentage'] = (($this->data['thisMonthSaleAmount'] - $this->data['lastMonthSaleAmount']) / ($this->data['thisMonthSaleAmount'] ?: 1)) * 100;
        } else {
            $this->data['monthSalePercentage'] = -1 * (($this->data['lastMonthSaleAmount'] - $this->data['thisMonthSaleAmount']) / ($this->data['lastMonthSaleAmount'] ?: 1)) * 100;
        }
        $this->data['totalSaleAmount'] = Sale::get()->sum('grand_total');

        // Calculate all sale return amounts history
        // $this->data['todaySaleReturnAmount'] = SaleReturn::where('date', $todayDate)->get()->sum('return_grand_total');
        // $this->data['previousDaySaleReturnAmount'] = SaleReturn::where('date', $previousDate)->get()->sum('return_grand_total');

        // Calculate all purchase amounts history
        $this->data['todayPurchaseAmount'] = Purchase::with('purchaseCost')->where('date', $todayDate)->get()->sum('grand_total');
        $this->data['previousDayPurchaseAmount'] = Purchase::with('purchaseCost')->where('date', $previousDate)->get()->sum('grand_total');

        if ($this->data['todayPurchaseAmount'] >= $this->data['previousDayPurchaseAmount']) {
            $this->data['todayPurchasePercentage'] = (($this->data['todayPurchaseAmount'] - $this->data['previousDayPurchaseAmount']) / ($this->data['todayPurchaseAmount'] ?: 1)) * 100;
        } else {
            $this->data['todayPurchasePercentage'] = -1 * (($this->data['previousDayPurchaseAmount'] - $this->data['todayPurchaseAmount']) / ($this->data['previousDayPurchaseAmount'] ?: 1)) * 100;
        }

        $this->data['thisMonthPurchaseAmount'] = Purchase::with('purchaseCost')->whereBetween('date', [$thisMonthStartDate, $thisMonthEndDate])->get()->sum('grand_total');
        $this->data['lastMonthPurchaseAmount'] = Purchase::with('purchaseCost')->whereBetween('date', [$lastMonthStartDate, $lastMonthEndDate])->get()->sum('grand_total');
        if ($this->data['thisMonthPurchaseAmount'] >= $this->data['lastMonthPurchaseAmount']) {
            $this->data['monthPurchasePercentage'] = (($this->data['thisMonthPurchaseAmount'] - $this->data['lastMonthPurchaseAmount']) / ($this->data['thisMonthPurchaseAmount'] ?: 1)) * 100;
        } else {
            $this->data['monthPurchasePercentage'] = -1 * (($this->data['lastMonthPurchaseAmount'] - $this->data['thisMonthPurchaseAmount']) / ($this->data['lastMonthPurchaseAmount'] ?: 1)) * 100;
        }
        $this->data['totalPurchaseAmount'] = Purchase::with('purchaseCost')->get()->sum('grand_total');

        // Calculate all purchase return amounts history
        // $this->data['todayPurchaseReturnAmount'] = PurchaseReturn::where('date', $todayDate)->get()->sum('return_grand_total');
        // $this->data['previousDayPurchaseReturnAmount'] = PurchaseReturn::where('date', $previousDate)->get()->sum('return_grand_total');

        // Calculate all expense history
        $this->data['todayExpense'] = Expense::where('date', $todayDate)->sum('amount');
        $this->data['previousDayExpense'] = Expense::where('date', $previousDate)->sum('amount');
        if ($this->data['todayExpense'] >= $this->data['previousDayExpense']) {
            $this->data['todayExpensePercentage'] = (($this->data['todayExpense'] - $this->data['previousDayExpense']) / ($this->data['todayExpense'] ?: 1)) * 100;
        } else {
            $this->data['todayExpensePercentage'] = -1 * (($this->data['previousDayExpense'] - $this->data['todayExpense']) / ($this->data['previousDayExpense'] ?: 1)) * 100;
        }
        $this->data['thisMonthTotalExpense'] = Expense::whereBetween('date', [$thisMonthStartDate, $thisMonthEndDate])->get()->sum('amount');
        $this->data['lastMonthTotalExpense'] = Expense::whereBetween('date', [$lastMonthStartDate, $lastMonthEndDate])->get()->sum('amount');
        if ($this->data['thisMonthTotalExpense'] >= $this->data['lastMonthTotalExpense']) {
            $this->data['monthExpensePercentage'] = (($this->data['thisMonthTotalExpense'] - $this->data['lastMonthTotalExpense']) / ($this->data['thisMonthTotalExpense'] ?: 1)) * 100;
        } else {
            $this->data['monthExpensePercentage'] = -1 * (($this->data['lastMonthTotalExpense'] - $this->data['thisMonthTotalExpense']) / ($this->data['lastMonthTotalExpense'] ?: 1)) * 100;
        }
        $this->data['totalExpense'] = Expense::get()->sum('amount');

        $this->data['todayIncome'] = IncomeRecord::where('date', $todayDate)->sum('amount');
        $this->data['previousDayIncome'] = IncomeRecord::where('date', $previousDate)->sum('amount');
        if ($this->data['todayIncome'] >= $this->data['previousDayIncome']) {
            $this->data['todayIncomePercentage'] = (($this->data['todayIncome'] - $this->data['previousDayIncome']) / ($this->data['todayIncome'] ?: 1)) * 100;
        } else {
            $this->data['todayIncomePercentage'] = -1 * (($this->data['previousDayIncome'] - $this->data['todayIncome']) / ($this->data['previousDayIncome'] ?: 1)) * 100;
        }
        $this->data['thisMonthTotalIncome'] = IncomeRecord::whereBetween('date', [$thisMonthStartDate, $thisMonthEndDate])->get()->sum('amount');
        $this->data['lastMonthTotalIncome'] = IncomeRecord::whereBetween('date', [$lastMonthStartDate, $lastMonthEndDate])->get()->sum('amount');
        if ($this->data['thisMonthTotalIncome'] >= $this->data['lastMonthTotalIncome']) {
            $this->data['monthIncomePercentage'] = (($this->data['thisMonthTotalIncome'] - $this->data['lastMonthTotalIncome']) / ($this->data['thisMonthTotalIncome'] ?: 1)) * 100;
        } else {
            $this->data['monthIncomePercentage'] = -1 * (($this->data['lastMonthTotalIncome'] - $this->data['todayIncome']) / ($this->data['lastMonthTotalIncome'] ?: 1)) * 100;
        }
        $this->data['totalIncome'] = IncomeRecord::get()->sum('amount');

        // Calculate customer due, supplier due, and expense
        $this->data['customerDue'] = Party::customer()->where('balance', '>', 0)->sum('balance');
        $this->data['supplierDue'] = Party::supplier()->where('balance', '<', 0)->sum('balance');

        return $this->data;
    }
}
