@section('title', 'Stock Report')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.reports.stock.menu')
        <!-- End menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded collapsed" title="Search"
                        data-bs-toggle="collapse" data-bs-target="#tableSearch" aria-controls="tableSearch"
                        aria-expanded="false">
                    <i class="bi bi-search"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="printable('print-widget')">
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
        <div class="widget-body collapse {{ request()->search == '1' ? 'show' : '' }}" id="tableSearch">
            <form action="{{ route('report.stock-report') }}" method="get">
                <div class="row py-3 g-3">
                    <input hidden type="text" name="search" value="1">
                    <div class="row py-3 g-3">
                        <div class="col-md-2">
                            <label for="date" class="form-label">Date</label>
                            <input
                            value="{{ (request()->search) ? request()->date : date('Y-m-d') }}"
                            type="date"
                            id="date"
                            name="date"
                            class="form-control"
                            placeholder="YYYY-MM-DD">
                        </div>
                        <div class="col-md-2">
                            <label for="branch_id">Branches</label><br>
                            <select name="branch_id" id="branch_id" style="width: 100%" class="search-select-2">
                                <option value="">Select branch</option>
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
                        <div class="col-md-3">
                            <label for="product_id">Product</label><br>
                            <select name="product_id" id="product_id" style="width: 100%" class="search-select-2">
                                <option value="">Select a product</option>
                                @foreach ($products as $product)
                                    <option value="{{ $product->id }}"
                                        {{ request('product_id') == $product->id ? 'selected' : '' }}>{{ $product->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">&nbsp;</label>
                            <button class="btn btn-success d-block w-100" type="submit"><i class="bi bi-search"></i> Search</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- End Filter Fill -->
    </div>
    <!-- End header widget -->

    <div id="print-widget">
            <!-- Start print header -->
            <x-print.header/>
            <!-- End print header -->
            <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>Report: Stock Report</h5>
                {{ request()->search ? 'Details are given below.' : 'Please search for details.' }}
            </div>
            <div class="widget-body">

                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th scope="col">SL</th>
                            <th scope="col">Name</th>
                            <th scope="col" class="text-end">Current Stock</th>
                            <th scope="col" class="text-end">Purchase</th>
                            <th scope="col" class="text-end">Purchase Return</th>
                            <th scope="col" class="text-end">Sale</th>
                            <th scope="col" class="text-end">Sale Return</th>
                            <th scope="col" class="text-end">Damage</th>
                            <th scope="col" class="text-end">Production</th>
                            <th scope="col" class="text-end">Stock - {{ \request()->search ? \Carbon\Carbon::parse(\request()->date)->format('d F Y')
                                                                                            : \Carbon\Carbon::now()->format('d F Y') }}</th>
                        </tr>
                    </thead>
                    @forelse ($products_query as $product)
                    @php
                        $purchaseQuantity = $product->details->where('detailable_type', 'App\Models\Purchase')->sum('quantity');
                        $purchaseReturnQuantity = $product->details->where('detailable_type', 'App\Models\PurchaseReturn')->sum('quantity');
                        $saleQuantity = $product->details->where('detailable_type', 'App\Models\Sale')->sum('quantity');
                        $saleReturnQuantity = $product->details->where('detailable_type', 'App\Models\SaleReturn')->sum('quantity');
                        $damageQuantity = $product->details->where('detailable_type', 'App\Models\damage')->sum('quantity');
                        $productionQuantity = $product->productionDetails->where('production_type', 'raw_product')->sum('quantity') -
                        $product->productionDetails->where('production_type', '!=', 'raw_product')->sum('quantity');
                        $currentQuantity = request()->search && request()->branch_id ? $product->total_product_quantity_branch_wise : $product->total_product_quantity;
                        $totalQuantity = ($currentQuantity + $saleQuantity + $purchaseReturnQuantity + $productionQuantity + $damageQuantity)
                                            -
                                         ($saleReturnQuantity + $purchaseQuantity)
                    @endphp
                       @if (request()->search)
                        <tr>
                            <th scope="row">{{ $products_query->firstItem() + $loop->index }}.</th>
                            <td>{{ $product->name }}</td>
                            <td class="text-end">
                                @if (request()->search && request()->branch_id)
                                {{ \App\Helpers\Converter::convertToUpperUnit($product->total_product_quantity_branch_wise, $product?->unit_label, $product?->unit_relation) }}
                                @else
                                {{ \App\Helpers\Converter::convertToUpperUnit($product->total_product_quantity, $product?->unit_label, $product?->unit_relation) }}
                                @endif
                            </td>

                            <td class="text-end">
                                {{ \App\Helpers\Converter::convertToUpperUnit($purchaseQuantity, $product?->unit_label, $product?->unit_relation) }}
                            </td>
                            <td class="text-end">
                                {{ \App\Helpers\Converter::convertToUpperUnit($purchaseReturnQuantity, $product?->unit_label, $product?->unit_relation) }}
                            </td>
                            <td class="text-end">
                                {{ \App\Helpers\Converter::convertToUpperUnit($saleQuantity, $product?->unit_label, $product?->unit_relation) }}
                            </td>
                            <td class="text-end">
                                {{ \App\Helpers\Converter::convertToUpperUnit($saleReturnQuantity, $product?->unit_label, $product?->unit_relation) }}
                            </td>
                            <td class="text-end">
                                {{ \App\Helpers\Converter::convertToUpperUnit($damageQuantity, $product?->unit_label, $product?->unit_relation) }}
                            </td>
                            <td class="text-end">
                                {{ \App\Helpers\Converter::convertToUpperUnit(abs($productionQuantity), $product?->unit_label, $product?->unit_relation) }}
                            </td>
                            <td class="text-end">
                                {{ \App\Helpers\Converter::convertToUpperUnit($totalQuantity, $product?->unit_label, $product?->unit_relation) }}
                            </td>

                        </tr>

                       @endif
                    @empty
                        <tr>
                            <th colspan="6">List is empty.</th>
                        </tr>
                    @endforelse
                </table>

            <!-- End body widget -->
        </div>
    </div>
    <!-- End main-bar-->
    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#branch_id').select2({
                    allowClear: true,
                    placeholder: "Choose one",
                    width: 'resolve'
                });
            });
            }, 1000);
            setTimeout(() => {
                $(document).ready(function() {
                $('#product_id').select2({
                    allowClear: true,
                    placeholder: "Choose one",
                    width: 'resolve'
                });
            });
            }, 1000);
            setTimeout(() => {
                $(document).ready(function() {
                $('#category_id').select2({
                    allowClear: true,
                    placeholder: "Choose one",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush
</x-app-layout>
