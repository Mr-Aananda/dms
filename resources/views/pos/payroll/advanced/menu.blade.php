<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='advanced-salary.create' ? 'active' : '' }}" href="{{ route('advanced-salary.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Advanced</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='advanced-salary.index' ? 'active' : '' }}" href="{{ route('advanced-salary.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Advanced</span>
            </a>
        </li>
       {{-- <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='advanced-salary.trash' ? 'active' : '' }}" href="{{ route('advanced-salary.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li> --}}

    </ul>
</nav>
