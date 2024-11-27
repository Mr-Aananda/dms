@section('title', 'Barcode')

<x-app-layout>
    <!-- Start main-bar ================================================ -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right buttons -->
        </div>
    </div>

    <div class="widget">
        @if($sale)
            <div class="widget-body" id="print-widget">
                <div class="row">
                    @foreach($sale['details'] as $index => $detail)
                        @for($i = 0; $i < $detail['quantity']; $i++)
                            <div class="barcode-wrap mt-2 mx-2" id="delete-{{ $index }}-{{ $i }}">
                                <div onclick="removeSingleBarcode({{ $index }}, {{ $i }})" style="cursor: pointer" class="text-danger print-none">
                                    <i class="bi bi-file-x"></i>
                                </div>

                                <div class="text-center">
                                    <span class="fw-bold" style="line-height: 0; font-size: 10px;">Khurak Food</span><br>
                                    <p style="font-size: 10px;">{{ $detail['product']['name'] }}</p>
                                    <span>{{ $detail['wholesale_price'] }} TK</span> <br>
                                    <img class="100%"
                                         src="data:image/png;base64,{{ DNS1D::getBarcodePNG(($detail['product']['barcode']), 'C128', 1, 33) }}"
                                         alt="barcode">
                                    <small
                                            class="d-block fw-bold mt-1"
                                            style="font-size: smaller"
                                    >
                                        {{ $detail['product']['barcode'] }}
                                    </small>
                                    @if($detail['product']['expired_date'])
                                        <small
                                                class="d-block fw-bold"
                                                style="font-size: smaller"
                                        >
                                            ---------------
                                            <p>MFG:{{ \Carbon\Carbon::parse($detail['created_at'])->format('d-m-Y')  }}</p>
                                            <p>EXP:{{ \Carbon\Carbon::parse($detail['product']['expired_date'])->format('d-m-Y') }}</p>
                                        </small>
                                    @endif
                                </div>
                            </div>
                        @endfor
                    @endforeach
                </div>
            </div>

            <div class="text-center my-3">
                <button class="btn btn-primary" type="button" onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                    Print
                </button>
            </div>
        @endif
    </div>
    <!-- End main-bar ================================================ -->

    @push('script')
        <script>
            function removeSingleBarcode(index, i) {
                let divId = `delete-${index}-${i}`;

                // Select the div element by its ID
                let divToRemove = document.getElementById(divId);

                // Check if the div element exists
                if (divToRemove) {
                    // Remove the div element from the DOM
                    divToRemove.remove();
                } else {
                    console.log("Div element with ID " + divId + " not found.");
                }
            }
        </script>
    @endpush
</x-app-layout>
