<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='branch.create' ? 'active' : '' }}" href="{{ route('branch.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Branch</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='branch.index' ? 'active' : '' }}" href="{{ route('branch.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Branches</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='branch.trash' ? 'active' : '' }}" href="{{ route('branch.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
