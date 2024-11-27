@section('title', 'Update Loan')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.payroll.loan.menu')
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
            <h5>Update Loan</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>

        <div class="widget-body" id="root">
            <form action="{{ route('loan.update', $loan->id) }}" method="POST" id="vueRoot">
                @csrf
                @method('PATCH')
                <div class="row g-2 mb-2">
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
                            {{ $loan->amount < 0 ? 'checked' : '' }}
                             style="font-size: 17px"
                            />
                            <span class="form-check-label me-3"  style="font-size: 17px">Advanced Give</span>
                        </label>

                        <label>
                            <input
                            class="form-check-input me-2"
                            type="radio"
                            name="loan_type"
                            id="take"
                            value="take"
                            {{ $loan->amount > 0 ? 'checked' : '' }}
                             style="font-size: 17px"
                            />
                            <span class="form-check-label"  style="font-size: 17px">Advanced Take</span>
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
                                selected_option="{{ $loan->loan_account_id }}"
                                required
                            />
                        </div>
                    </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Date" for="date" required/>
                        <x-form.input type="date" id="date" name="date" value="{{ old('date', $loan->date->format('Y-m-d')) }}" required/>
                    </div>
                    <div class="col-md-6">
                        <x-form.label name="Expired Date" for="expired_date" required/>
                        <x-form.input type="date" id="expired_date" name="expired_date" value="{{ old('expired_date', $loan->expired_date->format('Y-m-d')) }}" required/>
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Amount" for="amount" required/>
                        <x-form.input type="number" id="amount" name="amount" value="{{ old('amount') ?? abs($loan->amount) }}" placeholder="0.00" step="any" required/>
                    </div>

                    {{-- <div class="col-md-6">
                        <x-form.label name="Profit" for="profit"/>
                        <div class="input-group">
                            <x-form.input type="number" id="profit" name="profit" value="{{ old('profit') ?? abs($loan->profit) }}" step="any" min="0" placeholder="0.00"/>
                            <div class="input-group-append">
                                <select name="profit_type" class="form-select px-5 fw-bold">
                                    <option value="flat" {{$loan->profit_type == 'flat' ? 'selected':''}}>Flat</option>
                                    <option value="percentage" {{$loan->profit_type == 'percentage' ? 'selected':''}}>Percentage</option>
                                </select>
                            </div>
                        </div>
                    </div> --}}
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <payment-option-component
                            :old-loan="{{ $loan ?? ""  }}"
                            :errors="{{ $errors }}"
                        />
                    </div>
                </div>


                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Note" for="note"/>
                        <x-form.input type="textarea" id="note" name="note" old_text="{{ old('note') ?? $loan->note }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Loan"/>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget -->
</x-app-layout>
