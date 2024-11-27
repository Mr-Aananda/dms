@section('title', 'Sale Quantity Report')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.reports.sale.menu')
        <!-- End menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded collapsed" title="Search"
                        data-bs-toggle="collapse" data-bs-target="#tableSearch" aria-controls="tableSearch"
                        aria-expanded="false">
                    <i class="bi bi-search"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Reloar" onclick="location.reload()">
                    <i class="bi bi-bootstrap-reboot"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right buttons -->
        </div>
        <!-- Start Filter Fill -->
        <div class="widget-body collapse {{ request()->search == '1' ? 'show' : '' }}" id="tableSearch">
            <form action="{{ route('report.sale-qty-report') }}" method="get">
                <div class="row py-3 g-3">
                    <input hidden type="text" name="search" value="1">
                    <div class="row py-3 g-3">
                        <div class="col-md-2">
                            <label for="date" class="form-label">Date (From)</label>
                            <input
                            {{-- value="{{ (request()->search) ? request()->form_date : date('Y-m-d') }}" --}}
                            value="{{ (request()->search) ? request()->from_date : '' }}"
                            type="date"
                            id="fromdate"
                            name="from_date"
                            class="form-control"
                            placeholder="YYYY-MM-DD">
                        </div>
                        <div class="col-md-2">
                            <label for="date" class="form-label">Date (To)</label>
                            <input
                            {{-- value="{{ (request()->search) ? request()->to_date : date('Y-m-d') }}" --}}
                            value="{{ (request()->search) ? request()->to_date : '' }}"
                            type="date"
                            id="todate"
                            name="to_date"
                            class="form-control"
                            placeholder="YYYY-MM-DD">
                        </div>
                         <div class="col-md-3">
                            <label for="branch_id">Branches</label><br>
                            <select name="branch_id" id="branch_id" style="width: 100%" class="search-select-2">
                                <option value="">Select branch</option>
                                @foreach ($branches as $branch)
                                    <option value="{{ $branch->id }}"
                                        {{ request('branch_id') == $branch->id ? 'selected' : '' }}>{{ $branch->name }}</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label for="product_id" class="required">Product</label><br>
                            <select name="product_id" id="product_id" style="width: 100%" class="search-select-2" required>
                                <option value="">Select a product</option>
                                @foreach ($products as $product)
                                    <option value="{{ $product->id }}"
                                        {{ request('product_id') == $product->id ? 'selected' : '' }}>{{ $product->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">&nbsp;</label>
                            <button class="btn btn-success d-block w-100" type="submit"><i class="bi bi-search"></i> Search</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- End Filter Fill -->
    </div>
    <!-- End header widget -->

    <div id="print-widget">
            <!-- Start print header -->
            <x-print.header/>
            <!-- End print header -->
            <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>Report: Sale Quantity Report</h5>
                {{ request()->search ? 'Details are given below.' : 'Plese search for details.' }}
            </div>
            <div class="widget-body">

                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th scope="col">SL</th>
                            <th scope="col">Date</th>
                            <th scope="col">Product</th>
                            <th scope="col">Quantity</th>
                            <th scope="col" class="text-end">Total Price</th>
                        </tr>
                    </thead>
                    @forelse($sale_details as $detail)
                        @if (request()->search)
                        <tr>
                            <td>{{ $loop->iteration + 1 }}</td>
                            <td>{{ $detail->date->format('d-M-Y') }}</td>
                            <td>{{ $detail?->product?->name }}</td>
                            <td>
                                {{ \App\Helpers\Converter::convertToUpperUnit($detail?->total_quantity, $detail?->product?->unit_label, $detail?->product?->unit_relation) }}
                            </td>
                            <td class="text-end">{{ number_format($detail?->total_price,2) }}</td>

                        </tr>

                        @endif

                    @empty
                        <tr>
                            <td colspan="10" class="text-center">No data available</td>
                        </tr>
                    @endforelse
                </table>
            <!-- End body widget -->
        </div>
    </div>
        <!-- Start pagination -->
        <x-pagination :items="$sale_details" />
    <!-- End pagination -->
    <!-- End main-bar-->
    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#branch_id').select2({
                    allowClear: true,
                    placeholder: "Choose one",
                    width: 'resolve'
                });
            });
            }, 1000);
            setTimeout(() => {
                $(document).ready(function() {
                $('#product_id').select2({
                    allowClear: true,
                    placeholder: "Choose one",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush
</x-app-layout>
