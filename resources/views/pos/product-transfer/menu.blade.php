<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='product-transfer.create' ? 'active' : '' }}" href="{{ route('product-transfer.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>New Transfer</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='product-transfer.index' ? 'active' : '' }}" href="{{ route('product-transfer.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Transfers</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='product-transfer.trash' ? 'active' : '' }}" href="{{ route('product-transfer.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
