<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='damage.create' ? 'active' : '' }}" href="{{ route('damage.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>New Damage</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='damage.index' ? 'active' : '' }}" href="{{ route('damage.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Damages</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='damage.trash' ? 'active' : '' }}" href="{{ route('damage.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
