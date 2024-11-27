@section('title', 'Update unit')

<x-app-layout>
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start left menu -->
            @include('pos.unit.menu')
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
    <div class="widget">
        <div class="widget-head mb-3">
            <h5>Update unit</h5>
            <p><small> update unit from here... </small></p>
        </div>
        <div class="widget-body">
           <div id="vueRoot">
                <form action="{{ route('unit.update', $unit->id) }}" method="POST">
                    @csrf
                    @method('PATCH')
                    <unit :unit="{{ $unit }}"/>
                </form>
           </div>
        </div>
    </div>
    <!-- End body widget -->
</x-app-layout>
