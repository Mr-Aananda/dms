<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='loan.create' ? 'active' : '' }}" href="{{ route('loan.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Loan</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='loan.index' ? 'active' : '' }}" href="{{ route('loan.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Loans</span>
            </a>
        </li>

       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='loan.trash' ? 'active' : '' }}" href="{{ route('loan.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
