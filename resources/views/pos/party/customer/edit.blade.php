@section('title', 'Update customer')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.party.customer.menu')
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
            <h5>Update Customer</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>

        <div class="widget-body" id="root">
            <form action="{{ route('customer.update', $customer->id) }}" method="POST">
                @csrf
                @method('PATCH')

                <div class="row g-3 mb-2">
                    <div class="col-md-4">
                        <x-form.label name="Party name" for="name" required/>
                        <x-form.input type="text" id="name" name="name" value="{{ old('name') ?? $customer->name }}" placeholder="Enter party name" required/>
                    </div>

                    <div class="col-md-4">
                        <x-form.label name="Phone" for="phone" required/>
                        <x-form.input type="number" id="phone" name="phone" value="{{ old('phone') ?? $customer->phone }}" placeholder="Enter party mobile no" required/>
                    </div>

                    <div class="col-md-4">
                        <x-form.label name="Email" for="email"/>
                        <x-form.input type="email" id="email" name="email" value="{{ old('email') ?? $customer->email }}" placeholder="user@gmail.com"/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Balance" for="balance"/>
                        <div class="input-group">
                            <x-form.input type="number" id="balance" name="balance" value="{{ old('balance') ?? abs($customer->balance) }}" step="any" min="0" placeholder="0.00"/>
                            <div class="input-group-append">
                                <select name="balance_status" class="form-select px-5 fw-bold">
                                    <option value="receivable" {{$customer->balance >= 0 ? 'selected':''}}>Receivable</option>
                                    <option value="payable" {{$customer->balance < 0 ? 'selected':''}}>Payable</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <x-form.label name="Status" required/>
                        <select id="status" class="form-select" name="active">
                            <option selected disabled>Select Status</option>
                            <option
                                value="1" {{ $customer->active == '1' ? 'selected' : '' }}>
                                Active
                            </option>
                            <option
                                value="0" {{ $customer->active == '0' ? 'selected' : '' }}>
                                Inactive
                            </option>
                        </select>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Address" for="address"/>
                        <x-form.input type="textarea" id="address" name="address" old_text="{{ old('address') ?? $customer->address }}" placeholder="Enter address (Optional)"/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Description" for="description"/>
                        <x-form.input type="textarea" id="description" name="description" old_text="{{ old('description') ?? $customer->description }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Customer"/>
                </div>
            </form>
        </div>
    </div>
    <!-- End body widget -->
</x-app-layout>
