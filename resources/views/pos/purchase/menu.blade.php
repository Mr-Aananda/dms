<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='purchase.create' ? 'active' : '' }}" href="{{ route('purchase.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>New Purchase</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='purchase.index' ? 'active' : '' }}" href="{{ route('purchase.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Purchases</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='purchase.trash' ? 'active' : '' }}" href="{{ route('purchase.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
