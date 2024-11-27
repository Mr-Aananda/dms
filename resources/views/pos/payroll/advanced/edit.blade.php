@section('title', 'Update advanced')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.payroll.advanced.menu')
        <!-- End left menu -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
        </div>
    </div>
    <!-- End header widget -->
    <!-- Start body widget -->
    <div class="widget mb-5">

        <div class="widget-head mb-3">
            <h5>Update Advanced</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>

        <div class="widget-body" id="root">
            <form action="{{ route('advanced-salary.update', $advanced_salary->id) }}" method="POST" id="vueRoot">
                @csrf
                @method('PATCH')
                <div class="row g-2 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Advanced Type" for="type" required/>
                    </div>
                    <div class="col-md-12">
                        <label>
                            <input
                            class="form-check-input me-2"
                            type="radio"
                            name="advanced_type"
                            value="give"
                            id="give"
                            {{ $advanced_salary->amount < 0 ? 'checked' : '' }}
                             style="font-size: 17px"
                            />
                            <span class="form-check-label me-3"  style="font-size: 17px">Advanced Give</span>
                        </label>

                        <label>
                            <input
                            class="form-check-input me-2"
                            type="radio"
                            name="advanced_type"
                            id="take"
                            value="take"
                            {{ $advanced_salary->amount > 0 ? 'checked' : '' }}
                             style="font-size: 17px"
                            />
                            <span class="form-check-label"  style="font-size: 17px">Advanced Take</span>
                        </label>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Date" for="date" required/>
                        <x-form.input type="date" id="date" name="date" value="{{ old('date', $advanced_salary->date->format('Y-m-d')) }}" required/>
                    </div>
                    <div class="col-md-6">
                        <x-form.label name="Select Employees" for="employee" required/>
                        <x-form.select
                            name="employee_id"
                            id="employee"
                            :options="$users"
                            selected_option="{{ $advanced_salary->employee_id }}"
                            option_name="name"
                            required
                        />
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Amount" for="amount" required/>
                        <x-form.input type="number" id="amount" name="amount" value="{{ old('amount') ?? abs($advanced_salary->amount) }}" placeholder="0.00" step="any" required/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div>
                        <payment-option
                        :old-advanced-salary="{{ $advanced_salary ?? "" }}"
                        :errors="{{ $errors }}"
                        />
                    </div>
                </div>


                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Note" for="note"/>
                        <x-form.input type="textarea" id="note" name="note" old_text="{{ old('note') ?? $advanced_salary->note }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Advanced"/>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget -->
</x-app-layout>
