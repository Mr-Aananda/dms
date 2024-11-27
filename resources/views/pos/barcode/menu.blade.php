<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='sale-barcode' ? 'active' : '' }}" href="{{ route('sale-barcode') }}">
                <i class="bi bi-plus-square"></i>
                <span>Sale Barcode</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='invoice-sticker' ? 'active' : '' }}" href="{{ route('invoice-sticker') }}">
                <i class="bi bi-plus-square"></i>
                <span>Invoice Sticker</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='single-sticker' ? 'active' : '' }}" href="{{ route('single-sticker') }}">
                <i class="bi bi-plus-square"></i>
                <span>Single Sticker</span>
            </a>
        </li>

    </ul>
</nav>
