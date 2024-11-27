@section('title', 'Income Report')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
            @include('pos.reports.income.menu')
            <!-- End menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded collapsed" title="Search"
                        data-bs-toggle="collapse" data-bs-target="#tableSearch" aria-controls="tableSearch"
                        aria-expanded="false">
                    <i class="bi bi-search"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Print" onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Reload" onclick="location.reload()">
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
            <form action="{{ route('report.income-report') }}" method="get">
                <div class="row py-3 g-3">
                    <input hidden type="text" name="search" value="1">
                    <div class="row py-3 g-3">
                        <div class="col-md-5">
                            <label for="year">Year</label><br>
                            <select name="year" id="year" class="form-select">
                                <option value="">Select Year</option>
                                @foreach ($years as $year)
                                    <option value="{{ $year }}" {{ request('year') == $year ? 'selected' : '' }}>
                                        {{ $year }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <div class="col-md-2">
                            <label class="form-label">&nbsp;</label>
                            <button class="btn btn-success d-block w-100" type="submit"><i class="bi bi-search"></i> Search
                            </button>
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
            <div class="widget-head mb-2">
                <h5>Report: Income Report</h5>
                <p><small>{{ count($incomeDetails) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th style="width: 70px;">
                                SL
                            </th>
                            <th>Expense Sector</th>
                            @foreach ($months as $month)
                                <th class="text-end">{{ $month }}</th>
                            @endforeach
                            <th scope="col" class="text-end">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($incomeDetails as $index => $income)
                            <tr>
                                <th>{{  $index + 1}}</th>
                                <td>{{ $income->name }}</td>
                                @foreach ($months as $month)
                                    <td class="text-end">
                                        {{ isset($income->sum_of_each_month[$month]) ? number_format($income->sum_of_each_month[$month], 2) : number_format(0, 2) }}
                                    </td>
                                @endforeach
                                <td class="text-end">
                                    {{ number_format($income->sum_of_each_month->sum(), 2) }}
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="{{ count($months) + 2 }}" class="text-center">No Data found</td>
                            </tr>
                        @endforelse
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="2" class="text-end">Total</th>
                            @foreach ($months as $month)
                                <th class="text-end">
                                    {{ number_format(collect($incomeDetails)->whereNotNull('sum_of_each_month.'.$month)->sum('sum_of_each_month.'.$month), 2) }}
                                </th>
                            @endforeach
                            <th class="text-end">
                                {{ number_format(collect($incomeDetails)->pluck('sum_of_each_month')->flatten()->sum(), 2) }}
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>
    <!-- End main-bar-->
</x-app-layout>
