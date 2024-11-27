@section('title', 'Damage')

<x-app-layout>
    <div class="row">
        <div class="col-lg-9">
            <div id="print-widget">
                <!-- Start print header  -->
                <x-print.header />
                <!-- End print header -->

                <!-- Start body widget -->
                <div class="widget">
                    <div class="widget-head mb-3">
                        <h5>Damage Details</h5>
                    </div>
                    <div class="widget-body">
                        <div class="row">
                            <p class="col-4 mb-2"><span style="font-size: larger">Damage no:</span> {{ $damage->damage_no }} </p>
                            <p class="col-4"><span style="font-size: larger">Date:</span> {{ $damage?->date->format('d-M-Y') }} </p>
                            <p class="col-4"><span style="font-size: larger">Branch:</span> {{ $damage?->branch?->name }} </p>
                        </div>
                        <hr>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">sl.</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Barcode</th>
                                    <th scope="col">Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($damage->details as $detail)
                                    <tr>
                                        <th scope="row">{{ $loop->iteration }}.</th>
                                        <td>{{ $detail?->product_name }}</td>
                                        <td>{{ $detail?->product?->barcode }}</td>
                                        <td>
                                            {{ \App\Helpers\Converter::convertToUpperUnit($detail?->quantity, $detail?->product?->unit_label, $detail?->product?->unit_relation) }}
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="10" class="text-center">No Data found</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- End body widget -->
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
                            <i class="bi bi-printer"></i>
                            Print
                        </button>

                        <a href="{{ route('damage.edit', $damage->id) }}" class="btn btn-outline-primary">
                            <i class="bi bi-pencil-square"></i>
                            Edit Damage
                        </a>

                        <button
                            class="btn btn-danger"
                            href="#"
                            onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $damage->id }}').submit() } return false ">
                            <i class="bi bi-trash"></i>
                            Delete Damage
                        </button>

                        <form action="{{ route('damage.destroy', $damage->id) }}"
                                method="post" class="d-none"
                                id="sm-delete-{{ $damage->id }}">
                            @csrf
                            @method('DELETE')
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</x-app-layout>
