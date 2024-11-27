@section('title', 'product Details')
<x-app-layout>
    <div class="row g-3">
        <div class="col-lg-4">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center">
                    <button type="button" class="btn icon lg rounded" title="Print Product Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('product.edit', $product->id) }}" type="button" class="btn icon lg rounded"
                       title="Edit This Product">
                        <i class="bi bi-pencil-square"></i>
                    </a>
                    <button type="button" class="btn icon lg rounded" title="Reloar"
                            onclick="location.reload()">
                        <i class="bi bi-bootstrap-reboot"></i>
                    </button>
                    <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                        <i class="bi bi-arrow-left"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="col-lg-8">
            <div class="widget" id="print-widget">

                <!-- Start print header =========================== -->
                <x-print.header />
                <!-- End print header =========================== -->

                <!-- Start header ================= -->
                <div class="widget-head border-bottom pb-1">
                    <h4>{{ $product?->name }}</h4>
                    <p class="text-muted">
                        <strong>Date:</strong>
                        <span class="me-3">{{ $product?->created_at->format('d F, Y') }}</span>
                         <strong>Upload by :</strong>
                        <a href="{{route('user.show', $product?->user?->id) }}">{{ $product?->user?->name }}</a>
                    </p>
                </div>
                <!-- End header ==================== -->


                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <h5 class="mt-3 mb-2">Products Details</h5>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td>Name</td>
                                <td>{{ $product?->name }}</td>
                            </tr>
                            <tr>
                                <td>Category</td>
                                <td>{{ $product?->category_name }}</td>
                            </tr>
                            <tr>
                                <td>Subcategory</td>
                                <td>{{ $product?->subcategory_name }}</td>
                            </tr>
                            <tr>
                                <td>Brand</td>
                                <td>{{ $product?->brand_name }}</td>
                            </tr>
                            <tr>
                                <td>Barcode</td>
                                <td>{{ $product?->barcode }}</td>
                            </tr>
                            <tr>
                                <td>Unit Quantity</td>
                                <td>{{ $product?->total_product_quantity_in_unit }}</td>
                            </tr>
                            <tr>
                            <td>Unit</td>
                                <td>{{ $product?->unit_name }}</td>
                            </tr>
                            <tr>
                                <td>Purchase Price </td>
                                <td>{{ $product?->purchase_price }}</td>
                            </tr>

                            <tr>
                                <td>Trade Price</td>
                                <td>{{ $product?->sale_price }}</td>
                            </tr>

                            <tr>
                                <td>MRP Price</td>
                                <td>{{ $product?->wholesale_price }}</td>
                            </tr>
                            <tr>
                                <td>Stock Alert Qty</td>
                                <td>{{ \App\Helpers\Converter::convertToUpperUnit($product->stock_alert, $product?->unit_label, $product?->unit_relation) }}</td>
                            </tr>
                            <tr>
                                <td>Status</td>
                                <td>
                                    <span
                                        class="badge {{ $product->status == '1'
                                                ? 'bg-success'
                                                : 'bg-danger'
                                                }}">
                                        {{ $product->status == '1' ? 'Available' : 'Not Available' }}
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <div>
                        <p>Note : {!! $product?->description !!}</p>
                    </div>
                </div>
                <!-- End body ===================== -->

            </div>
        </div>
    </div>
</x-app-layout>
