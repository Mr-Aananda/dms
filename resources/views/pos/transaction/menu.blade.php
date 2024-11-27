<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='transaction.create' ? 'active' : '' }}" href="{{ route('transaction.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>New Transaction</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='transaction.index' ? 'active' : '' }}" href="{{ route('transaction.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Transactions</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='transaction.trash' ? 'active' : '' }}" href="{{ route('transaction.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
