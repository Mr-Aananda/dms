  <!-- Start aside =================================== -->
    <!--
    If you want to keep sidebar always hidden then follow below 2 process
    1. use .hide-always class in aside tag
    2. use .main-bar-expand class in main tag
   -->
<aside id="left-aside"
    class="left-aside print-none
        {{
            Route::currentRouteName() == 'sale.create'
            || Route::currentRouteName() == 'sale.edit'
            || Route::currentRouteName() == 'sale-return.create'
            || Route::currentRouteName() == 'sale-return.edit'
            || Route::currentRouteName() == 'purchase.create'
            || Route::currentRouteName() == 'purchase.edit'
            || Route::currentRouteName() == 'purchase-return.create'
            || Route::currentRouteName() == 'purchase-return.edit'
            || Route::currentRouteName() == 'production.create'
            || Route::currentRouteName() == 'production.edit'
            ? 'hide-always' : ''
        }}"
    >
<!-- Start Left logo area ======================================= -->
    <x-nav-logo-component/>
<!-- End Left logo area ======================================= -->

    <!-- Start aside menu ============================================== -->
    <ul class="accordion" id="dropdown-menu">

        <li class="accordion-item">
            <a href="{{ route('dashboard') }}" class="sigle-nav-link {{ Route::currentRouteName() == 'dashboard' ? 'active' : '' }}">
                <i class="bi bi-speedometer2"></i>
                <span>Dashboard</span>
            </a>
        </li>

        <li class="accordion-item">
            <span class="accordion-item-title text-primary">Modules</span>
        </li>
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#party"
               aria-expanded="false" aria-controls="party">
                <i class="bi bi-people"></i>
                <span class="me-auto">Party</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="party" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="supplier.index" :checkActive="['supplier.create','supplier.index','supplier.edit','supplier.show', 'supplier.trash']" name="Suppliers" />
                </li>
                <li>
                    <x-link route="customer.index" :checkActive="['customer.create','customer.index','customer.edit', 'customer.show', 'customer.trash']" name="Customers" />
                </li>
            </ul>
        </li>

        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#purchase"
               aria-expanded="false" aria-controls="purchase">
                <i class="bi bi-bag"></i>
                <span class="me-auto">Purchase</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="purchase" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="purchase.index" :checkActive="['purchase.index','purchase.show', 'purchase.trash']" name="All Purchases" />
                </li>
                <li>
                    <x-link route="purchase.create" :checkActive="['purchase.create','purchase.edit']" name="New Purchase" />
                </li>
            </ul>
        </li>

        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#purchase-return"
               aria-expanded="false" aria-controls="purchase-return">
                <i class="bi bi-bag-dash"></i>
                <span class="me-auto">Purchase Return</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="purchase-return" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="purchase-return.index" :checkActive="['purchase-return.index', 'purchase-return.show', 'purchase-return.trash']" name="All Return" />
                </li>
                <li>
                    <x-link route="purchase-return.create" :checkActive="['purchase-return.create', 'purchase-return.edit']" name="New Return" />
                </li>
            </ul>
        </li>

        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#sale"
               aria-expanded="false" aria-controls="sale">
                <i class="bi bi-cart"></i>
                <span class="me-auto">Sale</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="sale" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="sale.index" :checkActive="['sale.index','sale.show', 'sale.trash']" name="All Sales" />
                </li>
                <li>
                    <x-link route="sale.create" :checkActive="['sale.create', 'sale.edit']" name="New Sale" />
                </li>
            </ul>
        </li>

        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#sale-return"
               aria-expanded="false" aria-controls="sale-return">
                <i class="bi bi-cart-dash"></i>
                <span class="me-auto">Sale Return</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="sale-return" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="sale-return.index" :checkActive="['sale-return.index', 'sale-return.show', 'sale-return.trash']"  name="All Returns" />
                </li>
                <li>
                    <x-link route="sale-return.create" :checkActive="['sale-return.create', 'sale-return.show', 'sale-return.edit']" name="New Return" />
                </li>
            </ul>
        </li>

        <li class="accordion-item">
            <a href="{{ route('stock.index') }}" class="sigle-nav-link {{ Route::currentRouteName() == 'stock.index' ? 'active' : '' }}">
                <i class="bi bi-house-add"></i>
                <span>Stock</span>
            </a>
        </li>

        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#due-manage"
               aria-expanded="false" aria-controls="due-manage">
                <i class="bi bi-wallet2"></i>
                <span class="me-auto">Due Manage</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="due-manage" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="supplier-due.index" :checkActive="['supplier-due.create', 'supplier-due.index','supplier-due.edit', 'supplier-due.trash']" name="Supplier Due" />
                </li>
                <li>
                    <x-link route="customer-due.index" :checkActive="['customer-due.create', 'customer-due.index','customer-due.edit', 'customer-due.trash']" name="Customer Due" />
                </li>
            </ul>
        </li>

        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#damage"
               aria-expanded="false" aria-controls="damage">
                <i class="bi bi-cart-x"></i>
                <span class="me-auto">Damage</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="damage" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="damage.index" :checkActive="['damage.index', 'damage.show', 'damage.trash']" name="All Damages" />
                </li>
                <li>
                    <x-link route="damage.create" :checkActive="['damage.create', 'damage.edit']" name="New Damage" />
                </li>
            </ul>
        </li>

        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#production"
               aria-expanded="false" aria-controls="production">
                <i class="bi bi-minecart-loaded"></i>
                <span class="me-auto">Production</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="production" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="production.index" :checkActive="['production.index', 'production.show', 'production.trash']" name="All Productions" />
                </li>
                <li>
                    <x-link route="production.create" :checkActive="['production.create', 'production.edit']" name="New Production" />
                </li>
            </ul>
        </li>

        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#product-transfer"
               aria-expanded="false" aria-controls="product-transfer">
                <i class="bi bi-arrow-left-right"></i>
                <span class="me-auto">Product Transfers</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="product-transfer" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="product-transfer.index" :checkActive="['product-transfer.index', 'product-transfer.show', 'product-transfer.trash']" name="All Transfer"/>
                </li>
                <li>
                    <x-link route="product-transfer.create" :checkActive="['product-transfer.create', 'product-transfer.edit']" name="New Transfer"/>
                </li>
            </ul>
        </li>

        <!--  Transaction Part -->
        <li class="accordion-item">
            <span class="accordion-item-title text-primary">Transactions</span>
        </li>

         <!-- Balance-Transfer Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#balance-transfer"
               aria-expanded="false" aria-controls="balance-transfer">
                <i class="bi bi-credit-card-2-back"></i>
                <span class="me-auto">Balance Transfer</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="balance-transfer" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="transaction.index" :checkActive="['transaction.index','transaction.show','transaction.trash']" name="All Transactions" />
                </li>

                <li>
                    <x-link route="transaction.create" :checkActive="['transaction.create', 'transaction.edit']" name="New Transaction" />
                </li>
            </ul>
        </li>
        <!-- Balance-Transfer End-->

        <!-- Loan Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#loan"
               aria-expanded="false" aria-controls="loan">
                <i class="bi bi-collection"></i>
                <span class="me-auto">Loan</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="loan" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="loan-account.index" :checkActive="['loan-account.index', 'loan-account.create', 'loan-account.edit', 'loan-account.show', 'loan-account.trash']" name="Loan Accounts" />
                </li>
                <li>
                    <x-link route="loan.index" :checkActive="['loan.index', 'loan.create', 'loan.edit', 'loan.show', 'loan.trash','loan-installment.create','loan-installment.edit']" name="All Loans" />
                </li>
            </ul>
        </li>
        <!-- Loan End-->
        <!-- Payroll Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#payroll"
               aria-expanded="false" aria-controls="payroll">
                <i class="bi bi-cash-coin"></i>
                <span class="me-auto">Payroll</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="payroll" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="advanced-salary.index" :checkActive="['advanced-salary.create','advanced-salary.index','advanced-salary.edit','advanced-salary.show', 'advanced-salary.trash']" name="Advanced Salaries" />
                </li>

                <li>
                    <x-link route="salary.index" :checkActive="['salary.index', 'salary.create', 'salary.edit','salary.show', 'salary.trash']" name="All Salaries" />
                </li>
            </ul>
        </li>
        <!-- Payroll End-->

        <!-- Income Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#income"
               aria-expanded="false" aria-controls="income">
                <i class="bi bi-credit-card-2-front"></i>
                <span class="me-auto">Partial Income</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="income" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="income-sector.index" :checkActive="['income-sector.create','income-sector.index','income-sector.edit', 'income-sector.trash']" name="Income Sector" />
                </li>

                <li>
                    <x-link route="income-record.index" :checkActive="['income-record.index','income-record.show', 'income-record.create', 'income-record.edit', 'income-record.trash']" name="Income Record" />
                </li>
            </ul>
        </li>
        <!-- Income End-->

        <!-- Expense Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#expense"
               aria-expanded="false" aria-controls="expense">
                <i class="bi bi-wallet2"></i>
                <span class="me-auto">Expense</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="expense" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="expense.index" :checkActive="['expense.create','expense.index','expense.edit','expense.show', 'expense.trash']" name="All Expenses" />
                </li>

                <li>
                    <x-link route="expense-category.index" :checkActive="['expense-category.index', 'expense-category.create', 'expense-category.edit', 'expense-category.trash']" name="Expense Categories" />
                </li>
            </ul>
        </li>
        <!-- Expesne End-->

        <!-- Withdraw Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#withdraw"
               aria-expanded="false" aria-controls="withdraw">
                <i class="bi bi-cash-stack"></i>
                <span class="me-auto">Withdraw</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="withdraw" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="withdraw.index" :checkActive="['withdraw.index','withdraw.show', 'withdraw.trash']" name="All Withdraws" />
                </li>
                <li>
                    <x-link route="withdraw.create" :checkActive="['withdraw.create','withdraw.edit']" name="New Withdraw" />
                </li>
            </ul>
        </li>
        <!-- Withdraw End-->

        <!-- Investment Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#investment"
               aria-expanded="false" aria-controls="investment">
                <i class="bi bi-coin"></i>
                <span class="me-auto">Investment</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="investment" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="investor.index" :checkActive="['investor.index','investor.create','investor.edit','investor.show', 'investor.trash']" name="Investors" />
                </li>
                <li>
                    <x-link route="invest.index" :checkActive="['invest.index','invest.create','invest.edit','invest.show', 'invest.trash']" name="All Invests" />
                </li>
            </ul>
        </li>
        <!-- Investment End-->

        <!--  Settings Part -->
        <li class="accordion-item">
            <span class="accordion-item-title text-primary">Settings</span>
        </li>

        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#product"
               aria-expanded="false" aria-controls="product">
                <i class="bi bi-box"></i>
                <span class="me-auto">Products</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="product" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="product.index" :checkActive="['product.index', 'product.trash', 'product.show']" name="All Products" />
                </li>
                <li>
                    <x-link route="product.create" :checkActive="['product.create', 'product.edit']" name="New Product" />
                </li>
                <li>
                    <x-link route="category.index" :checkActive="['category.index', 'category.trash','category.create', 'category.edit']" name="Product Categories" />
                </li>
                <li>
                    <x-link route="brand.index" :checkActive="['brand.index', 'brand.trash', 'brand.create', 'brand.edit']" name="Product Brands" />
                </li>
            </ul>
        </li>

        <li class="accordion-item">
            <a href="{{ route('sale-barcode') }}" class="sigle-nav-link {{ Route::currentRouteName() == 'sale-barcode' ? 'active' : '' }}">
                <i class="bi bi-upc"></i>
                <span>Barcode</span>
            </a>
        </li>

        <!-- Unit Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#unit"
               aria-expanded="false" aria-controls="unit">
                <i class="bi bi-layers"></i>
                <span class="me-auto">Unit</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="unit" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="unit.index" :checkActive="['unit.index', 'unit.trash']" name="All Units" />
                </li>
                <li>
                    <x-link route="unit.create" :checkActive="['unit.create', 'unit.edit']" name="New Unit" />
                </li>

            </ul>
        </li>
        <!-- Unit End-->
        <!-- Branch Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#branch"
               aria-expanded="false" aria-controls="branch">
                <i class="bi bi-building"></i>
                <span class="me-auto">Branch</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="branch" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="branch.index" :checkActive="['branch.index', 'branch.trash']" name="All Branches" />
                </li>
                <li>
                    <x-link route="branch.create" :checkActive="['branch.create', 'branch.edit']" name="New Branch" />
                </li>

            </ul>
        </li>
        <!-- Branch End-->

        <!-- Bank Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#bank"
               aria-expanded="false" aria-controls="bank">
                <i class="bi bi-bank"></i>
                <span class="me-auto">Banking</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="bank" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="bank.index" :checkActive="['bank.index', 'bank.trash','bank.create','bank.edit']" name="Banks" />
                </li>

                <li>
                    <x-link route="bank-account.index" :checkActive="['bank-account.index', 'bank-account.trash','bank-account.create','bank-account.edit']" name="Accounts" />
                </li>
            </ul>
        </li>
        <!-- Bank End-->

        <!-- Cash Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cash"
               aria-expanded="false" aria-controls="cash">
                <i class="bi bi-cash"></i>
                <span class="me-auto">Cash</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="cash" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="cash.index" :checkActive="['cash.index', 'cash.trash']" name="All Cashes" />
                </li>
                <li>
                    <x-link route="cash.create" :checkActive="['cash.create', 'cash.edit']" name="New Cash" />
                </li>

            </ul>
        </li>
        <!-- Cash End-->
        <!--  Reports Part -->
        <li class="accordion-item">
            <span class="accordion-item-title text-primary">Reports</span>
        </li>

        <li class="accordion-item">
            <a href="{{ route('report.cash-book') }}" class="sigle-nav-link {{ Route::currentRouteName() == 'report.cash-book' ? 'active' : '' }}">
                <i class="bi bi-book"></i>
                <span>Cash Book</span>
            </a>
        </li>
        <!-- Ledger Report Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#ledger"
               aria-expanded="false" aria-controls="ledger">
                <i class="bi bi-calendar"></i>
                <span class="me-auto">Ledger</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="ledger" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="ledger.supplier-ledger"  name="Supplier Ledger" />
                </li>
                <li>
                    <x-link route="ledger.customer-ledger"  name="Customer Ledger" />
                </li>
                <li>
                    <x-link route="ledger.product-ledger"  name="Product Ledger" />
                </li>
            </ul>
        </li>
        <!-- Ledger Report->
        <!-- Purchase Report Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#purchase-reports"
               aria-expanded="false" aria-controls="purchase-reports">
                <i class="bi bi-calendar"></i>
                <span class="me-auto">Purchase Reports</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="purchase-reports" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="report.purchase-qty-report"  name="Quantity Report" />
                </li>
                <li>
                    <x-link route="report.purchase-voucher-report"  name="Voucher Report" />
                </li>
            </ul>
        </li>
        <!-- Purchase Report->
        <!-- Sale Report Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#sale-reports"
               aria-expanded="false" aria-controls="sale-reports">
                <i class="bi bi-calendar"></i>
                <span class="me-auto">Sale Reports</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="sale-reports" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="report.sale-qty-report"  name="Quantity Report" />
                </li>
                <li>
                    <x-link route="report.sale-invoice-report"  name="Invoice Report" />
                </li>
            </ul>
        </li>
        <!-- Sale Report->
        <!-- Others Report Start-->
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#others-report"
               aria-expanded="false" aria-controls="others-report">
                <i class="bi bi-calendar"></i>
                <span class="me-auto">Reports</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="others-report" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="report.stock-report"  name="Stock Report" />
                </li>
                <li>
                    <x-link route="report.production-report"  name="Production Report" />
                </li>
                <li>
                    <x-link route="report.income-report"  name="Income Report" />
                </li>
                <li>
                    <x-link route="report.expense-report"  name="Expense Report" />
                </li>
                <li>
                    <x-link route="report.profit-loss-report"  name="Profit Loss Report" />
                </li>
                <li>
                    <x-link route="report.net-profit-report"  name="EBITDA Report" />
                </li>
                <li>
                    <x-link route="report.salary-report" :checkActive="['report.salary-report', 'report.salary-details-report']"  name="Salary Report" />
                </li>
            </ul>
        </li>

        {{-- <li class="accordion-item">
            <span class="accordion-item-title text-primary">SMS</span>
        </li>
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#sms"
               aria-expanded="false" aria-controls="sms">
                <i class="bi bi-chat-right"></i>
                <span class="me-auto">SMS</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="sms" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="sms.group-sms"  name="Group SMS" />
                </li>
                <li>
                    <x-link route="sms.custom-sms"  name="Custom SMS" />
                </li>
            </ul>
        </li>
        <li class="accordion-item">
            <a href="{{ route('sms.report') }}" class="sigle-nav-link {{ Route::currentRouteName() == 'sms.report' ? 'active' : '' }}">
                <i class="bi bi-envelope"></i>
                <span>SMS Report</span>
            </a>
        </li>
        <li class="accordion-item">
            <a href="#" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#template"
               aria-expanded="false" aria-controls="template">
                <i class="bi bi-chat-right-text"></i>
                <span class="me-auto">SMS Template</span>
                <i class="bi bi-chevron-left"></i>
            </a>

            <ul id="template" class="accordion-collapse collapse" data-bs-parent="#dropdown-menu">
                <li>
                    <x-link route="sms-template.index"  name="All Templates" />
                </li>
                <li>
                    <x-link route="sms-template.create"  name="New Template" />
                </li>
            </ul>
        </li> --}}
    </ul>
    <!-- End aside menu ============================================== -->

</aside>
  <!-- End aside =================================== -->

    <!-- Start aside background Shadow =================================== -->
  <div id="aside-layer" onclick="expandFunction()"></div>
  <!-- End aside background Shadow =================================== -->

  <script>
    function expandFunction() {
    let pageAside = document.getElementById("left-aside");
    let asideLayer = document.getElementById("aside-layer");
    let mainBar = document.getElementById("main-bar");

    pageAside.classList.toggle("expand");
    asideLayer.classList.toggle("show");
    mainBar.classList.toggle("main-bar-expand");
}

// aside menu active function ==============================================>
function asideMenuActiveFanction() {
    let activeMenu = document.getElementById("is-menu-active");
    if (activeMenu) {
        if (activeMenu && activeMenu.className == "sigle-nav-link") {
            activeMenu.classList.add("active");
        } else if (activeMenu && activeMenu.className == "nav-link") {
            activeMenu.classList.add("active");
            activeMenu.closest(".collapse").classList.add("show");
            activeMenu
                .closest(".collapse")
                .previousElementSibling.classList.remove("collapsed");
        }
    } else {
        null;
    }
}
asideMenuActiveFanction();

  </script>
