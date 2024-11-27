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
            <form action="{{ route('ledger.customer-ledger') }}" method="get">
                <div class="row py-3 g-3">
                    <input hidden type="text" name="search" value="1">
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
                            <label for="party_id">Customers</label><br>
                            <select name="party_id" id="party_id" style="width: 100%" class="search-select-2">
                                <option value="">Select a customer</option>
                                @foreach ($parties as $party)
                                    <option value="{{ $party->id }}"
                                        {{ request('party_id') == $party->id ? 'selected' : '' }}>{{ $party->name }}({{ $party->phone }})</option>
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
                <h5>Ledger: Customer Ledger</h5>
                <p>
                    <small>
                        {{ request()->search ? 'Details are given below.' : 'Please search for details.' }}
                    </small>
                </p>
            </div>
            <div class="widget-body">
                <!-- End Table -->
                <table class="table table-bordered table-sm">
                    <thead>
                        <tr>
                            <th scope="col">SL</th>
                            <th scope="col">Date</th>
                            <th scope="col">Particular</th>
                            <th scope="col" class="text-end">Debit</th>
                            <th scope="col" class="text-end">Credit</th>
                            <th scope="col" class="text-end">Discount</th>
                            <th scope="col" class="text-end">Balance</th>
                            <th scope="col" class="text-end">Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <!-- Opening Balance -->
                        <tr>
                            <td>1.</td>
                            <td></td>
                            <td class="text-wrap">Opening Balance</td>
                            <td colspan="4" class="text-end">
                                @php
                                    $opening_balance = ($total_debit > $total_credit)
                                        ? $party_balance - ($total_debit - $total_credit)
                                        : $party_balance + ($total_credit - $total_debit);
                                    $balance = $opening_balance;
                                @endphp
                                {{ number_format($opening_balance, 2) }}
                                {{ $opening_balance >= 0 ? 'Receivable' : 'Payable' }}
                            </td>
                            <td class="print-none"></td>
                        </tr>

                        @forelse ($party_ledgers as $ledger)
                            <tr>
                                <td>{{ $loop->iteration + 1 }}</td>
                                <td>{{ $ledger->date->format('d-M-Y') }}</td>

                                <!-- Particular -->
                                <td class="text-wrap">
                                    @if ($ledger->type === 'sale')
                                        <span class="fw-bold">Product Sale</span>
                                        <br>
                                        <span>NOTE: {{$ledger->note != "null" ? $ledger->note : " "  }}</span>
                                    @elseif ($ledger->type === 'sale_return')
                                        <span class="fw-bold">Product Return </span>
                                        <br>
                                        <span>NOTE: {{$ledger->note != "null" ? $ledger->note : " "  }}</span>
                                    @elseif ($ledger->type === 'due_manage')
                                        <span class="fw-bold">Due Management</span>
                                        <br>
                                        <span>NOTE: {{$ledger->description != "null" ? $ledger->description : " "  }}</span>
                                    @else
                                        <p></p>
                                    @endif
                                </td>
                                <!-- Particular -->

                                <!-- Dabit -->
                                <td class="text-end">
                                    @if ($ledger->type === 'sale')
                                        {{ number_format($ledger->grand_total + $ledger->discount, 2) }}
                                    @elseif ($ledger->type === 'sale_return')
                                        {{ number_format($ledger->return_total_paid + $ledger->discount, 2) }}
                                    @elseif ($ledger->type === 'due_manage')
                                        <p>{{ (($ledger->amount <= 0) ? number_format(abs($ledger->amount), 2) : number_format(0, 2)) }}</p>
                                    @else
                                        <p></p>
                                    @endif
                                </td>
                                <!-- Dabit -->

                                <!-- Credit -->
                                <td class="text-end">
                                    @if ($ledger->type === 'sale')
                                        {{ number_format($ledger->total_paid, 2) }}
                                    @elseif ($ledger->type === 'sale_return')
                                        {{ number_format($ledger->return_grand_total, 2) }}
                                    @elseif ($ledger->type === 'due_manage')
                                        <p>{{ (($ledger->amount > 0) ? number_format(abs($ledger->amount), 2) : number_format(0, 2)) }}</p>
                                    @endif
                                </td>
                                    <!-- Credit -->

                                    <!-- Discount/Adjustment -->
                                <td class="text-end">
                                    @if ($ledger->type === 'sale')
                                        {{ number_format($ledger->discount, 2) }}
                                    @elseif ($ledger->type === 'sale_return')
                                        {{ number_format($ledger->discount, 2) }}
                                    @elseif ($ledger->type === 'due_manage')
                                        {{ number_format($ledger->adjustment, 2) }}
                                    @endif
                                </td>
                                <!-- Discount/Adjustment -->

                                <!-- Balance -->
                                <td class="text-end">
                                    @php
                                        if ($ledger->type === 'sale') {
                                            $balance += ($ledger->grand_total - $ledger->total_paid);
                                        } elseif ($ledger->type === 'sale_return') {
                                            $balance += $ledger->return_total_paid - $ledger->return_grand_total;
                                        } elseif ($ledger->type === 'due_manage') {
                                            if ($ledger->amount >= 0) {
                                                $balance -= $ledger->amount + $ledger->adjustment;
                                            } else {
                                                $balance += abs($ledger->amount);
                                            }
                                        }

                                    @endphp
                                    {{ number_format(abs($balance), 2) }}
                                    {{ $balance >= 0 ? 'Receivable' : 'Payable' }}
                                </td>
                                <!-- Balance -->

                                <td class="text-end print-none">
                                    @if ($ledger->type === 'sale')
                                        <a href="{{ route('sale.show', $ledger->id) }}"
                                            class="btn btn-primary sm" title="View Invoice" target="_blank">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                    @elseif ($ledger->type === 'sale_return')
                                        <a href="{{ route('sale-return.show', $ledger->id) }}"
                                            class="btn btn-primary sm" title="View Return Invoice" target="_blank">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                    @else
                                        <!-- Additional actions for other types if needed -->
                                    @endif
                                </td>
                            </tr>

                        @empty
                            <tr>
                                <td colspan="10" class="text-center">No ledger available</td>
                            </tr>
                        @endforelse

                        <!-- Total Row -->
                        <tr>
                            <th colspan="3" class="text-end">Total</th>
                            <td class="text-end">
                                {{ number_format($total_debit + $total_discount, 2) }}
                            </td>
                            <td class="text-end">
                                {{ number_format($total_credit, 2) }}
                            </td>
                            <td class="text-end">
                                {{ number_format($total_discount + $total_adjustment, 2) }}
                            </td>
                        </tr>
                    </tbody>
                </table>
                <h4 class="text-end">Closing Balance:
                    {{ number_format(abs($party_balance), 2) }}
                    {{ $party_balance >= 0 ? '(Receivable)' : '(Payable)' }}
                </h4>
                <!-- End Table -->

            </div>
            <!-- End body widget -->
        </div>
    </div>
    <!-- End main-bar-->
    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#party_id').select2({
                    allowClear: true,
                    placeholder: "Choose one",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush
</x-app-layout>
