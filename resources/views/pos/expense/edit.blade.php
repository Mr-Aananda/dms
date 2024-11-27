@section('title', 'Update Expense')

<x-app-layout>
    <!-- Start main-bar -->

    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
            @include('pos.expense.menu')
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
            <h5>Update Expense</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>
        <div class="widget-body" id="root">
            <form action="{{ route('expense.update', $expense->id) }}" method="POST" id="vueRoot">
                @csrf
                @method('PATCH')

                <div class="row g-3 mb-2">
                    <div class="col-md-5">
                        <x-form.label name="Date" for="date" required/>
                        <x-form.input type="date" id="date" name="date" value="{{ old('date') ?? $expense->date->format('Y-m-d') }}" required/>
                    </div>
                    <div class="col-md-5">
                        <x-form.label name="Branch" for="branch"/>
                        <x-form.select
                            name="branch_id"
                            id="branch"
                            :options="$branches"
                            option_name="name"
                            selected_option="{{ $expense->branch_id }}"
                        />
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <get-subcategories
                        :old_category_id={{ json_encode(old('expense_category_id')) }}
                        :old_subcategory_id={{ json_encode(old('expense_subcategory_id')) }}
                        :errors="{{ $errors }}"
                        :categories="{{ $categories }}"
                        :old-expense="{{ $expense }}"
                        />
                    </div>
                </div>

               <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <x-form.label name="Amount" for="amount" required/>
                        <x-form.input type="number" id="amount" name="amount" value="{{ old('amount') ?? $expense->amount }}" placeholder="0.00" step="any" required/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <payment-option-component
                            :errors="{{ $errors }}"
                            :old-expense="{{ $expense }}"
                        />
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <x-form.label name="Note" for="note"/>
                        <x-form.input type="textarea" id="note" name="note" old_text="{{ old('note') ?? $expense->note }}" placeholder="Optional"/>
                    </div>
                </div>

                 <div class="row mt-3">
                    <div class="col-10 text-end">
                        <x-form.reset/>
                        <x-form.save name="Update Expense"/>
                    </div>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget-->
</x-app-layout>
