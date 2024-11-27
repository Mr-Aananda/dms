@section('title', 'Sales')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start  menu -->
            @include('pos.sale.menu')
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
         <!-- Start Search body -->
        <div class="widget-body {{ request('search') ? '' : 'collapse' }}" id="tableSearch">
            <form action="{{ route('sale.index') }}" method="GET">
                <input type="hidden" name="search" value="1">
                <div class="row py-3 g-3">
                    <div class="col-md-2">
                        <label for="date" class="form-label">Date (From)</label>
                        <input
                        {{-- value="{{ (request()->search) ? request()->form_date : date('Y-m-d') }}" --}}
                        value="{{ (request()->search) ? request()->from_date : '' }}"
                        type="date"
                        id="fromdate"
                        name="from_date"
                        class="form-control"
                        placeholder="YYYY-MM-DD">
                    </div>
                    <div class="col-md-2">
                        <label for="date" class="form-label">Date (To)</label>
                        <input
                        {{-- value="{{ (request()->search) ? request()->to_date : date('Y-m-d') }}" --}}
                        value="{{ (request()->search) ? request()->to_date : '' }}"
                        type="date"
                        id="todate"
                        name="to_date"
                        class="form-control"
                        placeholder="YYYY-MM-DD">
                    </div>
                    <div class="col-md-3">
                        <label for="party_id">Customer</label><br>
                        <select name="party_id" id="party_id" style="width: 100%" class="search-select-2">
                            <option value="">Select party</option>
                            @foreach ($parties as $party)
                                <option value="{{ $party->id }}"
                                    {{ request('party_id') == $party->id ? 'selected' : '' }}>{{ $party->name }} ({{ $party->phone  }})</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="invoice_no" class="form-label">Invoice No</label>
                        <input
                            type="text"
                            class="form-control"
                            placeholder="Enter voucher number"
                            id="invoice_no"
                            value="{{ request('invoice_no') }}"
                            name="invoice_no">
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
    <!-- End header widget -->

    <div id="print-widget">

        <!-- Start print header  -->
        <x-print.header />
        <!-- End print header -->
        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Sales</h5>
                <p><small>{{ count($sales) }} results found </small></p>
            </div>
            <div class="widget-body">
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
                            <th scope="col" class="text-end print-none">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                            @php
                                $totalGrandTotal = 0;
                                $totalPaid = 0;
                                $totalDueChange= 0;
                            @endphp
                        @forelse($sales as $index => $sale)
                                @php
                                    $totalGrandTotal += $sale->grand_total;
                                    $totalPaid += $sale->total_paid;
                                    $totalDueChange += ($sale->grand_total - $sale->total_paid);
                                @endphp
                            <tr>
                                <th>{{ $sales?->firstItem() + $index }}</th>
                                <td>{{ $sale?->date->format('d-M-Y') }}</td>
                                <td>{{ $sale?->invoice_no }}</td>
                                <td>{{ $sale?->party_name }} ({{ $sale?->party?->phone }})</td>

                                <td class="text-end">{{ number_format($sale?->grand_total, 2) }}</td>
                                <td class="text-end">{{ number_format($sale?->total_paid, 2) }}</td>
                                <td class="text-end">
                                    {{ number_format(abs($sale?->grand_total - $sale?->total_paid), 2) }}
                                </td>
                                <td class="text-end print-none">
                                    <a href="{{ route('sale.show', $sale->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                    <a href="{{ route('sale.edit', $sale->id) }}" class="btn btn-warning sm">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <button
                                        class="btn btn-danger sm"
                                        href="#"
                                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $sale->id }}').submit() } return false ">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>

                                    <form action="{{ route('sale.destroy', $sale->id) }}"
                                          method="post" class="d-none"
                                          id="sm-delete-{{ $sale->id }}">
                                        @csrf
                                        @method('DELETE')
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="10" class="text-center">No Data found</td>
                            </tr>
                        @endforelse
                         <tr class="fw-bold">
                            <td colspan="4" class="text-end">Total</td>
                            <td class="text-end">{{ number_format($totalGrandTotal, 2) }}</td>
                            <td class="text-end">{{ number_format($totalPaid, 2) }}</td>
                            <td class="text-end">{{ number_format($totalDueChange, 2) }}</td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>
    <!-- Start pagination -->
        <x-pagination :items="$sales" />
    <!-- End pagination -->
    <!-- End main-bar-->

    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#party_id').select2({
                    allowClear: true,
                    placeholder: "Select One",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush
</x-app-layout>
