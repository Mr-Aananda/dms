<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Http\Controllers\Controller;
use App\Models\Expense;
use App\Models\ExpenseCategory;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Http\Request;

class ExpenseReportController extends Controller
{
    /**
     * Display the Monthly Expense Report.
     */
    public function index()
    {
        $running_month = date('m');
        $expenseCategories = ExpenseCategory::query();
        if (\request('search')) {
            $month = substr(\request('month'), strpos(\request('month'), '-') + 1);
            $expenseCategories = $expenseCategories->with(['expenses' => function ($query) use ($month) {
                $query->whereMonth('date', $month);
            }])
            ->whereHas('expenses', function ($query) use ($month) {
                $query->whereMonth('date', $month);
            });
        } else {
            $expenseCategories = $expenseCategories->with(['expenses' => function ($query) use ($running_month) {
                $query->whereMonth('date', $running_month);
            }])
                ->whereHas('expenses', function ($query) use ($running_month) {
                    $query->whereMonth('date', $running_month);
                });
        }
        $expenseCategories = $expenseCategories
            ->paginate(30)
            ->withQueryString();
        $total_amount = 0;
        foreach ($expenseCategories as $expenseCategory) {
            $total_amount += $expenseCategory->expenses->sum('amount');
        }
        return view('pos.reports.expense.index',compact('expenseCategories', 'total_amount'));
    }
    /**
     * Display the Monthly Expense Details Report.
     */
    public function details($id)
    {
        $running_month = date('m');
        $expenses = Expense::query();
        if (\request('search')) {
            $month = substr(\request('month'), strpos(\request('month'), '-') + 1);
            $expenses = $expenses->whereMonth('date', $month);
        } else {
            $expenses = $expenses->whereMonth('date', $running_month);
        }
        $expenseCategoryDetails = $expenses->where('expense_category_id', $id)
            ->paginate(30)->withQueryString();

        $total_amount = $expenseCategoryDetails->sum('amount');
        return view('pos.reports.expense.details',compact('expenseCategoryDetails', 'total_amount'));
    }
    /**
     * Display the Monthly Expense Details Report.
     */
    public function yearlyReport()
    {
        $expenseDetails = [];
        $months = config('pos.single_months');
        $startYear = 2022;
        $currentYear = Carbon::now()->year;
        $years = range($startYear, $currentYear);

        if (request()->search) {
            $expenseDetails = ExpenseCategory::query()
                ->where('active', 1)
                ->whereNull('parent_id')
                ->orWhereIn('id', function ($query) {
                    $query->select('parent_id')
                        ->from('expense_categories')
                        ->whereNotNull('parent_id');
                })
                ->with([
                    'expenses' => function (HasMany $query) {
                        $query->select('expense_category_id', 'date', 'amount')
                            ->whereYear('date', request()->year);
                    }
                ])
                ->get()
                ->map(function (ExpenseCategory $sector) {
                    $records = $sector->expenses->map(function (Expense $record) {
                        $record['month'] = $record->date->format('M');
                        return $record;
                    })->groupBy('month')->map(function ($item) {
                        return $item->sum('amount');
                    });

                    $sector['sum_of_each_month'] = $records;

                    return $sector;
                });
        }
        return view('pos.reports.expense.yearly-report',compact('expenseDetails', 'months', 'years'));
    }
}
