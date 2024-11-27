@section('title', 'Customers')

<x-app-layout>
    <!-- Start main-bar-->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
            @include('pos.party.customer.menu')
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
            <form action="{{ route('customer.index') }}" method="get">
                <div class="row py-3 g-3">

                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-4">
                        <label for="party_id">Customers</label><br>
                        <select name="party_id" id="party_id" style="width: 100%" class="search-select-2">
                            <option value="">Select a customer</option>
                            @foreach ($customers as $customer)
                                <option value="{{ $customer->id }}"
                                    {{ request('party_id') == $customer->id ? 'selected' : '' }}>{{ $customer->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="phone" class="form-label">Phone</label>

                        <input class="form-control" list="customerList" name="phone" id="phone"
                               placeholder="Enter mobile no" value="{{ request()->phone }}">
                    </div>
                    <div class="col-md-3">
                        <x-form.label name="Status"/>
                        <select id="active" class="form-select" name="active">
                            <option selected disabled>Select Status</option>
                            <option value="1" {{ request()->active == '1' ? 'selected' : '' }}>
                                Active
                            </option>
                            <option value="0" {{ request()->active == '0' ? 'selected' : '' }}>
                                Inactive
                            </option>
                        </select>
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
                <h5>All Customers</h5>
                <p><small>{{ count($customers) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Party name</th>
                        <th scope="col">Phone</th>
                        <th scope="col" class="text-end">Balance</th>
                        <th scope="col">Balance status</th>
                        <th scope="col">Status</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    @forelse($customers as $customer)
                        <tr>
                            <th scope="row">{{ $customers->firstItem() + $loop->index }}</th>
                            <td>{{ $customer->name }}</td>
                            <td>{{ $customer->phone }}</td>
                            <td class="text-end">{{ number_format(abs($customer->balance), 2)}}</td>
                            <td class="{{ $customer->balance >= 0 ? 'text-success fw-bold' : 'text-danger fw-bold'}}">
                                {{ $customer->balance >= 0 ? "Receivable" : "Payable" }}
                            </td>
                            <td class="text-center">
                                    <span
                                        class="badge {{ $customer->active == '1'
                                                ? 'bg-success'
                                                : 'bg-danger'
                                                }}">
                                        {{ $customer->active== '1' ? 'Active' : 'Inactive' }}
                                    </span>
                                </td>
                            <td class="text-end print-none">

                                @can('customer.show')
                                    <a href="{{ route('customer.show', $customer->id) }}" class="btn btn-primary sm">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                @endcan

                                @can('customer.edit')
                                    <a href="{{ route('customer.edit', $customer->id) }}"
                                        class="btn sm btn-warning" title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                @endcan

                                @can('customer.destroy')
                                    <form action="{{ route('customer.destroy', $customer->id) }}" method="POST"
                                            class="d-inline"
                                            onsubmit="return confirm('Are you sure want to delete?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" title="Delete"
                                                {{ $customer->sales_count > 0 ? 'disabled' : '' }} class="btn sm btn-danger">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                @endcan
                            </td>
                        </tr>
                        @empty
                            <tr>
                                <td colspan="10" class="text-center">No data found</td>
                            </tr>
                        @endforelse

                        <tr>
                            <td colspan="3" class="text-end">Total</td>
                            <td class="text-end">{{ Number_format(abs($totalBalance),2) }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>

    <!-- End main-bar  -->
      <!-- Start pagination -->
        <x-pagination :items="$customers" />
    <!-- End pagination -->
    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#party_id').select2({
                    allowClear: true,
                    placeholder: "Select a customer",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush

</x-app-layout>
