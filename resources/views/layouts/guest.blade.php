<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
@include('layouts.partials.head')

    <body>

        {{ $slot }}

        <!-- Javascript -->
        {{-- <script src="{{Vite::asset("resources/template/js/form.js")}}"></script> --}}
        @include('layouts.partials.script')

        <!-- Custom Scripts -->
        @stack('script')
    </body>
</html>
