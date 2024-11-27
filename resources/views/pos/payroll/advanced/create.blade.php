@section('title', 'Create Branch')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start menu -->
        @include('pos.payroll.advanced.menu')
        <!-- End menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right buttons -->
        </div>
    </div>
    <!-- End header widget -->
    <!-- Start body widget -->
    <div class="row">
        <div class="col-md-12">
            <div class="widget">
                <div class="widget-body">
                    <form action="{{ route('advanced-salary.store') }}" method="POST" id="vueRoot">
                        @csrf

                        <div class="row g-2 mb-2">
                            <div class="col-md-12 my-0">
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
                                    checked
                                    style="font-size: 17px"
                                    />
                                    <span class="form-check-label me-3" style="font-size: 17px">Advanced Give</span>
                                </label>

                                <label>
                                    <input
                                    class="form-check-input me-2"
                                    type="radio"
                                    name="advanced_type"
                                    id="take"
                                    value="take"
                                    style="font-size: 17px"
                                    />
                                    <span class="form-check-label" style="font-size: 17px">Advanced Take</span>
                                </label>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Date" for="date" required/>
                                <x-form.input type="date" id="date" name="date" value="{{ old('date', date('Y-m-d')) }}" required/>
                            </div>
                            <div class="col-md-6">
                                <x-form.label name="Select Employees" for="employee" required/>
                                <x-form.select
                                    name="employee_id"
                                    id="employee"
                                    :options="$users"
                                    option_name="name"
                                    required
                                />
                            </div>
                        </div>
                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Amount" for="amount" required/>
                                <x-form.input type="number" id="amount" name="amount" placeholder="0.00" step="any" required/>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div>
                                <payment-option
                                :errors="{{ $errors }}"
                                />
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Note" for="note"/>
                                <x-form.input type="textarea" id="note" name="note" placeholder="Optional"/>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12 text-end">
                                <x-form.reset/>
                                <x-form.save name="Add Advanced"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
    <!-- End body widget -->
    <!-- End main-bar -->

</x-app-layout>
