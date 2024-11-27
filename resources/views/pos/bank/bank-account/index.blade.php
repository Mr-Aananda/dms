@section('title', 'Banks')

<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.bank.bank-account.menu')
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
            <form action="{{ route('bank-account.index') }}" method="get">
                <div class="row py-3 g-3">

                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-3">
                        <label for="bank" class="form-label">Account name</label>

                        <input class="form-control" list="accountList" name="account_name" id="account-name"
                               placeholder="Type a account name" value="{{ request()->account_name }}">
                    </div>
                    <div class="col-md-3">
                        <label for="bank" class="form-label">Account number</label>

                        <input class="form-control" list="accountList" name="account_number" id="bank"
                               placeholder="Type a account number" value="{{ request()->account_number }}">
                    </div>
                    <div class="col-md-4">
                        <label for="bank_id">Banks</label><br>
                        <select name="bank_id" id="bank_id" style="width: 100%" class="search-select-2">
                            <option value="">Select a bank</option>
                            @foreach ($banks as $bank)
                                <option value="{{ $bank->id }}"
                                    {{ request('bank_id') == $bank->id ? 'selected' : '' }}>{{ $bank->name }}</option>
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
            <!-- Start print header -->
            <x-print.header/>
            <!-- End print header -->
        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Accounts</h5>
                <p><small>{{ count($accounts) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Bank name</th>
                        <th scope="col">Holder Name</th>
                        <th scope="col">Account Number</th>
                        <th scope="col">Branch</th>
                        <th scope="col">Balance</th>
                        <th scope="col">Description</th>
                        <th scope="col" class="text-end print-none">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    @forelse($accounts as $account)
                        <tr>
                            <th scope="row">{{ $accounts->firstItem() + $loop->index }}</th>
                            <td>{{$account->bank->name}}</td>
                            <td>{{$account->account_name}}</td>
                            <td>{{$account->account_number}}</td>
                            <td>{{$account->branch}}</td>
                            <td>{{$account->balance}}</td>
                            <td>{{$account->description }}</td>
                            <td class="text-end print-none">
                                @can('bank-account.edit')
                                    <a href="{{ route('bank-account.edit', $account->id) }}"
                                        class="btn sm btn-primary" title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                @endcan

                                @can('bank-account.destroy')
                                    <form action="{{ route('bank-account.destroy', $account->id) }}" method="POST"
                                            class="d-inline"
                                            onsubmit="return confirm('Are you sure want to delete?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" title="Delete"
                                                {{ $account->transaction_count > 0 ? 'disabled' : '' }} class="btn sm btn-danger">
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
    <!-- End main-bar-->
    <!-- Start pagination -->
        <x-pagination :items="$accounts" />
    <!-- End pagination -->
        @push('script')
        <script>
            setTimeout(() => {
                $(document).ready(function() {
                $('#bank_id').select2({
                    allowClear: true,
                    placeholder: "Select Bank",
                    width: 'resolve'
                });
            });
            }, 1000);
        </script>
    @endpush
</x-app-layout>
