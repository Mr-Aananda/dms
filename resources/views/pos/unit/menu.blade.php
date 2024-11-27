<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='unit.create' ? 'active' : '' }}" href="{{ route('unit.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Create new</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='unit.index' ? 'active' : '' }}" href="{{ route('unit.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Units</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='unit.trash' ? 'active' : '' }}" href="{{ route('unit.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
