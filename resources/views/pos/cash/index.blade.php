@section('title', 'Cashes')

<x-app-layout>
    <!-- Start main-bar-->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.cash.menu')

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
            <form action="{{ route('cash.index') }}" method="get">
                <div class="row py-3 g-3">

                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-4">
                        <label for="cash" class="form-label">Cash name</label>

                        <input class="form-control" list="cashList" name="name" id="cash"
                               placeholder="Type a cash name" value="{{ request()->name }}">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"><i
                                class="bi bi-search"></i>
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
            <!-- Start print header =========================== -->
            <x-print.header/>
            <!-- End print header =========================== -->

        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Cashes</h5>
                <p><small>{{ count($cashes) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Cash name</th>
                        <th scope="col">Balance</th>
                        <th scope="col">Branch</th>
                        <th scope="col">Description</th>
                        <th scope="col" class="text-center">Status</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    @forelse($cashes as $cash)
                        <tr>
                            <th scope="row">{{ $cashes->firstItem() + $loop->index }}</th>
                            <td>{{ $cash->name }}</td>
                            <td>{{ $cash->balance}}</td>
                            <td>{{ $cash?->branch?->name }}</td>
                            <td>{{ $cash->description }}</td>
                            <td class="text-center">
                                <span
                                    class="badge {{ $cash->active == '1'
                                            ? 'bg-success'
                                            : 'bg-danger'
                                            }}">
                                    {{ $cash->active== '1' ? 'Active' : 'Inactive' }}
                                </span>
                            </td>
                            <td class="text-end print-none">

                                @can('cash.edit')
                                    <a href="{{ route('cash.edit', $cash->id) }}"
                                        class="btn sm btn-primary" title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                @endcan

                                @can('cash.destroy')
                                    <form action="{{ route('cash.destroy', $cash->id) }}" method="POST"
                                            class="d-inline"
                                            onsubmit="return confirm('Are you sure want to delete?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" title="Delete"
                                                {{ $cash->transaction_count > 0 ? 'disabled' : '' }} class="btn sm btn-danger">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                @endcan
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

    <!-- End main-bar  -->

</x-app-layout>
