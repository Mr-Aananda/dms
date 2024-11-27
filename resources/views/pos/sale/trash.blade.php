@section('title', 'Sale Trash')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3 border-top print-none">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.sale.menu')
        <!-- End left menu -->
            <!-- Start right button -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="window.print()">
                    <i class="bi bi-printer"></i>
                </button>
                <a class="btn icon lg rounded" title="Reload" href="{{ route('sale.trash') }}">
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
                <h5>All sale trashes</h5>
                <p><small>Total Result found {{ count($sales) }} </small></p>
            </div>
            <div class="widget-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th style="width: 70px;">
                                SL
                            </th>
                            <th>Sale Date</th>
                            <th>Invoice No</th>
                            <th>Customer</th>
                            <th class="text-end">Total</th>
                            <th class="text-end">Paid</th>
                            <th class="text-end">Due/Change</th>
                            <th class="text-end print-none">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach($sales as $index => $sale)
                            <tr>
                                <th>{{ $sales?->firstItem() + $index }}</th>
                                <td>{{ $sale?->date->format('d-M-Y') }}</td>
                                <td>{{ $sale?->invoice_no }}</td>
                                <td>{{ $sale?->party?->name }} ({{ $sale?->party?->phone }})</td>

                                <td class="text-end">{{ number_format($sale?->grand_total, 2) }}</td>
                                <td class="text-end">{{ number_format($sale?->total_paid, 2) }}</td>
                                <td class="text-end">
                                    {{ number_format(abs($sale?->grand_total - $sale?->total_paid), 2) }}
                                </td>
                                <td class="text-end print-none">
                                    <a href="{{ route('sale.restore', $sale->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-arrow-clockwise"></i>
                                    </a>

                                    <button
                                        class="btn btn-danger sm"
                                        href="#"
                                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $sale->id }}').submit() } return false ">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>

                                    <form action="{{ route('sale.permanentDelete', $sale->id) }}"
                                          method="get" class="d-none"
                                          id="sm-delete-{{ $sale->id }}">
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
        <x-pagination :items="$sales" />
    <!-- End pagination -->
    <!-- End Body widget -->
</x-app-layout>
