 <div class="row g-3 mb-3">
    {{-- Total cash banalce --}}
    <div class="col-xxl-3 col-xl-4 col-sm-6">
        <div class="widget px-2 py-3">
        <div class="widget-head d-flex align-items-center">
            <div>
                <h4 class="fw-bold"><span>৳ </span>{{ number_format($cashBalance,2) }}</h4>
                <p class="fw-bold text-secondary">Total Cash</p>
            </div>

            <div class="stats-icon lg ms-auto">
            <i class="bi bi-cash"></i>
            </div>
        </div>
        <div class="widget-body">
            <div class="bg-light py-2 px-3 rounded-2 mt-3">
            <p class="p-0">
                <span>Sum of all cash balance</span>
            </p>
            </div>
        </div>
        </div>
    </div>
    {{-- Total bank banalce --}}
    <div class="col-xxl-3 col-xl-4 col-sm-6">
        <div class="widget px-2 py-3">
            <div class="widget-head d-flex align-items-center">
                <div>
                    <h4 class="fw-bold"><span>৳ </span>{{ number_format($bankBalance,2) }}</h4>
                    <p class="fw-bold text-secondary">Total Bank Balance</p>
                </div>

                <div class="stats-icon lg success ms-auto">
                    <i class="bi bi-bank"></i>
                </div>
            </div>
            <div class="widget-body">
                <div class="bg-light py-2 px-3 rounded-2 mt-3">
                    <p class="p-0">
                        <span>Sum of all bank balance</span>
                    </p>
                </div>
            </div>
        </div>
    </div>

    {{-- Total Invest --}}
    <div class="col-xxl-3 col-xl-4 col-sm-6">
        <div class="widget px-2 py-3">
            <div class="widget-head d-flex align-items-center">
                <div>
                    <h4 class="fw-bold"><span>৳ </span>{{ number_format($totalInvest,2) }}</h4>
                    <p class="fw-bold text-secondary">Total Investment</p>
                </div>

                <div class="stats-icon lg danger ms-auto">
                    <i class="bi bi-cash-stack"></i>
                </div>
            </div>
            <div class="widget-body">
                <div class="bg-light py-2 px-3 rounded-2 mt-3">
                    <p class="p-0">
                        <span>Total amount of all invest amount</span>
                    </p>
                </div>
            </div>
        </div>
    </div>

    {{-- Total stock --}}
    <div class="col-xxl-3 col-xl-4 col-sm-6">
        <div class="widget px-2 py-3">
            <div class="widget-head d-flex align-items-center">
                <div>
                    <h4 class="fw-bold"><span>৳ </span>{{ number_format($totalProductPrice,2) }}</h4>
                    <p class="fw-bold text-secondary">Total Stock</p>
                </div>

                <div class="stats-icon lg warning ms-auto">
                    <i class="bi bi-house-add"></i>
                </div>
            </div>
            <div class="widget-body">
                <div class="bg-light py-2 px-3 rounded-2 mt-3">
                    <p class="p-0">
                        <span>Total amount of all products</span>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xxl-3 col-xl-4 col-sm-6">
        <div class="widget px-2 py-3">
            <div class="widget-head d-flex align-items-center">
                <div>
                    <h4 class="fw-bold"><span>৳ </span>{{ number_format($thisMonthSaleAmount,2) }}</h4>
                    <p class="fw-bold text-secondary">Sales This Month</p>
                </div>

                <div class="stats-icon lg success ms-auto">
                <i class="bi bi-cart"></i>
                </div>
            </div>
            <div class="widget-body">
                <div class="bg-light py-2 px-3 rounded-2 mt-3">
                    <p class="p-0">
                        <span class="{{ $monthSalePercentage >= 0 ? 'text-primary' : 'text-danger' }} fw-bold ">
                            @if($monthSalePercentage >= 0)
                                <i class="bi bi-arrow-up"></i>
                            @else
                                <i class="bi bi-arrow-down"></i>
                            @endif
                            <span>{{ number_format(abs($monthSalePercentage), 2) }}%</span>
                        </span>
                        <span>Since last month</span>
                    </p>
                </div>
            </div>
        </div>
    </div>

   <div class="col-xxl-3 col-xl-4 col-sm-6">
        <div class="widget px-2 py-3">
            <div class="widget-head d-flex align-items-center">
                <div>
                <h4 class="fw-bold"><span>৳ </span>{{ number_format($thisMonthPurchaseAmount,2) }}</h4>
                    <p class="fw-bold text-secondary">Purchase This Month</p>
                </div>

                <div class="stats-icon lg warning ms-auto">
                    <i class="bi bi-bag"></i>
                </div>
            </div>
            <div class="widget-body">
                <div class="bg-light py-2 px-3 rounded-2 mt-3">
                <p class="p-0">
                    <span class="{{ $monthPurchasePercentage >= 0 ? 'text-danger' : 'text-primary' }} fw-bold ">
                        @if($monthPurchasePercentage >= 0)
                            <i class="bi bi-arrow-up"></i>
                        @else
                            <i class="bi bi-arrow-down"></i>
                        @endif
                        <span>{{ number_format(abs($monthPurchasePercentage), 2) }}%</span>
                    </span>
                    <span>Since last month</span>
                </p>
                </div>
            </div>
        </div>
    </div>
     <div class="col-xxl-3 col-xl-4 col-sm-6">
        <div class="widget px-2 py-3">
            <div class="widget-head d-flex align-items-center">
                <div>
                <h4 class="fw-bold"><span>৳ </span>{{ number_format($thisMonthTotalExpense,2) }}</h4>
                    <p class="fw-bold text-secondary">Expenses This Month</p>
                </div>

                <div class="stats-icon lg danger ms-auto">
                    <i class="bi bi-coin"></i>
                </div>
            </div>
            <div class="widget-body">
                <div class="bg-light py-2 px-3 rounded-2 mt-3">
                    <p class="p-0">
                        <span class="{{ $monthExpensePercentage >= 0 ? 'text-primary' : 'text-danger' }} fw-bold ">
                            @if($monthExpensePercentage >= 0)
                                <i class="bi bi-arrow-up"></i>
                            @else
                                <i class="bi bi-arrow-down"></i>
                            @endif
                            <span>{{ number_format(abs($monthExpensePercentage), 2) }}%</span>
                        </span>
                        <span>Since last month</span>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xxl-3 col-xl-4 col-sm-6">
        <div class="widget px-2 py-3">
            <div class="widget-head d-flex align-items-center">
                <div>
                <h4 class="fw-bold"><span>৳ </span>{{ number_format($thisMonthTotalIncome,2) }}</h4>
                    <p class="fw-bold text-secondary">Partial Incomes This Month</p>
                </div>

                <div class="stats-icon lg ms-auto">
                    <i class="bi bi-cash-coin"></i>
                </div>
            </div>
            <div class="widget-body">
                <div class="bg-light py-2 px-3 rounded-2 mt-3">
                    <p class="p-0">
                        <span class="{{ $monthIncomePercentage >= 0 ? 'text-danger' : 'text-primary' }} fw-bold ">
                            @if($monthIncomePercentage >= 0)
                                <i class="bi bi-arrow-up"></i>
                            @else
                                <i class="bi bi-arrow-down"></i>
                            @endif
                            <span>{{ number_format(abs($monthIncomePercentage), 2) }}%</span>
                        </span>
                        <span>Since last month</span>
                    </p>
                </div>
            </div>
        </div>
    </div>

</div>
