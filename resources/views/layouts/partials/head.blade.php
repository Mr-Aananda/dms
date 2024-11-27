<head>
    <!-- Title -->
    <title>@yield('title') | {{ config('app.name') }}</title>

    <meta charset="UTF-8">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="base-url" content="{{ url('/') }}">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Favicon -->
    <link rel="shortcut icon" href="{{ Vite::asset('resources/template/assets/icons/khurak.svg')}}" type="image/x-icon">
    <!-- Bootstrap icon CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Main Style -->

    @vite(['resources/js/app.js'])

    @stack('style')
</head>
