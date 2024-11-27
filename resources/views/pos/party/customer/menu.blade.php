<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='customer.create' ? 'active' : '' }}" href="{{ route('customer.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Customers</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='customer.index' ? 'active' : '' }}" href="{{ route('customer.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Customers</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='customer.trash' ? 'active' : '' }}" href="{{ route('customer.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
