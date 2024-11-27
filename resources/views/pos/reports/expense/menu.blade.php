<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.expense-report' ? 'active' : 'border' }}" href="{{ route('report.expense-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Monthly Report</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.expense-yearly-report' ? 'active' : 'border' }}" href="{{ route('report.expense-yearly-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Yearly Report</span>
            </a>
        </li>
    </ul>
</nav>
