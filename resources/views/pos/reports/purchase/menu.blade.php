<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.purchase-qty-report' ? 'active' : 'border' }}" href="{{ route('report.purchase-qty-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Quantity Report</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.purchase-voucher-report' ? 'active' : 'border' }}" href="{{ route('report.purchase-voucher-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Voucher Report</span>
            </a>
        </li>
    </ul>
</nav>
