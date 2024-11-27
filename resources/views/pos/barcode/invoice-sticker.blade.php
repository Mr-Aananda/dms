@section('title', 'Invoice Sticker')

<x-app-layout>
    <!-- Start main-bar ================================================ -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            @include('pos.barcode.menu')

            <!-- Start right buttons -->
            <div class="ms-auto">
                <a class="btn icon lg rounded" title="Reload" href="{{ route('invoice-sticker') }}">
                    <i class="bi bi-bootstrap-reboot"></i>
                </a>

                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right buttons -->
        </div>
    </div>

    <div class="widget">
        <div class="widget-head mb-4">
            <h4 class="border-bottom mb-3 pb-1">Invoice Sticker Generator</h4>
            <form method="GET">
                <div class="row my-3">
                    <div class="col-12">
                        <label for="name" class="form-label required">Invoice Number</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-boxes"></i></span>
                            <input type="text" class="form-control" value="{{ request('invoice_no') }}" name="invoice_no" id="invoice_no" placeholder="Ex: IV-0000001" >
                        </div>
                    </div>

                    <div class="col-12 mt-2 text-end">
                        <button class="btn btn-success" type="submit"> <i class="bi bi-eye "> </i> Search Invoice</button>
                    </div>
                </div>
            </form>
        </div>

       <div id="vueRoot">
           <sticker-invoice-component :sale='@json($sale)'/>
       </div>
    </div>
    <!-- End main-bar ================================================ -->
</x-app-layout>
