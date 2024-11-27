@section('title', 'All Invest')

<x-app-layout>
    <!-- Start main-bar-->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
            @include('pos.investment.invest.menu')
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
            <form action="{{ route('invest.index') }}" method="get">
                <input hidden type="text" name="search" value="1">
                <div class="row py-3 g-3">
                    <div class="col-md-3">
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
                    <div class="col-md-3">
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
                        <label for="investor_id">Investor</label><br>
                        <select name="investor_id" id="investor_id" style="width: 100%" class="search-select-2">
                            <option value="">Select investor</option>
                            @foreach ($investors as $investor)
                                <option value="{{ $investor->id }}"
                                    {{ request('investor_id') == $investor->id ? 'selected' : '' }}>{{ $investor->name }}</option>
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
                <h5>All Invests</h5>
                <p><small>{{ count($invests) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Date</th>
                        <th scope="col">Investor</th>
                        <th scope="col">Branch</th>
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
                    @forelse($invests as $invest)
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
                            <td>{{ $invest?->branch?->name }}</td>
                            <td class="text-end">
                                {{ number_format($invest->amount, 2)}}
                            </td>
                            <td class="text-end">{{ number_format($profit_amount, 2)}}</td>
                            <td class="text-end print-none">

                                @can('invest.show')
                                    <a href="{{ route('invest.show', $invest->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                @endcan

                                @can('invest.edit')
                                    <a href="{{ route('invest.edit', $invest->id) }}"
                                        class="btn sm btn-warning" title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                @endcan

                                @can('invest.destroy')
                                    <form action="{{ route('invest.destroy', $invest->id) }}" method="POST"
                                            class="d-inline"
                                            onsubmit="return confirm('Are you sure want to delete?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" title="Delete"
                                                {{ $invest->invest_withdraws_count > 0 ? 'disabled' : '' }} class="btn sm btn-danger">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                @endcan
                            </td>
                        </tr>
                        @empty
                            <tr>
                                <td colspan="10" class="text-center">No Data found</td>
                            </tr>
                        @endforelse
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
        <!-- End body widget -->
    </div>

    <!-- End main-bar  -->
      <!-- Start pagination -->
        <x-pagination :items="$invests" />
    <!-- End pagination -->
        @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#investor_id').select2({
                    allowClear: true,
                    placeholder: "Select One",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush

</x-app-layout>
