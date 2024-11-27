<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
@include('layouts.partials.head')

    <body>

        <!-- Start navigation  -->
        @include('layouts.partials.navbar')
        <!-- End navigation  -->

        <!-- start aside-bar -->
        @include('layouts.partials.aside')
        <!-- end aside-bar -->

        <!-- Start offcanvas  -->
        {{-- @include('layouts.partials.offcanvas') --}}
        <!-- End offcanvas  -->

        <main
            class="main-bar
            {{
                Route::currentRouteName() == 'sale.create'
                || Route::currentRouteName() == 'sale.edit'
                || Route::currentRouteName() == 'sale-return.create'
                || Route::currentRouteName() == 'sale-return.edit'
                || Route::currentRouteName() == 'purchase.create'
                || Route::currentRouteName() == 'purchase.edit'
                || Route::currentRouteName() == 'purchase-return.create'
                || Route::currentRouteName() == 'purchase-return.edit'
                || Route::currentRouteName() == 'production.create'
                || Route::currentRouteName() == 'production.edit'
                ? 'main-bar-expand' : ''
            }}"

            id="main-bar">

            <div class="container-fluid">
                {{-- show error or success message --}}
                <x-alert />

                {{-- main body start--}}
                {{ $slot }}

            </div>
        </main>

        <!-- Javascript -->
        @include('layouts.partials.script')

        <!-- Custom Scripts -->
        @stack('script')

    </body>
</html>
