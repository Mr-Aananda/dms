@section('title', 'Invest Details')
<x-app-layout>
    <div class="row g-3" id="vueRoot">
        <div class="col-lg-3">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center">
                    <button type="button" class="btn icon lg rounded" title="Print Invest Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('invest.edit', $invest->id) }}" type="button" class="btn icon lg rounded"
                       title="Edit This Invest">
                        <i class="bi bi-pencil-square"></i>
                    </a>
                    <button type="button" class="btn icon lg rounded" title="Reloar"
                            onclick="location.reload()">
                        <i class="bi bi-bootstrap-reboot"></i>
                    </button>
                    <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                        <i class="bi bi-arrow-left"></i>
                    </button>
                </div>
            </div>
            <div class="mt-3">
                <a href="#" class="btn btn-primary btn w-100 mb-2" type="button" data-bs-toggle="modal" data-bs-target="#profitWithdrawCreateModal">
                    <i class="bi bi-dash-circle"></i>
                    <span class="ms-2">Profit Withdraw</span>
                </a>
                <a href="#" class="btn btn-success btn w-100 mb-2" type="button" data-bs-toggle="modal" data-bs-target="#profitAddCreateModal">
                    <i class="bi bi-plus-circle"></i>
                    <span class="ms-2">Profit Addition</span>
                </a>
                <a href="#" class="btn btn-warning btn w-100 mb-2" type="button" data-bs-toggle="modal" data-bs-target="#investWithdrawCreateModal">
                    <i class="bi bi-dash-circle-dotted"></i>
                    <span class="ms-2">Invest Withdraw</span>
                </a>
            </div>
        </div>
        <div class="col-lg-9">
            <div class="widget" id="print-widget">

                <!-- Start print header =========================== -->
                <x-print.header />
                <!-- End print header =========================== -->

                <!-- Start header ================= -->
                <div class="widget-head border-bottom pb-1">
                    <h4>{{ $invest?->investor?->name }}</h4>
                    <p class="text-muted">
                        <strong>Date:</strong>
                        <span class="me-3">{{ $invest?->date->format('d F, Y') }}</span>
                         <strong>Created by :</strong>
                        <a href="{{route('user.show', $invest?->user?->id) }}">{{ $invest?->user?->name }}</a>
                    </p>
                </div>
                <!-- End header ==================== -->


                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <h5 class="mt-3 mb-2">Invest Details</h5>
                    <table class="table table-bordered">
                        @php
                             $profit_amount = $invest->profit_type == 'percentage' ? (abs($invest->amount) * $invest->profit) / 100 : $invest->profit;
                        @endphp
                        <tbody>
                            <tr>
                                <td>Invest Date</td>
                                <td>{{ $invest?->date->format('d F, Y') }}</td>
                            </tr>
                            <tr>
                                <td>Investor</td>
                                <td>{{ $invest?->investor?->name }} ({{$invest?->investor?->phone }})</td>
                            </tr>
                            <tr>
                                <td>Branch</td>
                                <td>{{ $invest?->branch?->name }}</td>
                            </tr>
                            <tr>
                                <td>Amount</td>
                                <td>{{ number_format($invest?->amount, 2)}}</td>
                            </tr>
                            <tr>
                                <td>Profit Addition Date</td>
                                <td>{{ $invest->profit_addition_date }}</td>
                            </tr>
                            <tr>
                                <td>Profit Per Month</td>
                                <td>{{ number_format($profit_amount, 2)}}</td>
                            </tr>
                        </tbody>
                    </table>

                    <div>
                        <p>Note : {!! $invest?->note !!}</p>
                    </div>
                    <div class="text-center">
                        <form action="{{ route('invest.toggleAutomatic', $invest->id) }}" method="POST">
                            @csrf
                            @method('PATCH')
                            <button type="submit" class="btn {{ $invest->isAutomatic ? 'btn-primary':'btn-danger'   }}">
                                <i class="bi bi-arrow-right"></i>
                                {{ $invest->isAutomatic ? 'Automatic Profit Addition (Enable)' : 'Automatic Profit Addition (Disable)' }}
                            </button>
                        </form>
                    </div>
                </div>
                <!-- End body ===================== -->
            </div>
            <div class="widget">
                <h2 class="text-center mb-2">
                    Withdraw Details
                    {{-- <span class="float-end">
                        <a class="btn icon lg rounded" href="{{ route('invest-withdraw.trash') }}" title="Recycle Bin">
                            <i class="bi bi-trash"></i>
                        </a>
                    </span> --}}
                </h2>
                 <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Date</th>
                        <th scope="col" class="text-end">Amount</th>
                        <th scope="col">Type</th>
                        <th scope="col">Investor</th>
                        <th scope="col" >Created By</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                        @forelse($invest->investWithdraws as $index => $withdraw)
                        <tr>
                            <th scope="row">{{ $index + 1 }}.</th>
                            <td>{{ $withdraw->date->format('d F, Y') }}</td>
                            <td class="text-end">{{ number_format(abs($withdraw->amount),2) }}</td>
                            <td>{{ $withdraw->type }}</td>
                            <td>{{ $invest?->investor_name }}</td>
                            <td>{{ $withdraw?->user?->name }}</td>
                            <td class="text-end print-none">

                                {{-- @can('invest-withdraw.edit')
                                    <a href="{{ route('invest-withdraw.edit', $withdraw->id) }}"
                                        class="btn sm btn-warning" title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                @endcan --}}

                                @can('invest-withdraw.destroy')
                                    <form action="{{ route('invest-withdraw.destroy', $withdraw->id) }}" method="POST"
                                            class="d-inline"
                                            onsubmit="return confirm('Are you sure want to delete?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" title="Delete" class="btn sm btn-danger">
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
        @include('pos.modal-component.profit-withdraw-component', ['profit_amount' => $profit_amount, 'invest' => $invest])
        @include('pos.modal-component.profit-add-component', ['profit_amount' => $profit_amount, 'invest' => $invest])
        @include('pos.modal-component.invest-withdraw-component', ['invest' => $invest])

    </div>

</x-app-layout>
