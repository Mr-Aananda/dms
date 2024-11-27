@section('title', 'Salary Report Details')

<x-app-layout>
    <!-- Start main-bar-->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
            @include('pos.reports.payroll.menu')
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
            <form action="{{ route('report.salary-details-report',$employee->id) }}" method="get">
                <div class="row py-3 g-3">
                    <input hidden type="text" name="search" value="1">

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
                    <div class="col-md-1">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"><i class="bi bi-search"></i>
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
            <div class="widget-head mb-3 text-center">
                <h3 class="fw-bold mb-2">Report Year:
                    <span class="text-primary">
                        @if(request()->has('year') && !empty(request('year')))
                            {{ request('year') }}
                        @else
                            {{ \Carbon\Carbon::now()->year }}
                        @endif
                    </span>
                </h3>
                <h5>Salary Report For : <span class="text-primary">{{ $employee->name }} ({{ $employee->phone }})</span></h5>
            </div>
            <div class="widget-body">
                <table class="table table-bordered table-sm">
                    <thead>
                        <tr>
                            <th scope="col" class="w-25">Month</th>
                            <th scope="col">Purpose</th>
                            <th scope="col" class="text-end">Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Loop through salaries -->
                        @foreach($salaries as $salary)
                            @if(count($salary['details']) > 0)
                                @php
                                    $totalSalaryAmount = 0; // Initialize total salary amount for each salary
                                @endphp
                                @foreach($salary['details'] as $index => $details)
                                    <tr>
                                        <!-- Display month only for the first row of each salary -->
                                        @if($index == 0)
                                            <td rowspan="{{ count($salary['details']) + 1 }}">
                                               {{ \Carbon\Carbon::parse($salary['salary_month'])->format('F Y') }}
                                            </td>
                                        @endif
                                        <td class="{{ in_array($details['purpose'], ['deduction', 'advanced']) ? 'text-danger' : '' }}">
                                            {{ ucfirst(str_replace('_', ' ', $details['purpose'])) }}
                                        </td>
                                        <td class="text-end {{ in_array($details['purpose'], ['deduction', 'advanced']) ? 'text-danger' : '' }}">
                                            {{ number_format(abs($details['amount']), 2) }}
                                        </td>
                                    </tr>
                                    @php
                                        $totalSalaryAmount += $details['amount']; // Accumulate amount for overall total
                                    @endphp
                                @endforeach
                                <tr>
                                    <td><strong>Total</strong></td>
                                    <td class="text-end">{{ number_format($totalSalaryAmount, 2) }}</td>
                                </tr>
                            @endif
                        @endforeach
                    </tbody>
                    <tfoot>
                         <tr>
                            <!-- Display overall total only if there are salaries -->
                            @if(count($salaries) > 0)
                                <td>&nbsp;</td>
                                <td><strong>Overall Total</strong></td>
                                <td class="text-end">
                                    @php
                                        $overallTotalAmount = collect($salaries)->flatMap(function($salary) {
                                            return collect($salary['details'])->pluck('amount');
                                        })->sum();
                                    @endphp
                                    {{ number_format(abs($overallTotalAmount), 2) }}
                                </td>
                            @endif
                        </tr>
                    </tfoot>
                </table>

            </div>
        </div>
        <!-- End body widget -->
    </div>


</x-app-layout>
