<?php

namespace App\Http\Controllers;

use App\Models\Purchase;
use App\Models\Sale;
use App\Services\Dashboard\DashboardService;
use Carbon\Carbon;
use Carbon\CarbonInterval;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public $data = [];

    /**
     * Display the dashboard with relevant information.
     *
     * @return \Illuminate\View\View
     */
    public function index(DashboardService $service)
    {
        // $this->data['todayDueCollection'] = DueManage::where('date', $todayDate)->where('amount', '>', 0)->sum('amount');

        // Get monthly and daily data for purchase and sale
        $this->data['purchaseMonthlyData'] = $this->getMonthlyPurchaseData();
        $this->data['saleMonthlyData'] = $this->getMonthlySaleData();
        $this->data['dailySaleData'] = $this->getDailySaleData();
        $this->data['dailyPurchaseData'] = $this->getDailyPurchaseData();
        $this->data = array_merge($this->data, $service->dashboardData());

        // Return the dashboard view with the data
        return view('dashboard')->with($this->data);
    }

    /**
     * Get monthly total purchase data.
     *
     * @return array
     */
    public function getMonthlyPurchaseData()
    {
        // Get Carbon instance for monthly data range
        $carbonData = $this->getCarbonMonthlyData();
        // Initialize an array to store monthly purchase data
        $purchaseMonthlyData = [];
        // Iterate through each month within the specified range
        foreach (Carbon::parse($carbonData['startOfYear'])->range($carbonData['endOfYear'], $carbonData['interval']) as $month) {
            // Fetch and sum the grand total of purchases for the current month
            $purchaseMonthlyData[$month->format('M')] = Purchase::with('purchaseCost')->whereMonth('date', $month)->get()->sum('grand_total');
        }
        return $purchaseMonthlyData;
    }

    /**
     * Get monthly total sale data.
     *
     * @return array
     */
    public function getMonthlySaleData()
    {
        // Get Carbon instance for monthly data range
        $carbonData = $this->getCarbonMonthlyData();
        // Initialize an array to store monthly sale data
        $saleMonthlyData = [];
        // Iterate through each month within the specified range
        foreach (Carbon::parse($carbonData['startOfYear'])->range($carbonData['endOfYear'], $carbonData['interval']) as $month) {
            // Fetch and sum the grand total of sales for the current month
            $saleMonthlyData[$month->format('M')] = Sale::whereMonth('date', $month)->get()->sum('grand_total');
        }
        return $saleMonthlyData;
    }

    /**
     * Get daily sale data.
     *
     * @return array
     */
    public function getDailySaleData(): array
    {
        // Get Carbon instance for daily data range
        $carbonData = $this->getCarbonDailyData();
        // Initialize an array to store daily sale data
        $dailySaleChartData = [];
        // Iterate through each day within the specified range
        foreach (Carbon::parse($carbonData['start'])->range($carbonData['end'], $carbonData['interval']) as $date) {
            // Fetch and sum the grand total of sales for the current day
            $dailySaleChartData[$date->format('j')] = Sale::whereDate('date', $date)->get()->sum('grand_total');
        }
        return $dailySaleChartData;
    }

    /**
     * Get daily purchase data.
     *
     * @return array
     */
    public function getDailyPurchaseData(): array
    {
        // Get Carbon instance for daily data range
        $carbonData = $this->getCarbonDailyData();
        // Initialize an array to store daily purchase data
        $dailyPurchaseChartData = [];
        // Iterate through each day within the specified range
        foreach (Carbon::parse($carbonData['start'])->range($carbonData['end'], $carbonData['interval']) as $date) {
            // Fetch and sum the grand total of purchases for the current day
            $dailyPurchaseChartData[$date->format('j')] = Purchase::with('purchaseCost')->whereDate('date', $date)->get()->sum('grand_total');
        }
        return $dailyPurchaseChartData;
    }

    /**
     * Get Carbon data for monthly calculations.
     *
     * @return array
     */
    public function getCarbonMonthlyData(): array
    {
        $now = Carbon::now()->toImmutable();
        return [
            'startOfYear' => $now->startOfYear(),
            'endOfYear' => $now->endOfYear(),
            'interval' => CarbonInterval::months(1),
        ];
    }

    /**
     * Get Carbon data for daily calculations.
     *
     * @return array
     */
    public function getCarbonDailyData(): array
    {
        return [
            'start' => Carbon::now()->startOfMonth(),
            'end' => Carbon::now()->endOfMonth(),
            'interval' => CarbonInterval::day(1),
        ];
    }

}
