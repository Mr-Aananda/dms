<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\DueManageRequest;
use App\Models\DueManage;
use App\Models\Party;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Exception;
use Illuminate\Support\Facades\DB;

class CustomerDueManageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $dueManages_query = DueManage::query();
        // Check if there's a search query or not
        if (request()->search) {
            // set date
            $date = [];
            // set date
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
                    $dueManages_query = $dueManages_query->whereBetween('date', $date);
                }
            }
        } else {
            // If there's no search, set the default search date to today
            $today = Carbon::today();
            $dueManages_query = $dueManages_query->where('date', $today);
        }

        if (request('party_id')) {
            $dueManages_query->where('party_id', \request('party_id'));
        }

        // get all suppliers data
        $dueManages = $dueManages_query->with('party')->where('type', 'customer')->latest()->paginate(30)->withQueryString();
        $parties = Party::customer()->get();

        return view('pos.due-manage.customer.index', compact('dueManages', 'parties'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $type = "customer";
        return view('pos.due-manage.customer.create', compact('type'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(DueManageRequest $request)
    {
        // dd($request->all());
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;
        DB::beginTransaction();
        try {
            $due_manage = DueManage::create($data);
            $this->updatePaymentDetails($request, $due_manage);
            DB::commit();
            return response()->json($due_manage, 200);
        } catch (Exception $exception) {
            DB::rollback();
            return response()->json($exception, 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        // get the specified resource
        $dueManage = DueManage::with('bankAccount')->findOrFail($id);
        $dueManage['formatted_date'] = $dueManage->date->format('Y-m-d');

        $type = "customer";

        // view
        return view('pos.due-manage.customer.edit', compact('dueManage', 'type'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(DueManageRequest $request, string $id)
    {
        $data = $request->validated();
        DB::beginTransaction();
        try {
            $old_due_manage = DueManage::findOrFail($id);
            $this->updatePreviousPartyBalance($old_due_manage);
            $this->updatePreviousCashBankBalance($old_due_manage);
            $data = $request->validated();
            $old_due_manage->update($data);

            $this->updatePaymentDetails($request, $old_due_manage);
            DB::commit();
            return response()->json($old_due_manage, 200);
        } catch (Exception $exception) {
            DB::rollback();
            return response()->json($exception, 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        DueManage::findOrFail($id)->delete();

        return redirect()->route('customer-due.index')->withSuccess('Due manage delete successfully!');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $dueManages = DueManage::latest()->where('type', 'customer')->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.due-manage.customer.trash', compact('dueManages'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        DueManage::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Due manage restore successfully.');
    }


    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $old_due_manage = DueManage::withTrashed()->findOrFail($id);
        $this->updatePreviousPartyBalance($old_due_manage);
        $this->updatePreviousCashBankBalance($old_due_manage);

        $old_due_manage->forceDelete();

        return redirect()->back()->withSuccess('Due manage deleted permanently.');
    }

    /**
     * update due manage party balance,
     * update due manage cash or bank balance,
     * @param $request
     * @param $due_manage
     * @return void
     */
    public function updatePaymentDetails($request, $due_manage)
    {
        //Party balance update
        if ($request->paymentType == 'paid') {
            $total_balance = ($request->amount - $request->adjustment);
        } else {
            $total_balance = ($request->amount + $request->adjustment);
        }
        $due_manage->party()->decrement('balance', $total_balance);

        //Cash/bank balance update
        if ($request->cash_id) {
            $due_manage->cash()->increment('balance', $request->amount);
        } else {
            $due_manage->bankAccount()->increment('balance', $request->amount);
        }
    }

    /**
     * update previous party balance when due manage edit or delete
     * @param $old_due_manage
     * @return void
     */
    public function updatePreviousPartyBalance($old_due_manage)
    {
        if ($old_due_manage->amount >= 0) {
            $total_balance = $old_due_manage->amount + $old_due_manage->adjustment;
        } else {
            $total_balance = $old_due_manage->amount - $old_due_manage->adjustment;
        }
        $old_due_manage->party->increment('balance', $total_balance);
    }

    /**
     * update previous cash or bank balance when due manage edit or delete
     * @param $old_due_manage
     * @return void
     */
    public function updatePreviousCashBankBalance($old_due_manage)
    {
        if ($old_due_manage->cash_id) {
            $old_due_manage->cash->decrement('balance', $old_due_manage->amount);
        } else {
            $old_due_manage->bankAccount->decrement('balance', $old_due_manage->amount);
        }
    }
}
