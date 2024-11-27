<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='report.cash-book' ? 'active' : 'border' }}" href="{{ route('report.cash-book') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Cashbook</span>
            </a>
        </li>
    </ul>
</nav>
