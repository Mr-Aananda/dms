@section('title', 'Custom SMS')

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
                        <h4 class="main-title">Custom SMS Send</h4>
                        <p><small>About {{ isset($datas) ? count($datas) : 0 }} results found.</small></p>
                    </div>
                </div>

                <div class="mt-2">
                    <p class="mb-2 fw-bold text-muted"> 1. Type Mobile Number and Use Comma to separate more than one Number.</p>
                    <p class="mb-2 fw-bold text-muted"> 2. You can select template SMS (optional).</p>
                    <p class="mb-2 fw-bold text-muted"> 3. Type Message and then click Send button to Send SMS.</p>
                </div>
            </div>
            <div class="widget-body">
                <form action="{{ route('sms.custom-sms') }}" method="POST">
                    @csrf
                    <div class="col-md-12 mb-3">
                        <label for="phone" class="mt-1 form-label required">Mobile Number</label>
                            <textarea name="phones" class="form-control" id="phone" rows="3"
                                placeholder="Use comma to separate number" required>{{ old('phones') }}</textarea>

                            <!-- error -->
                            @error('phones')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                            @enderror
                    </div>
                    <!-- Write number End-->

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
                    <div class="col-md-12">
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

        <!-- Javascript -->
        @include('layouts.partials.sms')

</x-app-layout>
