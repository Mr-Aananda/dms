@section('title', 'Create Expense')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start  menu -->
        @include('pos.expense.menu')
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
                    <form action="{{ route('expense.store') }}" method="POST" id="vueRoot">
                        @csrf
                        <div class="row g-3 mb-2">
                            <div class="col-md-5">
                                <x-form.label name="Date" for="date" required/>
                                <x-form.input type="date" id="date" value="{{ old('date', date('Y-m-d')) }}" name="date" required/>
                            </div>
                            <div class="col-md-5">
                                <x-form.label name="Branch" for="branch"/>
                                <x-form.select
                                    name="branch_id"
                                    id="branch"
                                    :options="$branches"
                                    selected_option="{{ auth()->user()->branch_id ? auth()->user()->branch_id : $branches[0]->id }}"
                                    option_name="name"
                                />
                            </div>
                        </div>
                        <div class="row g-3 mb-2">
                            <div class="col-md-10">
                                <get-subcategories
                                :old_category_id={{ json_encode(old('category_id')) }}
                                :old_subcategory_id={{ json_encode(old('subcategory_id')) }}
                                :errors="@json($errors->toArray())"
                                :categories="{{ $categories }}"
                                />
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-10">
                                <x-form.label name="Amount" for="amount" required/>
                                <x-form.input type="number" id="amount" name="amount" placeholder="0.00" step="any" required/>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-10">
                                <payment-option-component
                                    :errors="{{ $errors }}"
                                />
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-10">
                                <x-form.label name="Note" for="note"/>
                                <x-form.input type="textarea" id="note" name="note" placeholder="Optional"/>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-10 text-end">
                                <x-form.reset/>
                                <x-form.save name="New Expense"/>
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
