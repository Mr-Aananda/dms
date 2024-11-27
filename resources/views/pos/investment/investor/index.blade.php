@section('title', 'Investors')

<x-app-layout>
    <!-- Start main-bar-->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
            @include('pos.investment.investor.menu')
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
            <form action="{{ route('investor.index') }}" method="get">
                <div class="row py-3 g-3">

                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-3">
                        <label for="account" class="form-label">Name</label>

                        <input class="form-control" list="accountList" name="name" id="account"
                               placeholder="Type a account name" value="{{ request()->name }}">
                    </div>
                    <div class="col-md-3">
                        <label for="phone" class="form-label">Phone</label>

                        <input class="form-control" name="phone" id="phone"
                               placeholder="Enter mobile no" value="{{ request()->phone }}">
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
            <!-- Start print header -->
            <x-print.header/>
            <!-- End print header -->

        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Investor</h5>
                <p><small>{{ count($investors) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Name</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Address</th>
                        <th scope="col" class="text-end">Balance</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                        @php
                            $totalBalance = 0;
                        @endphp
                    @forelse($investors as $investor)
                        @php
                            $totalBalance += $investor->balance;
                        @endphp
                        <tr>
                            <th scope="row">{{ $investors->firstItem() + $loop->index }}</th>
                            <td>{{ $investor->name }}</td>
                            <td>{{ $investor->phone }}</td>
                            <td>{{ $investor->address }}</td>
                            <td class="text-end">{{ number_format($investor->balance, 2)}}</td>

                            <td class="text-end print-none">

                                {{-- @can('investor.show')
                                    <a href="{{ route('investor.show', $investor->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                @endcan --}}

                                @can('investor.edit')
                                    <a href="{{ route('investor.edit', $investor->id) }}"
                                        class="btn sm btn-warning" title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                @endcan

                                @can('investor.destroy')
                                    <form action="{{ route('investor.destroy', $investor->id) }}" method="POST"
                                            class="d-inline"
                                            onsubmit="return confirm('Are you sure want to delete?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" title="Delete"
                                                {{ $investor->invests_count > 0 ? 'disabled' : '' }} class="btn sm btn-danger">
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
                    <tfoot>
                        <tr>
                            <th colspan="3"></th>
                            <th class="text-end">Total</th>
                            <th class="text-end">{{ number_format($totalBalance, 2) }}</th>
                            <th></th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>

    <!-- End main-bar  -->
      <!-- Start pagination -->
        <x-pagination :items="$investors" />
    <!-- End pagination -->

</x-app-layout>
