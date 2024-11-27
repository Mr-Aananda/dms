@section('title', 'Create Invest')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start  menu -->
        @include('pos.investment.invest.menu')
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
                    <form action="{{ route('invest.store') }}" method="POST" id="vueRoot">
                        @csrf

                        <div class="row g-3 mb-2">
                            <div class="col-md-4">
                                <x-form.label name="Date" for="date" required/>
                                <x-form.input type="date" id="date" value="{{ old('date', date('Y-m-d')) }}" name="date" required/>
                            </div>
                            <div class="col-md-4">
                                <x-form.label name="Branch" for="branch"/>
                                <x-form.select
                                    name="branch_id"
                                    id="branch"
                                    :options="$branches"
                                    selected_option="{{ auth()->user()->branch_id ? auth()->user()->branch_id : $branches[0]->id }}"
                                    option_name="name"
                                />
                            </div>
                            <div class="col-md-4">
                                <x-form.label name="Investor" for="investor" required/>
                                <x-form.select
                                    name="investor_id"
                                    id="investor"
                                    :options="$investors"
                                    option_name="name"
                                    required
                                />
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-4">
                                <x-form.label name="Amount" for="amount" required/>
                                <x-form.input type="number" id="amount" name="amount" placeholder="0.00" step="any" required/>
                            </div>

                            <div class="col-md-4">
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
                            </div>
                            <div class="col-md-4">
                                <x-form.label name="Profit Addition Date (Optional)" for="profit-addition-date"/>
                                <x-form.input type="date" id="profit-addition-date" value="{{ old('profit_addition_date') }}" name="profit_addition_date"/>
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
                                <x-form.save name="Add Invest"/>
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
