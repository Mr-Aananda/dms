@section('title', 'Update Cash')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.cash.menu')
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
            <h5>Update Cash</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>

        <div class="widget-body" id="root">
            <form action="{{ route('cash.update', $cash->id) }}" method="POST">
                @csrf
                @method('PATCH')
                 <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Name" for="name" required/>
                        <x-form.input type="text" id="name" name="name" value="{{ old('name') ?? $cash->name }}" placeholder="Enter cash name" required/>
                    </div>
                    <div class="col-md-6">
                        <x-form.label name="balance" for="balance"/>
                        <x-form.input type="number" id="balance" name="balance" value="{{ old('balance') ?? $cash->balance }}" placeholder="0.00" step="any"/>
                    </div>
                </div>
                 <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Select Branch" for="branch" required/>
                        <x-form.select
                            name="branch_id"
                            id="branch"
                            :options="$branches"
                            option_name="name"
                            selected_option="{{ $cash->branch_id }}"
                        />
                    </div>
                     <div class="col-md-6">
                        <x-form.label name="status" required/>
                        <select id="status" class="form-select" name="active">
                            <option selected disabled>Select Status</option>
                            <option
                                value="1" {{ $cash->active == '1' ? 'selected' : '' }}>
                                Active
                            </option>
                            <option
                                value="0" {{ $cash->active == '0' ? 'selected' : '' }}>
                                Inactive
                            </option>

                        </select>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Description" for="description"/>
                        <x-form.input type="textarea" id="description" name="description" old_text="{{ old('description') ?? $cash->description }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Cash"/>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget -->
</x-app-layout>
