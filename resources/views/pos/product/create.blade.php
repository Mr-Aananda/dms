@section('title', 'Create Product')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start  menu -->
        @include('pos.product.menu')
        <!-- End menu -->
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
                    <form action="{{ route('product.store') }}" method="POST" id="vueRoot">
                        @csrf
                        <div class="row g-3 mb-2">
                            <div class="col-md-5">
                                <x-form.label name="Product name" for="name" required/>
                                <x-form.input type="text" id="name" name="name" placeholder="Enter product name" required autofocus/>
                            </div>
                            <div class="col-md-5">
                                <x-form.label name="Brand" for="brand"/>
                                <x-form.select
                                    name="brand_id"
                                    id="brand"
                                    :options="$brands"
                                    option_name="name"
                                />
                            </div>
                            <div class="col-md-2">
                                <div>&nbsp;</div>
                                <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#brandCreateModal">
                                    <i class="bi bi-plus-lg"></i>
                                    Add Brand
                                </button>
                            </div>
                        </div>
                        <div class="row g-3 mb-2">
                            <div class="col-md-10">
                                <get-subcategories
                                :old_category_id={{ json_encode(old('category_id')) }}
                                :old_subcategory_id={{ json_encode(old('subcategory_id')) }}
                                :errors="{{ $errors }}"
                                :categories="{{ $categories }}"
                                />
                            </div>
                            <div class="col-md-2">
                                <div>&nbsp;</div>
                                <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#categoryCreateModal">
                                    <i class="bi bi-plus-lg"></i>
                                    Add Category
                                </button>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <price-type-by-unit
                                :old_unit_id={{ json_encode(old('unit_id')) }}
                                :old_price_type={{ json_encode(old('price_type')) }}
                                :old_stock_alert={{ json_encode(old('stock_alert')) }}
                                :old_quantity_in_unit={{ json_encode(old('quantity_in_unit')) }}
                                :errors="{{ $errors }}"
                                :units="{{ $units }}"
                            />
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-4">
                                <x-form.label name="Purchase price" for="purchase-price" required/>
                                <x-form.input type="number" id="purchase-price" name="purchase_price" placeholder="0.00" step="any" required/>
                            </div>
                            <div class="col-md-4">
                                <x-form.label name="Trade price" for="sale-price" required/>
                                <x-form.input type="number" id="purchase-price" name="sale_price" placeholder="0.00" step="any" required/>
                            </div>
                            <div class="col-md-4">
                                <x-form.label name="MRP price" for="wholesale-price"/>
                                <x-form.input type="number" id="wholesale-price" name="wholesale_price" placeholder="0.00" step="any"/>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            {{-- <div class="col-md-6">
                                <x-form.label name="Product type" for="type" required/>
                                <select id="type" class="form-select" name="product_type">
                                    <option disabled>Select type</option>
                                    <option value="raw_material" >Raw Product</option>
                                    <option value="finish_product" selected >Finish Product</option>
                                </select>
                            </div> --}}
                            <div class="col-md-6">
                                <x-form.label name="Barcode" for="barcode"/>
                                <x-form.input type="text" id="barcode" name="barcode" placeholder="Enter barcode"/>
                            </div>
                             <div class="col-md-6">
                                <x-form.label name="Status" for="status" required/>
                                <select id="status" class="form-select" name="status">
                                    <option disabled>Select Status</option>
                                    <option value="1" selected >Available</option>
                                    <option value="0">Not Available</option>
                                </select>
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
                                <x-form.save name="Add Product"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
    <!-- End body widget -->
    <!-- End main-bar -->

@php
    // Define $existingCategoryId and $categories here
    $existingCategoryId = "";
    $categories = App\Models\Category::tree(); // Adjust this according to your data retrieval logic
@endphp

    @include('pos.modal-component.category-component', ['existingCategoryId' => $existingCategoryId, 'categories' => $categories])
    @include('pos.modal-component.brand-component')

</x-app-layout>
