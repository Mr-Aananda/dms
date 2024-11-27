@section('title', 'Update Bank Account')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.bank.bank-account.menu')
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
            <h5>Update Bank Account</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>

        <div class="widget-body" id="root">
            <form action="{{ route('bank-account.update', $account->id) }}" method="POST">
                @csrf
                @method('PATCH')
                 <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Select Bank" for="bank" required/>
                        <x-form.select
                            name="bank_id"
                            id="bank"
                            :options="$banks"
                            selected_option="{{ $account->bank_id }}"
                            option_name="name"
                            required
                        />
                    </div>
                    <div class="col-md-6">
                        <x-form.label name="Account Holder Name" for="account-name" required/>
                        <x-form.input type="text" id="account-name" name="account_name" value="{{ old('account_name') ?? $account->account_name }}" placeholder="Enter branch name" required/>
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Account Number" for="account-number" required/>
                        <x-form.input type="text" id="account-number" name="account_number" value="{{ old('account_number') ?? $account->account_number }}" placeholder="Enter account number" required/>
                    </div>
                    <div class="col-md-6">
                        <x-form.label name="Branch" for="branch" required/>
                        <x-form.input type="text" id="branch" name="branch" value="{{ old('branch') ?? $account->branch }}" placeholder="Enter branch" required/>
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Initial Balance" for="balance"/>
                        <x-form.input type="number" id="balance" name="balance" value="{{ old('balance') ?? $account->balance }}" placeholder="0.00" step="any" readonly/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Description" for="description"/>
                        <x-form.input type="textarea" id="description" name="description" old_text="{{ old('description') ?? $account->description }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Account"/>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget -->
</x-app-layout>
