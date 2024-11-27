@section('title', 'Transaction Details')
<x-app-layout>
    <div class="row g-3">
        <div class="col-lg-4">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center">
                    <button type="button" class="btn icon lg rounded" title="Print Transaction Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('transaction.edit', $transaction->id) }}" type="button" class="btn icon lg rounded"
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
                    <h4>Date: {{ $transaction?->date->format('d F, Y') }}</h4>
                    <p class="text-muted">
                         <strong>Created By :</strong>
                        <a href="{{route('user.show', $transaction?->user?->id) }}">{{ $transaction?->user?->name }}</a>
                    </p>
                </div>
                <!-- End header ==================== -->


                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <h5 class="mt-3 mb-2">Transaction Details</h5>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td>Transaction From</td>
                                <td>
                                    {{
                                        $transaction->transaction_from == 'cash' ?
                                        'Cash (' . $transaction->from_transaction->name . ')' :
                                        'Bank- (' . $transaction->from_transaction->custom_name . ')'
                                    }}
                                </td>
                            </tr>
                            <tr>
                                <td>Transaction To</td>
                                <td>
                                    {{
                                        $transaction->transaction_to == 'cash' ?
                                        'Cash (' . $transaction->to_transaction->name . ')' :
                                        'Bank- (' . $transaction->to_transaction->custom_name . ')'
                                    }}
                                </td>
                            </tr>
                            <tr>
                                <td>Transfer Amount</td>
                                <td class="fw-bold">{{ $transaction->amount }}</td>
                            </tr>
                        </tbody>
                    </table>

                    <div>
                        <p>Note : {!! $transaction?->note !!}</p>
                    </div>
                </div>
                <!-- End body ===================== -->
            </div>
        </div>
    </div>
</x-app-layout>
