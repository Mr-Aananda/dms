<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='expense-category.create' ? 'active' : '' }}" href="{{ route('expense-category.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Expense Category</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='expense-category.index' ? 'active' : '' }}" href="{{ route('expense-category.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Expense Categories</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='expense-category.trash' ? 'active' : '' }}" href="{{ route('expense-category.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
