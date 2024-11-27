<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='invest.create' ? 'active' : '' }}" href="{{ route('invest.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Invest</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='invest.index' ? 'active' : '' }}" href="{{ route('invest.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Invests</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='invest.trash' ? 'active' : '' }}" href="{{ route('invest.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
