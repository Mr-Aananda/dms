@section('title', 'Income Record Details')
<x-app-layout>
    <div class="row g-3">
        <div class="col-lg-4">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center">
                    <button type="button" class="btn icon lg rounded" title="Print Expense Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('income-record.edit', $incomeRecord->id) }}" type="button" class="btn icon lg rounded"
                       title="Edit This Product">
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
        </div>
        <div class="col-lg-8">
            <div class="widget" id="print-widget">

                <!-- Start print header =========================== -->
                <x-print.header />
                <!-- End print header =========================== -->

                <!-- Start header ================= -->
                <div class="widget-head border-bottom pb-1">
                    <h4>Income Sector: {{ $incomeRecord?->incomeSector?->name }}</h4>
                    <p class="text-muted">
                        <strong>Date:</strong>
                        <span class="me-3">{{ $incomeRecord?->date->format('d F, Y') }}</span>
                         <strong>Created By :</strong>
                        <a href="{{route('user.show', $incomeRecord?->user?->id) }}">{{ $incomeRecord?->user?->name }}</a>
                    </p>
                </div>
                <!-- End header ==================== -->


                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <h5 class="mt-3 mb-2">Income Record Details</h5>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td>Income Sector</td>
                                <td>{{ $incomeRecord?->incomeSector?->name }}</td>
                            </tr>
                            <tr>
                                <td>Branch</td>
                                <td>{{ $incomeRecord?->branch?->name }}</td>
                            </tr>

                            <tr>
                                <td>Amount</td>
                                <td class="fw-bold">{{ $incomeRecord->amount }}</td>
                            </tr>

                            <tr>
                                <td>Payment Method</td>
                                <td>{{ $incomeRecord->payment_method == 'cash' ? 'Cash' : 'Bank Payemnt' }}</td>
                            </tr>

                            <tr>
                                <td>Income By</td>
                                <td>{{ $incomeRecord->income_by }}</td>
                            </tr>

                        </tbody>
                    </table>

                    <div>
                        <p>Note : {!! $incomeRecord?->note !!}</p>
                    </div>
                </div>
                <!-- End body ===================== -->
            </div>
        </div>
    </div>
</x-app-layout>
