@section('title', 'Salary Details')
<x-app-layout>
    <div class="row g-3">
        <div class="col-lg-4">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center">
                    <button type="button" class="btn icon lg rounded" title="Print Salary Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('salary.edit', $salary->id) }}" type="button" class="btn icon lg rounded"
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
                <div class="widget-head">
                     <div class="text-center mb-2">
                        <h5 class="mt-3">Employee Salary Invoice</h5>
                        <p><span class="fw-bold">Salary no:</span> {{$salary->salary_no }} </p>
                     </div>
                    <div class="row">
                        <div class="col-5 lh-lg">
                            <p><span class="fw-bold">Name:</span> {{ $salary->employee->name }} </p>
                            <p><span class="fw-bold">Mobile:</span> {{ $salary->employee->phone }} </p>
                            <p><span class="fw-bold">Email:</span> {{ $salary->employee->email }} </p>
                            <p><span class="fw-bold">Address:</span> {{ $salary->employee->address }} </p>
                        </div>
                        <div class="col-3 lh-lg"></div>
                        <div class="col-4 text-end">
                            <p><span class="fw-bold">Salary Month:</span> {{ Carbon\Carbon::parse($salary->salary_month)->format('F Y')}} </p>
                            <p><span class="fw-bold">Given Date:</span> {{ Carbon\Carbon::parse($salary->given_date)->format('d M Y')}} </p>
                        </div>
                    </div>
                </div>
                <!-- End header ==================== -->

                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <table class="table table-bordered">
                        <thead >
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Details</th>
                                <th scope="col" class="text-end">Amount</th>
                            </tr>
                        </thead>
                       <tbody>
                            @foreach($salary['details'] as $index => $details)
                                <tr>
                                    <td>{{ $index + 1 }}</td>
                                    <td>{{ ucfirst(str_replace('_', ' ', $details['purpose'])) }}</td>
                                    <td class="text-end">{{ number_format(abs($details['amount']), 2) }}</td>
                                </tr>
                            @endforeach
                        </tbody>

                        <tfoot class="text-end border-top">
                            <tr class="fw-bold">
                                <td colspan="1" rowspan="9" class="align-middle"></td>
                                <td>Total</td>
                                <td class="text-end">
                                    {{ number_format($salary['total_salary_paid'], 2) }}
                                </td>
                            </tr>
                        </tfoot>
                    </table>

                    <div>
                        <p>Note : {!! $salary?->note !!}</p>
                    </div>

                    <div class="footer mt-5">
                        <div class="row">
                            <div class="col-3 border-top text-center">
                                Employee Sign
                            </div>
                            <div class="col-6"></div>
                            <div class="col-3  border-top text-center">
                                Authorized Sign
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End body ===================== -->

            </div>
        </div>
    </div>
</x-app-layout>
