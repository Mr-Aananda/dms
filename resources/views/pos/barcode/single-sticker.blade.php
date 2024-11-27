@section('title', 'Sticker')

<x-app-layout>
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            @include('pos.barcode.menu')

            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Search" data-bs-toggle="collapse"
                    href="#tableSearch" aria-controls="tableSearch">
                    <i class="bi bi-search"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Print"
                    onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Reload" onclick="location.reload()">
                    <i class="bi bi-bootstrap-reboot"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
        </div>
    </div>

    <div class="widget mb-3 collapse show" id="tableSearch">
        <h3 class="px-3">Generate Stickers</h3>
        <div class="widget-body">
            <form>
                <input type="hidden" name="search" value="1">
                <div class="row py-3 gx-3">
                    <div class="col-md-3">
                        <label for="product" class="form-label">Select Product</label>
                        <select name="product_id" required id="product_id" style="width: 100%" class="search-select-2">
                            <option value="">Select product</option>
                            @foreach ($products as $_product)
                                <option value="{{ $_product->id }}"
                                    {{ request('product_id') == $_product->id ? 'selected' : '' }}>{{ $_product->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="name" class="form-label">Write Importer name</label>
                        <input type="text" class="form-control" placeholder="Enter importer name" name="importer_name" value="{{ request('importer_name') }}" id="name">
                    </div>
                    <div class="col-md-3">
                        <label for="quantity" class="form-label">Quantity</label>
                        <input type="number" class="form-control" placeholder="0" name="quantity" value="{{ request('quantity') }}" id="quantity">
                    </div>
                    <div class="col-md-1">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100"> <i class="bi bi-search"></i> Generate </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div id="print-widget">
        <div class="widget">
            <div class="widget-head mb-3 print-none">
                <h5>Stickers</h5>
                <p><small>About {{ count($stickers) }} results found.</small></p>
            </div>

            <div class="widget-body d-flex flex-wrap">
                @if(isset($stickers) && count($stickers) > 0)
                    @foreach($stickers as $sticker)
                        <div class="border border-dark py-1 m-1 text-center">
                            <h5>Imported By</h5>
                            <p>{{ $sticker['importer_name'] }}</p>
                            <div class="border border-dark"></div>
                            <small class="text-dark">{{ $sticker['product_name'] }}</small>
                            <h4 class="text-dark">MRP: {{ number_format($sticker['mrp'], 2) }}</h4>
                        </div>
                    @endforeach
                @else
                    <p class="text-center">No stickers to display.</p>
                @endif
            </div>
        </div>
    </div>

    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                    $('#product_id').select2({
                        allowClear: true,
                        placeholder: "Select a product",
                        width: 'resolve'
                    });
                });
            }, 500);
        </script>
    @endpush
</x-app-layout>
