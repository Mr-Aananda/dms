@section('title', 'Update Loan Installment')

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
            <h5>Update Loan Installment</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>

        <div class="widget-body" id="root">
            <form action="{{ route('loan-installment.update', $loanInstallment->id) }}" method="POST" id="vueRoot">
                @csrf
                @method('PATCH')

                <input type="hidden" name="loan_id" value="{{ $loanInstallment->loan_id }}">

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Date" for="date" required/>
                        <x-form.input type="date" id="date" name="date" value="{{ old('date', $loanInstallment->date->format('Y-m-d')) }}" required/>
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Amount" for="amount" required/>
                        <x-form.input type="number" id="amount" name="amount" value="{{ old('amount') ?? abs($loanInstallment->amount) }}" placeholder="0.00" step="any" required/>
                    </div>
                    <div class="col-md-6">
                        <x-form.label name="Adjustment" for="adjustment"/>
                        <x-form.input type="number" id="adjustment" name="adjustment" value="{{ old('adjustment') ?? abs($loanInstallment->adjustment) }}" placeholder="0.00" step="any"/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <payment-option-component
                            :old-loan-installment="{{ $loanInstallment ?? ""  }}"
                            :errors="{{ $errors }}"
                        />
                    </div>
                </div>


                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Note" for="note"/>
                        <x-form.input type="textarea" id="note" name="note" old_text="{{ old('note') ?? $loanInstallment->note }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Installment"/>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget -->
</x-app-layout>
