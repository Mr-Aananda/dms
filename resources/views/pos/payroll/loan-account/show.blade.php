@section('title', 'Account Details')
<x-app-layout>
    <div class="row g-3">
        <div class="col-lg-4">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center">
                    <button type="button" class="btn icon lg rounded" title="Print Customer Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('loan-account.edit', $loanAccount->id) }}" type="button" class="btn icon lg rounded"
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
        </div>
        <div class="col-lg-8">
            <div class="widget" id="print-widget">

                <!-- Start print header =========================== -->
                <x-print.header />
                <!-- End print header =========================== -->

                <!-- Start header ================= -->
                <div class="widget-head border-bottom pb-1">
                    <h4>{{ $loanAccount?->name }}</h4>
                    <p class="text-muted">
                        <strong>Date:</strong>
                        <span class="me-3">{{ $loanAccount?->created_at->format('d F, Y') }}</span>
                         <strong>Created by :</strong>
                        <a href="{{route('user.show', $loanAccount?->user?->id) }}">{{ $loanAccount?->user?->name }}</a>
                    </p>
                </div>
                <!-- End header ==================== -->


                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <h5 class="mt-3 mb-2">Loan Account Details</h5>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td>Name</td>
                                <td>{{ $loanAccount?->name }}</td>
                            </tr>
                            <tr>
                                <td>Mobile</td>
                                <td>{{ $loanAccount?->phone }}</td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td>{{ $loanAccount?->address }}</td>
                            </tr>
                            <tr>
                                <td>Total Loan</td>
                                <td>{{ number_format(abs($loanAccount->total_loan), 2)}}
                                    <span class="{{$loanAccount->total_loan <= 0 ? 'text-success' : 'text-danger'  }}">({{ $loanAccount->total_loan <= 0 ? 'Rec':'Pay' }})</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Total Paid</td>
                                <td>{{ number_format(abs($loanAccount->total_paid), 2)}}</td>
                            </tr>
                            <tr>
                                <td>Total Adjustment</td>
                                <td>{{ number_format(abs($loanAccount->total_adjustment), 2)}}</td>
                            </tr>
                            <tr>
                                <td>Balance</td>
                                <td>{{ number_format(abs($loanAccount->total_due), 2)}}
                                    <span class="{{$loanAccount->total_due <= 0 ? 'text-success' : 'text-danger'  }}">({{ $loanAccount->total_due <= 0 ? 'Rec':'Pay' }})</span>
                                </td>
                            </tr>

                        </tbody>
                    </table>

                    <div>
                        <p>Note : {!! $loanAccount?->note !!}</p>
                    </div>
                </div>
                <!-- End body ===================== -->

            </div>
        </div>
    </div>
</x-app-layout>
