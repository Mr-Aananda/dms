<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='income-sector.create' ? 'active' : '' }}" href="{{ route('income-sector.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Sector</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='income-sector.index' ? 'active' : '' }}" href="{{ route('income-sector.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Sectors</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='income-sector.trash' ? 'active' : '' }}" href="{{ route('income-sector.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
