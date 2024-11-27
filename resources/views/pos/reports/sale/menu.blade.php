<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.sale-qty-report' ? 'active' : 'border' }}" href="{{ route('report.sale-qty-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Quantity Report</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.sale-invoice-report' ? 'active' : 'border' }}" href="{{ route('report.sale-invoice-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Invoice Report</span>
            </a>
        </li>
    </ul>
</nav>
