@section('title', 'Product Trash')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3 border-top print-none">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.product.menu')
        <!-- End left menu -->
            <!-- Start right button -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="window.print()">
                    <i class="bi bi-printer"></i>
                </button>
                <a class="btn icon lg rounded" title="Reload" href="{{ route('product.trash') }}">
                    <i class="bi bi-bootstrap-reboot"></i>
                </a>
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right button -->
        </div>
    </div>
    <!-- End header widget -->


    <!-- Start body widget -->
    <div id="print-widget">
        <!-- Start print header =========================== -->
        <x-print.header />
        <!-- End print header =========================== -->

        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All trash products</h5>
                <p><small>Total Result found {{ count($products) }} </small></p>
            </div>
            <div class="widget-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th style="width: 70px;">
                                    SL
                                </th>
                            <th scope="col">Name</th>
                            <th scope="col">Barcode</th>
                            <th scope="col">Category</th>
                            <th scope="col">Brand</th>
                            {{-- <th scope="col">Price type</th> --}}
                            <th scope="col">Unit</th>
                            <th scope="col">Purchase price</th>
                            <th scope="col">sale price</th>
                            <th scope="col">Status</th>
                                <th scope="col" class="text-end print-none">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        @foreach($products as $index => $product)
                            <tr>
                                <th scope="row">{{ $products->firstItem() + $loop->index }}</th>
                               <td>{{ $product->name }}</td>
                                <td>{{ $product->barcode ?? '' }}</td>
                                <td>{{ $product->category?->name }}</td>
                                <td>{{ $product->brand?->name }}</td>
                                {{-- <td>{{ $product->price_type }}</td> --}}
                                <td>{{ $product->unit?->name }}</td>
                                <td>{{ $product->purchase_price }}</td>
                                <td>{{ $product->sale_price }}</td>
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
                                    <a href="{{ route('product.restore', $product->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-arrow-clockwise"></i>
                                    </a>

                                    <button
                                        class="btn btn-danger sm"
                                        href="#"
                                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $product->id }}').submit() } return false ">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>

                                    <form action="{{ route('product.permanentDelete', $product->id) }}"
                                          method="get" class="d-none"
                                          id="sm-delete-{{ $product->id }}">
                                        @csrf
                                        @method('DELETE')
                                    </form>
                                </td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
       <!-- Start pagination -->
        <x-pagination :items="$products" />
    <!-- End pagination -->
    <!-- End Body widget -->
</x-app-layout>
