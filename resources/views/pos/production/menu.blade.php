<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='production.create' ? 'active' : '' }}" href="{{ route('production.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>New Production</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='production.index' ? 'active' : '' }}" href="{{ route('production.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Productions</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='production.trash' ? 'active' : '' }}" href="{{ route('production.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
