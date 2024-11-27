@section('title', 'Update Investoe')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.investment.investor.menu')
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
            <h5>Update Investor Account</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>

        <div class="widget-body" id="root">
            <form action="{{ route('investor.update', $investor->id) }}" method="POST">
                @csrf
                @method('PATCH')

                <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Name" for="name" required/>
                        <x-form.input type="text" id="name" name="name" value="{{ old('name') ?? $investor->name }}" placeholder="Enter Investor name" required/>
                    </div>

                    <div class="col-md-6">
                        <x-form.label name="Phone" for="phone" required/>
                        <x-form.input type="number" id="phone" name="phone" value="{{ old('phone') ?? $investor->phone }}" placeholder="Enter investor mobile no" required/>
                    </div>

                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Address" for="address"/>
                        <x-form.input type="textarea" id="address" name="address" old_text="{{ old('address') ?? $investor->address }}" placeholder="Enter address (Optional)"/>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Note" for="note"/>
                        <x-form.input type="textarea" id="note" name="note" old_text="{{ old('note') ?? $investor->note }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Investor"/>
                </div>
            </form>
        </div>
    </div>
    <!-- End body widget -->
</x-app-layout>
