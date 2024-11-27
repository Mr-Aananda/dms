<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Http\Controllers\Controller;
use App\Models\IncomeRecord;
use App\Models\IncomeSector;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Carbon\Carbon;
use Illuminate\Http\Request;

class IncomeReportController extends Controller
{
    public function index()
    {
        $incomeDetails = [];
        $months = config('pos.single_months');
        $startYear = 2022;
        $currentYear = Carbon::now()->year;
        $years = range($startYear, $currentYear);
        if (request()->search) {
            $incomeDetails = IncomeSector::query()
                ->with([
                    'incomeRecords' => function (HasMany $query) {
                        $query->select('income_sector_id', 'date', 'amount')
                            ->whereYear('date', request()->year);
                    }
                ])
                ->get()
                ->map(function (IncomeSector $sector) {
                    $records = $sector->incomeRecords->map(function (IncomeRecord $record) {
                        $record['month'] = $record->date->format('M');
                        return $record;
                    })->groupBy('month')->map(function ($item) {
                        return $item->sum('amount');
                    });

                    $sector['sum_of_each_month'] = $records;

                    return $sector;
                });
        }
        return view('pos.reports.income.index', compact('incomeDetails', 'months', 'years'));
    }
}
