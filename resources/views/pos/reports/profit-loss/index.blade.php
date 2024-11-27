@section('title', 'Profit Loss Report')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.reports.profit-loss.menu')
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
            <form action="{{ route('report.profit-loss-report') }}" method="get">
                <div class="row py-3 g-3">
                    <input hidden type="text" name="search" value="1">
                    <div class="row py-3 g-3">
                        <div class="col-md-3">
                            <label for="date" class="form-label">Date (From)</label>
                            <input
                            value="{{ (request()->search) ? request()->from_date : date('Y-m-d') }}"
                            {{-- value="{{ (request()->search) ? request()->from_date : '' }}" --}}
                            type="date"
                            id="fromdate"
                            name="from_date"
                            class="form-control"
                            placeholder="YYYY-MM-DD">
                        </div>
                        <div class="col-md-3">
                            <label for="date" class="form-label">Date (To)</label>
                            <input
                            value="{{ (request()->search) ? request()->to_date : date('Y-m-d') }}"
                            {{-- value="{{ (request()->search) ? request()->to_date : '' }}" --}}
                            type="date"
                            id="todate"
                            name="to_date"
                            class="form-control"
                            placeholder="YYYY-MM-DD">
                        </div>
                        <div class="col-md-4">
                            <label for="branch_id">Branches</label><br>
                            <select name="branch_id" id="branch_id" style="width: 100%" class="search-select-2">
                                <option value="">Select branch</option>
                                @foreach ($branches as $branch)
                                    <option value="{{ $branch->id }}"
                                        {{ request('branch_id') == $branch->id ? 'selected' : '' }}>{{ $branch->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">&nbsp;</label>
                            <button class="btn btn-success d-block w-100" type="submit"><i class="bi bi-search"></i> Search</button>
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
            <div class="widget-head mb-3">
                <h5>Report: Profit Loss Report</h5>
                <p>Date: {{ \request()->search ? \Carbon\Carbon::parse(\request()->date)->format('d F Y')
                                     : \Carbon\Carbon::now()->format('d F Y') }}</p>
            </div>
            <div class="widget-body">

                <div class="row my-3">
                    <!-- total sale amount -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Sales</h5>
                                <p>{{ number_format($total_sales_amount,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total sale amount -->
                    <!-- total purchase amount -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Purchase</h5>
                                <p>{{ number_format($total_purchase_amount,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total purchase amount -->
                    <!-- total gross profit amount -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Gross Profit</h5>
                                <p>{{number_format($total_sales_amount - $total_purchase_amount ,2)}}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total gross profit amount -->
                </div>

                <div class="row">
                     <!-- total sale return amount -->
                    <div class="col-md-4 mt-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Sale Return</h5>
                                <p>{{ number_format($total_sales_return_purchase_amount ,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total sale return amount -->
                    <!-- total sale return purchase amount -->
                    <div class="col-md-4 mt-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Sale Return Purchase Price</h5>
                                <p>{{ number_format($total_sales_return_sale_amount ,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total sale return purchase amount -->
                    <!-- total sale return profit amount -->
                    <div class="col-md-4 mt-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Sale Return Profit</h5>
                                <p>{{ number_format($total_sales_return_sale_amount - $total_sales_return_purchase_amount,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total sale return profit amount -->
                </div>

                <div class="row my-3">
                    <!-- total income Record  amount -->
                    <div class="col-md-4 mt-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Income</h5>
                                <p>{{ number_format($total_income_amount,2)}}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total income Record amount -->
                    <!-- total expense amount -->
                        <div class="col-md-4 mt-3">
                            <div class="card">
                                <div class="card-body text-center">
                                    <h5>Expense</h5>
                                    <p>{{ number_format($total_expenses_amount,2)}}</p>
                                </div>
                            </div>
                        </div>
                    <!-- total expense amount -->
                    <!-- total salary amount -->
                        <div class="col-md-4 mt-3">
                            <div class="card">
                                <div class="card-body text-center">
                                    <h5>Salary</h5>
                                    <p>{{ number_format($total_salary_paid_amount,2)}}</p>
                                </div>
                            </div>
                        </div>
                    <!-- total salary amount -->
                    <!-- total invest amount -->
                        <div class="col-md-4 mt-3">
                            <div class="card">
                                <div class="card-body text-center">
                                    <h5>Invest</h5>
                                    <p>{{ number_format($total_invest_amount,2)}}</p>
                                </div>
                            </div>
                        </div>
                    <!-- total invest amount -->

                    <!-- total invest withdraw amount -->
                        <div class="col-md-4 mt-3">
                            <div class="card">
                                <div class="card-body text-center">
                                    <h5>Invest/Profit Withdraws</h5>
                                    <p>{{ number_format($total_invest_withdraw_amount,2)}}</p>
                                </div>
                            </div>
                        </div>
                    <!-- total invest withdraw amount -->
                    <div class="col-md-4 mt-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Stocks</h5>
                                <p>{{ number_format($total_stock_price,2)}}</p>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="row my-3">
                    <!-- total profit/loss amount -->
                    @php
                        $grossProfit = $total_sales_amount - $total_purchase_amount;
                        $returnProfit = $total_sales_return_sale_amount - $total_sales_return_purchase_amount;
                        $totalProfitLoss = ($grossProfit + $total_income_amount + $total_stock_price)
                                            -
                                            ($returnProfit + $total_expenses_amount + $total_salary_paid_amount + $total_invest_withdraw_amount);
                    @endphp
                        <div class="col-md-3 mt-2"></div>
                        <div class="col-md-6 mt-3">
                            <div class="card">
                                <div class="card-body text-center">
                                    <h5 class="{{ $totalProfitLoss >= 0 ? '' : 'text-danger' }}">
                                         {{ $totalProfitLoss >= 0 ? "Net Profit" : "Loss" }}
                                    </h5>
                                    <p class="{{ $totalProfitLoss >= 0 ? '' : 'text-danger' }}">
                                        {{ number_format(abs($totalProfitLoss), 2) }}
                                    </p>
                                </div>
                            </div>
                        </div>

                    <!-- total profit/loss amount -->

                </div>

                <div class="row">
                    <!-- Chart -->
                    <div class="col-12">
                        <div class="my-5 chartjs">
                            <div class="row">
                                <!-- bar chart -->
                                <div class="col-6">
                                    <canvas id="barChart"></canvas>
                                </div>
                                <!-- bar chart -->

                                <!-- doughnut chart -->
                                <div class="col-6">
                                    <div style="height: 320px;">
                                        <canvas id="doughnutChart"></canvas>
                                    </div>
                                </div>
                                <!-- doughnut chart -->
                            </div>
                        </div>
                    </div>
                    <!-- End Chart -->
                </div>

            </div>
        </div>
    <!-- End body widget -->
    <!-- End main-bar-->
    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#branch_id').select2({
                    allowClear: true,
                    placeholder: "Choose one",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>

        <script>
            var doughnut = document.getElementById('doughnutChart').getContext('2d');
            var doughnutChart = new Chart(doughnut, {
                type: 'doughnut',
                data: {
                    labels: [
                        'Sale: {{$total_sales_amount }}',
                        'Purchase: {{ $total_purchase_amount}}',
                        'Sale Return: {{ $total_sales_return_sale_amount }}',
                        'Sale Return Purchase Price: {{ $total_sales_return_purchase_amount}}',
                        'Income: {{ $total_income_amount }}',
                        'Expense: {{ $total_expenses_amount }}',
                        'Invest: {{ $total_invest_amount }}',
                        'Invest/Profit Withdraw: {{ $total_invest_withdraw_amount }}',
                        'Salaries: {{ $total_salary_paid_amount }}',
                        'Stocks: {{ $total_stock_price }}',
                    ],
                    datasets: [{
                        data: [
                            {{$total_sales_amount }},
                            {{ $total_purchase_amount}},
                            {{ $total_sales_return_sale_amount}},
                            {{ $total_sales_return_purchase_amount }},
                            {{ $total_income_amount }},
                            {{ $total_expenses_amount }},
                            {{ $total_invest_amount }},
                            {{ $total_invest_withdraw_amount }},
                            {{ $total_salary_paid_amount }},
                            {{ $total_stock_price }},
                        ],
                        backgroundColor: ["#0CA8C0", "#FFCE56", "#36A2EB", "#43d888","#bb3ded", "#FF6384","#2ec4b6","#84a59d","#ea38c0","#acdd39"],
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                }
            });
        </script>


        <script>
            const bar = document.getElementById('barChart');

            new Chart(bar, {
                type: 'bar',
                data: {
                labels: [
                    'Sale',
                    'Purchase',
                    'Sale Return',
                    'Sale Return Purchase Price',
                    'Income',
                    'Expense',
                    'Invest',
                    'Invest/Profit Withdraw',
                    'Salaries',
                    'Stocks',
                ],
                datasets: [{
                    label: '#Overall Report',
                    data: [
                        {{$total_sales_amount }},
                        {{ $total_purchase_amount}},
                        {{ $total_sales_return_sale_amount}},
                        {{ $total_sales_return_purchase_amount }},
                        {{ $total_income_amount }},
                        {{ $total_expenses_amount }},
                        {{ $total_invest_amount }},
                        {{ $total_invest_withdraw_amount }},
                        {{ $total_salary_paid_amount }},
                        {{ $total_stock_price }},
                    ],

                    // backgroundColor: ["#0CA8C0"],
                    borderWidth: 1
                }]
                },
                options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
                }
            });
        </script>
    @endpush
</x-app-layout>
