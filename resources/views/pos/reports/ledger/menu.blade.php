<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='ledger.customer-ledger' ? 'active' : 'border' }}" href="{{ route('ledger.customer-ledger') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Customer Ledger</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='ledger.supplier-ledger' ? 'active' : 'border' }}" href="{{ route('ledger.supplier-ledger') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Supplier Ledger</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='ledger.product-ledger' ? 'active' : 'border' }}" href="{{ route('ledger.product-ledger') }}">
                <i class="bi bi-card-checklist"></i>
                <span>Product Ledger</span>
            </a>
        </li>
    </ul>
</nav>
