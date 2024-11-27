@section('title', 'Products')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start  menu -->
            @include('pos.product.menu')
            <!-- End  menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded collapsed" title="Search" data-bs-toggle="collapse"
                    data-bs-target="#tableSearch" aria-controls="tableSearch" aria-expanded="false">
                    <i class="bi bi-search"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Print" onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Reloar" onclick="location.reload()">
                    <i class="bi bi-bootstrap-reboot"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right buttons -->
        </div>
        <!-- Start Filter Fill -->
        <div class="widget-body {{ request('search') ? '' : 'collapse' }}" id="tableSearch">
            <form action="{{ route('product.index') }}" method="GET">
                <input type="hidden" name="search" value="1">
                <div class="row py-3 g-3">
                    <div class="col-md-2">
                        <label for="product_id">Product</label><br>
                        <select name="product_id" id="product_id" style="width: 100%" class="search-select-2">
                            <option value="">Select party</option>
                            @foreach ($searchProducts as $product)
                                <option value="{{ $product->id }}"
                                    {{ request('product_id') == $product->id ? 'selected' : '' }}>{{ $product->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="category_id">Category</label><br>
                        <select name="category_id" id="category_id" style="width: 100%" class="search-select-2">
                            <option value="">Select party</option>
                            @foreach ($categories as $category)
                                <option value="{{ $category->id }}"
                                    {{ request('category_id') == $category->id ? 'selected' : '' }}>{{ $category->name }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-2">
                        <label for="barcode" class="form-label">Barcode</label>
                        <input
                            type="text"
                            class="form-control"
                            placeholder="Enter barcode number"
                            id="barcode"
                            value="{{ request('barcode') }}"
                            name="barcode">
                    </div>

                    <div class="col-md-2">
                        <label for="brand_id">Brand</label><br>
                        <select name="brand_id" id="brand_id" style="width: 100%" class="search-select-2">
                            <option value="">Select brand</option>
                            @foreach ($brands as $brand)
                                <option value="{{ $brand->id }}"
                                    {{ request('brand_id') == $brand->id ? 'selected' : '' }}>{{ $brand->name }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-2">
                        <label for="brand_id">Status</label><br>
                        <select id="status" class="form-select" name="status">
                            <option value="">Select Status</option>
                            <option value="1" {{ request()->status == '1' ? 'selected' : '' }} >Available</option>
                            <option value="0" {{ request()->status == '0' ? 'selected' : '' }}>Not Available</option>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"><i
                                class="bi bi-search"></i>
                            Search
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- End Filter Fill -->
    </div>
    <!-- End header widget -->

    <div id="print-widget">

        <!-- Start print header  -->
        <x-print.header />
        <!-- End print header -->


        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Products</h5>
                <p><small>{{ count($products) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th scope="col">sl</th>
                            <th scope="col">Name</th>
                            <th scope="col">Barcode</th>
                            <th scope="col">Brand</th>
                            <th scope="col">Category</th>
                            <th scope="col">Unit</th>
                            <th scope="col">Price type</th>
                            <th scope="col">Purchase price</th>
                            <th scope="col">Trade price</th>
                            <th scope="col">MRP price</th>
                            <th scope="col" class="text-center" >Status</th>

                            <th scope="col" class="text-end print-none">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($products as $product)
                            <tr>
                                <th scope="row">{{ $products->firstItem() + $loop->index }}</th>
                                <td>{{ $product->name }}</td>
                                <td>{{ $product->barcode ?? '' }}</td>
                                <td>{{ $product->brand?->name }}</td>
                                <td>{{ $product->category?->name }}</td>
                                <td>{{ $product->unit?->name }}</td>
                                <td>{{ explode('/', $product?->unit_label)[$product->price_type]  ?? ""}}</td>
                                <td>{{ $product->purchase_price }}</td>
                                <td>{{ $product->sale_price }}</td>
                                <td>{{ $product->wholesale_price }}</td>
                                <td class="text-center">
                                    <span
                                        class="badge {{ $product->status == '1'
                                                ? 'bg-success'
                                                : 'bg-danger'
                                                }}">
                                        {{ $product->status == '1' ? 'Available' : 'Not Available' }}
                                    </span>
                                </td>

                                <td class="text-end print-none">
                                    @can('product.show')
                                        <a href="{{ route('product.show', $product->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    @endcan

                                    @can('product.edit')
                                        <a href="{{ route('product.edit', $product->id) }}" class="btn sm btn-warning"
                                            title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                    @endcan

                                    @can('product.destroy')
                                        <form action="{{ route('product.destroy', $product->id) }}" method="POST"
                                            class="d-inline" onsubmit="return confirm('Are you sure want to delete?')">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" title="Delete"
                                                {{ $product->details_count || $product->productiondetails_count > 0 ? 'disabled' : '' }}
                                                class="btn sm btn-danger">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    @endcan
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="10" class="text-center">No Data found</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>
    <!-- Start pagination -->
        <x-pagination :items="$products" />
    <!-- End pagination -->
    <!-- End main-bar-->
        @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#brand_id').select2({
                    allowClear: true,
                    placeholder: "Select Brand",
                    width: 'resolve'
                });
            });
            }, 1000);
            setTimeout(() => {
                $(document).ready(function() {
                $('#category_id').select2({
                    allowClear: true,
                    placeholder: "Select Category",
                    width: 'resolve'
                });
            });
            }, 1000);
             setTimeout(() => {
                $(document).ready(function() {
                $('#product_id').select2({
                    allowClear: true,
                    placeholder: "Select Product",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush
</x-app-layout>
