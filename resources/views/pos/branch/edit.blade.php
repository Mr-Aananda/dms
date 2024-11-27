@section('title', 'Update Branch')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start menu -->
        @include('pos.branch.menu')
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
            <h5>Update Branch</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>
        <div class="widget-body" id="root">
            <form action="{{ route('branch.update', $branch->id) }}" method="POST">
                @csrf
                @method('PATCH')
                 <div class="row g-3 mb-2">
                    <div class="col-md-4">
                        <x-form.label name="Name" for="name" required/>
                        <x-form.input type="text" id="name" name="name" value="{{ old('name') ?? $branch->name }}" placeholder="Enter branch name" required/>
                    </div>
                    <div class="col-md-4">
                        <x-form.label name="location" for="location" required/>
                        <x-form.input type="text" id="location" name="location" value="{{ old('name') ?? $branch->location }}" placeholder="Enter branch location" required/>
                    </div>
                    <div class="col-md-4">
                        <x-form.label name="Status" required/>
                        <select id="status" class="form-select" name="active">
                            <option selected disabled>Select Status</option>
                            <option
                                value="1" {{ $branch->active == '1' ? 'selected' : '' }}>
                                Active
                            </option>
                            <option
                                value="0" {{ $branch->active == '0' ? 'selected' : '' }}>
                                Inactive
                            </option>
                        </select>
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Description" for="description"/>
                        <x-form.input type="textarea" id="description" name="description" old_text="{{ old('description') ?? $branch->description }}" placeholder="Optional"/>
                    </div>
                </div>
                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Branch"/>
                </div>
            </form>
        </div>
    </div>
    <!-- End body widget -->
</x-app-layout>
