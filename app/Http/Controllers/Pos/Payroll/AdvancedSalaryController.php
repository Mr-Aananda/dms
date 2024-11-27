<?php

namespace App\Http\Controllers\Pos\Payroll;

use App\Http\Controllers\Controller;
use App\Http\Requests\AdvancedSalaryRequest;
use App\Models\AdvancedSalary;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class AdvancedSalaryController extends Controller
{
    private $advanced_salary;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $users = User::query();
        // search by customer name
        if (request('name')) {
            $users->where('name', 'like', '%' . request('name') . '%');
        }
        // search by mobile no
        if (request('phone')) {
            $users->where('phone', request()->phone);
        }
        // search by mobile no
        if (request('email')) {
            $users->where('email','like', '%' . request('email') . '%');
        }

        $users = $users->addTotalAdvancedPaidAmount()
                    ->addTotalAdvancedReceiveAmount()
                    ->paginate(30)->withQueryString();
        // view
        return view('pos.payroll.advanced.index', compact('users'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $users = User::select('id','name')->get();
        return view('pos.payroll.advanced.create',compact('users'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(AdvancedSalaryRequest $request)
    {
        DB::transaction(function () use ($request) {
            $data = $request->validated();
            $data['user_id'] = Auth::id();

            if ($request->advanced_type === "give") {
               $data['amount'] = -1 * $request->amount;
            } else {
                $data['amount'] = $request->amount;
            }

            $this->advanced_salary = AdvancedSalary::create($data);

            if ($request->cash_id) {
                Cash::findOrFail($request->cash_id)->increment('balance', $data['amount']);
            } else {
                BankAccount::findOrFail($request->bank_account_id)->increment('balance', $data['amount']);
            }
        });
        if ($this->advanced_salary) {
            return redirect()->route('advanced-salary.index')->with('success', 'Advanced created successfully.');
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $userAdvancedSalaries = AdvancedSalary::latest()->where('employee_id', $id)
            ->paginate(30)->withQueryString();

        return view('pos.payroll.advanced.show', compact('userAdvancedSalaries'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $advanced_salary = AdvancedSalary::with('bankAccount')->findOrFail($id);
        $users = User::select('id', 'name')->get();

        return view('pos.payroll.advanced.edit', compact('advanced_salary','users'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(AdvancedSalaryRequest $request, string $id)
    {
        DB::transaction(function () use ($request, $id) {
            $advanced_salary = AdvancedSalary::findOrFail($id);
            $data = $request->validated();
            $data['user_id'] = Auth::id();
            $this->advanced_salary = $advanced_salary;
            $this->updatePreviousCashBankBalance($advanced_salary);

            if ($request->advanced_type === "give") {
                $data['amount'] = -1 * $request->amount;
            } else {
                $data['amount'] = $request->amount;
            }

            $advanced_salary->update($data);

            if ($request->cash_id) {
                Cash::findOrFail($request->cash_id)->increment('balance',$data['amount']);
            } else {
                BankAccount::findOrFail($request->bank_account_id)->increment('balance',$data['amount']);
            }
        });
        if ($this->advanced_salary) {
            return redirect()->route('advanced-salary.show', $id)->with('success', 'Advanced updated successfully.');
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $advanced_salary = AdvancedSalary::findOrFail($id);
        DB::transaction(function () use ($advanced_salary) {
            $this->updatePreviousCashBankBalance($advanced_salary);
            $advanced_salary->delete();
        });

        return redirect()->back()->with('success', 'Advanced updated successfully.');
    }

    /**
     * update previous advance cash or bank account balance
     * @param $advanced_salary
     * @return void
     */
    public function updatePreviousCashBankBalance($advanced_salary)
    {
        if ($advanced_salary->cash_id) {
            $advanced_salary->cash()->decrement('balance', $advanced_salary->amount);
        } else {
            $advanced_salary->bankAccount()->decrement('balance', $advanced_salary->amount);
        }
    }
}
