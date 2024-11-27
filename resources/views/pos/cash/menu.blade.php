<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='cash.create' ? 'active' : '' }}" href="{{ route('cash.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Cash</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='cash.index' ? 'active' : '' }}" href="{{ route('cash.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Cashes</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='cash.trash' ? 'active' : '' }}" href="{{ route('cash.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
