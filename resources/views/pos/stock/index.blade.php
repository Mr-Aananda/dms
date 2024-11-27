@section('title', 'Stock')

<x-app-layout>
    <!-- Start header widget =================================== -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
            @include('pos.stock.menu')
            <!-- End left menu -->

            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Search" data-bs-toggle="collapse"
                    data-bs-target="#tableSearch" aria-controls="tableSearch" aria-expanded="true">
                    <i class="bi bi-search"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Print" onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                </button>
                {{-- <button type="button" class="btn icon lg rounded" disabled title="Delete all selected items">
                            <i class="bi bi-trash"></i>
                        </button> --}}
                <button type="button" class="btn icon lg rounded" title="Reloar" onclick="location.reload()">
                    <i class="bi bi-bootstrap-reboot"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right buttons -->

        </div>
        <!-- Start Search body -->
        <div class="widget-body {{ request('search') ? '' : 'collapse' }}" id="tableSearch">
            <form action="{{ route('stock.index') }}" method="GET">
                <input type="hidden" name="search" value="1">
                <div class="row py-3 g-3">
                    <div class="col-md-4">
                        <label for="product_id">Product</label><br>
                        <select name="product_id" id="product_id" style="width: 100%" class="search-select-2">
                            <option value="">Select a product</option>
                            @foreach ($allProducts as $product)
                                <option value="{{ $product->id }}"
                                    {{ request('product_id') == $product->id ? 'selected' : '' }}>{{ $product->name }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label for="branch_id">Branch</label><br>
                        <select name="branch_id" id="branch_id" style="width: 100%" class="search-select-2">
                            <option value="">Select party</option>
                            @foreach ($branches as $branch)
                                <option value="{{ $branch->id }}"
                                    {{ request('branch_id') == $branch->id ? 'selected' : '' }}>{{ $branch->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-3">
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
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"><i
                                class="bi bi-search"></i>
                            Search
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <!-- End Search body -->
    </div>
    <!-- End header widget =================================== -->


    <div id="print-widget">
        <!-- Start print header =========================== -->
        <x-print.header />
        <!-- End print header =========================== -->

        <!-- Start body widget =================================== -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Stock products</h5>
                <p><small>About {{ count($products) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th style="width: 70px;">
                                <label for="check-all" class="form-check-label"> SL </label>
                            </th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Quantity</th>
                            <th>Damage Quantity</th>
                            <th>Purchase price</th>
                            <th>Price Type</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($products as $product)
                            <tr>
                                <th>
                                    <label for="check-1" class="form-check-label">{{ $loop->index + 1 }}
                                    </label>
                                </th>
                                <td class="{{ $product && $product->total_product_quantity <= $product->stock_alert ? 'text-danger' : '' }}">
                                    {{ $product?->name }}
                                </td>
                                <td class="{{ $product && $product->total_product_quantity <= $product->stock_alert ? 'text-danger' : '' }}">
                                    {{ $product?->category?->name }}
                                </td>
                                <td class="{{ $product && $product->total_product_quantity <= $product->stock_alert ? 'text-danger' : '' }}">
                                    {{ $product?->total_product_quantity_in_unit }}
                                </td>
                                <td class="{{ $product && $product->total_product_quantity <= $product->stock_alert ? 'text-danger' : '' }}">
                                    {{ $product?->damage_quantity }}
                                </td>
                                <td class="{{ $product && $product->total_product_quantity <= $product->stock_alert ? 'text-danger' : '' }}">
                                    {{ $product?->purchase_price }}
                                </td>
                                <td class="{{ $product && $product->total_product_quantity <= $product->stock_alert ? 'text-danger' : '' }}">
                                    {{ explode('/', $product?->unit_label)[$product->price_type]  ?? ""}}
                                </td>
                            <tr>
                            @empty
                            <tr>
                                <td colspan="6" class="text-center">No information found</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget =================================== -->

<!-- Start pagination -->
        <x-pagination :items="$products" />
    <!-- End pagination -->
    </div>

    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#branch_id').select2({
                    allowClear: true,
                    placeholder: "Select Branch",
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
