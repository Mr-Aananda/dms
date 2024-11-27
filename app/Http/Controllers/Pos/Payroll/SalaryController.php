<?php

namespace App\Http\Controllers\Pos\Payroll;

use App\Http\Controllers\Controller;
use App\Http\Requests\SalaryRequest;
use App\Models\AdvancedSalary;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Salary;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class SalaryController extends Controller
{
    private $salary;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $previous_month = Carbon::now()->subMonth()->format('Y-m') . '-01';
        $request_month = \request()->filled('salary_month') ? Carbon::parse(\request()->salary_month)->format('Y-m-d') : null;
        $salary_month = $request_month ?? $previous_month;
        $month = $request_month ? Carbon::parse(\request()->salary_month)->format('F Y') : Carbon::today()->subMonth()->format('F Y');
        $users = User::with(['salaries' => function ($query) use ($salary_month) {
            $query->where('salary_month', $salary_month);
        }])->paginate(30);

        return view('pos.payroll.salary.index', compact('users', 'month', 'salary_month'));
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $user_id = request()->id ?? null;
        $month = null;
        if (request()->id) {
            $carbonMonth = Carbon::parse(\request()->month);
            $month = $carbonMonth->format('Y-m');
        }

        $users = User::select('id', 'name')->addTotalAdvancedPaidAmount()
                    ->addTotalAdvancedReceiveAmount()->get();
        return view('pos.payroll.salary.create', compact('users', 'month', 'user_id'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(SalaryRequest $request)
    {
        $exists = Salary::where('employee_id', $request->employee_id)
                ->where('salary_month', $request->salary_month)
                ->first();

        $requestedDate = Carbon::parse($request->salary_month);
        $monthName = $requestedDate->format('F Y');

        if ($exists) {
            throw new \Exception("Salary already given for $monthName .");
        }

        if ($request->advanced) {
            $user = User::addTotalAdvancedPaidAmount()
                ->addTotalAdvancedReceiveAmount()
                ->find($request->employee_id);

            $remainingAdvance = abs($user->total_advanced_paid) - abs($user->total_advanced_receive);

            if ($remainingAdvance < $request->advanced) {
                throw new \Exception("Remaining advance amount is less then requesting advance");
            }
        }

        DB::transaction(function () use ($request) {
            $data = $request->validated();
            $data['user_id'] = Auth::id();
            $data['salary_no'] = str_pad(Salary::max('id') + 1, 8, 0, STR_PAD_LEFT);
            $salary = Salary::create($data);
            $this->salary  = $salary;
            // update cash or bank balance
            $this->updateCashBankBalance($request);
            $this->saveSalaryDetails($request, $salary);
        });

        if ($this->salary) {
            return response($this->salary, 200);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $salary = Salary::with('user', 'details')
                ->addTotalSalaryPaidAmount()
                ->findOrFail($id);
        return view('pos.payroll.salary.show', compact('salary'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $oldSalary = Salary::with('details', 'advancedSalary')->findOrFail($id);
        $month =  Carbon::parse($oldSalary->salary_month)->format('Y-m');
        $users = User::all();
        return view('pos.payroll.salary.edit', compact('users', 'month', 'oldSalary'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(SalaryRequest $request, string $id)
    {
        $exists = Salary::where('employee_id', $request->employee_id)
            ->where('salary_month', $request->salary_month)
            ->first();

        $requestedDate = Carbon::parse($request->salary_month);
        $monthName = $requestedDate->format('F Y');

        if ($exists && $exists->id != $id) {
            throw new \Exception("Salary already given for $monthName .");
        }

        DB::transaction(function () use ($request, $id) {
            $oldSalary = Salary::AddTotalSalaryPaidAmount()->findOrFail($id);
            $data = $request->validated();
            $data['salary_no'] = str_pad(Salary::max('id') + 1, 8, 0, STR_PAD_LEFT);
            $oldSalary->update($data);
            $this->salary  = $oldSalary;
            $this->updatePreviousSalaryDetail($oldSalary);

            // update cash or bank balance
            $this->updateCashBankBalance($request);
            $this->saveSalaryDetails($request, $oldSalary);
        });

        if ($this->salary) {
            return response($this->salary, 200);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        DB::transaction(function () use ($id) {
            $oldSalary = Salary::AddTotalSalaryPaidAmount()->with('advancedSalary')->findOrFail($id);
            //   <!-- update previous record -->
            $this->updatePreviousSalaryDetail($oldSalary);
            //    <!-- update previous record -->

            $this->salary = $oldSalary->delete();
        });

        if ($this->salary) {
            return redirect()->back()->withSuccess('Salary deleted successfully.');
        }
    }


    /**
     * update cash or bank balance
     * @param $request
     * @return void
     */
    public function updateCashBankBalance($request)
    {
        $total_paid = ($request->basic_salary - $request->advanced + $request->bonus + $request->deduction);

        if ($request->cash_id) {
            Cash::findOrFail($request->cash_id)->decrement('balance', $total_paid);
        } else {
            BankAccount::findOrFail($request->bank_account_id)->decrement('balance', $total_paid);
        }
    }

    /**
     * save salary details
     * @param $request
     * @return void
     */
    public function saveSalaryDetails($request, $salary)
    {
        // dd($salary);
        // if it has basic salary then save it
        if ($request->basic_salary) {
            $salary_details = [
                'purpose' => 'basic_salary',
                'amount' => $request->basic_salary,
            ];
            $salary->details()->create($salary_details);
        }
        // if it has bonus then save it
        if ($request->bonus) {
            $salary_details = [
                'purpose' => 'bonus',
                'amount' => $request->bonus,
            ];
            $salary->details()->create($salary_details);
        }
        // if it has advanced then save it
        if ($request->advanced) {
            $user_id = Auth::id();
            AdvancedSalary::create([
                'employee_id' => $request->employee_id,
                'user_id' => $user_id,
                'salary_id' => $salary->id,
                'date' => $request->given_date,
                'amount' => $request->advanced,
                'cash_id' => $request->cash_id,
                'bank_account_id' => $request->bank_account_id,
            ]);
            $salary_details = [
                'purpose' => 'advanced',
                'amount' => (-1 * $request->advanced),
            ];
            $salary->details()->create($salary_details);
        }
        // if it has deduction then save it
        if ($request->deduction) {
            $salary_details = [
                'purpose' => 'deduction',
                'amount' => (-1 * $request->deduction),
            ];
            $salary->details()->create($salary_details);
        }
    }

    public function updatePreviousSalaryDetail($oldSalary)
    {
        if ($oldSalary->cash_id) {
            Cash::findOrFail($oldSalary->cash_id)->increment('balance', $oldSalary->total_salary_paid);
        } else {
            BankAccount::findOrFail($oldSalary->cash_id)->increment('balance', $oldSalary->total_salary_paid);
        }
        // dd($oldSalary->advancedSalary);
        if ($oldSalary->advancedSalary) {
            $oldSalary->advancedSalary->delete();
        }
        $oldSalary->details()->delete();
    }
}
