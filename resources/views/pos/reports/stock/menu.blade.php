<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.stock-report' ? 'active' : 'border' }}" href="{{ route('report.stock-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Stock Report</span>
            </a>
        </li>
    </ul>
</nav>
