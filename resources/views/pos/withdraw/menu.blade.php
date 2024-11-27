<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='withdraw.create' ? 'active' : '' }}" href="{{ route('withdraw.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Withdraw</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='withdraw.index' ? 'active' : '' }}" href="{{ route('withdraw.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Withdraws</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='withdraw.trash' ? 'active' : '' }}" href="{{ route('withdraw.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
