<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\ExpenseRequest;
use App\Models\BankAccount;
use App\Models\Branch;
use App\Models\Cash;
use App\Models\Expense;
use App\Models\ExpenseCategory;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ExpenseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
         //expense query
        $expenses_query = Expense::query();

        if (request()->search) {
            // set date
            $date = [];
            if (request()->from_date != null) {
                $date[] = date(request()->from_date);

                if (request()->to_date != null) {
                    $date[] = date(request()->to_date);
                } else {
                    if (request()->from_date != null) {
                        $date[] = date('Y-m-d');
                    }
                }
                if (count($date) > 0) {
                    $expenses_query = $expenses_query->whereBetween('date', $date);
                }
            }
        } else {
            // If there's no search, set the default search date to today
            $today = Carbon::today();
            $expenses_query = $expenses_query->where('date', $today);
        }

        if (\request('category_id')) {
            $expenses_query = $expenses_query->where('expense_category_id', \request('category_id'));
        }
        if (\request('branch_id')) {
            $expenses_query = $expenses_query->where('branch_id', \request('branch_id'));
        }

        // get data
        $expenses = $expenses_query->latest()->with('branch','expenseCategory')->paginate(30)->withQueryString();
        $branches = Branch::select('id', 'name')->where('active', 1)->get();
        // $categories = ExpenseCategory::select('id', 'name')->get();
        $categories = ExpenseCategory::select('id', 'name')
        ->where('active', 1)
        ->whereNull('parent_id')
            ->orWhereIn('id', function ($query) {
                $query->select('parent_id')
                ->from('expense_categories')
                ->whereNotNull('parent_id');
            })
            ->get();

        return view('pos.expense.index', compact('expenses', 'branches', 'categories'));

    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        // $categories = ExpenseCategory::with('subCategory')->select('id', 'name')->where('active', 1)->get();
        $categories = ExpenseCategory::with('subCategory')
        ->select('id', 'name')
        ->where('active', 1)
        ->whereNull('parent_id')
        ->orWhereIn('id', function ($query) {
            $query->select('parent_id')
            ->from('expense_categories')
            ->whereNotNull('parent_id');
        })
            ->get();
        $branches = Branch::select('id', 'name')->where('active', 1)->get();
        return view('pos.expense.create', compact('categories', 'branches'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ExpenseRequest $request)
    {
    //    return $request->all();
        $data = $request->validated();

        $transactionable = null;

        // identify payment method
        if ($request->payment_method == 'cash') {
            $transactionable = Cash::find($request->transactionable_id);
        } else {
            $transactionable = BankAccount::find($request->transactionable_id);
        }

        $data['user_id'] = Auth::user()->id;
        $data['expense_category_id'] = $request->category_id;
        $data['expense_subcategory_id'] = $request->subcategory_id;

        DB::transaction(function () use ($data, $request, $transactionable) {
            $transactionable->expenses()->create($data);
            $transactionable->decrement('balance', $request->amount);
        });

        return redirect()->back()->withSuccess('Expense create successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $expense = Expense::query()
            ->select('*')
            ->addPaymentMethod()
            ->findOrFail($id);
        return view('pos.expense.show', compact('expense'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        // get the specified resource
        $expense = Expense::query()
            ->select('*')
            ->with('transactionable')
            ->addPaymentMethod()
            ->findOrFail($id);
        // $categories = ExpenseCategory::with('subCategory')->select('id', 'name')->where('active', 1)->get();
        $categories = ExpenseCategory::with('subCategory')
        ->select('id', 'name')
        ->where('active', 1)
        ->whereNull('parent_id')
        ->orWhereIn('id', function ($query) {
            $query->select('parent_id')
                ->from('expense_categories')
                ->whereNotNull('parent_id');
        })
        ->get();
        $branches = Branch::select('id', 'name')->where('active', 1)->get();
        //view
        return view('pos.expense.edit', compact('expense', 'categories', 'branches'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ExpenseRequest $request, string $id)
    {
        $data = $request->validated();

        $expense = Expense::query()
            ->with('transactionable')
            ->find($id);

        $oldPaymentMethod = $expense->payment_method;

        if ($oldPaymentMethod == $request->payment_method) {
            // Same payment method
            $diff = $expense->amount - $request->amount;

            DB::transaction(function () use ($diff, $expense, $data) {
                $expense->transactionable->increment('balance', $diff);
                $expense->update($data);
            });
        } else {
            // Different payment method
            DB::transaction(function () use ($expense, $request, $data) {
                $expense->transactionable->increment('balance', $expense->amount);

                if ($request->payment_method == 'cash') {
                    $transactionable = Cash::find($request->transactionable_id);
                } else {
                    $transactionable = BankAccount::find($request->transactionable_id);
                }

                $transactionable->decrement('balance', $request->amount);

                $expense->update($data + [
                    'payment_method' => $request->payment_method,
                    'transactionable_type' => $transactionable->getMorphClass(),
                    'transactionable_id' => $transactionable->id,
                ]);
            });
        }

        return redirect()
            ->back()
            ->with('success', 'Expense updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $expense = Expense::query()
            ->with('transactionable')
            ->find($id);

        // restore balance
        // $expense->transactionable->increment('balance', $expense->amount);

        $expense->delete();

        return back()->with('success', 'Expense deleted successfully.');
    }


    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $expenses = Expense::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.expense.trash', compact('expenses'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Expense::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Expense restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $expense = Expense::withTrashed()->findOrFail($id);
        // restore balance
        $expense->transactionable->increment('balance', $expense->amount);
        $expense->forceDelete();

        return redirect()->back()->withSuccess('Expense deleted permanently.');
    }

}
