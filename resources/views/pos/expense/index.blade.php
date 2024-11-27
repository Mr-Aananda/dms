@section('title', 'Expenses')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start  menu -->
            @include('pos.expense.menu')
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
            <form action="{{ route('expense.index') }}" method="get">
                <input type="hidden" name="search" value="1">
                <div class="row py-3 g-3">
                    <div class="col-md-2">
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
                    <div class="col-md-2">
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

                    <div class="col-md-3">
                        <label for="category_id">Categories</label><br>
                        <select name="category_id" id="category_id" style="width: 100%" class="search-select-2">
                            <option value="">Select category</option>
                            @foreach ($categories as $category)
                                <option value="{{ $category->id }}"
                                    {{ request('category_id') == $category->id ? 'selected' : '' }}>{{ $category->name }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label for="branch_id">Branches</label><br>
                        <select name="branch_id" id="branch_id" style="width: 100%" class="search-select-2">
                            <option value="">Select branch</option>
                            @foreach ($branches as $branch)
                                <option value="{{ $branch->id }}"
                                    {{ request('branch_id') == $branch->id ? 'selected' : '' }}>{{ $branch->name }}</option>
                            @endforeach
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

        <!-- Start print header  -->
        <x-print.header />
        <!-- End print header -->


        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Expenses</h5>
                <p><small>{{ count($expenses) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th scope="col">sl</th>
                            <th scope="col">Date</th>
                            <th scope="col">Branch</th>
                            <th scope="col">Category</th>
                            <th scope="col">Subcategory</th>
                            <th scope="col" class="text-end">Expense</th>
                            <th scope="col" class="text-end print-none">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @php
                            $totalAmount = 0;
                        @endphp
                        @forelse($expenses as $expense)
                            @php
                                $totalAmount += $expense->amount;
                            @endphp
                            <tr>
                                <th scope="row">{{ $expenses->firstItem() + $loop->index }}</th>
                                <td>{{$expense->date->format('d M ,Y')}}</td>
                                <td>{{$expense->branch?->name}}</td>
                                <td>{{$expense->expenseCategory?->name}}</td>
                                <td>{{$expense->expenseSubcategory?->name}}</td>
                                <td class="text-end">{{$expense->amount}}</td>

                                <td class="text-end print-none">
                                    @can('expense.show')
                                        <a href="{{ route('expense.show', $expense->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    @endcan

                                    @can('expense.edit')
                                        <a href="{{ route('expense.edit', $expense->id) }}" class="btn sm btn-warning"
                                            title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                    @endcan

                                    @can('expense.destroy')
                                        <form action="{{ route('expense.destroy', $expense->id) }}" method="POST"
                                            class="d-inline" onsubmit="return confirm('Are you sure want to delete?')">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" title="Delete"
                                                {{ $expense->details_count > 0 ? 'disabled' : '' }}
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
                            <td colspan="5" class="text-end">Total Expenses : </td>
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
        <x-pagination :items="$expenses" />
    <!-- End pagination -->
    <!-- End main-bar-->
    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#branch_id').select2({
                    allowClear: true,
                    placeholder: "Select One",
                    width: 'resolve'
                });
            });
            }, 1000);
            setTimeout(() => {
                $(document).ready(function() {
                $('#category_id').select2({
                    allowClear: true,
                    placeholder: "Select One",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush
</x-app-layout>
