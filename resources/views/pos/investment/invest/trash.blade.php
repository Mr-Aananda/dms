@section('title', 'Invest Trash')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3 border-top print-none">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.investment.invest.menu')
        <!-- End left menu -->
            <!-- Start right button -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="window.print()">
                    <i class="bi bi-printer"></i>
                </button>
                <a class="btn icon lg rounded" title="Reload" href="{{ route('invest.trash') }}">
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
                <h5>All trash invests</h5>
                <p><small>Total Result found {{ count($invests) }} </small></p>
            </div>
            <div class="widget-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th style="width: 70px;">
                                    SL
                                </th>
                                <th scope="col">Date</th>
                                <th scope="col">Investor</th>
                                <th scope="col" class="text-end">Amount</th>
                                <th scope="col" class="text-end">Profit Per Month</th>
                                <th scope="col" class="text-end print-none">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @php
                                $totalAmount = 0;
                                $totalProfit = 0;
                                $profit_amount = 0;
                            @endphp
                        @foreach($invests as $index => $invest)
                            @php
                                $profit_amount = $invest->profit_type == 'percentage' ? (abs($invest->amount) * $invest->profit) / 100 : $invest->profit;
                                // $total_amount_with_profit = (abs($invest->amount) + $profit_amount)
                                $totalAmount += $invest->amount;
                                $totalProfit += $profit_amount;
                            @endphp
                            <tr>
                                <th scope="row">{{ $invests->firstItem() + $loop->index }}</th>
                                <td>{{ $invest->date->format('d F, Y') }}</td>
                                <td>{{ $invest?->investor_name }} ({{ $invest?->investor->phone }})</td>
                                <td class="text-end">
                                    {{ number_format($invest->amount, 2)}}
                                </td>
                                <td class="text-end">{{ number_format($profit_amount, 2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('invest.restore', $invest->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-arrow-clockwise"></i>
                                        </a>

                                        <button
                                            class="btn btn-danger sm"
                                            href="#"
                                            onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $invest->id }}').submit() } return false ">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>

                                        <form action="{{ route('invest.permanentDelete', $invest->id) }}"
                                            method="get" class="d-none"
                                            id="sm-delete-{{ $invest->id }}">
                                            @csrf
                                            @method('DELETE')
                                        </form>
                                    </td>
                                </tr>
                        @endforeach
                        </tbody>
                         <tfoot>
                            <tr>
                                <th colspan="2"></th>
                                <th class="text-end">Total</th>
                                <th class="text-end">{{ number_format($totalAmount, 2) }}</th>
                                <th class="text-end">{{ number_format($totalProfit, 2) }}</th>
                                <th></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Start pagination -->
    <x-pagination :items="$invests"/>
    <!-- End pagination -->

    <!-- End Body widget -->
</x-app-layout>
