@section('title', 'Create Bank Account')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.bank.bank-account.menu')
        <!-- End left menu -->
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
                    <form action="{{ route('bank-account.store') }}" method="POST">
                        @csrf
                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Select Bank" for="bank" required/>
                                <x-form.select
                                    name="bank_id"
                                    id="bank"
                                    :options="$banks"
                                    option_name="name"
                                    required
                                />
                            </div>
                            <div class="col-md-6">
                                <x-form.label name="Account Holder Name" for="name" required/>
                                <x-form.input type="text" id="name" name="account_name" placeholder="Enter account holder name" required/>
                            </div>
                        </div>
                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Account Number" for="account-number" required/>
                                <x-form.input type="text" id="account-number" name="account_number" placeholder="Enter account number" required/>
                            </div>
                            <div class="col-md-6">
                                <x-form.label name="Branch" for="branch" required/>
                                <x-form.input type="text" id="branch" name="branch" placeholder="Enter branch" required/>
                            </div>
                        </div>
                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Initial Balance" for="balance"/>
                                <x-form.input type="number" id="balance" name="balance" placeholder="0.00" step="any"/>
                            </div>
                        </div>
                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Description" for="description"/>
                                <x-form.input type="textarea" id="description" name="description" placeholder="Optional"/>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12 text-end">
                                <x-form.reset/>
                                <x-form.save name="Add Account"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
    <!-- End body widget -->
    <!-- End main-bar-->
</x-app-layout>
