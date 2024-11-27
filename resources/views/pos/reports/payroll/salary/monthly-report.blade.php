@section('title', 'Salary Report')

<x-app-layout>
    <!-- Start main-bar-->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
            @include('pos.reports.payroll.menu')
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
            <form action="{{ route('report.salary-monthly-report') }}" method="get">
                <div class="row py-3 g-3">

                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-4">
                            <label for="month" class="form-label">Select Month</label>
                            <input type="month" name="month" class="form-control"
                                placeholder="Enter month" value="{{ request('month', \Carbon\Carbon::now()->format('Y-m')) }}" required>
                    </div>
                    <div class="col-md-1">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"><i class="bi bi-search"></i>
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
                <h5>Employee Monthly Salary Report</h5>
                <p><small>{{ count($reports) }} results found </small></p>
                <div class="text-center">
                    <h3 class="fw-bold mb-2">Report Month:
                        <span class="text-primary">
                            @if(request()->has('month') && !empty(request('month')))
                                {{ \Carbon\Carbon::parse(request('month'))->format('F Y') }}
                            @else
                                {{ \Carbon\Carbon::now()->format('F Y') }}
                            @endif
                        </span>
                    </h3>
                </div>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Employee Name</th>
                        <th>Salary No</th>
                        <th>Given Date</th>
                        <th>Salary Month</th>
                        <th>Details</th>
                    </tr>
                    </thead>
                    <tbody>
                    @forelse($reports as $item)
                        <tr>
                            <td>{{ $item['Employee Name'] }}</td>
                            <td>{{ $item['Salary No'] }}</td>
                            <td>{{ $item['Given Date'] }}</td>
                            <td>{{ $item['Salary Month'] }}</td>
                            <td>
                                <ul>
                                    @foreach($item['Details'] as $detail)
                                        <li>{{ $detail['Purpose'] }}: {{ $detail['Amount'] }}</li>
                                    @endforeach
                                </ul>
                            </td>
                        </tr>
                        @empty
                            <tr>
                                <td colspan="10" class="text-center">No Data found</td>
                            </tr>
                        @endforelse
                        <tr>
                            <td colspan="4" class="text-end" ><strong>Total = </strong></td>
                            <td class="fw-bold">{{ number_format($totalSalaries, 2) }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>

    <!-- End main-bar  -->
    <!-- End main-bar  -->
    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#employee_id').select2({
                    allowClear: true,
                    placeholder: "Select a employee",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush

</x-app-layout>
