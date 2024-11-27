<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\IncomeRecordRequest;
use App\Models\BankAccount;
use App\Models\Branch;
use App\Models\Cash;
use App\Models\IncomeRecord;
use App\Models\IncomeSector;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class IncomeRecordController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //expense query
        $incomeRecords = IncomeRecord::query();

        if (\request('sector_id')) {
            $incomeRecords = $incomeRecords->where('income_sector_id', \request('sector_id'));
        }

        // get data
        $incomeRecords = $incomeRecords->with('branch','incomeSector')->latest()->paginate(30)->withQueryString();
        $incomeSectors = IncomeSector::select('id', 'name')->get();

        return view('pos.income-record.index', compact('incomeRecords', 'incomeSectors'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $incomeSectors = IncomeSector::select('id', 'name')->get();
        $branches = Branch::select('id', 'name')->where('active', 1)->get();
        return view('pos.income-record.create', compact('incomeSectors', 'branches'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(IncomeRecordRequest $request)
    {
        $data = $request->validated();
        $transactionable = null;

        // identify payment method
        if ($request->payment_method == 'cash') {
            $transactionable = Cash::find($request->transactionable_id);
        } else {
            $transactionable = BankAccount::find($request->transactionable_id);
        }

        $data['user_id'] = Auth::user()->id;

        DB::transaction(function () use ($data, $request, $transactionable) {
            $transactionable->incomeRecords()->create($data);
            $transactionable->increment('balance', $request->amount);
        });

        return redirect()->back()->withSuccess('Income Record create successfully.');

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $incomeRecord = IncomeRecord::query()
            ->select('*')
            ->addPaymentMethod()
            ->findOrFail($id);
        return view('pos.income-record.show', compact('incomeRecord'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        // get the specified resource
        $incomeRecord = IncomeRecord::query()
            ->select('*')
            ->with('transactionable')
            ->addPaymentMethod()
            ->findOrFail($id);
        $incomeSectors = IncomeSector::select('id', 'name')->get();
        $branches = Branch::select('id', 'name')->where('active', 1)->get();
        //view
        return view('pos.income-record.edit', compact('incomeRecord', 'incomeSectors', 'branches'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(IncomeRecordRequest $request, string $id)
    {
        $data = $request->validated();

        $incomeRecord = IncomeRecord::query()
            ->with('transactionable')
            ->find($id);


        // check payment method is updated or not
        if ($incomeRecord->payment_method == $request->payment_method) {
            // payment method is same
            // get the different
            $diff = $incomeRecord->amount - $request->amount;

            // query safer
            DB::transaction(function () use ($diff, $incomeRecord, $data) {
                // adjust the balance
                $incomeRecord->transactionable->decrement('balance', $diff);
                // update expense
                $incomeRecord->update($data);
            });
        } else {
            // payment method is not same

            // identify payment method
            if ($request->payment_method == 'cash') {
                $transactionable = Cash::find($request->transactionable_id);
            } else {
                $transactionable = BankAccount::find($request->transactionable_id);
            }

            // query safer
            DB::transaction(function () use ($incomeRecord, $transactionable, $request, $data) {
                // add previous amount in previous payment method
                $incomeRecord->transactionable->decrement('balance', $incomeRecord->amount);

                // update payment method in expense
                $incomeRecord->fill($data);
                // $incomeRecord->payment_method = $request->payment_method;
                $incomeRecord->transactionable_type = $transactionable->getMorphClass();
                $incomeRecord->transactionable_id = $transactionable->id;

                $incomeRecord->save();

                // decrement amount from current transactionable
                $transactionable->increment('balance', $request->amount);
            });
        }

        return redirect()
            ->back()
            ->with('success', 'Income record updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $incomeRecord = IncomeRecord::query()
            ->with('transactionable')
            ->find($id);

        $incomeRecord->delete();

        return back()->with('success', 'Income record deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $incomeRecords = IncomeRecord::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.income-record.trash', compact('incomeRecords'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        IncomeRecord::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Income record restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $incomeRecord = IncomeRecord::withTrashed()->findOrFail($id);
        // restore balance
        $incomeRecord->transactionable->decrement('balance', $incomeRecord->amount);
        $incomeRecord->forceDelete();

        return redirect()->back()->withSuccess('Income record deleted permanently.');
    }
}
