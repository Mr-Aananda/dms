@section('title', 'SMS')

<x-app-layout>
    <!-- Start statistics -->
    <div class="widget">
        <div class="widget-body">
            <div class="row g-4">

                <!-- Start single stats wrap ============================= -->
                <div class="col-xl-3 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon success me-3">
                            <i class="bi bi-cash"></i>
                        </div>
                        <div class="stats">
                            <p class="title-sm">SMS Balance</p>
                            <h4 class=" fw-bold text-muted">৳ {{ $sms_balance }}</h4>
                        </div>
                    </div>
                </div>
                <!-- End single stats wrap ============================= -->
                <!-- Start single stats wrap ============================= -->
                <div class="col-xl-3 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon success me-3">
                            <i class="bi bi-envelope"></i>
                        </div>
                        <div class="stats">
                            <p class="title-sm">Total remaining SMS</p>
                            <h4 class=" fw-bold text-muted">{{ $remaining_sms }}</h4>
                        </div>
                    </div>
                </div>
                <!-- End single stats wrap ============================= -->

                <!-- Start single stats wrap ============================= -->
                <div class="col-xl-3 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon me-3">
                            <i class="bi bi-send-check"></i>
                        </div>
                        <div class="stats">
                            <p class="title-sm">Total Send sms</p>
                            <h4 class=" fw-bold text-muted"> {{ $totalSendSmsCount }}</h4>
                        </div>
                    </div>
                </div>
                <!-- End single stats wrap ============================= -->
            </div>
        </div>
    </div>
    <!-- End statistics -->

    <!-- Start header widget -->
    <div class="widget mb-3 border-top">
        <div class="widget-body d-flex">

            @include('pos.sms.menu')

            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Search" data-bs-toggle="collapse"
                    data-bs-target="#tableSearch" aria-controls="tableSearch">
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
        </div>
        <div class="widget-body collapse  {{ request()->search == '1' ? 'show' : '' }}" id="tableSearch">
            <form action="{{ route('sms.report') }}" method="GET">
                <div class="row py-3 gx-3">

                    <input hidden type="text" name="search" value="1">


                    <div class="col-md-2">
                        <label for="date-from" class="form-label">Date from</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-calendar-week"></i></span>
                            <input type="date" class="form-control" name="date_from" id="date-from"
                                value="{{ old('date_from', request()->date_from) }}">
                        </div>
                    </div>

                    <div class="col-md-2">
                        <label for="date-to" class="form-label">Date to</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-calendar-week"></i></span>
                            <input type="date" class="form-control" name="date_to" id="date-to"
                                value="{{ old('date_to', request()->date_to) }}">
                        </div>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"> <i
                                class="bi bi-search"></i>
                            Search</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- End header widget -->

    <div id="print-widget">

        <!-- Start print header =========================== -->
        <x-print.header />
        <!-- End print header =========================== -->


        <!-- Start body widget =================================== -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All SMS</h5>
                <p><small>{{ count($smsReports) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th style="width: 70px;">SL</th>
                            <th>Date</th>
                            <th>Send to</th>
                            <th>Message</th>
                            <th>SMS count</th>
                            <th class="text-end">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($smsReports as $smsReport)
                        <tr>
                            <th>{{ $smsReports->firstItem() + $loop->index }}</th>
                            <td>{{ $smsReport->created_at->format('Y-m-d') }}</td>
                            <td>{{ $smsReport->phone }}</td>
                            <td>{{ $smsReport->message }}</td>
                            <td>{{ $smsReport->total_sms }}</td>
                            <td class="text-end"><span class="badge bg-success rounded">{{ $smsReport->status ? 'success' : 'error' }}</span></td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget =================================== -->
    </div>

    <!-- Start pagination -->
    <nav aria-label="..." class=" float-end mt-4">
        {{ $smsReports->links() }}
    </nav>
    <!-- End pagination -->

</x-app-layout>
