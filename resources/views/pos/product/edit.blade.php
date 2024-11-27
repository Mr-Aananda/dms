@section('title', 'Update Product')

<x-app-layout>
    <!-- Start main-bar -->

    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
            @include('pos.product.menu')
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
            <h5>Update Product</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>
        <div class="widget-body" id="root">
            <form action="{{ route('product.update', $product->id) }}" method="POST" id="vueRoot">
                @csrf
                @method('PATCH')

                <div class="row g-3 mb-2">
                    <div class="col-md-6">
                        <x-form.label name="Product name" for="name" required/>
                        <x-form.input type="text" id="name" name="name" value="{{ old('name') ?? $product->name }}" placeholder="Enter product name" required/>
                    </div>
                    <div class="col-md-6">
                        <x-form.label name="Brand" for="brand"/>
                        <x-form.select
                            name="brand_id"
                            id="brand"
                            :options="$brands"
                            selected_option="{{ $product->brand_id }}"
                            option_name="name"
                        />
                    </div>
                </div>
                <div class="row g-3 mb-2">
                    <div>
                        <get-subcategories
                        :categories="{{ $categories }}"
                        :old-product="{{ $product }}" />
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <price-type-by-unit :units="{{ $units }}" :old-product="{{ $product }}" />
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-4">
                        <x-form.label name="Purchase price" for="purchase-price" required/>
                        <x-form.input type="number" id="purchase-price" name="purchase_price" value="{{ old('purchase_price') ?? $product->purchase_price }}" placeholder="0.00" step="any" required/>
                    </div>
                    <div class="col-md-4">
                        <x-form.label name="Trade price" for="sale-price" required/>
                        <x-form.input type="number" id="purchase-price" name="sale_price" value="{{ old('sale_price') ?? $product->sale_price }}" placeholder="0.00" step="any" required/>
                    </div>
                    <div class="col-md-4">
                        <x-form.label name="MRP price" for="wholesale-price" required/>
                        <x-form.input type="number" id="wholesale-price" name="wholesale_price" value="{{ old('wholesale_price') ?? $product->wholesale_price }}" placeholder="0.00" step="any" required/>
                    </div>
                </div>

               <div class="row g-3 mb-2">
                    {{-- <div class="col-md-6">
                        <x-form.label name="Product type" for="type" required/>
                        <select id="type" class="form-select" name="product_type">
                            <option disabled>Select type</option>
                            <option value="raw_material" {{ $product->product_type === 'raw_material' ? 'selected' : '' }}>Raw Product</option>
                            <option value="finish_product" {{ $product->product_type === 'finish_product' ? 'selected' : '' }}>Finish Product</option>
                        </select>
                    </div> --}}
                    <div class="col-md-6">
                        <x-form.label name="Barcode" for="barcode"/>
                        <x-form.input type="text" id="barcode" name="barcode" value="{{ old('barcode') ?? $product->barcode }}" placeholder="Enter barcode"/>
                    </div>
                    <div class="col-md-6">
                        <x-form.label name="Status" for="status" required/>
                        <select id="status" class="form-select" name="status">
                            <option disabled>Select Status</option>
                            <option value="1" {{ $product->status == 1 ? 'selected' : '' }}>Available</option>
                            <option value="0" {{ $product->status == 0 ? 'selected' : '' }}>Not Available</option>
                        </select>
                    </div>
                </div>

                <div class="row g-3 mb-2">
                    <div class="col-md-12">
                        <x-form.label name="Description" for="description"/>
                        <x-form.input type="textarea" id="description" name="description" old_text="{{ old('description') ?? $product->description }}" placeholder="Optional"/>
                    </div>
                </div>

                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Product"/>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget-->
</x-app-layout>
