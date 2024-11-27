@section('title', 'Update Category')

<x-app-layout>
    <!-- Start main-bar -->

    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
            @include('pos.category.menu')
            <!-- End left menu -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
        </div>
    </div>
    <!-- End header widget -->
    <!-- Start body widget-->
    <div class="widget mb-5">
        <div class="widget-head mb-3">
            <h5>Update Category</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>
        <div class="widget-body" id="root">
            <form action="{{ route('category.update', $category->id) }}" method="POST">
                @csrf
                @method('PATCH')
                 <div class="row g-3 mb-2">
                    <div class="col-md-4">
                        <x-form.label name="Name" for="name" required/>
                        <x-form.input type="text" id="name" name="name" value="{{ old('name') ?? $category->name }}" placeholder="Enter category name" required/>
                    </div>
                    <div class="col-md-4">
                        <x-form.label name="Select Category" for="category"/>
                        <select name="parent_id" id="parent" class="form-select @error('parent_id') is-invalid @enderror">
                            <option value="" disabled selected>-- Select a Category --</option>
                            <x-form.category-select :categories="$categories" :level="0"
                                :selected="old('parent_id', $category->parent_id)"
                                :existing-category-id="$existingCategoryId"
                                 />
                        </select>

                        @error('parent_id')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                        @enderror
                    </div>
                    <div class="col-md-4">
                        <x-form.label name="Status" required/>
                        <select id="status" class="form-select" name="active">
                            <option selected disabled>Select Status</option>
                            <option
                                value="1" {{ $category->active == '1' ? 'selected' : '' }}>
                                Active
                            </option>
                            <option
                                value="0" {{ $category->active == '0' ? 'selected' : '' }}>
                                Inactive
                            </option>
                        </select>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Description" for="description"/>
                        <x-form.input type="textarea" id="description" name="description" old_text="{{ old('description') ?? $category->description }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Category"/>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget-->
</x-app-layout>
