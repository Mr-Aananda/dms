@section('title', 'Supplier Details')
<x-app-layout>
    <div class="row g-3">
        <div class="col-lg-4">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center">
                    <button type="button" class="btn icon lg rounded" title="Print Supplier Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('supplier.edit', $supplier->id) }}" type="button" class="btn icon lg rounded"
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
                    <h4>{{ $supplier?->name }}</h4>
                    <p class="text-muted">
                        <strong>Date:</strong>
                        <span class="me-3">{{ $supplier?->created_at->format('d F, Y') }}</span>
                         <strong>Added by :</strong>
                        <a href="{{route('user.show', $supplier?->user?->id) }}">{{ $supplier?->user?->name }}</a>
                    </p>
                </div>
                <!-- End header ==================== -->


                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <h5 class="mt-3 mb-2">Supplier Details</h5>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td>Name</td>
                                <td>{{ $supplier?->name }}</td>
                            </tr>
                            <tr>
                                <td>Company name</td>
                                <td>{{ $supplier?->company_name }}</td>
                            </tr>
                            <tr>
                                <td>Mobile</td>
                                <td>{{ $supplier?->phone }}</td>
                            </tr>
                            <tr>
                                <td>Email</td>
                                <td>{{ $supplier?->email }}</td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td>{{ $supplier?->address }}</td>
                            </tr>
                            <tr>
                            <td class="fw-bold">Balance</td>
                                <td>{{ $supplier?->balance }}
                                    <span class="{{ $supplier->balance >= 0 ? 'text-success fw-bold' : 'text-danger fw-bold'}}">({{ $supplier->balance >= 0 ? "Receivable" : "Payable" }})</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Status</td>
                                <td>
                                    <span
                                        class="badge {{ $supplier->active == '1'
                                                ? 'bg-success'
                                                : 'bg-danger'
                                                }}">
                                        {{ $supplier->active == '1' ? 'Active' : 'Inactive' }}
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <div>
                        <p>Note : {!! $supplier?->description !!}</p>
                    </div>
                </div>
                <!-- End body ===================== -->

            </div>
        </div>
    </div>
</x-app-layout>
