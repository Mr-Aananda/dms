<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.salary-report' ? 'active' : 'border' }}" href="{{ route('report.salary-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Salary Report</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.salary-monthly-report' ? 'active' : 'border' }}" href="{{ route('report.salary-monthly-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Monthly Report</span>
            </a>
        </li>
    </ul>
</nav>
