@section('title', 'Salaries')

<x-app-layout>
    <!-- Start main-bar-->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
            @include('pos.payroll.salary.menu')
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
            <form action="{{ route('salary.index') }}" method="get">
                <div class="row py-3 g-3">

                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-4">
                            <label for="month" class="form-label">Select Month</label>
                            <input type="month" name="salary_month" class="form-control"
                                placeholder="Enter month" value="{{ request('salary_month') }}" required>
                    </div>
                    <div class="col-md-1">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"><i class="bi bi-search"></i>
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
                <h5>All Salaries</h5>
                <p><small>{{ count($users) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Month</th>
                        <th scope="col" class="text-center">Salary</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    @forelse($users as $user)
                        <tr>
                            <th scope="row">{{ $users->firstItem() + $loop->index }}.</th>
                                <td>{{$user->name}}</td>
                                <td>{{$user->email}}</td>
                                <td>{{ $month }}</td>
                                <td class="text-center">
                                    <span class="{{ $user->salaries->count() > 0 ? 'badge bg-success' : 'badge bg-danger' }}">
                                        {{ $user->salaries->count() > 0 ? 'Paid' : 'Unpaid' }}
                                    </span>
                                </td>

                                <td class="text-end print-none">
                                    @if ($user->salaries->count() > 0)
                                        @can('salary.show')
                                            <a href="{{ route('salary.show', $user->salaries[0]->id) }}" class="btn btn-primary sm">
                                                <i class="bi bi-eye-fill"></i>
                                            </a>
                                        @endcan

                                        @can('salary.edit')
                                            <a href="{{ route('salary.edit', $user->salaries[0]->id) }}" class="btn sm btn-warning"
                                                title="Edit">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                        @endcan

                                        @can('salary.destroy')
                                            <form action="{{ route('salary.destroy', $user->salaries[0]->id) }}" method="POST"
                                                class="d-inline" onsubmit="return confirm('Are you sure want to delete?')">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" title="Delete"
                                                    class="btn sm btn-danger">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        @endcan

                                    @else

                                        @can('salary.create')
                                            <a href="{{ route('salary.create', ['id' => $user->id, 'month' => $month]) }}" class="btn btn-primary sm">
                                                <i class="bi bi-plus-circle"></i>
                                            </a>
                                        @endcan

                                    @endif

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
      <!-- Start pagination -->
        <x-pagination :items="$users" />
    <!-- End pagination -->

</x-app-layout>
