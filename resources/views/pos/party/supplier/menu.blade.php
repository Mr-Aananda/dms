<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='supplier.create' ? 'active' : '' }}" href="{{ route('supplier.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Supplier</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='supplier.index' ? 'active' : '' }}" href="{{ route('supplier.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Suppliers</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='supplier.trash' ? 'active' : '' }}" href="{{ route('supplier.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
