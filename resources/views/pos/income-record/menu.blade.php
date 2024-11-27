<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='income-record.create' ? 'active' : '' }}" href="{{ route('income-record.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Income Record</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='income-record.index' ? 'active' : '' }}" href="{{ route('income-record.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Records</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='income-record.trash' ? 'active' : '' }}" href="{{ route('income-record.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
