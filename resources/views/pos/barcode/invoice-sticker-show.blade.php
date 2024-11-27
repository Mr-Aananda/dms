@section('title', 'Sticker')

<x-app-layout>
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
        </div>
    </div>

    <div id="print-widget">
        <div class="widget">
            <div class="widget-head mb-3 print-none">
                <h3>Stickers</h3>
                <p><small id="sticker-info">About <strong>0</strong> stickers found.</small></p> <!-- Bold the count number -->
            </div>
            <div class="widget-body d-flex flex-wrap">
                @foreach ($sale['details'] as $details)
                    @for ($i = 0; $i < $details['quantity']; $i++)
                        <div class="sticker border border-dark py-1 m-1 text-center position-relative">
                            <div onclick="removeSticker(this)" class="delete-btn text-danger position-absolute top-0 end-0 p-1 print-none" style="cursor: pointer; background: white; border-radius: 50%;">
                                <i class="bi bi-trash"></i>
                            </div>
                            <h5>Imported By</h5>
                            <p class="px-1">{{ $details['product']['importer_name'] }}</p>
                            <div class="border border-dark mb-2"></div>
                            <small class="text-dark px-1">{{ $details['product_name'] }}</small>
                            <h4 class="text-dark px-1">MRP: {{ $details['wholesale_price'] }} Tk</h4>
                        </div>
                    @endfor
                @endforeach
            </div>
            <div class="text-center my-3">
                <button class="btn btn-primary btn-lg print-none" type="button" onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                    Print
                </button>
            </div>
        </div>
    </div>

    @push('script')
        <script>
            function removeSticker(element) {
                // Get the parent sticker element
                const stickerElement = element.closest('.sticker');
                // Remove the sticker element
                stickerElement.remove();
                // Update the sticker count
                updateStickerCount();
            }

            function updateStickerCount() {
                // Count all the stickers
                const stickerCount = document.querySelectorAll('.sticker').length;
                // Update the sticker info text to show the count in bold
                document.getElementById('sticker-info').innerHTML = `About <strong>${stickerCount}</strong> stickers found.`;
            }

            // Initial count update
            document.addEventListener('DOMContentLoaded', updateStickerCount);
        </script>
    @endpush
</x-app-layout>
