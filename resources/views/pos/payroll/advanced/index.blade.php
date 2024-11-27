@section('title', 'Advanced')

<x-app-layout>
    <!-- Start main-bar-->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
            @include('pos.payroll.advanced.menu')
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
            <form action="{{ route('advanced-salary.index') }}" method="get">
                <div class="row py-3 g-3">

                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-3">
                        <label for="account" class="form-label">Employee name</label>

                        <input class="form-control" name="name" id="account"
                               placeholder="Type employee name" value="{{ request()->name }}">
                    </div>
                    <div class="col-md-3">
                        <label for="phone" class="form-label">Phone</label>

                        <input class="form-control" name="phone" id="phone"
                               placeholder="Enter mobile no" value="{{ request()->phone }}">
                    </div>
                    <div class="col-md-3">
                        <label for="email" class="form-label">Email</label>

                        <input class="form-control" name="email" id="email"
                               placeholder="Enter email" value="{{ request()->email }}">
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
                <h5>All Advanced</h5>
                <p><small>{{ count($users) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Name</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Email</th>
                        <th scope="col"  class="text-end">Advanced Amount</th>
                        <th scope="col"  class="text-end">Advanced Paid</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                        @php
                            $totalPaid = 0;
                            $totalReceive = 0;
                        @endphp
                    @forelse($users as $user)
                        @php
                            $totalPaid += abs($user->total_advanced_paid);
                            $totalReceive += $user->total_advanced_receive;
                        @endphp
                        <tr>
                            <th scope="row">{{ $users->firstItem() + $loop->index }}.</th>
                                <td>{{$user->name}}</td>
                                <td>{{$user->phone}}</td>
                                <td>{{$user->email}}</td>
                                <td  class="text-end" >{{number_format(abs($user->total_advanced_paid),2)}}</td>
                                <td  class="text-end">{{number_format($user->total_advanced_receive,2)}}</td>
                                <td class="text-end print-none">

                                    @can('user.show')
                                        <a href="{{ route('advanced-salary.show', $user->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
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
                        <tr class="fw-bold">
                            <td colspan="4" class="text-end">Total</td>
                            <td  class="text-end">{{ number_format($totalPaid, 2) }}</td>
                            <td  class="text-end">{{ number_format($totalReceive, 2) }}</td>
                            <td class="text-end print-none"></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>

    <!-- End main-bar  -->
      <!-- Start pagination -->
        <x-pagination :items="$users" />
    <!-- End pagination -->

</x-app-layout>
