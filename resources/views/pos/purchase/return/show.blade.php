@section('title', 'Purchase Return')
<x-app-layout>
    <div class="row">
        <div class="col-lg-9">
            <div class="widget" id="print-widget">
                <!-- Start header ================= -->
                <div class="widget-head text-center">
                    <img src="{{Vite::asset('resources/template/assets/images/logo/khurak.svg')}}" style="height: 65px;" alt="#">
                </div>
                <!-- End header ==================== -->

                <!-- Start body ===================== -->
                <div class="widget-body">
                    <div class="row mb-1">
                        <div class="col-7">
                            <p>
                                <strong class="d-block">Khurak</strong>
                                <span class="d-block">Amirabad, Maskanda, Mymensingh</span>
                                <span class="d-block">Phone: +880 1795 290732</span>
                                {{-- <span class="d-block">Mail: info@utkorsho.com</span> --}}
                            </p>
                        </div>
                        <div class="col-5 text-end">
                            <h5> Return No. <strong>{{ $return?->return_no }}</strong></h5>
                            <p> Date: <strong>{{ $return?->date?->format('d-M-Y') }}</strong></p>
                        </div>
                        <div class="col-12 mt-1">
                            <p>
                                <strong>Supplier:</strong>
                                <span>{{ $return?->party_name }}</span>
                                <strong class="ms-3">Phone:</strong>
                                <span>{{ $return?->party?->phone }}</span>
                                <strong class="ms-3">Email:</strong>
                                <span>{{ $return?->party?->email }}</span>
                                <strong class="ms-3">Address:</strong>
                                <span>{{ $return?->party?->address }}</span>
                            </p>
                        </div>
                    </div>

                    <!-- Start product table ================== -->
                    <table class="table table-bordered table-sm">
                        <thead>
                        <tr>
                            <th class="text-center" style="width: 50px;">SL</th>
                            <th>Product</th>
                            <th class="text-end">Qty</th>
                            <th class="text-end">Return Price</th>
                            {{-- <th class="text-end">Discount</th> --}}
                            <th class="text-end">Total</th>
                        </tr>
                        </thead>
                        <tbody>
                            @forelse($return?->details as $details)
                                <tr>
                                    <td class="text-center">{{ $loop->iteration }}</td>
                                    <td>{{ $details?->product_name }}</td>
                                    <td class="text-end">
                                         {{ \App\Helpers\Converter::convertToUpperUnit($details?->quantity, $details?->product?->unit_label, $details?->product?->unit_relation) }}
                                    </td>
                                    <td class="text-end">{{ number_format($details?->return_price, 2) }} Tk</td>
                                    {{-- <td class="text-end">{{ number_format($details?->discount, 2) }} Tk</td> --}}
                                    <td class="text-end">{{ number_format(($details?->quantity * $details?->return_price)- $details?->discount, 2) }} Tk</td>
                                </tr>
                            @empty
                            @endforelse
                            <tr>
                                <td colspan="3" rowspan="6">
                                    <strong>In Word : </strong>
                                    <span>{{ ucwords((new NumberFormatter('en_IN', NumberFormatter::SPELLOUT))->format($return?->return_grand_total)) }}</span>
                                </td>
                                <td class="text-end">Total:</td>
                                <td class="text-end">{{ number_format($return?->subtotal, 2) }} Tk</td>
                            </tr>
                            <tr>
                                <td class="text-end">Discount:</td>
                                <td class="text-end">{{ $return?->discount }} Tk</td>
                            </tr>
                            <tr>
                                <td class="text-end">Previous Balance:</td>
                                <td class="text-end">
                                    {{ number_format(abs($return?->previous_balance), 2) }} Tk
                                    <span>({{ $return?->previous_balance >=0 ? 'Rec':'Pay' }})</span>
                                </td>

                            </tr>
                            <tr>
                                <td class="text-end">Grand Total:</td>
                                <td class="text-end">{{ number_format($return?->return_grand_total + $return?->previous_balance , 2) }} Tk</td>
                            </tr>
                            <tr>
                                <td class="text-end">Total Paid:</td>
                                <td class="text-end">{{ number_format($return?->return_total_paid, 2) }} Tk</td>
                            </tr>
                            <tr>
                                <td class="text-end">{{ (($return?->return_grand_total + $return?->previous_balance) - $return?->return_total_paid) >= 0 ? 'Due' : 'Advanced' }}:</td>
                                <td class="text-end">
                                    {{ number_format(abs(($return?->return_grand_total + $return?->previous_balance) - $return?->return_total_paid), 2) }} Tk
                                    <span>({{ ($return?->return_grand_total - $return?->previous_balance) - $return?->return_total_paid >= 0 ? 'Pay' : 'Rec' }})</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- End product table ================== -->

                    <!-- Start signature =================== -->
                    <div class="row mb-4" style="margin-top: 100px;">
                        <div class="col-4">
                            <p class="text-center ms-5 border-top w-50">Customer's Signature</p>
                        </div>

                        {{-- <div class="col-4">
                            <img class="w-100"
                                 src="data:image/png;base64,{{ DNS1D::getBarcodePNG($purchase->voucher_no, 'C128', 1, 33) }}"
                                 alt="barcode">
                        </div> --}}

                        <div class="col-4">
                            <p class="text-center ms-auto me-5 border-top w-50">For Utkorsho</p>
                        </div>
                    </div>
                    <!-- End signature =================== -->

                    <!-- Start payment table -->
                    <table class="table table-bordered table-sm">
                        <thead>
                        <tr>
                            <th class="text-center" style="width: 50px;">SL</th>
                            <th>Date</th>
                            <th>Payment method</th>
                            <th>Payment By</th>
                            <th>Cash/Bank</th>
                            <th class="text-end">Amount</th>
                        </tr>
                        </thead>
                        <tbody>
                            @forelse($return?->payments as $payment)
                                <tr>
                                    <td class="text-center">01</td>
                                    <td>{{ $payment?->date->format('d M Y') }}</td>
                                    <td>{{ $payment?->cash_id ? 'Cash' : 'Bank' }}</td>
                                    <td>{{ $payment?->user_name }}</td>
                                    <td>{{ $payment?->cash_name ?? $payment?->bank_name }}</td>
                                    <td class="text-end">{{ number_format($payment?->amount, 2) }} Tk</td>
                                </tr>
                            @empty
                                <x-table.empty-data/>
                            @endforelse
                        <tr>
                            <td colspan="4"></td>
                            <td class="text-end">Total</td>
                            <td class="text-end">{{ number_format($return?->payments->sum('amount'), 2) }} Tk</td>
                        </tr>
                        </tbody>
                    </table>
                    <!-- End payment table -->

                    <!-- Start Note -->
                    <div>
                        <p><Strong>Note: </Strong>It was a pleasure working with you and your team. We hope you
                            will keep us in mind for future freelance projects. Thank You!</p>
                    </div>
                    <!-- end Note -->
                </div>
                <!-- End body ===================== -->

            </div>
        </div>

        <div class="col-lg-3">
            <div class="widget">
                <div class="widget-body">
                    <div class="d-grid gap-2">
                        <button
                            class="btn btn-outline-primary"
                            type="button"
                            onclick="printable('print-widget')">
                            <i class="bi bi-printer"></i> Print Invoice
                        </button>

                        <a href="{{ route('purchase-return.edit', $return->id) }}" class="btn btn-outline-primary">
                            <i class="bi bi-pencil-square"></i> Edit Invoice
                        </a>

                        <button
                            class="btn btn-danger"
                            href="#"
                            onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $return->id }}').submit() } return false ">
                            <i class="bi bi-trash"></i> Delete
                            Invoice
                        </button>

                        <form action="{{ route('purchase-return.destroy', $return->id) }}"
                              method="post" class="d-none"
                              id="sm-delete-{{ $return->id }}">
                            @csrf
                            @method('DELETE')
                        </form>
                    </div>

                    {{-- <div>
                        <a href="{{ $purchase->getFirstMediaUrl(\App\Models\Purchase::MEDIA_COLLECTION_AVATAR) }}" target="_blank">
                            <img src="{{ $purchase->getFirstMediaUrl(\App\Models\Purchase::MEDIA_COLLECTION_AVATAR) }}" alt="" class="mt-4" width="300">
                        </a>
                    </div> --}}
                </div>
            </div>
        </div>
    </div>

</x-app-layout>
