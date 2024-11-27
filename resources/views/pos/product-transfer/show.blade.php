@section('title', 'Production ')

<x-app-layout>
 <div class="row">
    <div class="col-lg-4">
        <div class="widget">
            <div class="widget-head border-bottom pb-3 text-center">
                <button type="button" class="btn icon lg rounded" title="Print Transfer Details"
                        onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                </button>
                <a href="{{ route('product-transfer.edit', $productTransfer->id) }}" type="button" class="btn icon lg rounded"
                    title="Edit This Transfer">
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
        <div id="print-widget">

            <!-- Start print header  -->
            <x-print.header />
            <!-- End print header -->

            <!-- Start body widget -->
            <div class="widget">
                <div class="widget-head mb-3">
                    <h5>Product Transfer Details</h5>
                    <p><small>Transfer product from branch to another branch</small></p>
                </div>
                <div class="widget-body">
                    <div class="row mt-1">
                        <div class="col-12">
                            <p>
                                <strong>Transfer Date:</strong>
                                <span>{{ $productTransfer?->date?->format('d-M-Y') }}</span>
                                <strong class="ms-3">Transfer No:</strong>
                                <span>{{ $productTransfer?->transfer_no }}</span>
                                <strong class="ms-3">Transfer By:</strong>
                                <span>{{ $productTransfer?->user?->name }}</span>
                            </p>
                        </div>
                    </div>

                    <div class="row mb-1">
                        <div class="row my-3">
                            <h5 class="col-6">From Branch : <span class="fw-bold">{{ $productTransfer?->fromBranch?->name }}</span> </h5>
                            <h5 class="col-6 text-end">To Branch : <span class="fw-bold">{{ $productTransfer?->toBranch?->name }}</h5>
                        </div>
                        <hr>
                        <div class="col-12 my-2">
                            <!-- Start product table ================== -->
                            <table class="table table-bordered table-sm">
                                <thead>
                                    <tr>
                                        <th class="text-center" style="width: 50px;">SL</th>
                                        <th>Product</th>
                                        <th class="text-end">Quantity</th>
                                        <th class="text-end">Purchase Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($productTransfer?->productTransferDetails as $details)
                                        <tr>
                                            <td class="text-center">{{ $loop->iteration }}.</td>
                                            <td>{{ $details?->product_name }}</td>
                                            <td class="text-end">
                                                {{ \App\Helpers\Converter::convertToUpperUnit($details?->quantity, $details?->product?->unit_label, $details?->product?->unit_relation) }}
                                            </td>
                                            <td class="text-end">{{ $details?->purchase_price }}</td>
                                        </tr>
                                    @empty
                                    @endforelse
                                </tbody>
                            </table>
                            <!-- End product table ================== -->
                        </div>
                        @if ($productTransfer?->note)
                            <p>
                                <strong class="ms-3">note:</strong>
                                <span>{{ $productTransfer?->note }}</span>
                            </p>
                        @endif
                    </div>

                </div>
            </div>
            <!-- End body widget -->
        </div>
        <!-- End main-bar-->
    </div>
    {{-- <div class="col-lg-3">
        <div class="widget">
            <div class="widget-body">
                <div class="d-grid gap-2">
                    <button
                        class="btn btn-outline-primary"
                        type="button"
                        onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                        Print
                    </button>

                    <a href="{{ route('product-transfer.edit', $productTransfer->id) }}" class="btn btn-outline-primary">
                        <i class="bi bi-pencil-square"></i>
                        Edit Transfer
                    </a>

                    <button
                        class="btn btn-danger"
                        href="#"
                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $productTransfer->id }}').submit() } return false ">
                        <i class="bi bi-trash"></i>
                        Delete Transfer
                    </button>

                    <form action="{{ route('product-transfer.destroy', $productTransfer->id) }}"
                            method="post" class="d-none"
                            id="sm-delete-{{ $productTransfer->id }}">
                        @csrf
                        @method('DELETE')
                    </form>
                </div>
            </div>
        </div>
    </div> --}}
 </div>
</x-app-layout>
