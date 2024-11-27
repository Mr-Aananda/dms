@section('title', 'Create Loan Installment')
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
                    <form action="{{ route('loan-installment.store') }}" method="POST" id="vueRoot">
                        @csrf

                        <input type="hidden" name="loan_id" value="{{ request('loan_id')}}">

                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Date" for="date" required/>
                                <x-form.input type="date" id="date" value="{{ old('date', date('Y-m-d')) }}" name="date" required/>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Amount" for="amount" required/>
                                <x-form.input type="number" id="amount" name="amount" placeholder="0.00" step="any" required/>
                            </div>
                            <div class="col-md-6">
                                <x-form.label name="Adjustment" for="adjustment"/>
                                <x-form.input type="number" id="adjustment" name="adjustment" placeholder="0.00" step="any"/>
                            </div>
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
                                <x-form.save name="Add Installment"/>
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
