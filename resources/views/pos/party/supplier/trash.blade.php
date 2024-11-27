@section('title', 'Supplier Trash')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3 border-top print-none">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.party.supplier.menu')
        <!-- End left menu -->
            <!-- Start right button -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="window.print()">
                    <i class="bi bi-printer"></i>
                </button>
                <a class="btn icon lg rounded" title="Reload" href="{{ route('supplier.trash') }}">
                    <i class="bi bi-bootstrap-reboot"></i>
                </a>
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right button -->
        </div>
    </div>
    <!-- End header widget -->


    <!-- Start body widget -->
    <div id="print-widget">
        <!-- Start print header =========================== -->
        <x-print.header />
        <!-- End print header =========================== -->

        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All trash suppliers</h5>
                <p><small>Total Result found {{ count($suppliers) }} </small></p>
            </div>
            <div class="widget-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th style="width: 70px;">
                                    SL
                                </th>
                                <th scope="col">Party name</th>
                                <th scope="col">Phone</th>
                                <th scope="col" class="text-end">Balance</th>
                                <th scope="col">Balance status</th>
                                <th scope="col">Status</th>
                                <th scope="col" class="text-end print-none">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        @foreach($suppliers as $index => $supplier)
                            <tr>
                                <th scope="row">{{ $suppliers->firstItem() + $loop->index }}</th>
                                <td>{{ $supplier->name }}</td>
                                <td>{{ $supplier->phone }}</td>
                                <td class="text-end">{{ number_format(abs($supplier->balance), 2)}}</td>
                                <td>{{ $supplier->balance >= 0 ? "Receivable" : "Payable" }}</td>
                                <td class="text-center">
                                        <span
                                            class="badge {{ $supplier->active == '1'
                                                    ? 'bg-success'
                                                    : 'bg-danger'
                                                    }}">
                                            {{ $supplier->active== '1' ? 'Active' : 'Inactive' }}
                                        </span>
                                    </td>
                                <td class="text-end print-none">
                                    <a href="{{ route('supplier.restore', $supplier->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-arrow-clockwise"></i>
                                    </a>

                                    <button
                                        class="btn btn-danger sm"
                                        href="#"
                                        onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $supplier->id }}').submit() } return false ">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>

                                    <form action="{{ route('supplier.permanentDelete', $supplier->id) }}"
                                          method="get" class="d-none"
                                          id="sm-delete-{{ $supplier->id }}">
                                        @csrf
                                        @method('DELETE')
                                    </form>
                                </td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
       <!-- Start pagination -->
        <x-pagination :items="$suppliers" />
    <!-- End pagination -->
    <!-- End Body widget -->
</x-app-layout>
