<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.profit-loss-report' ? 'active' : 'border' }}" href="{{ route('report.profit-loss-report') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Profit Loss</span>
            </a>
        </li>
    </ul>
</nav>
