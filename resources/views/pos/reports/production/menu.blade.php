<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.production-report' ? 'active' : 'border' }}" href="{{ route('report.production-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Production Report</span>
            </a>
        </li>
    </ul>
</nav>
