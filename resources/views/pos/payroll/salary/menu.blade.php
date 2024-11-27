<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='salary.create' ? 'active' : '' }}" href="{{ route('salary.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>New Salary</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='salary.index' ? 'active' : '' }}" href="{{ route('salary.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Salaries</span>
            </a>
        </li>
       {{-- <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='salary.trash' ? 'active' : '' }}" href="{{ route('salary.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li> --}}

    </ul>
</nav>
