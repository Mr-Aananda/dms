@section('title', 'Expense Details')
<x-app-layout>
    <div class="row g-3">
        <div class="col-lg-4">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center">
                    <button type="button" class="btn icon lg rounded" title="Print Expense Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('expense.edit', $expense->id) }}" type="button" class="btn icon lg rounded"
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
                    <h4>Branch: {{ $expense?->branch?->name }}</h4>
                    <p class="text-muted">
                        <strong>Date:</strong>
                        <span class="me-3">{{ $expense?->date->format('d F, Y') }}</span>
                         <strong>Created By :</strong>
                        <a href="{{route('user.show', $expense?->user?->id) }}">{{ $expense?->user?->name }}</a>
                    </p>
                </div>
                <!-- End header ==================== -->


                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <h5 class="mt-3 mb-2">Expense Details</h5>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td>Category</td>
                                <td>{{ $expense?->expenseCategory?->name }}</td>
                            </tr>
                            <tr>
                                <td>Subcategory</td>
                                <td>{{ $expense?->expenseSubcategory?->name }}</td>
                            </tr>
                            <tr>
                                <td>Expense Amount</td>
                                <td class="fw-bold">{{ $expense->amount }}</td>
                            </tr>
                            <tr>
                                <td>Payment Method</td>
                                <td>{{ $expense->payment_method == 'cash' ? 'Cash' : 'Bank Payemnt' }}</td>
                            </tr>

                        </tbody>
                    </table>

                    <div>
                        <p>Note : {!! $expense?->description !!}</p>
                    </div>
                </div>
                <!-- End body ===================== -->
            </div>
        </div>
    </div>
</x-app-layout>
