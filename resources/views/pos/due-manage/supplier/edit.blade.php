@section('title', 'Update Supplier Due Manage')

<x-app-layout>
    <!-- Start main-bar -->

    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
            @include('pos.due-manage.supplier.menu')
            <!-- End left menu -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
        </div>
    </div>
    <!-- End header widget -->
    <!-- Start body widget-->
    <div class="widget mb-5">
        <div class="widget-head mb-3">
            <h5>Update Supplier Due</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>
        <div class="widget-body" id="root">
             <!-- Vue Component-->
            <div id="vueRoot">
                <due-manage
                    :old-due-manage="{{ $dueManage ?? " "}}"
                    party-type = "{{ $type ?? null }}"
                />
            </div>
        </div>

    </div>
    <!-- End body widget-->
</x-app-layout>
