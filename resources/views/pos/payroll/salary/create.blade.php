@section('title', 'Create Salary')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start menu -->
        @include('pos.payroll.salary.menu')
        <!-- End menu -->

            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right buttons -->
        </div>
    </div>
    <!-- End header widget -->
    <!-- Start body widget -->
    <div class="row">
        <div class="col-md-12">
            <div class="widget">
                <div class="widget-body">
                   <!-- Vue Component-->
                    <div id="vueRoot">
                        <salary
                            :users="{{ json_encode($users) }}"
                            :user-id="{{ json_encode($user_id)}}"
                            :month="{{ json_encode($month) }}"
                        />
                    </div>


                </div>
            </div>
        </div>

    </div>
    <!-- End body widget -->
    <!-- End main-bar -->
</x-app-layout>
