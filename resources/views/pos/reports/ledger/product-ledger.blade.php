@section('title', 'Ledger Report')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.reports.ledger.menu')
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
            <form action="{{ route('ledger.product-ledger') }}" method="get">
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
                <h5>Ledger: Product Ledger</h5>
                {{ request()->search ? 'Details are given below.' : 'Please search for details.' }}
            </div>
            <div class="widget-body">

                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <td colspan="10" class="fs-5">Search Product Name:
                                <span class="fw-bold">
                                    @if ($searchedProduct = $products->where('id', request('product_id'))->first())
                                        {{ $searchedProduct->name }}
                                    @else
                                        Not Found
                                    @endif
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="col">SL</th>
                            <th scope="col">Date</th>
                            <th scope="col">Status</th>
                            <th scope="col" class="text-end">Invoice/Voucher/Return</th>
                            <th scope="col" class="text-end">Quantity</th>
                            <th scope="col" class="text-end">Balance Quantity</th>
                        </tr>
                    </thead>
                    @forelse($ledgerDetails as $index => $detail)
                        <tr>
                            <td>{{ $index + 1 }}</td>
                            {{-- <td>{{ $detail['date']->format('d-M-Y') }}</td> --}}
                            <td>{{ date('d-M-Y', strtotime($detail['date'])) }}</td>
                            <td>{{ $detail['status'] }}</td>
                            <td class="text-end">{{ $detail['invoice_voucher'] }}</td>
                            <td class="text-end">{{ $detail['quantity'] }}</td>
                            <td class="text-end">{{ $detail['remaining_quantity'] }}</td>
                        </tr>

                    @empty
                        <tr>
                            <td colspan="10" class="text-center">No ledger available</td>
                        </tr>
                    @endforelse
                </table>

               @if (request()->search)
                <div class="row">
                    <div class="col-md-7"></div>
                    <div class="col-md-5">
                        <table class="table table-bordered table-sm fs-6">
                            <thead>
                                <tr>
                                    <th scope="col">Type</th>
                                    <th scope="col" class="text-end">Total Quantity</th>
                                </tr>
                            </thead>
                            <tbody class="fw-bold">
                                <tr>
                                    <td>Total Purchase:</td>
                                    <td class="text-end">{{ $totalPurchase }}</td>
                                </tr>

                                <tr>
                                    <td>Total Sale:</td>
                                    <td class="text-end">{{ $totalSale }}</td>
                                </tr>

                                <tr>
                                    <td>Total Purchase Return:</td>
                                    <td class="text-end">{{ $totalPurchaseReturn }}</td>
                                </tr>

                                <tr>
                                    <td>Total Sale Return:</td>
                                    <td class="text-end">{{ $totalSaleReturn }}</td>
                                </tr>

                                <tr>
                                    <td>Total Damage:</td>
                                    <td class="text-end">{{ $totalDamage }}</td>
                                </tr>
                                <tr>
                                    <td>Total Production:</td>
                                    <td class="text-end">{{ $totalProduction }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
               @endif

            <!-- End body widget -->
        </div>
    </div>
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
