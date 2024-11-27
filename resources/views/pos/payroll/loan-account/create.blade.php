@section('title', 'Create Loan Account')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start left menu -->
        @include('pos.payroll.loan-account.menu')
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
                    <form action="{{ route('loan-account.store') }}" method="POST">
                        @csrf

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Name" for="name" required/>
                                <x-form.input type="text" id="name" name="name" placeholder="Enter loan account name" required autofocus/>
                            </div>

                            <div class="col-md-6">
                                <x-form.label name="Phone" for="phone" required/>
                                <x-form.input type="number" id="phone" name="phone" placeholder="Enter mobile no" required/>
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
                                <x-form.label name="Note" for="note"/>
                                <x-form.input type="textarea" id="note" name="note" placeholder="Optional"/>
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
    <!-- End main-bar -->
</x-app-layout>
