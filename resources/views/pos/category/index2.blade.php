@section('title', 'Categories')

<x-app-layout>

    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start  menu -->
        @include('pos.category.menu')
            <!-- End  menu -->
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
                {{-- <button type="button" class="btn icon lg rounded" disabled=""
                    title="Delete all selected items">
                    <i class="bi bi-trash"></i>
                </button> --}}
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
            <form action="{{ route('category.index') }}" method="get">
                <div class="row py-3 g-3">

                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-2">
                        <label for="category" class="form-label">Category name</label>

                        <input class="form-control" list="categoryList" name="name" id="category"
                               placeholder="Type a category name" value="{{ request()->name }}">

                    </div>

                    <div class="col-md-1">
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

            <!-- Start print header =========================== -->
            <x-print.header/>
            <!-- End print header =========================== -->

                <div class="nasted-list">
                <div class="widget">
                    <div class="widget-body">
                        <h4 class="mb-3">Nested list</h4>
                        <ul>
                            <li>
                                <div class="d-flex align-items-center border p-2 rounded my-1">
                                    <span>
                                        <img src="https://admin.famicart.com/storage/18/foods.svg" alt="" style="width: 30px;" class="me-2">
                                    </span>
                                    <span>Lorem ipsum dolor sit,</span>
                                    <span class="ms-auto badge bg-success me-4">active</span>
                                    <span class="text-end">
                                        <a href="#" class="btn btn-warning sm">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <button class="btn btn-danger sm" href="#" onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-4').submit() } return false ">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </span>
                                </div>
                                <ul class="sub-nasted">
                                    <li>
                                        <div class="d-flex align-items-center border p-2 rounded my-1">
                                            <span>Lorem ipsum dolor sit,</span>
                                            <span class="ms-auto badge bg-success me-4">active</span>
                                            <span class="text-end">
                                                <a href="#" class="btn btn-warning sm">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <button class="btn btn-danger sm" href="#" onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-4').submit() } return false ">
                                                    <i class="bi bi-trash-fill"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="d-flex align-items-center border p-2 rounded my-1">
                                            <span>Lorem ipsum dolor sit,</span>
                                            <span class="ms-auto badge bg-success me-4">active</span>
                                            <span class="text-end">
                                                <a href="#" class="btn btn-warning sm">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <button class="btn btn-danger sm" href="#" onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-4').submit() } return false ">
                                                    <i class="bi bi-trash-fill"></i>
                                                </button>
                                            </span>
                                        </div>
                                        <ul class="sub-nasted">
                                            <li>
                                                <div class="d-flex align-items-center border p-2 rounded my-1">
                                                    <span>Lorem ipsum dolor sit,</span>
                                                    <span class="ms-auto badge bg-success me-4">active</span>
                                                    <span class="text-end">
                                                        <a href="#" class="btn btn-warning sm">
                                                            <i class="bi bi-pencil-square"></i>
                                                        </a>
                                                        <button class="btn btn-danger sm" href="#" onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-4').submit() } return false ">
                                                            <i class="bi bi-trash-fill"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="d-flex align-items-center border p-2 rounded my-1">
                                                    <span>Lorem ipsum dolor sit,</span>
                                                    <span class="ms-auto badge bg-success me-4">active</span>
                                                    <span class="text-end">
                                                        <a href="#" class="btn btn-warning sm">
                                                            <i class="bi bi-pencil-square"></i>
                                                        </a>
                                                        <button class="btn btn-danger sm" href="#" onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-4').submit() } return false ">
                                                            <i class="bi bi-trash-fill"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </li>
                                        </ul>
                                    </li>


                                </ul>
                            </li>
                            <li>
                                <div class="d-flex align-items-center border p-2 rounded my-1">
                                    <span>
                                        <img src="https://admin.famicart.com/storage/18/foods.svg" alt="" style="width: 30px;" class="me-2">
                                    </span>
                                    <span>Lorem ipsum dolor sit,</span>
                                    <span class="ms-auto badge bg-success me-4">active</span>
                                    <span class="text-end">
                                        <a href="#" class="btn btn-warning sm">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <button class="btn btn-danger sm" href="#" onclick="if(confirm('Are you sure want to delete?')) { document.getElementById('sm-delete-4').submit() } return false ">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

    </div>
    <!-- End main-bar-->
</x-app-layout>
