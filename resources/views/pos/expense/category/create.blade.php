@section('title', 'Create Expense Category')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.expense.category.menu')
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
                    <form action="{{ route('expense-category.store') }}" method="POST">
                        @csrf
                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Name" for="name" required/>
                                <x-form.input type="text" id="name" name="name" placeholder="Enter category or subcategory name" required autofocus/>
                            </div>
                            <div class="col-md-6">
                                <x-form.label name="Select Category" for="category"/>
                                    <select name="parent_id" id="parent" class="form-select @error('parent_id') is-invalid @enderror">
                                    <option value="" disabled selected>-- Select a Category --</option>
                                    <x-form.category-select :categories="$categories" :level="0"
                                        :selected="old('parent_id')"
                                        :existing-category-id="$existingCategoryId"
                                        />
                                </select>

                                @error('parent_id')
                                    <div class="invalid-feedback">
                                        {{ $message }}
                                    </div>
                                @enderror
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
                                <x-form.save name="New Category"/>
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
