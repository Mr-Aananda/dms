@section('title', 'Withdraws')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start  menu -->
            @include('pos.withdraw.menu')
            <!-- End  menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded collapsed" title="Search" data-bs-toggle="collapse"
                    data-bs-target="#tableSearch" aria-controls="tableSearch" aria-expanded="false">
                    <i class="bi bi-search"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Print" onclick="printable('print-widget')">
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
            <form action="{{ route('withdraw.index') }}" method="get">
                <input type="hidden" name="search" value="1">
                <div class="row py-3 g-3">
                    <div class="col-md-3">
                        <label for="date" class="form-label">Date (From)</label>
                        <input
                        {{-- value="{{ (request()->search) ? request()->form_date : date('Y-m-d') }}" --}}
                        value="{{ (request()->search) ? request()->from_date : '' }}"
                        type="date"
                        id="fromdate"
                        name="from_date"
                        class="form-control"
                        placeholder="YYYY-MM-DD">
                    </div>
                    <div class="col-md-3">
                        <label for="date" class="form-label">Date (To)</label>
                        <input
                        {{-- value="{{ (request()->search) ? request()->to_date : date('Y-m-d') }}" --}}
                        value="{{ (request()->search) ? request()->to_date : '' }}"
                        type="date"
                        id="todate"
                        name="to_date"
                        class="form-control"
                        placeholder="YYYY-MM-DD">
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

        <!-- Start print header  -->
        <x-print.header />
        <!-- End print header -->


        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Withdraws</h5>
                <p><small>{{ count($withdraws) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th scope="col">sl</th>
                            <th scope="col">Date</th>
                            <th scope="col">Withdraw By</th>
                            <th scope="col" class="text-end">Amount</th>
                            <th scope="col" class="text-end print-none">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @php
                            $totalAmount = 0;
                        @endphp
                        @forelse($withdraws as $withdraw)
                            @php
                                $totalAmount += $withdraw->amount;
                            @endphp
                            <tr>
                                <th scope="row">{{ $withdraws->firstItem() + $loop->index }}</th>
                                <td>{{$withdraw->date->format('d M ,Y')}}</td>
                                <td>{{$withdraw?->user?->name}}</td>
                                <td class="text-end">{{$withdraw->amount}}</td>

                                <td class="text-end print-none">
                                    @can('withdraw.show')
                                        <a href="{{ route('withdraw.show', $withdraw->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    @endcan

                                    @can('withdraw.edit')
                                        <a href="{{ route('withdraw.edit', $withdraw->id) }}" class="btn sm btn-warning"
                                            title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                    @endcan

                                    @can('withdraw.destroy')
                                        <form action="{{ route('withdraw.destroy', $withdraw->id) }}" method="POST"
                                            class="d-inline" onsubmit="return confirm('Are you sure want to delete?')">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" title="Delete"
                                                {{ $withdraw->details_count > 0 ? 'disabled' : '' }}
                                                class="btn sm btn-danger">
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
                        <tr class="fw-bold">
                            <td colspan="3" class="text-end">Total Withdraws : </td>
                            <td class="text-end">{{ number_format($totalAmount, 2) }}</td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>
    <!-- Start pagination -->
        <x-pagination :items="$withdraws" />
    <!-- End pagination -->
    <!-- End main-bar-->
    @push('script')

    @endpush
</x-app-layout>
