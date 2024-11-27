@section('title', 'Update Sector')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start menu -->
        @include('pos.income-sector.menu')
        <!-- End menu -->
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
            <h5>Update Income Sector</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>
        <div class="widget-body" id="root">
            <form action="{{ route('income-sector.update', $incomeSector->id) }}" method="POST">
                @csrf
                @method('PATCH')
                 <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <x-form.label name="Name" for="name" required/>
                        <x-form.input type="text" id="name" name="name" value="{{ old('name') ?? $incomeSector->name }}" placeholder="Enter branch name" required/>
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-10">
                        <x-form.label name="Description" for="note"/>
                        <x-form.input type="textarea" id="note" name="note" old_text="{{ old('note') ?? $incomeSector->note }}" placeholder="Optional"/>
                    </div>
                </div>
                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Sector"/>
                </div>
            </form>
        </div>
    </div>
    <!-- End body widget -->
</x-app-layout>
