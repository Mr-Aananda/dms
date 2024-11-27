@section('title', 'Users')

<x-app-layout>
    <!-- Start Statistics -->
    <div class="widget print-none">
        <div class="widget-body">
            <div class="row g-4">
                <!-- Start single stats wrap -->
                <div class="col-xl-3 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon me-3">
                            <i class="bi bi-people"></i>
                        </div>
                        <div class="stats">
                            <p class="title-sm">Total users</p>
                            <h4 class=" fw-bold text-muted">{{ $total_user }}</h4>
                        </div>
                    </div>
                </div>
                <!-- End single stats wrap -->
                <!-- Start single stats wrap -->
                <div class="col-xl-3 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon success me-3">
                            <i class="bi bi-person-check"></i>
                        </div>
                        <div class="stats">
                            <p class="title-sm">Total Active users</p>
                            <h4 class="fw-bold text-muted">{{ $total_active_user }}</h4>
                        </div>
                    </div>
                </div>
                <!-- End single stats wrap-->
                <!-- Start single stats wrap-->
                <div class="col-xl-3 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon warning me-3">
                            <i class="bi bi-people"></i>
                        </div>
                        <div class="stats">
                            <p class="title-sm">Total inactive users</p>
                            <h4 class=" fw-bold text-muted">{{ $total_inactive_user }}</h4>
                        </div>
                    </div>
                </div>
                <!-- End single stats wrap -->
                <!-- End single stats wrap -->
            </div>
        </div>
    </div>
    <!-- End Statistics -->
    <!-- Start header widget -->
    <div class="widget mb-3 border-top print-none">
        <div class="widget-body d-flex">
        <!-- Start menu -->
        @include('user.menu')
        <!-- End  menu -->
            <!-- Start right button -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Search" data-bs-toggle="collapse"
                        data-bs-target="#tableSearch" aria-controls="tableSearch" aria-expanded="true">
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
            <!-- End right button -->
        </div>

        <!-- Start Search body -->
        <div class="widget-body collapse {{ request()->search == '1'? 'show'  : '' }}" id="tableSearch">
            <form action="{{ route('user.index') }}">
                <div class="row py-3 g-3">

                    <input hidden name="search" value="1">
                    <div class="col-md-3">
                        <label for="account" class="form-label">User name</label>
                        <input type="text" class="form-control" value="{{ request()->name  }}" placeholder="search users" id="account"
                               list="search-user" name="name">

                    </div>

                    <div class="col-md-3">
                        <label for="phone" class="form-label"> Phone</label>
                        <input type="text" class="form-control" value="{{ request()->phone  }}" placeholder="Ex: 01xxx" name="phone"
                               id="phone">
                    </div>

                    <div class="col-md-3">
                        <label for="Status" class="form-label"> Status</label>
                        <select class="form-select" name="status" id="Status">
                            <option selected disabled value>--Choose one--</option>
                            <option value="1">Active User</option>
                            <option value="0">Inactive User</option>
                        </select>
                    </div>

                    <div class="col-md-1">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"><i
                                class="bi bi-search"></i>
                            Search
                        </button>
                    </div>
                    <div class="col-md-1">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-danger d-block w-100" type="reset">
                            <i class="bi bi-stars"></i>
                            Reset
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <!-- End Search body -->
    </div>
    <!-- End header widget -->


    <!-- Start body widget -->
    <div id="print-widget">
        <!-- Start print header -->
        <x-print.header />
        <!-- End print header -->

        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Users</h5>
                <p><small>Total Result found {{ count($users) }} </small></p>
            </div>
            <div class="widget-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th style="width: 70px;">
                                SL
                            </th>
                            <th>Name</th>
                            <th>Phone Number</th>
                            <th>Email</th>
                            <th>Branch</th>
                            <th class="text-center">Status</th>
                            <th class="text-end print-none">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        @forelse($users as $user)
                            <tr>
                                <th>
                                    {{ $users->firstItem() + $loop->index }}
                                </th>
                                <td>{{ $user->name }}</td>
                                <td>{{ $user->phone }}</td>
                                <td>{{ $user->email }}</td>
                                <td>{{ $user->branch?->name }}</td>
                                <td class="text-center">
                                    <span
                                        class="badge {{ $user->active == '1'
                                                ? 'bg-success'
                                                : 'bg-danger'
                                                }}">
                                        {{ $user->active== '1' ? 'Active' : 'Inactive' }}
                                    </span>
                                </td>
                                <td class="text-end print-none">
                                    @can('user.show')
                                        <a href="{{ route('user.show', $user->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    @endcan

                                    @can('user.edit')
                                    <a href="{{ route('user.edit', $user->id) }}" class="btn btn-warning sm">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    @endcan

                                    @can('user.destroy')
                                        <form action="{{ route('user.destroy', $user->id) }}"
                                            method="post" class="d-none"
                                            id="sm-delete-{{ $user->id }}">
                                            @csrf
                                            @method('DELETE')
                                            <button
                                                class="btn btn-danger sm" href="#"
                                                onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-{{ $user->id }}').submit() } return false ">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </form>
                                    @endcan
                                </td>
                            </tr>
                            @empty
                            <x-table.empty-data />
                        @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    < <!-- Start pagination -->
        <x-pagination :items="$users" />
    <!-- End pagination -->
    <!-- End Body widget -->
</x-app-layout>
