<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\InvestorRequest;
use App\Models\Investor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class InvestorController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $investors = Investor::query();
        // search by customer name
        if (request('name')) {
            $investors->where('name', 'like', '%' . request('name') . '%');
        }
        // search by mobile no
        if (request('phone')) {
            $investors->where('phone', request()->phone);
        }

        $investors = $investors->withCount('invests')->latest()->paginate(30)->withQueryString();

        return view('pos.investment.investor.index', compact('investors'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.investment.investor.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(InvestorRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;

        Investor::create($data);
        return redirect()->route("investor.index")->withSuccess('Investor create successfully');
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
        $investor = Investor::query()
            ->findOrFail($id);
        return view('pos.investment.investor.edit', compact('investor'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(InvestorRequest $request, string $id)
    {
        $investor = Investor::query()
            ->findOrFail($id);
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;
        $investor->update($data);

        return redirect()
            ->back()
            ->withSuccess('Investor updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $investor = Investor::query()
            ->findOrFail($id);

        $investor->delete();

        return redirect()->route('investor.index')->withSuccess('Investor deleted successfully.');
    }

    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $investors = Investor::latest()
            ->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.investment.investor.trash', compact('investors'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Investor::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Investor restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $investor = Investor::withTrashed()->findOrFail($id);
        $investor->forceDelete();

        return redirect()->back()->withSuccess('Investor deleted permanently.');
    }
}
