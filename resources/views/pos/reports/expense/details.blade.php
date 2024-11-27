@section('title', 'Monthly Expense Report')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.reports.expense.menu')
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
            <form action="{{ route('report.expense-report') }}" method="get">
                <div class="row py-3 g-3">
                    <input hidden type="text" name="search" value="1">
                    <div class="row py-3 g-3">
                        <div class="col-md-5">
                            <label for="month">Month</label>
                            <input type="month" id="month" class="form-control" name="month" value="{{ old('month', request()->input('month', date('Y-m'))) }}">
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
            <div class="widget-head mb-2">
                <h5>Report: Monthly Expense Details Report</h5>
                <p><small>{{ count($expenseCategoryDetails) }} results found </small></p>
            </div>
            <div class="text-center mb-1">
                <strong class="fs-5">{{ request()->search ? \Carbon\Carbon::parse(request()->month)->format('F-Y') : \Carbon\Carbon::now()->format('F-Y') }}</strong>
            </div>
            <div class="widget-body">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th style="width: 70px;">
                                SL
                            </th>
                            <th>Date</th>
                            <th>Category(Subcategory)</th>
                            <th class="text-end">Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($expenseCategoryDetails as $index => $detail)
                            <tr>
                                <th>{{ $expenseCategoryDetails?->firstItem() + $index }}</th>
                                <td>{{ $detail?->date->format('d-M-Y') }}</td>
                                <td>{{ $detail?->expenseCategory?->name }} - {{ $detail?->expenseSubcategory?->name ?? "" }}</td>
                                <td class="text-end">{{ number_format($detail->amount,2) }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="10" class="text-center">No Data found</td>
                            </tr>
                        @endforelse
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="3" class="text-end">Total</th>
                            <th class="text-end">{{ number_format($total_amount,2) }}</th>
                            {{-- <td></td> --}}
                        </tr>
                    </tfoot>
                </table>

            <!-- End body widget -->
        </div>
    </div>
    <!-- Start pagination -->
        <x-pagination :items="$expenseCategoryDetails" />
    <!-- End pagination -->
    <!-- End main-bar-->
</x-app-layout>
