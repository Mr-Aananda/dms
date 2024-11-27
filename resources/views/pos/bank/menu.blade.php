<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='bank.create' ? 'active' : '' }}" href="{{ route('bank.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Bank</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='bank.index' ? 'active' : '' }}" href="{{ route('bank.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Banks</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='bank.trash' ? 'active' : '' }}" href="{{ route('bank.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
