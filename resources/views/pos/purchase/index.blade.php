@section('title', 'Purchases')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start  menu -->
            @include('pos.purchase.menu')
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
            <form action="{{ route('purchase.index') }}" method="GET">
                <input type="hidden" name="search" value="1">
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
                        <label for="party_id">Supplier</label><br>
                        <select name="party_id" id="party_id" style="width: 100%" class="search-select-2">
                            <option value="">Select party</option>
                            @foreach ($parties as $party)
                                <option value="{{ $party->id }}"
                                    {{ request('party_id') == $party->id ? 'selected' : '' }}>{{ $party->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="voucher_no" class="form-label">Voucher No</label>
                        <input
                            type="text"
                            class="form-control"
                            placeholder="Enter voucher number"
                            id="voucher_no"
                            value="{{ request('voucher_no') }}"
                            name="voucher_no">
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
                <h5>All Purchases</h5>
                <p><small>{{ count($purchases) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th style="width: 70px;">
                                SL
                            </th>
                            <th>Purchase Date</th>
                            <th>Voucher No</th>
                            <th>Supplier</th>
                            <th class="text-end">Total</th>
                            <th class="text-end">Paid</th>
                            <th class="text-end">Due/Advanced</th>
                            <th scope="col" class="text-end print-none">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                           @php
                                $totalGrandTotal = 0;
                                $totalPaid = 0;
                                $totalDueAdvanced = 0;
                            @endphp
                        @forelse($purchases as $index => $purchase)
                                @php
                                    $totalGrandTotal += $purchase->grand_total;
                                    $totalPaid += $purchase->total_paid;
                                    $totalDueAdvanced += ($purchase->grand_total - $purchase->total_paid);
                                    $totalDueAdvanced += $purchase->total_due;
                                @endphp
                            <tr>
                                <th>{{ $purchases?->firstItem() + $index }}</th>
                                <td>{{ $purchase?->date->format('d-M-Y') }}</td>
                                <td>{{ $purchase?->voucher_no }}</td>
                                <td>{{ $purchase?->party_name }}</td>

                                <td class="text-end">{{ number_format($purchase?->grand_total, 2) }}</td>
                                <td class="text-end">{{ number_format($purchase?->total_paid, 2) }}</td>
                                {{-- <td class="text-end">{{ number_format(($purchase?->grand_total - $purchase?->total_paid), 2) }}</td> --}}
                                <td class="text-end">{{ number_format(($purchase?->total_due), 2) }}</td>
                                <td class="text-end print-none">
                                    <a href="{{ route('purchase.show', $purchase->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                    <a href="{{ route('purchase.edit', $purchase->id) }}" class="btn btn-warning sm">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <button
                                        class="btn btn-danger sm"
                                        href="#"
                                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $purchase->id }}').submit() } return false ">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>

                                    <form action="{{ route('purchase.destroy', $purchase->id) }}"
                                          method="post" class="d-none"
                                          id="sm-delete-{{ $purchase->id }}">
                                        @csrf
                                        @method('DELETE')
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="10" class="text-center">No data found</td>
                            </tr>
                        @endforelse
                            <tr class="fw-bold">
                                <td colspan="4" class="text-end">Total</td>
                                <td class="text-end">{{ number_format($totalGrandTotal, 2) }}</td>
                                <td class="text-end">{{ number_format($totalPaid, 2) }}</td>
                                <td class="text-end">{{ number_format($totalDueAdvanced, 2) }}</td>
                                <td></td>
                            </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>
    <!-- Start pagination -->
        <x-pagination :items="$purchases" />
    <!-- End pagination -->
    <!-- End main-bar-->

    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#party_id').select2({
                    allowClear: true,
                    placeholder: "Select One",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush
</x-app-layout>