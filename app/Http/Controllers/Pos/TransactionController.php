<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\TransactionRequest;
use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TransactionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $transactions = Transaction::query();

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
                    $transactions = $transactions->whereBetween('date', $date);
                }
            }
        }

        $transactions = $transactions->latest()->paginate(30)->withQueryString();
        // view
        return view('pos.transaction.index', compact('transactions'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $banks = BankAccount::all();
        $cashes = Cash::where('active', 1)->get();
        return view('pos.transaction.create', compact('banks', 'cashes'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(TransactionRequest $request)
    {
        DB::beginTransaction();

        try {
            $data = $request->validated();
            $data['user_id'] = Auth::id();
            $this->updateFromPaymentMethodBalance($request);
            $this->updateToPaymentMethodBalance($request);

            $balance_transfer = Transaction::create($data);
            DB::commit();

            return response()->json($balance_transfer);
        } catch (\Exception $exception) {
            DB::rollBack();
            return $exception;
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $transaction = Transaction::findOrFail($id);
        return view('pos.transaction.show', compact('transaction'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $transaction = Transaction::findOrFail($id);
        $transaction['formatted_date'] = $transaction->date->format('Y-m-d');
        $banks = BankAccount::all();
        $cashes = Cash::where('active', 1)->get();
        return view('pos.transaction.edit', compact('transaction', 'banks', 'cashes'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(TransactionRequest $request, string $id)
    {
        DB::beginTransaction();
        try {
            $oldTransaction = Transaction::findOrFail($id);
            $data = $request->validated();
            $data['user_id'] = Auth::id();
            $this->updateOldFromPaymentMethodBalance($oldTransaction);
            $this->updateOldToPaymentMethodBalance($oldTransaction);
            $this->updateFromPaymentMethodBalance($request);
            $this->updateToPaymentMethodBalance($request);
            $oldTransaction->update($data);
            DB::commit();
            return response()->json($oldTransaction, 200);
        } catch (\Exception $exception) {
            DB::rollBack();
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        Transaction::findOrFail($id)->delete();
        return redirect()->route('transaction.index')->withSuccess('Transaction delete successfully!');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $transactions = Transaction::latest()->onlyTrashed()->paginate(30)->withQueryString();

        return view('pos.transaction.trash', compact('transactions'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Transaction::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Transaction restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        DB::beginTransaction();

        try {
            $oldTransaction = Transaction::withTrashed()->findOrFail($id);
            $this->updateOldFromPaymentMethodBalance($oldTransaction);
            $this->updateOldToPaymentMethodBalance($oldTransaction);
            $oldTransaction->forceDelete();
            DB::commit();
            return redirect()->back()->with('success', 'Transaction delete successfully');
        } catch (\Exception $exception) {
            DB::rollBack();
            return back()->with('error', 'Something went wrong');
        }
    }

    /**
     * decrement from payment method balance. // cash/bank account
     * @param $request
     * @return void
     */
    public function updateFromPaymentMethodBalance($request)
    {
        if ($request->transaction_from == 'cash') {
            Cash::findOrFail($request->transaction_from_id)->decrement('balance', $request->amount);
        } else {
            BankAccount::findOrFail($request->transaction_from_id)->decrement('balance', $request->amount);
        }
    }

    /**
     * increment to payment method balance
     * @param $request
     * @return void
     */
    public function updateToPaymentMethodBalance($request)
    {
        if ($request->transaction_to == 'cash') {
            Cash::findOrFail($request->transaction_to_id)->increment('balance', $request->amount);
        } else {
            BankAccount::findOrFail($request->transaction_to_id)->increment('balance', $request->amount);
        }
    }

    /**
     * increment old from payment method balance
     * @param $oldTransaction
     * @return void
     */
    public function updateOldFromPaymentMethodBalance($oldTransaction)
    {
        $oldTransaction->from_transaction->increment('balance', $oldTransaction->amount);
    }

    /**
     * decrement old from payment method balance
     * @param $oldTransaction
     * @return void
     */
    public function updateOldToPaymentMethodBalance($oldTransaction)
    {
        $oldTransaction->to_transaction->decrement('balance', $oldTransaction->amount);
    }
}
