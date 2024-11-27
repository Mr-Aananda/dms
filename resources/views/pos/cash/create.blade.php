@section('title', 'Create Cash')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
        @include('pos.cash.menu')
        <!-- End left menu -->
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
                    <form action="{{ route('cash.store') }}" method="POST">
                        @csrf
                        <div class="row g-3 mb-2">
                            <div class="col-md-4">
                                <x-form.label name="Name" for="name" required/>
                                <x-form.input type="text" id="name" name="name" placeholder="Enter cash name" required autofocus/>
                            </div>
                            <div class="col-md-4">
                                <x-form.label name="Balance" for="balance"/>
                                <x-form.input type="number" id="balance" name="balance" placeholder="0.00" step="any"/>
                            </div>
                            <div class="col-md-4">
                                <x-form.label name="Select Branch" for="branch" required/>
                                <x-form.select
                                    name="branch_id"
                                    id="branch"
                                    :options="$branches"
                                    option_name="name"
                                     selected_option="{{ auth()->user()->branch_id ? auth()->user()->branch_id : $branches[0]->id }}"
                                    required
                                />
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
                                <x-form.save name="Add Cash"/>
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
