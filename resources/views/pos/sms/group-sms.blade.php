@section('title', 'Group SMS')

<x-app-layout>
    <!-- Start statistics -->
    <div class="widget">
        <div class="widget-body">
            <div class="row g-4">

                <!-- Start single stats wrap ============================= -->
                <div class="col-xl-3 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon success me-3">
                            <i class="bi bi-cash"></i>
                        </div>
                        <div class="stats">
                            <p class="title-sm">SMS Balance</p>
                            <h4 class=" fw-bold text-muted">৳ {{ $sms_balance }}</h4>
                        </div>
                    </div>
                </div>
                <!-- End single stats wrap ============================= -->
                <!-- Start single stats wrap ============================= -->
                <div class="col-xl-3 col-md-6">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon success me-3">
                            <i class="bi bi-envelope"></i>
                        </div>
                        <div class="stats">
                            <p class="title-sm">Total remaining SMS</p>
                            <h4 class=" fw-bold text-muted">{{ $remaining_sms }}</h4>
                        </div>
                    </div>
                </div>
                <!-- End single stats wrap ============================= -->
            </div>
        </div>
    </div>
    <!-- End statistics -->

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.sms.menu')
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
            <form action="{{ route('sms.group-sms') }}" method="get">
                <div class="row py-3 g-3">

                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-6">
                        <label for="type">Filter by:</label>
                        <select name="type" id="type" class="form-control">
                            <option value="all" {{ $type == 'all' ? 'selected' : '' }}>All</option>
                            <option value="customer" {{ $type == 'customer' ? 'selected' : '' }}>Customers</option>
                            <option value="supplier" {{ $type == 'supplier' ? 'selected' : '' }}>Suppliers</option>
                            <option value="user" {{ $type == 'user' ? 'selected' : '' }}>Users</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="perPage" class="form-label">Records per page</label>
                        <select id="perPage" name="perPage" class="form-select" onchange="this.form.submit()">
                            <option value="25" {{ Request::get('perPage') == 25 ? 'selected' : '' }}>25</option>
                            <option value="50" {{ Request::get('perPage') == 50 ? 'selected' : '' }}>50</option>
                            <option value="100" {{ Request::get('perPage') == 100 ? 'selected' : '' }}>100</option>
                            <option value="250" {{ Request::get('perPage') == 250 ? 'selected' : '' }}>250</option>
                            <option value="all" {{ Request::get('perPage') == 'all' ? 'selected' : '' }}>All</option>
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
                <div class="d-flex align-items-center flex-wrap">
                    <div>
                        <h4 class="main-title">Group SMS Send</h4>
                        <p><small>About {{ isset($datas) ? count($datas) : 0 }} results found.</small></p>
                    </div>
                </div>

                <div class="mt-2">
                    <p class="mb-2 fw-bold text-muted"> 1. If don't want send SMS Please Uncheck.</p>
                    <p class="mb-2 fw-bold text-muted"> 2. You can select template SMS (optional).</p>
                    <p class="mb-2 fw-bold text-muted"> 3. Type Message and then click Send button to Send SMS.</p>
                </div>
            </div>
            <div class="widget-body">
                <form action="{{ route('sms.group-sms') }}" method="POST">
                    @csrf
                    <div class="mb-3 table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th scope="col" class="p-0">
                                        <label for="check-all" class="p-2 d-block">
                                            <input type="checkbox" class="me-2" id="check-all">
                                            <span>SL </span>
                                        </label>
                                    </th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Phone</th>
                                    <th scope="col">Type</th>
                                </tr>
                            </thead>

                            <tbody>
                                @forelse($datas as $index=> $data)
                                    <tr>
                                        <th scope="row" class="p-0">
                                            <label class="p-2 d-block">
                                                <input type="checkbox" name="phones[]" value="{{ $data->phone }}" class="me-2">
                                                    {{ $index + $datas->firstItem() }}.
                                            </label>
                                        </th>
                                        <td>{{ $data->name ?? '' }}</td>
                                        <td>{{ $data->phone ?? '' }}</td>
                                        <td>{{ $data->type ?? '' }}</td>
                                    </tr>
                                @empty
                                    <tr>
                                        <th colspan="3">No data available here. </th>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                    <!-- data table end -->

                    <!-- paginate -->
                    <div class="container-fluid mt-2 mb-2">
                        <nav>
                            {{ $datas->withQueryString()->links() }}
                        </nav>
                    </div>
                    <!-- pagination end -->

                    <div class="mb-3 row">
                        <!-- Template start -->
                        <div class="col-md-12">
                            <label for="template" class="mt-1 form-label">Template</label>
                            <select name="template" onchange="fillMessageFromTemplate(event)" class="form-select" id="template">
                                <option value="" selected disabled> --Select template-- </option>
                                @foreach ($templates as $template)
                                    <option value="{{ $template->description }}">{{ $template->title }}</option>
                                @endforeach
                            </select>

                            <!-- error -->
                            @error('template')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                            @enderror
                        </div>
                        <!-- Template end -->
                    </div>

                    <!-- Write Message Start-->
                    <div class="mb-3 row">
                        <div class="col-12">
                            <label for="message" class="mt-1 form-label required">Message</label>
                                <textarea name="message" class="form-control" id="message" rows="4"
                                    placeholder="Type message here.." required>{{ old('message')}}</textarea>

                                    <!-- error -->
                                    @error('message')
                                    <div class="invalid-feedback">
                                        {{ $message }}
                                    </div>
                                    @enderror
                        </div>
                    </div>
                    <!-- Write Message End-->

                    <!-- SMS & Character count start -->
                    <div class="row">
                        <div class="col-md-6">
                            <p class="text-muted">
                                <span>
                                    <strong>Total Characters</strong>
                                    <x-form.input type="text" id="total_characters" class="form-control" name="total_characters" value="25" readonly />
                                </span>
                            </p>
                        </div>

                        <div class="col-md-6">
                            <p class="text-muted">
                                <span>
                                    <strong>Total Messages</strong>
                                    <x-form.input type="text" id="total_messages" class="form-control" value="1" name="total_messages" readonly />
                                </span>
                            </p>
                        </div>
                    </div>
                    <!-- SMS & Character count end -->

                    <div class="row mt-3">
                        <div class="col-12 text-end">
                            <x-form.reset/>
                            <x-form.save name="Send SMS"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- End body widget -->
    </div>
    <!-- End main-bar-->

    @push('script')
        <!-- checked all program script -->
        <script>
            // select master & child checkboxes
            let masterCheckbox = document.getElementById("check-all"),
                childCheckbox = document.querySelectorAll('[name="phones[]"]');

            // add 'change' event into master checkbox
            masterCheckbox.addEventListener("change", function() {
                // add/remove attribute into child checkbox conditionally
                for (var i = 0; i < childCheckbox.length; i++) {
                    if(this.checked) {
                        childCheckbox[i].checked = true; // add attribute
                    } else {
                        childCheckbox[i].checked = false; // add attribute
                    }
                }
            });
        </script>
        <!-- checked all program script end -->
    @endpush

        <!-- Javascript -->
        @include('layouts.partials.sms')

</x-app-layout>
