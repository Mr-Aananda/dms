@section('title', 'Production ')

<x-app-layout>
 <div class="row">
    <div class="col-lg-4">
        <div class="widget">
            <div class="widget-head border-bottom pb-3 text-center">
                <button type="button" class="btn icon lg rounded" title="Print Production Details"
                        onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                </button>
                <a href="{{ route('production.edit', $production->id) }}" type="button" class="btn icon lg rounded"
                    title="Edit This Production">
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
        <div id="print-widget">

            <!-- Start print header  -->
            <x-print.header />
            <!-- End print header -->

            <!-- Start body widget -->
            <div class="widget">
                <div class="widget-head mb-3">
                    <h5>Production Details</h5>
                    <p><small>Raw products to Production products details</small></p>
                </div>
                <div class="widget-body">
                    <div class="row mt-1">
                        <div class="col-12">
                            <p>
                                <strong>Production Date:</strong>
                                <span>{{ $production?->date?->format('d-M-Y') }}</span>
                                <strong class="ms-3">Responsible Person:</strong>
                                <span>{{ $production?->user?->name }}</span>
                            </p>
                        </div>
                    </div>

                    <div class="row mb-1">
                        <div class="col-6 my-2">
                            <!-- Start product table ================== -->
                            <h5 class="mb-2">Raw Products</h5>
                            <table class="table table-bordered table-sm">
                                <thead>
                                    <tr>
                                        <th class="text-center" style="width: 50px;">SL</th>
                                        <th>Product</th>
                                        <th class="text-end">Cut Qty</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($production?->details->where('production_type', 'raw_product') as $details)
                                        <tr>
                                            <td class="text-center">{{ $loop->iteration }}</td>
                                            <td>{{ $details?->product_name }}</td>
                                            <td class="text-end">
                                                {{ \App\Helpers\Converter::convertToUpperUnit($details?->quantity, $details?->product?->unit_label, $details?->product?->unit_relation) }}
                                            </td>
                                        </tr>
                                    @empty
                                    @endforelse

                                </tbody>
                            </table>
                            <!-- End product table ================== -->
                        </div>
                        <div class="col-6 my-2">
                            <!-- Start product table ================== -->
                            <h5 class="mb-2">Production Product</h5>
                            <table class="table table-bordered table-sm">
                                <thead>
                                    <tr>
                                        <th class="text-center" style="width: 50px;">SL</th>
                                        <th>Product</th>
                                        <th class="text-end">Add Qty</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($production?->details->where('production_type', 'finish_product') as $details)
                                        <tr>
                                            <td class="text-center">{{ $loop->iteration }}</td>
                                            <td>{{ $details?->product_name }}</td>
                                            <td class="text-end">
                                                {{ \App\Helpers\Converter::convertToUpperUnit($details?->quantity, $details?->product?->unit_label, $details?->product?->unit_relation) }}
                                            </td>
                                        </tr>
                                    @empty
                                    @endforelse

                                </tbody>
                            </table>
                            <!-- End product table ================== -->
                        </div>
                        @if ($production?->note)
                            <p>
                                <strong class="ms-3">note:</strong>
                                <span>{{ $production?->note == "null" ? "" : $production?->note == "null"  }}</span>
                            </p>
                        @endif
                    </div>

                </div>
            </div>
            <!-- End body widget -->
        </div>
        <!-- End main-bar-->
    </div>
    {{-- <div class="col-lg-3">
        <div class="widget">
            <div class="widget-body">
                <div class="d-grid gap-2">
                    <button
                        class="btn btn-outline-primary"
                        type="button"
                        onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                        Print
                    </button>

                    <a href="{{ route('production.edit', $production->id) }}" class="btn btn-outline-primary">
                        <i class="bi bi-pencil-square"></i>
                        Edit Production
                    </a>

                    <button
                        class="btn btn-danger"
                        href="#"
                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $production->id }}').submit() } return false ">
                        <i class="bi bi-trash"></i>
                        Delete Production
                    </button>

                    <form action="{{ route('production.destroy', $production->id) }}"
                            method="post" class="d-none"
                            id="sm-delete-{{ $production->id }}">
                        @csrf
                        @method('DELETE')
                    </form>
                </div>
            </div>
        </div>
    </div> --}}
 </div>
</x-app-layout>
