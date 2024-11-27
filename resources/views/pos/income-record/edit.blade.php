@section('title', 'Update Income Record')

<x-app-layout>
    <!-- Start main-bar -->

    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
            @include('pos.income-record.menu')
            <!-- End left menu -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
        </div>
    </div>
    <!-- End header widget -->
    <!-- Start body widget-->
    <div class="widget mb-5">
        <div class="widget-head mb-3">
            <h5>Update Income Record</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>
        <div class="widget-body" id="root">
            <form action="{{ route('income-record.update', $incomeRecord->id) }}" method="POST" id="vueRoot">
                @csrf
                @method('PATCH')

                <div class="row g-3 mb-2">
                    <div class="col-md-5">
                        <x-form.label name="Date" for="date" required/>
                        <x-form.input type="date" id="date" name="date" value="{{ old('date') ?? $incomeRecord->date->format('Y-m-d') }}" required/>
                    </div>
                    <div class="col-md-5">
                        <x-form.label name="Branch" for="branch" required/>
                        <x-form.select
                            name="branch_id"
                            id="branch"
                            :options="$branches"
                            option_name="name"
                            selected_option="{{ $incomeRecord->branch_id }}"
                            required
                        />
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <x-form.label name="Income Sector" for="income_sector_id" required/>
                        <x-form.select
                            name="income_sector_id"
                            id="income_sector_id"
                            :options="$incomeSectors"
                            option_name="name"
                            selected_option="{{ $incomeRecord->income_sector_id }}"
                            required
                        />
                    </div>
                </div>

               <div class="row g-3 mb-2">
                    <div class="col-md-5">
                        <x-form.label name="Amount" for="amount" required/>
                        <x-form.input type="number" id="amount" name="amount" value="{{ old('amount') ?? $incomeRecord->amount }}" placeholder="0.00" step="any" required/>
                    </div>
                    <div class="col-md-5">
                        <x-form.label name="Income By" for="income-by" required/>
                        <x-form.input type="text" id="income-by" name="income_by" value="{{ old('income_by') ?? $incomeRecord->income_by }}" placeholder="Enter collector name "/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <payment-option-component
                            :errors="{{ $errors }}"
                            :old-income-record="{{ $incomeRecord }}"
                        />
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <x-form.label name="Note" for="note"/>
                        <x-form.input type="textarea" id="note" name="note" old_text="{{ old('note') ?? $incomeRecord->note }}" placeholder="Optional"/>
                    </div>
                </div>

                 <div class="row mt-3">
                    <div class="col-10 text-end">
                        <x-form.reset/>
                        <x-form.save name="Update Income Record"/>
                    </div>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget-->
</x-app-layout>
