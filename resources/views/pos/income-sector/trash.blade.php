@section('title', 'Income Sector Trash')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3 border-top print-none">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.income-sector.menu')
        <!-- End left menu -->
            <!-- Start right button -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="window.print()">
                    <i class="bi bi-printer"></i>
                </button>
                <a class="btn icon lg rounded" title="Reload" href="{{ route('income-sector.trash') }}">
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
                <h5>All income sector trashes</h5>
                <p><small>Total Result found {{ count($incomeSectors) }} </small></p>
            </div>
            <div class="widget-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th style="width: 70px;">
                                    SL
                                </th>
                                <th scope="col">Sector name</th>
                                <th scope="col">note</th>
                                <th scope="col" class="text-end print-none">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        @foreach($incomeSectors as $index => $sector)
                            <th scope="row">{{ $incomeSectors->firstItem() + $loop->index }}</th>
                            <td>{{ $sector->name }}</td>
                            <td>{{ $sector->note }}</td>
                            <td class="text-end print-none">
                                <a href="{{ route('income-sector.restore', $sector->id) }}" class="btn btn-primary sm">
                                    <i class="bi bi-arrow-clockwise"></i>
                                </a>

                                <button
                                    class="btn btn-danger sm"
                                    href="#"
                                    onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $sector->id }}').submit() } return false ">
                                    <i class="bi bi-trash-fill"></i>
                                </button>

                                <form action="{{ route('income-sector.permanentDelete', $sector->id) }}"
                                        method="get" class="d-none"
                                        id="sm-delete-{{ $sector->id }}">
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
        <x-pagination :items="$incomeSectors" />
    <!-- End pagination -->
    <!-- End Body widget -->
</x-app-layout>
