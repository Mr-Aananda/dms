<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.net-profit-report' ? 'active' : 'border' }}" href="{{ route('report.net-profit-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Net Profit</span>
            </a>
        </li>
    </ul>
</nav>
