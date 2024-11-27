<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='loan-account.create' ? 'active' : '' }}" href="{{ route('loan-account.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Account</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='loan-account.index' ? 'active' : '' }}" href="{{ route('loan-account.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Accounts</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='loan-account.trash' ? 'active' : '' }}" href="{{ route('loan-account.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
