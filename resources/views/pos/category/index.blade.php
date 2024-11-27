@section('title', 'Categories')

<x-app-layout>
    <!-- Start main-bar -->
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
                    <div class="col-md-4">
                        <label for="category" class="form-label">Category name</label>

                        <input class="form-control" list="categoryList" name="name" id="category"
                               placeholder="Type a category name" value="{{ request()->name }}">
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
            <x-print.header/>
            <!-- End print header -->


        <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <h5>All Categories</h5>
                <p><small>{{ count($categories) }} results found </small></p>
            </div>
            <div class="widget-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">sl</th>
                        <th scope="col">Category name</th>
                        <th scope="col">Parent category</th>
                        <th scope="col">Description</th>
                        <th scope="col">Status</th>
                        <th scope="col" class="text-end">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    @forelse($categories as $category)
                        <tr>
                            <th scope="row">{{ $categories->firstItem() + $loop->index }}</th>
                            <td>{{ $category->name }}</td>
                            <td>{{ $category->parentCategory?->name }}</td>
                            <td>{{ $category->description }}</td>
                            <td class="text-center">
                                <span
                                    class="badge {{ $category->active == '1'
                                            ? 'bg-success'
                                            : 'bg-danger'
                                            }}">
                                    {{ $category->active== '1' ? 'Active' : 'Inactive' }}
                                </span>
                            </td>
                            <td class="text-end">

                                @can('category.edit')
                                    <a href="{{ route('category.edit', $category->id) }}"
                                        class="btn sm btn-primary" title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                @endcan

                                @can('category.destroy')
                                    <form action="{{ route('category.destroy', $category->id) }}" method="POST"
                                            class="d-inline"
                                            onsubmit="return confirm('Are you sure want to delete?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" title="Delete"
                                                {{ $category->categories_count> 0 ? 'disabled' : '' }} class="btn sm btn-danger">
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
    <!-- Start pagination -->
    <x-pagination :items="$categories" />
    <!-- End pagination -->
    <!-- End main-bar-->
</x-app-layout>
