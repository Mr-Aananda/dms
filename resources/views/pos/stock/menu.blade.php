<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='stock.index' ? 'active' : '' }}" href="{{ route('stock.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All  Stock</span>
            </a>
        </li>

    </ul>
</nav>
