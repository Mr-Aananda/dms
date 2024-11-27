@section('title', 'Sale Return Trash')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3 border-top print-none">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.sale.return.menu')
        <!-- End left menu -->
            <!-- Start right button -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="window.print()">
                    <i class="bi bi-printer"></i>
                </button>
                <a class="btn icon lg rounded" title="Reload" href="{{ route('sale-return.trash') }}">
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
                <h5>All sale return trashes</h5>
                <p><small>Total Result found {{ count($returns) }} </small></p>
            </div>
            <div class="widget-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th style="width: 70px;">
                                SL
                            </th>
                            <th>Return Date</th>
                            <th>Return No</th>
                            <th>Customer</th>
                            <th class="text-end">Total</th>
                            <th class="text-end">Paid</th>
                            <th class="text-end">Due/Advanced</th>
                            <th class="text-end print-none">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach($returns as $index => $return)
                            <tr>
                               <th>{{ $returns?->firstItem() + $index }}</th>
                                <td>{{ $return?->date->format('d-M-Y') }}</td>
                                <td>{{ $return?->return_no }}</td>
                                <td>{{ $return?->party_name }}</td>

                                <td class="text-end">{{ number_format($return?->return_grand_total, 2) }}</td>
                                <td class="text-end">{{ number_format($return?->return_total_paid, 2) }}</td>
                                <td class="text-end">{{ number_format(($return?->return_grand_total - $return?->return_total_paid), 2) }}</td>
                                <td class="text-end print-none">
                                    <a href="{{ route('sale-return.restore', $return->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-arrow-clockwise"></i>
                                    </a>

                                    <button
                                        class="btn btn-danger sm"
                                        href="#"
                                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $return->id }}').submit() } return false ">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>

                                    <form action="{{ route('sale-return.permanentDelete', $return->id) }}"
                                          method="get" class="d-none"
                                          id="sm-delete-{{ $return->id }}">
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
        <x-pagination :items="$returns" />
    <!-- End pagination -->
    <!-- End Body widget -->
</x-app-layout>
