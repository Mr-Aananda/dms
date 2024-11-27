<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='customer-due.create' ? 'active' : '' }}" href="{{ route('customer-due.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Customer due</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='customer-due.index' ? 'active' : '' }}" href="{{ route('customer-due.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Customers Due</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='customer-due.trash' ? 'active' : '' }}" href="{{ route('customer-due.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
