<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='brand.create' ? 'active' : '' }}" href="{{ route('brand.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Brand</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='brand.index' ? 'active' : '' }}" href="{{ route('brand.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Brands</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='brand.trash' ? 'active' : '' }}" href="{{ route('brand.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>
    </ul>
</nav>
