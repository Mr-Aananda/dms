@section('title', 'Product Transfers')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start  menu -->
            @include('pos.product-transfer.menu')
            <!-- End  menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded collapsed" title="Search" data-bs-toggle="collapse"
                    data-bs-target="#tableSearch" aria-controls="tableSearch" aria-expanded="false">
                    <i class="bi bi-search"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Print" onclick="printable('print-widget')">
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
         <!-- Start Search body -->
        <div class="widget-body {{ request('search') ? '' : 'collapse' }}" id="tableSearch">
            <form action="{{ route('production.index') }}" method="GET">
                <input type="hidden" name="search" value="1">
                <div class="row py-3 g-3">
                    <div class="col-md-3">
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
                    <div class="col-md-3">
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
                    <div class="col-md-4">
                        <label for="transfer_no" class="form-label">Transfer No</label>
                        <input
                            type="text"
                            class="form-control"
                            placeholder="Enter transfer number"
                            id="transfer_no"
                            value="{{ request('transfer_no') }}"
                            name="transfer_no">
                    </div>

                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"><i
                                class="bi bi-search"></i>
                            Search
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <!-- End Search body -->
    </div>
    <!-- End header widget -->

    <div id="print-widget">

        <!-- Start print header  -->
        <x-print.header />
        <!-- End print header -->
        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Product Transfers</h5>
                <p><small>{{ count($productTransfers) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th style="width: 70px;">
                                SL
                            </th>
                            <th>Date</th>
                            <th>Transfer No</th>
                            <th>From Branch</th>
                            <th>To Branch</th>
                            <th>Transfer By</th>
                            <th scope="col" class="text-end print-none">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($productTransfers as $index => $transfer)
                            <tr>
                                <th>{{ $productTransfers?->firstItem() + $index }}</th>
                                <td>{{ $transfer?->date->format('d-M-Y') }}</td>
                                <td>{{ $transfer?->transfer_no }}</td>
                                <td>{{ $transfer?->fromBranch?->name }}</td>
                                <td>{{ $transfer?->toBranch?->name }}</td>
                                <td>{{ $transfer?->user?->name }}</td>

                                <td class="text-end print-none">
                                    <a href="{{ route('product-transfer.show', $transfer->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                    <a href="{{ route('product-transfer.edit', $transfer->id) }}" class="btn btn-warning sm">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <button
                                        class="btn btn-danger sm"
                                        href="#"
                                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $transfer->id }}').submit() } return false ">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>

                                    <form action="{{ route('product-transfer.destroy', $transfer->id) }}"
                                          method="post" class="d-none"
                                          id="sm-delete-{{ $transfer->id }}">
                                        @csrf
                                        @method('DELETE')
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="10" class="text-center">No Data found</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>
    <!-- Start pagination -->
        <x-pagination :items="$productTransfers" />
    <!-- End pagination -->
    <!-- End main-bar-->

    @push('script')
    @endpush
</x-app-layout>
