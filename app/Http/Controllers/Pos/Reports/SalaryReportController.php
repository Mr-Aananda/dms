<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Http\Controllers\Controller;
use App\Models\Salary;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;

class SalaryReportController extends Controller
{
    /**
     * get income report data
     * @return \Inertia\Response
     */
    public function index()
    {
        // employee query
        $employees_query = User::query();

        // search by employee name
        if (request('employee_id')) {
            $employees_query->where('id', request('employee_id'));
        }
        // search by mobile no
        if (request('phone')) {
            $employees_query->where('mobile', request()->phone);
        }

        // get all services data
        $employees = $employees_query->where('active', true)->paginate(30)->withQueryString();

        return view('pos.reports.payroll.salary.index', compact('employees'));
    }

    /**
     * get income report data
     * @return \Inertia\Response
     */
    public function details($id)
    {

        $employee = User::findOrFail($id);
        $startYear = 2022;
        $currentYear = Carbon::now()->year;
        $years = range($startYear, $currentYear);

        if (request()->search) {
            $salaries = Salary::with('details')->whereYear('salary_month', request()->year)
                ->where('employee_id', $id)
                ->get();
        } else {
            $salaries = Salary::with('details')->whereYear('salary_month', $currentYear)
                ->where('employee_id', $id)
                ->get();
        }

        return view('pos.reports.payroll.salary.details', compact('employee', 'salaries', 'years'));
    }

    /**
     * get monthly report data
     */
    public function monthlyReport()
    {
        $month = request()->month ?: Carbon::now()->format('Y-m');
        $formattedMonth = Carbon::parse($month)->format('F Y'); // e.g., "January 2024"

        // Fetch employees with their salaries for the given month
        $employees = User::with(['salaries' => function ($query) use ($month) {
            $query->whereMonth('salary_month', Carbon::parse($month)->month)
                ->whereYear('salary_month', Carbon::parse($month)->year)
                ->with('details');
        }])->get();

        $reports = [];
        $totalSalaries = 0;

        foreach ($employees as $employee) {
            $employeeTotal = 0;
            foreach ($employee->salaries as $salary) {
                $salaryDetails = $salary->details->map(function ($detail) use (&$employeeTotal) {
                    $amount = (float) $detail->amount;
                    $employeeTotal += $amount;
                    return [
                        'Purpose' => ucwords(str_replace('_', ' ', $detail->purpose)),
                        'Amount' => $amount
                    ];
                })->toArray();

                $reports[] = [
                    'Employee Name' => $employee->name,
                    'Salary No' => $salary->salary_no,
                    'Given Date' => $salary->given_date,
                    'Salary Month' => Carbon::parse($salary->salary_month)->format('F Y'),
                    'Details' => $salaryDetails
                ];
            }
            $totalSalaries += $employeeTotal;
        }

        return view('pos.reports.payroll.salary.monthly-report', compact('reports', 'formattedMonth', 'totalSalaries'));
    }
}
