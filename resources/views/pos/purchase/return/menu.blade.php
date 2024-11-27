<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='purchase-return.create' ? 'active' : '' }}" href="{{ route('purchase-return.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>New Return</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='purchase-return.index' ? 'active' : '' }}" href="{{ route('purchase-return.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Returns</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='purchase-return.trash' ? 'active' : '' }}" href="{{ route('purchase-return.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
