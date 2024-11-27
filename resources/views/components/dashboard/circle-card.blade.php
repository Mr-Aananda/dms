    <div class="widget mb-3">
        <div class="widget-body">
            <div class="row g-4">

                <!-- Start single stats wrap ============================= -->
                <div class="col-xxl-3 col-lg-4 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon deep lg success rounded-circle me-3">
                            <i class="bi bi-cart"></i>
                        </div>
                        <div class="stats">
                        <div class="d-flex">
                            <h4 class="fw-bold text-secondary me-3"><span>৳ </span>{{ number_format($todaySaleAmount,2) }}</h4>
                            <p class="text-primary fw-bold">
                                <span class="{{ $todaySalePercentage >= 0 ? 'text-primary' : 'text-danger' }} fw-bold ">
                                    @if($todaySalePercentage >= 0)
                                        <i class="bi bi-arrow-up"></i>
                                    @else
                                        <i class="bi bi-arrow-down"></i>
                                    @endif
                                    <span>{{ number_format(abs($todaySalePercentage), 2) }}%</span>
                                </span>
                            </p>
                        </div>
                            <p class="title-sm">Today's Sale</p>
                        </div>

                    </div>
                </div>

                <div class="col-xxl-3 col-lg-4 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon deep rounded-circle warning lg me-3">
                            <i class="bi bi-bag"></i>
                        </div>
                        <div class="stats">
                        <div class="d-flex">
                            <h4 class="fw-bold text-secondary me-3"><span>৳ </span>{{ number_format($todayPurchaseAmount,2) }}</h4>
                            <p class="text-success fw-bold">
                                <span class="{{ $todayPurchasePercentage >= 0 ? 'text-danger' : 'text-primary' }} fw-bold ">
                                    @if($todayPurchasePercentage >= 0)
                                        <i class="bi bi-arrow-up"></i>
                                    @else
                                        <i class="bi bi-arrow-down"></i>
                                    @endif
                                    <span>{{ number_format(abs($todayPurchasePercentage), 2) }}%</span>
                                </span>
                            </p>
                        </div>
                            <p class="title-sm">Today's Purchase</p>
                        </div>

                    </div>
                </div>
                <div class="col-xxl-3 col-lg-4 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon deep rounded-circle danger lg me-3">
                            <i class="bi bi-wallet2"></i>
                        </div>
                        <div class="stats">
                            <div class="d-flex">
                                <h4 class="fw-bold text-secondary me-3"><span>৳ </span>{{ number_format($todayExpense,2) }}</h4>
                                <p class="text-danger fw-bold">
                                    <span class="{{ $todayExpensePercentage >= 0 ? 'text-danger' : 'text-primary' }} fw-bold ">
                                        @if($todayExpensePercentage >= 0)
                                            <i class="bi bi-arrow-up"></i>
                                        @else
                                            <i class="bi bi-arrow-down"></i>
                                        @endif
                                        <span>{{ number_format(abs($todayExpensePercentage), 2) }}%</span>
                                    </span>
                                </p>
                            </div>
                            <p class="title-sm">Today's Expense</p>
                        </div>

                    </div>
                </div>

                <div class="col-xxl-3 col-lg-4 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon deep rounded-circle lg me-3">
                            <i class="bi bi-people"></i>
                        </div>
                        <div class="stats">
                        <div class="d-flex">
                            <h4 class="fw-bold text-secondary me-3"><span>৳ </span>{{ number_format($todayIncome,2) }}</h4>
                                <p class="text-danger fw-bold">
                                    <span class="{{ $todayIncomePercentage >= 0 ? 'text-primary' : 'text-danger' }} fw-bold ">
                                        @if($todayIncomePercentage >= 0)
                                            <i class="bi bi-arrow-up"></i>
                                        @else
                                            <i class="bi bi-arrow-down"></i>
                                        @endif
                                        <span>{{ number_format(abs($todayIncomePercentage), 2) }}%</span>
                                    </span>
                                </p>
                        </div>
                            <p class="title-sm">Today's Partial Income</p>
                        </div>
                    </div>
                </div>

                <div class="col-xxl-3 col-lg-4 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon warning deep rounded-circle lg me-3">
                            <i class="bi bi-people"></i>
                        </div>
                        <div class="stats">
                        <div class="d-flex">
                            <h4 class="fw-bold text-secondary me-3"><span>৳ </span>{{ number_format($customerDue,2) }}</h4>
                        </div>
                            <p class="title-sm">Total Customer Dues</p>
                        </div>
                    </div>
                </div>

                <div class="col-xxl-3 col-lg-4 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon warning deep rounded-circle lg me-3">
                            <i class="bi bi-people"></i>
                        </div>
                        <div class="stats">
                        <div class="d-flex">
                            <h4 class="fw-bold text-secondary me-3"><span>৳ </span>{{ number_format(abs($supplierDue),2) }}</h4>
                        </div>
                            <p class="title-sm">Total Supplier Dues</p>
                        </div>

                    </div>
                </div>

                <div class="col-xxl-3 col-lg-4 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon success deep rounded-circle lg me-3">
                            <i class="bi bi-credit-card"></i>
                        </div>
                        <div class="stats">
                        <div class="d-flex">
                            <h4 class="fw-bold text-secondary me-3"><span>৳ </span>{{ number_format($totalWithdrawAmount,2) }}</h4>
                        </div>
                            <p class="title-sm">Total Cash/Bank Amount Withdraw</p>
                        </div>

                    </div>
                </div>
                <!-- End single stats wrap ============================= -->

            </div>
        </div>
    </div>
