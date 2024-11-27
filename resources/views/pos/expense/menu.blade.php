<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='expense.create' ? 'active' : '' }}" href="{{ route('expense.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Expense</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='expense.index' ? 'active' : '' }}" href="{{ route('expense.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Expenses</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='expense.trash' ? 'active' : '' }}" href="{{ route('expense.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
