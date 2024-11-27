<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='supplier-due.create' ? 'active' : '' }}" href="{{ route('supplier-due.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Supplier due</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='supplier-due.index' ? 'active' : '' }}" href="{{ route('supplier-due.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Suppliers Due</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='supplier-due.trash' ? 'active' : '' }}" href="{{ route('supplier-due.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
