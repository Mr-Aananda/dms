@section('title', 'Advanced Details')

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
                <p><small>{{ count($userAdvancedSalaries) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Date</th>
                        <th scope="col">Payment Source</th>
                        <th scope="col">Amount</th>
                        <th scope="col">Status</th>
                        <th scope="col">Note</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    @forelse($userAdvancedSalaries as $advance)
                        <tr>
                            <th scope="row">{{ $userAdvancedSalaries->firstItem() + $loop->index }}.</th>
                                <td>{{$advance->date->format('d F, Y')}}</td>
                                <td>{{$advance->cash_id ? 'Cash' : 'Bank'}} ({{ $advance->cash_id ? $advance->cash?->name : $advance->bankAccount?->account_name}})</td>
                                <td>{{number_format(abs($advance->amount),2)}}</td>
                                <td>{{$advance->amount > 0 ? 'Advanced Taken' : 'Advanced Given'}}</td>
                                <td>{{$advance->note}}</td>
                                <td class="text-end print-none">

                                    @can('advance.edit')
                                        <a href="{{ route('advanced-salary.edit', $advance->id) }}"
                                            class="btn sm btn-warning" title="Edit">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                    @endcan
                                    @can('advance.destroy')
                                        <form action="{{ route('advanced-salary.destroy', $advance->id) }}" method="POST"
                                                class="d-inline"
                                                onsubmit="return confirm('Are you sure want to delete?')">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" title="Delete"
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
                    </tbody>
                </table>
            </div>
        </div>
        <!-- End body widget -->
    </div>

    <!-- End main-bar  -->
      <!-- Start pagination -->
        <x-pagination :items="$userAdvancedSalaries" />
    <!-- End pagination -->

</x-app-layout>
