<nav aria-label="..." class=" float-end mt-2">
    {{-- @if ($items->lastPage() > 1)
        <ul class="pagination">
            @if ($items->currentPage() > 1)
                <li class="page-item">
                    <a class="page-link" href="{{ $items->previousPageUrl() }}" tabindex="-1">Previous</a>
                </li>
            @endif
            @foreach ($items->getUrlRange(1, $items->lastPage()) as $page => $url)
                <li class="page-item{{ $page === $items->currentPage() ? ' active' : '' }}">
                    <a class="page-link" href="{{ $url }}">{{ $page }}</a>
                </li>
            @endforeach
            @if ($items->hasMorePages())
                <li class="page-item">
                    <a class="page-link" href="{{ $items->nextPageUrl() }}">Next</a>
                </li>
            @endif
        </ul>
    @endif --}}

    @if ($items->lastPage() > 1)
        <ul class="pagination">
            <li class="page-item{{ $items->currentPage() === 1 ? ' disabled' : '' }}">
                <a class="page-link" href="{{ $items->previousPageUrl() }}" tabindex="-1" aria-disabled="{{ $items->currentPage() === 1 ? 'true' : 'false' }}">Previous</a>
            </li>
            @foreach ($items->getUrlRange(1, $items->lastPage()) as $page => $url)
                <li class="page-item{{ $page === $items->currentPage() ? ' active' : '' }}">
                    <a class="page-link" href="{{ $url }}">{{ $page }}</a>
                </li>
            @endforeach
            <li class="page-item{{ !$items->hasMorePages() ? ' disabled' : '' }}">
                <a class="page-link" href="{{ $items->nextPageUrl() }}" aria-disabled="{{ !$items->hasMorePages() ? 'true' : 'false' }}">Next</a>
            </li>
        </ul>
    @endif


</nav>
