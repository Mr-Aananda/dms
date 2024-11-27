<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\SmsTemplateRequest;
use App\Models\SmsTemplate;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SmsTemplateController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $templates = SmsTemplate::query();
        //search
        if (\request()->title) {
            $templates->where('title', 'LIKE', '%' . request()->title . '%');
        }
        $templates = $templates->latest()->paginate(30)->withQueryString();
        // view
        return view('pos.sms.sms-template.index', compact('templates'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.sms.sms-template.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(SmsTemplateRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;

        SmsTemplate::create($data);
        return redirect()->back()->withSuccess('Template create successfully');
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
        $template = SmsTemplate::query()
            ->findOrFail($id);
        return view('pos.sms.sms-template.edit', compact('template'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(SmsTemplateRequest $request, string $id)
    {
        $template = SmsTemplate::query()
            ->findOrFail($id);
        $data = $request->validated();
        $data['user_id'] = Auth::user()->id;
        $template->update($data);

        return redirect()
            ->route("sms-template.index")
            ->withSuccess('Template updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $template = SmsTemplate::query()
            ->findOrFail($id);

        $template->delete();

        return redirect()->back()->withSuccess('Template deleted successfully.');
    }
}
