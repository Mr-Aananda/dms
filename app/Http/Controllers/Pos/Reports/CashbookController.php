<?php

namespace App\Http\Controllers\Pos\Reports;

use App\Http\Controllers\Controller;
use App\Models\AdvancedSalary;
use App\Models\Cash;
use App\Models\ClosingBalance;
use App\Models\DueManage;
use App\Models\Expense;
use App\Models\IncomeRecord;
use App\Models\Invest;
use App\Models\InvestWithdraw;
use App\Models\Loan;
use App\Models\Purchase;
use App\Models\PurchaseReturn;
use App\Models\Salary;
use App\Models\Sale;
use App\Models\SaleReturn;
use App\Models\Withdraw;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CashbookController extends Controller
{
    public $data = [];
    /**
     * show cash book details
     *
     */
    public function index()
    {
        // $date = date('Y-m-d');
        // $data = $this->cashBookData($date);
        if (\request('search')) {
            $date = \request('date');
        } else {
            $date = date('Y-m-d');
        }
        $data = $this->cashBookData($date);
        return view('pos.reports.cash-book.index', compact('data'));
    }

    /**
     * get date wise data
     * @param $date
     * @return mixed
     */
    public function cashBookData($date)
    {
        $opening_date = '2023-01-01';
        $previous_day = date('Y-m-d', strtotime('-1 day', strtotime($date)));
        // get closing balance
        $this->data['opening_balance'] = ClosingBalance::where('date', $previous_day)
            ->first();

        if (!$this->data['opening_balance']) {
            $this->data['opening_balance'] = ClosingBalance::whereBetween('date', [$opening_date, $previous_day])
                ->get()
                ->last();
        }

        $this->data['cash_balance'] = Cash::all()->sum('balance');

        $this->data['sales'] = Sale::with('party')->where('paid', '>', 0)->whereDate('date', $date)->get();

        $this->data['total_sale'] = $this->data['sales']->sum('paid');

        $this->data['sale_returns'] = SaleReturn::with('party')->whereDate('date', $date)->get();

        $this->data['total_sale_return'] = $this->data['sale_returns']->sum('return_total_paid');

        $this->data['due_receives'] = DueManage::with('party')->whereDate('date', $date)->where('amount', '>', 0)->get();

        $this->data['total_due_receive'] = $this->data['due_receives']->sum('amount');

        $this->data['expenses'] = Expense::with('expenseCategory')->whereDate('date', $date)->get();
        $this->data['total_expense'] = $this->data['expenses']->sum('amount');

        $this->data['invests'] = Invest::whereDate('date', $date)->get();
        $this->data['total_invest'] = $this->data['invests']->sum('amount');

        $this->data['invests_withdraws'] = InvestWithdraw::whereDate('date', $date)->get();
        $this->data['total_invest_withdraw'] = $this->data['invests_withdraws']->sum('amount');

        $this->data['withdraws'] = Withdraw::whereDate('date', $date)->get();
        $this->data['total_withdraw'] = $this->data['withdraws']->sum('amount');

        $this->data['salaries'] = Salary::whereDate('given_date', $date)->get();
        $this->data['total_salary'] = $this->data['salaries']->sum(function ($salary) {
            return $salary->details->sum('amount');
        });
        $this->data['advances'] = AdvancedSalary::whereDate('date', $date)->where('amount', '<', 0)->get();
        $this->data['total_advanced'] = $this->data['advances']->sum('amount');

        $this->data['advances_recieved'] = AdvancedSalary::whereDate('date', $date)->where('amount', '>', 0)->get();
        $this->data['total_advanced_recieved'] = $this->data['advances_recieved']->sum('amount');

        $this->data['loan_given'] = Loan::whereDate('date', $date)->where('amount', '<', 0)->get();
        $this->data['total_loan_given'] = $this->data['loan_given']->sum('amount');

        $this->data['loan_taken'] = Loan::whereDate('date', $date)->where('amount', '>', 0)->get();
        $this->data['total_loan_taken'] = $this->data['loan_taken']->sum('amount');

        $this->data['incomes'] = IncomeRecord::whereDate('date', $date)->get();
        $this->data['total_income'] = $this->data['incomes']->sum('amount');

        $this->data['purchases'] = Purchase::with('party')->where('paid', '>', 0)->whereDate('date', $date)->get();

        $this->data['total_purchase'] = $this->data['purchases']->sum('paid');

        $this->data['purchase_returns'] = PurchaseReturn::with('party')->whereDate('date', $date)->get();

        $this->data['total_purchase_return'] = $this->data['purchase_returns']->sum('return_total_paid');

        $this->data['due_payments'] = DueManage::with('party')->whereDate('date', $date)->where('amount', '<', 0)->get();

        $this->data['total_due_payment'] = $this->data['due_payments']->sum('amount');

        return $this->data;
    }

    public function closingBalanceStore(Request $request)
    {
        $data = $request->validate([
            'date' => 'required|date',
            'amount' => 'required|numeric'
        ]);
        $data['user_id'] = Auth::user()->id;

        $exist = ClosingBalance::where('date', $request->date)->first();
        if ($exist) {
            return redirect()->back()->withInput()->withErrors('Closing balance already exist for this date');
        } else {
            ClosingBalance::create($data);
        }
        return redirect()->back()->withSuccess('Balance close successfully');
    }
}
