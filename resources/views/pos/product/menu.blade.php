<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='product.create' ? 'active' : '' }}" href="{{ route('product.create') }}">
                <i class="bi bi-plus-square"></i>
                <span>Add Product</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='product.index' ? 'active' : '' }}" href="{{ route('product.index') }}">
                <i class="bi bi-card-checklist"></i>
                <span>All Products</span>
            </a>
        </li>
       <li class="nav-item">
           <a class="nav-link {{Route::currentRouteName() =='product.trash' ? 'active' : '' }}" href="{{ route('product.trash') }}">
               <i class="bi bi-trash2"></i>
               <span>Recycle bin</span>
           </a>
       </li>

    </ul>
</nav>
