@section('title', 'Update Salary')

<x-app-layout>
    <!-- Start main-bar -->

    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
            @include('pos.payroll.salary.menu')
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
            <h5>Update Salary</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>
        <div class="widget-body" id="root">
             <!-- Vue Component-->
            <div id="vueRoot">
                <salary
                    :users="{{ $users ?? " "}}"
                    :month="{{ json_encode($month) }}"
                    :old-salary="{{ $oldSalary ?? " "}}"
                />
            </div>
        </div>

    </div>
    <!-- End body widget-->
</x-app-layout>