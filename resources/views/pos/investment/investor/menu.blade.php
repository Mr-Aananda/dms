<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='investor.create' ? 'active' : '' }}" href="{{ route('investor.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Investor</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='investor.index' ? 'active' : '' }}" href="{{ route('investor.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Investors</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='investor.trash' ? 'active' : '' }}" href="{{ route('investor.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
