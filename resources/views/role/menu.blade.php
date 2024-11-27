<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='role.create' ? 'active' : '' }}" href="{{ route('role.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Role</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='role.index' ? 'active' : '' }}" href="{{ route('role.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Manage Roles</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="bi bi-recycle"></i>
                <span>Recycle bin</span>
            </a>
        </li>
    </ul>
</nav>