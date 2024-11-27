<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='sale.create' ? 'active' : '' }}" href="{{ route('sale.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>New Sale</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='sale.index' ? 'active' : '' }}" href="{{ route('sale.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Sales</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='sale.trash' ? 'active' : '' }}" href="{{ route('sale.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
