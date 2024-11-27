@section('title', 'Create supplier')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start left menu -->
        @include('pos.party.supplier.menu')
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
                    <form action="{{ route('supplier.store') }}" method="POST">
                        @csrf
                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Company name" for="name"/>
                                <x-form.input type="text" id="name" name="company_name" placeholder="Enter company name" autofocus/>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-4">
                                <x-form.label name="Party name" for="name" required/>
                                <x-form.input type="text" id="name" name="name" placeholder="Enter party name" required/>
                            </div>

                            <div class="col-md-4">
                                <x-form.label name="Phone" for="phone" required/>
                                <x-form.input type="number" id="phone" name="phone" placeholder="Enter party mobile no" required/>
                            </div>

                            <div class="col-md-4">
                                <x-form.label name="Email" for="email"/>
                                <x-form.input type="email" id="email" name="email" placeholder="user@gmail.com"/>
                            </div>
                        </div>
                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Balance" for="balance"/>
                               <div class="input-group">
                                    <x-form.input type="number" id="balance" name="balance" step="any" min="0" placeholder="0.00"/>
                                    <div class="input-group-append">
                                        <select name="balance_status" class="form-select px-5 fw-bold">
                                            <option value="receivable" {{ old('balance_status') == 'receivable' ? 'selected' : '' }}>Receivable</option>
                                            <option value="payable" {{ old('balance_status') == 'payable' ? 'selected' : '' }}>Payable</option>
                                        </select>
                                    </div>
                               </div>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Address" for="address"/>
                                <x-form.input type="textarea" id="address" name="address" placeholder="Enter address (Optional)"/>
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
                                <x-form.save name="Add Supplier"/>
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
