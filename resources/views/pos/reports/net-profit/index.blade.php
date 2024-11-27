@section('title', 'Net Profit Report')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.reports.net-profit.menu')
        <!-- End menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
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

    </div>
    <!-- End header widget -->

    <div id="print-widget">
            <!-- Start print header -->
            <x-print.header/>
            <!-- End print header -->
        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>Report: EBITDA Report</h5>
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
                                <p>৳ {{ number_format($totalSaleAmount,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total sale amount -->
                    <!-- total purchase amount -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Purchase</h5>
                                <p>৳ {{ number_format($totalPurchaseAmount,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total purchase amount -->
                    <!-- total gross profit amount -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5 class="text-primary fw-bold" {{ $totalGrossProfit >= 0 ? '' : 'text-danger' }}>
                                    {{ $totalGrossProfit >= 0 ? "Gross Profit" : "Loss" }}
                                </h5>
                                <p>৳ {{ number_format($totalGrossProfit,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <!-- total gross profit amount -->
                </div>

                <!-- Assets start -->
                <div class="row my-2">
                    <div class="mb-2">
                        <h4 class="text-primary">Assets</h4>
                    </div>
                    <div class="col-md-2">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Stock</h5>
                                <p>৳ {{ number_format($totalProductPrice,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Customer Dues</h5>
                                <p>৳ {{ number_format($customerDue,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Cash/Bank Balance</h5>
                                <p>৳ {{ number_format($cashBalance + $bankBalance,2) }}</p>
                            </div>
                        </div>
                    </div>
{{--                    <div class="col-md-2 mb-2">--}}
{{--                        <div class="card">--}}
{{--                            <div class="card-body text-center">--}}
{{--                                <h5>Income</h5>--}}
{{--                                <p>৳ {{ number_format($totalIncome,2) }}</p>--}}
{{--                            </div>--}}
{{--                        </div>--}}
{{--                    </div>--}}
                    <div class="col-md-2 mb-2">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Loan Given Due Amount</h5>
                                <p>৳ {{ number_format(abs($loanGivenDue),2) }}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-2 border-primary">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5 class="text-primary fw-bold">Total Asset</h5>
                                <p>৳ {{ number_format($totalAsset,2) }}</p>
                            </div>
                        </div>
                    </div>
                </div>
                 <!-- Assets start -->

                 <!-- Liabilities start -->
                <div class="row my-2">
                    <div class="mb-2">
                        <h4 class="text-primary">Liabilities</h4>
                    </div>
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Supplier Dues</h5>
                                <p>৳ {{ number_format(abs($supplierDue),2) }}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Invest</h5>
                                <p>৳ {{ number_format($totalInvest,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Loan Taken Due Amount</h5>
                                <p>৳ {{ number_format($loanTakenDue,2) }}</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-2">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5 class="text-primary fw-bold">Total Liability</h5>
                                <p>৳ {{ number_format($totalLiability,2) }}</p>
                            </div>
                        </div>
                    </div>
                </div>
                 <!-- Liabilities start -->

                <!-- Liabilities start -->
                <div class="row my-2">
                    <div class="mb-2">
                        <h4 class="text-primary">Expenses</h4>
                    </div>
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Expense</h5>
                                <p>৳ {{ number_format($totalExpense,2) }}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Salary</h5>
                                <p>৳ {{ number_format($totalSalary,2) }}</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-2">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5>Profit/Invest Withdraw</h5>
                                <p>৳ {{ number_format($total_invest_withdraw_amount,2) }}</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-2">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5 class="text-primary fw-bold">Total Expense</h5>
                                <p>৳ {{ number_format($totalExpenseAmount,2) }}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- total net profit amount -->
                {{-- <div class="row my-3">
                    <div class="col-md-3 mt-2"></div>
                    <div class="col-md-6 mt-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5 class="fw-bold {{ $totalGrossProfit - $totalExpenseAmount >= 0 ? '' : 'text-danger' }}">
                                        {{ $totalGrossProfit - $totalExpenseAmount >= 0 ? "Net Profit" : "Loss" }}
                                </h5>
                                <p class="fw-bold">৳ {{ number_format($totalGrossProfit - $totalExpenseAmount,2) }}</p>
                                <small>(Gross Profits - Total Expenses)</small>
                            </div>
                        </div>
                    </div>
                </div> --}}
                <div class="row my-3">
                    <div class="col-md-3 mt-2"></div>
                    <div class="col-md-6 mt-3">
                        <div class="card">
                            <div class="card-body text-center">
                                <h5 class="fw-bold {{ $totalAsset - $totalLiability >= 0 ? '' : 'text-danger' }}">
                                        {{ $totalAsset - $totalLiability >= 0 ? "Net Profit" : "Loss" }}
                                </h5>
                                <p class="fw-bold">৳ {{ number_format($totalAsset - $totalLiability,2) }}</p>
                                <small>(Assets - Liabilities)</small>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- total net profit amount -->
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

    @endpush
</x-app-layout>
