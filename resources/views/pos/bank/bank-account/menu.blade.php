<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='bank-account.create' ? 'active' : '' }}" href="{{ route('bank-account.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Account</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='bank-account.index' ? 'active' : '' }}" href="{{ route('bank-account.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Accounts</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='bank-account.trash' ? 'active' : '' }}" href="{{ route('bank-account.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
