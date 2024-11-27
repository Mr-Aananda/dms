<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.income-report' ? 'active' : 'border' }}" href="{{ route('report.income-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Income Report</span>
            </a>
        </li>
    </ul>
</nav>
