@section('title', 'Update Withdraw')

<x-app-layout>
    <!-- Start main-bar -->

    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
            @include('pos.withdraw.menu')
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
            <h5>Update Withdraw</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>
        <div class="widget-body" id="root">
            <form action="{{ route('withdraw.update', $withdraw->id) }}" method="POST" id="vueRoot">
                @csrf
                @method('PUT')

                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <x-form.label name="Date" for="date" required/>
                        <x-form.input type="date" id="date" name="date" value="{{ old('date') ?? $withdraw->date->format('Y-m-d') }}" required/>
                    </div>
                </div>

               <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <x-form.label name="Amount" for="amount" required/>
                        <x-form.input type="number" id="amount" name="amount" value="{{ old('amount') ?? $withdraw->amount }}" placeholder="0.00" step="any" required/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <payment-option-component
                            :errors="{{ $errors }}"
                            :old-withdraw="{{ $withdraw }}"
                        />
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <x-form.label name="Note" for="note"/>
                        <x-form.input type="textarea" id="note" name="note" old_text="{{ old('note') ?? $withdraw->note }}" placeholder="Optional"/>
                    </div>
                </div>

                 <div class="row mt-3">
                    <div class="col-10 text-end">
                        <x-form.reset/>
                        <x-form.save name="Update Withdraw"/>
                    </div>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget-->
</x-app-layout>
