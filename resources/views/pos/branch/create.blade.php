@section('title', 'Create Branch')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start menu -->
        @include('pos.branch.menu')
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
                    <form action="{{ route('branch.store') }}" method="POST">
                        @csrf

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Name" for="name" required/>
                                <x-form.input type="text" id="name" name="name" placeholder="Enter branch name" required autofocus/>
                            </div>
                            <div class="col-md-6">
                                <x-form.label name="location" for="location" required/>
                                <x-form.input type="text" id="location" name="location" placeholder="Enter branch location" required/>
                            </div>
                        </div>
                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Description" for="description"/>
                                <x-form.input type="textarea" id="description" name="description" placeholder="Optional"/>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12 text-end">
                                <x-form.reset/>
                                <x-form.save name="Add Branch"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
    <!-- End body widget -->
    <!-- End main-bar -->

</x-app-layout>
