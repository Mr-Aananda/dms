@section('title', 'Product Transfer Trash')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3 border-top print-none">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.product-transfer.menu')
        <!-- End left menu -->
            <!-- Start right button -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="window.print()">
                    <i class="bi bi-printer"></i>
                </button>
                <a class="btn icon lg rounded" title="Reload" href="{{ route('purchase.trash') }}">
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
                <h5>All trash product tranfers</h5>
                <p><small>Total Result found {{ count($productTransfers) }} </small></p>
            </div>
            <div class="widget-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th style="width: 70px;">
                                SL
                            </th>
                            <th>Date</th>
                            <th>Transfer No</th>
                            <th>From Branch</th>
                            <th>To Branch</th>
                            <th>Transfer By</th>
                            <th class="text-end print-none">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach($productTransfers as $index => $transfer)
                            <tr>
                                <th>{{ $productTransfers?->firstItem() + $index }}</th>
                                <td>{{ $transfer?->date->format('d-M-Y') }}</td>
                                <td>{{ $transfer?->transfer_no }}</td>
                                <td>{{ $transfer?->fromBranch?->name }}</td>
                                <td>{{ $transfer?->toBranch?->name }}</td>
                                <td>{{ $transfer?->user?->name }}</td>
                                <td class="text-end print-none">
                                    <a href="{{ route('product-transfer.restore', $transfer->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-arrow-clockwise"></i>
                                    </a>

                                    <button
                                        class="btn btn-danger sm"
                                        href="#"
                                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $transfer->id }}').submit() } return false ">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>

                                    <form action="{{ route('product-transfer.permanentDelete', $transfer->id) }}"
                                          method="get" class="d-none"
                                          id="sm-delete-{{ $transfer->id }}">
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
        <x-pagination :items="$productTransfers" />
    <!-- End pagination -->
    <!-- End Body widget -->
</x-app-layout>
