@section('title', 'Income Records')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start  menu -->
            @include('pos.income-record.menu')
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
            <form action="{{ route('income-record.index') }}" method="get">
                <input type="hidden" name="search" value="1">
                <div class="row py-3 g-3">

                    <div class="col-md-5">
                        <label for="sector_id">Income Sector</label><br>
                        <select name="sector_id" id="sector_id" style="width: 100%" class="search-select-2">
                            <option value="">Select income sector</option>
                            @foreach ($incomeSectors as $sector)
                                <option value="{{ $sector->id }}"
                                    {{ request('sector_id') == $sector->id ? 'selected' : '' }}>{{ $sector->name }}</option>
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
                <h5>All Income Records</h5>
                <p><small>{{ count($incomeRecords) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th scope="col">sl</th>
                            <th scope="col">Date</th>
                            <th scope="col">Branch</th>
                            <th scope="col">Income Sector</th>
                            <th scope="col" class="text-end">Amount</th>
                            <th scope="col" class="text-end print-none">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @php
                            $totalAmount = 0;
                        @endphp
                        @forelse($incomeRecords as $record)
                            @php
                                $totalAmount += $record->amount;
                            @endphp
                            <tr>
                                <th scope="row">{{ $incomeRecords->firstItem() + $loop->index }}</th>
                                <td>{{$record->date->format('d M ,Y')}}</td>
                                <td>{{$record?->branch?->name}}</td>
                                <td>{{$record?->incomeSector?->name}}</td>
                                <td class="text-end">{{$record->amount}}</td>

                                <td class="text-end print-none">
                                    @can('income-record.show')
                                        <a href="{{ route('income-record.show', $record->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    @endcan

                                    @can('income-record.edit')
                                        <a href="{{ route('income-record.edit', $record->id) }}" class="btn sm btn-warning"
                                            title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                    @endcan

                                    @can('income-record.destroy')
                                        <form action="{{ route('income-record.destroy', $record->id) }}" method="POST"
                                            class="d-inline" onsubmit="return confirm('Are you sure want to delete?')">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" title="Delete"
                                                {{ $record->details_count > 0 ? 'disabled' : '' }}
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
                            <td colspan="3" class="text-end">Total Amount : </td>
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
        <x-pagination :items="$incomeRecords" />
    <!-- End pagination -->
    <!-- End main-bar-->
    @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#sector_id').select2({
                    allowClear: true,
                    placeholder: "Select One",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush
</x-app-layout>
