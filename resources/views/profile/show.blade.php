@section('title', 'Profile details')

<x-app-layout>
    <!-- Start main-bar ================================================ -->

    <div class="row g-3">

        <div class="col-lg-3">
            <div class="widget">
                <div class="widget-head border-bottom pb-3 text-center mb-2">
                    <button type="button" class="btn icon lg rounded" title="Print Product Details"
                            onclick="printable('print-widget')">
                        <i class="bi bi-printer"></i>
                    </button>
                    <a href="{{ route('user.edit', $user->id) }}" type="button" class="btn icon lg rounded"
                       title="Edit">
                        <i class="bi bi-pencil-square"></i>
                    </a>
                </div>

                <div class="text-center">
                    <img src="https://ui-avatars.com/api/?name={{ $user->name }}&background=random&size=300"
                        class="rounded" alt="{{ $user->name }}">
                </div>
            </div>
        </div>

        <div class="col-lg-9">
            <div class="widget" id="print-widget">

                <!-- Start print header =========================== -->
                <x-print.header/>
                <!-- End print header =========================== -->

                <!-- Start body ===================== -->
                <div class="widget-body mt-3">
                    <h5 class="mt-3 mb-2">Profile Details</h5>
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <td>Name</td>
                            <td>{{ $user->name }}</td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td>{{ $user->email }}</td>
                        </tr>
                        <tr>
                            <td>Phone</td>
                            <td>{{ $user->phone }}, {{ $user->userDetails?->phone }}</td>
                        </tr>
                        </tbody>
                    </table>


                    <h5 class="mt-3 mb-2">Roles and Permissions</h5>
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <td>User role</td>
                            <td>{{ $user->roles->first()->name ?? '' }}</td>
                        </tr>

                        </tbody>
                    </table>
                </div>
                <!-- End body ===================== -->
                <div class="col-12 mt-3">
{{--                    <h5 class="text-center text-decoration-underline mb-3">Permissions</h5>--}}
                    @unless(in_array(\Database\Seeders\RoleSeeder::ADMINISTRATOR_RULE_NAME, $user->getRoleNames()->toArray()))

                        <div class="p-2">

                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>permission areas</th>
                                    <th>Item</th>
                                </tr>
                                </thead>
                                <tbody>
                                @forelse($assigned_permission_area_groups as $group => $permission_areas)
                                    <tr class="">
                                        <td class="w-25">{{ ucwords($group) }}</td>
                                        <td class="">
                                            @forelse($permission_areas as $permission_area)
                                                <span class="p-2 m-1 btn text-bg-info">{{ $permission_area['key'] }}</span>
                                            @empty
                                                <span class="">No permission.
                                                    </span>
                                            @endforelse
                                        </td>
                                    </tr>
                                @empty
                                @endforelse
                                </tbody>
                            </table>
                        </div>
                    @else
                        <p class="text-center">All permissions. </p>
                    @endunless
                </div>

                <div class="mt-2">
                    <p class="text-center fs-5 text-decoration-underline">Partial Permissions</p>

                    @unless(in_array(\Database\Seeders\RoleSeeder::ADMINISTRATOR_RULE_NAME, $user->getRoleNames()->toArray()))

                        <div
                            class="row row-cols-1 g-4 @if (count($assigned_partial_permission_groups)) row-cols-md-4 @endif">
                            @forelse($assigned_partial_permission_groups as $group => $partial_permissions)
                                <div class="col">
                                    <div class="card">
                                        <div class="card-header text-center">{{ ucfirst($group) }}</div>
                                        <div class="card-body px-0">
                                            <ul class="list-group list-group-flush">
                                                @forelse($partial_permissions as $partial_permission)
                                                    <li class="list-group-item">
                                                        <label class="form-check-label"
                                                               for="{{ $partial_permission['name'] }}">
                                                            {{ \Illuminate\Support\Str::of($partial_permission['name'])->replace('_', ' ')->replace('-', ' ')->ucfirst() }}
                                                        </label>
                                                        @isset($partial_permission['description'])
                                                            <div class="form-text">
                                                                {{ $partial_permission['description'] }}
                                                            </div>
                                                        @endisset
                                                    </li>
                                                @empty
                                                    <li class="list-group-item text-center">No permission.
                                                    </li>
                                                @endforelse
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            @empty
                                <div class="col text-center">
                                    <p>No Permission.</p>
                                </div>
                            @endforelse
                        </div>
                    @else
                        <p class="text-center">All permissions. </p>
                    @endunless
                </div>

            </div>
        </div>
    </div>


    <!-- Start offcanvas ================ -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="addPayment" aria-labelledby="addPaymentLabel">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="addPaymentLabel">Add Payment</h5>
            <button type="button" class="btn icon" data-bs-dismiss="offcanvas">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
        <div class="offcanvas-body">
            <form action="#">
                <div class="row gy-3">
                    <div class="col-12">
                        <label for="date" class="form-label required">Payment date</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-calendar-week"></i></span>
                            <input type="date" class="form-control" required name="#" id="date">
                        </div>
                    </div>
                    <div class="col-12">
                        <label for="bank" class="form-label required">Transection Account</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-bank"></i></span>
                            <select class="form-select" name="#" required id="bank">
                                <option selected>Open this select menu</option>
                                <option value="1">Amanat</option>
                                <option value="2">Bkash</option>
                                <option value="3">Nagad</option>
                                <option value="4">DBBL</option>
                                <option value="5">Cash</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-12">
                        <label for="amount" class="form-label required">Amount</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-coin"></i></span>
                            <input type="number" class="form-control" required placeholder="0.00"
                                   name="#" id="amount">
                        </div>
                    </div>
                    <div class="col-12 text-end">
                        <button class="btn btn-success" type="submit"><i class="bi bi-credit-card"></i> Add
                            Payment
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- End offcanvas ================ -->

    <!-- End main-bar ================================================ -->

</x-app-layout>
