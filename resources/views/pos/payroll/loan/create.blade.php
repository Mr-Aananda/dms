@section('title', 'Create Loan')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start  menu -->
        @include('pos.payroll.loan.menu')
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
                    <form action="{{ route('loan.store') }}" method="POST" id="vueRoot">
                        @csrf

                        <div class="row g-2 mb-2 fs-6">
                            <div class="col-md-12">
                                <x-form.label name="Loan Type" for="type" required/>
                            </div>
                            <div class="col-md-12">
                                <label>
                                    <input
                                    class="form-check-input me-2"
                                    type="radio"
                                    name="loan_type"
                                    value="give"
                                    id="give"
                                    style="font-size: 17px"
                                    checked
                                    />
                                    <span class="form-check-label me-3" style="font-size: 17px">Loan Give</span>
                                </label>

                                <label>
                                    <input
                                    class="form-check-input me-2"
                                    type="radio"
                                    name="loan_type"
                                    id="take"
                                    style="font-size: 17px"
                                    value="take"
                                    />
                                    <span class="form-check-label" style="font-size: 17px">Loan Take</span>
                                </label>
                            </div>
                        </div>
                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Loan Accounts" for="loan-account" required/>
                                <x-form.select
                                    name="loan_account_id"
                                    id="loan-account"
                                    :options="$loanAccounts"
                                    option_name="name"
                                    required
                                />
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Given Date" for="date" required/>
                                <x-form.input type="date" id="date" value="{{ old('date', date('Y-m-d')) }}" name="date" required/>
                            </div>
                            <div class="col-md-6">
                                <x-form.label name="Expired Date" for="expired_date" required/>
                                <x-form.input type="date" id="expired_date" value="{{ old('expired_date') }}" name="expired_date" required/>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Amount" for="amount" required/>
                                <x-form.input type="number" id="amount" name="amount" placeholder="0.00" step="any" required/>
                            </div>

                            {{-- <div class="col-md-6">
                                <x-form.label name="Profit" for="profit"/>
                               <div class="input-group">
                                    <x-form.input type="number" id="profit" name="profit" step="any" min="0" placeholder="0.00"/>
                                    <div class="input-group-append">
                                        <select name="profit_type" class="form-select px-5 fw-bold">
                                            <option value="flat" {{ old('profit_type') == 'flat' ? 'selected' : '' }}>Flat</option>
                                            <option value="percentage" {{ old('profit_type') == 'percentage ' ? 'selected' : '' }}>Percentage </option>
                                        </select>
                                    </div>
                               </div>
                            </div> --}}
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <payment-option-component
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
                                <x-form.save name="New Loan"/>
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
