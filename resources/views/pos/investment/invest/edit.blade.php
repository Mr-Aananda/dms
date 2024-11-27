@section('title', 'Update Invest')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.investment.invest.menu')
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
            <h5>Update Invest</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>

        <div class="widget-body" id="root">
            <form action="{{ route('invest.update', $invest->id) }}" method="POST" id="vueRoot">
                @csrf
                @method('PATCH')

                 <div class="row g-3 mb-2">
                    <div class="col-md-4">
                        <x-form.label name="Date" for="date" required/>
                        <x-form.input type="date" id="date" name="date" value="{{ old('date', $invest->date->format('Y-m-d')) }}" required/>
                    </div>
                    <div class="col-md-4">
                        <x-form.label name="Branch" for="branch"/>
                        <x-form.select
                            name="branch_id"
                            id="branch"
                            :options="$branches"
                            option_name="name"
                            selected_option="{{ $invest->branch_id }}"
                        />
                    </div>
                    <div class="col-md-4">
                        <x-form.label name="Investor" for="investor" required/>
                        <x-form.select
                            name="investor_id"
                            id="investor"
                            :options="$investors"
                            option_name="name"
                            selected_option="{{ $invest->investor_id }}"
                            required
                        />
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-4">
                        <x-form.label name="Amount" for="amount" required/>
                        <x-form.input type="number" id="amount" name="amount" value="{{ old('amount') ?? abs($invest->amount) }}" placeholder="0.00" step="any" required/>
                    </div>

                    <div class="col-md-4">
                        <x-form.label name="Profit" for="profit"/>
                        <div class="input-group">
                            <x-form.input type="number" id="profit" name="profit" value="{{ old('profit') ?? abs($invest->profit) }}" step="any" min="0" placeholder="0.00"/>
                            <div class="input-group-append">
                                <select name="profit_type" class="form-select px-5 fw-bold">
                                    <option value="flat" {{$invest->profit_type == 'flat' ? 'selected':''}}>Flat</option>
                                    <option value="percentage" {{$invest->profit_type == 'percentage' ? 'selected':''}}>Percentage</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <x-form.label name="Profit Addition Date (Optional)" for="profit-addtion-date"/>
                        <x-form.input type="date" id="profit-addtion-date" value="{{ old('profit_addition_date',$invest->profit_addition_date) }}" name="profit_addition_date"/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <payment-option-component
                            :old-invest="{{ $invest ?? ""  }}"
                            :errors="{{ $errors }}"
                        />
                    </div>
                </div>


                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Note" for="note"/>
                        <x-form.input type="textarea" id="note" name="note" old_text="{{ old('note') ?? $invest->note }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Invest"/>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget -->
</x-app-layout>
