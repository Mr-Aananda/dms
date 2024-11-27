@section('title', 'All Loans')

<x-app-layout>
    <!-- Start main-bar-->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
            @include('pos.payroll.loan.menu')
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
            <form action="{{ route('loan.index') }}" method="get">
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
                    <div class="col-md-3">
                        <label for="loan_account_id">Loan Accounts</label><br>
                        <select name="loan_account_id" id="loan_account_id" style="width: 100%" class="search-select-2">
                            <option value="">Select account</option>
                            @foreach ($loanAccounts as $account)
                                <option value="{{ $account->id }}"
                                    {{ request('loan_account_id') == $account->id ? 'selected' : '' }}>{{ $account->name }}</option>
                            @endforeach
                        </select>
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
                <h5>All Loans</h5>
                <p><small>{{ count($loans) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Loan Account</th>
                        <th scope="col">Date</th>
                        <th scope="col" class="text-end">Amount</th>
                        {{-- <th scope="col" class="text-end">Profit Amount</th> --}}
                        {{-- <th scope="col" class="text-end">With Profit</th> --}}
                        <th scope="col" class="text-end">Paid</th>
                        <th scope="col" class="text-end">Adjustment</th>
                        <th scope="col" class="text-end">Due</th>
                        <th scope="col">Expire Date</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    @forelse($loans as $loan)
                        @php
                            $profit_amount = $loan->profit_type == 'percentage' ? (abs($loan->amount) * $loan->profit) / 100 : $loan->profit;
                            $total_amount_with_profit = (abs($loan->amount) + $profit_amount)
                        @endphp
                        <tr>
                            <th scope="row">{{ $loans->firstItem() + $loop->index }}</th>
                            <td>{{ $loan->loan_account_name }}</td>
                            <td>{{ $loan->date->format('d F, Y') }}</td>
                            <td class="text-end">
                                {{ number_format(abs($loan->amount), 2)}}
                                <span class="{{$loan->amount <= 0 ? 'text-success' : 'text-danger'  }}">({{ $loan->amount <= 0 ? 'Rec':'Pay' }})</span>
                            </td>
                            {{-- <td class="text-end">{{ number_format($profit_amount, 2)}}</td>
                            <td class="text-end">{{ number_format($total_amount_with_profit, 2)}}</td> --}}
                            <td class="text-end">{{ number_format(abs($loan->paid), 2)}}</td>
                            <td class="text-end">{{ number_format(abs($loan->adjustment), 2)}}</td>
                            <td class="text-end">
                                {{ number_format(abs($loan->due), 2)}}
                                <span class="{{$loan->due <= 0 ? 'text-success' : 'text-danger'  }}">({{ $loan->due <= 0 ? 'Rec':'Pay' }})</span>
                            </td>
                            <td class="{{ $loan->expired_date->gt(now()) ? '' : 'text-danger' }}">
                                {{ $loan->expired_date->format('d F, Y') }}
                            </td>
                            <td class="text-end print-none">

                                @can('loan.show')
                                    <a href="{{ route('loan.show', $loan->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                @endcan

                                @can('loan.edit')
                                    <a href="{{ route('loan.edit', $loan->id) }}"
                                        class="btn sm btn-warning" title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                @endcan

                                @can('loan.destroy')
                                    <form action="{{ route('loan.destroy', $loan->id) }}" method="POST"
                                            class="d-inline"
                                            onsubmit="return confirm('Are you sure want to delete?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" title="Delete"
                                                {{ $loan->loan_installments_count > 0 ? 'disabled' : '' }} class="btn sm btn-danger">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                @endcan
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

    <!-- End main-bar  -->
      <!-- Start pagination -->
        <x-pagination :items="$loans" />
    <!-- End pagination -->
        @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#loan_account_id').select2({
                    allowClear: true,
                    placeholder: "Select One",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush

</x-app-layout>
