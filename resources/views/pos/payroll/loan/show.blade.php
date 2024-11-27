@section('title', 'Loan Details')
<x-app-layout>
    <div class="row g-3">
        <div class="col-lg-3">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center">
                    <button type="button" class="btn icon lg rounded" title="Print Customer Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('loan.edit', $loan->id) }}" type="button" class="btn icon lg rounded"
                       title="Edit This Supplier">
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
                <a href="{{ route('loan-installment.create', ['loan_id' => $loan->id]) }}"
                    class="btn btn-primary btn-lg w-100 {{$loan?->due == 0 ? 'disabled' : ''  }}"
                    >
                    <i class="bi bi-plus-circle"></i>
                    <span>Add Installment</span>
                    {{-- <i class="bi bi-plus-circle"></i> --}}
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
                    <h4>{{ $loan?->loanAccount?->name }}</h4>
                    <p class="text-muted">
                        <strong>Date:</strong>
                        <span class="me-3">{{ $loan?->date->format('d F, Y') }}</span>
                         <strong>Created by :</strong>
                        <a href="{{route('user.show', $loan?->user?->id) }}">{{ $loan?->user?->name }}</a>
                    </p>
                </div>
                <!-- End header ==================== -->


                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <h5 class="mt-3 mb-2">Loan Details</h5>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td>Loan Type</td>
                                <td>{{ $loan?->amount > 0 ? 'Take':'Give' }}</td>
                            </tr>
                            <tr>
                                <td>Amount</td>
                                <td>{{ number_format(abs($loan?->amount), 2)}}</td>
                            </tr>
                            <tr>
                                <td>Expired Date</td>
                                <td class="{{ $loan->expired_date->gt(now()) ? '' : 'text-danger' }}">
                                    {{ $loan?->expired_date->format('d F, Y') }}
                                </td>
                            </tr>
                            <tr>
                                <td>Paid</td>
                                <td>{{ number_format(abs($loan?->paid), 2)}}</td>
                            </tr>
                            <tr>
                                <td>Adjustment</td>
                                <td>{{ number_format(abs($loan?->adjustment), 2)}}</td>
                            </tr>
                            <tr>
                                <td>Due</td>
                                <td>{{ number_format(abs($loan?->due), 2)}}</td>
                            </tr>

                        </tbody>
                    </table>

                    <div>
                        <p>Note : {!! $loan?->note !!}</p>
                    </div>
                </div>
                <!-- End body ===================== -->
            </div>
            <div class="widget">
                <h2 class="text-center mb-2">
                    Installments
                    <span>
                        <a class="btn btn-warning sm" href="{{ route('loan-installment.trash') }}" title="Recycle Bin">
                            <i class="bi bi-trash"></i>
                        </a>
                    </span>

                </h2>
                 <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Date</th>
                        <th scope="col" class="text-end">Amount</th>
                        <th scope="col" class="text-end">Adjustment</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                        @forelse($loan->loanInstallments as $index => $installment)
                        <tr>
                            <th scope="row">{{ $index + 1 }}.</th>
                            <td>{{ $installment->date->format('d F, Y') }}</td>
                            <td class="text-end">{{ number_format(abs($installment->amount),2) }}</td>
                            <td class="text-end">{{ number_format(abs($installment->adjustment),2) }}</td>

                            <td class="text-end print-none">

                                @can('loan-installment.edit')
                                    <a href="{{ route('loan-installment.edit', $installment->id) }}"
                                        class="btn sm btn-warning" title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                @endcan

                                @can('loan-installment.destroy')
                                    <form action="{{ route('loan-installment.destroy', $installment->id) }}" method="POST"
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
    </div>
</x-app-layout>
