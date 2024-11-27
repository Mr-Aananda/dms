@section('title', 'Login')
<x-guest-layout>
    <!-- Session Status -->
    <x-auth-session-status class="mb-4" :status="session('status')" />

    {{-- <form method="POST" action="{{ route('login') }}">
        @csrf

        <!-- Email Address -->
        <div>
            <x-input-label for="email" :value="__('Email')" />
            <x-text-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')" required autofocus autocomplete="username" />
            <x-input-error :messages="$errors->get('email')" class="mt-2" />
        </div>

        <!-- Password -->
        <div class="mt-4">
            <x-input-label for="password" :value="__('Password')" />

            <x-text-input id="password" class="block mt-1 w-full"
                            type="password"
                            name="password"
                            required autocomplete="current-password" />

            <x-input-error :messages="$errors->get('password')" class="mt-2" />
        </div>

        <!-- Remember Me -->
        <div class="block mt-4">
            <label for="remember_me" class="inline-flex items-center">
                <input id="remember_me" type="checkbox" class="rounded border-gray-300 text-indigo-600 shadow-sm focus:ring-indigo-500" name="remember">
                <span class="ml-2 text-sm text-gray-600">{{ __('Remember me') }}</span>
            </label>
        </div>

        <div class="flex items-center justify-end mt-4">
            @if (Route::has('password.request'))
                <a class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" href="{{ route('password.request') }}">
                    {{ __('Forgot your password?') }}
                </a>
            @endif

            <x-primary-button class="ml-3">
                {{ __('Log in') }}
            </x-primary-button>
        </div>
    </form> --}}

    <!-- Start authentication ================================================ -->
    <main class="authentication">
        <div class="widget">
            <div class="widget-head">
                <div class="logo">
                    <img src="{{Vite::asset('resources/template/assets/images/logo/khurak.png')}}" style="height: 70px;" alt="UTKARSHO IT">
                </div>
            </div>

            <div class="widget-body">
                <div class="text-center mb-3">
                    <h4>Sign in</h4>
                    <p>Log in to the POS system</p>
                </div>
                <form method="POST" action="#">
                    @csrf
                    <div class="row g-3">
                        <!-- Start user ID -->
                        <div class="col-12">
                            <label for="email" class="form-label required">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="email" value="{{ old('email')}}" name="email"
                                       class="form-control @error('email') is-invalid @enderror"
                                       placeholder="Ex: example@gmail.com" id="email" required>
                                @error('email')
                                <div class="invalid-feedback">
                                    {{ $message }}
                                </div>
                                @enderror
                            </div>
                        </div>
                        <!-- End user ID -->

                        <!-- Start Password -->
                        <div class="mb-12">
                            <label for="password" class="form-label required">Password</label>
                            <div class="input-group toggle-password-fill">
                                <span class="input-group-text"><i class="bi bi-unlock"></i></span>
                                <input type="password"
                                       class="form-control @error('password') is-invalid @enderror" placeholder="Password"
                                       name="password" id="password" required onkeydown="capsLock(event)">
                                <button type="button" class="pass-eye" onclick="show(event, password)"><i
                                        class="bi bi-eye-fill"></i></button>
                                @error('password')
                                <div class="invalid-feedback">
                                    {{ $message }}
                                </div>
                                @enderror
                            </div>
                            <small id="capsLockText" class="d-none text-danger">Caps lock is on</small>
                        </div>
                        <!-- End Password -->


                        <!-- Start Remember checkbox -->
                        <div class="col-12">
                            <div class="form-check">
                                <input type="checkbox" name="remember" class="form-check-input" id="remember"
                                       value="">
                                <label class="form-check-label" for="remember">Remember me</label>
                            </div>
                        </div>
                        <!-- End Remember checkbox -->

                        <!-- Start Sign in button -->
                        <div class="col-12">
                            <button class="btn btn-primary w-100" type="submit"><i class="bi bi-box-arrow-in-right"></i>
                                Sign in
                            </button>
                        </div>
                        <!-- End Sign in button -->
                    </div>

                </form>
            </div>


            <div class="widget-foot">
                <div class="text-center mt-3">
                    {{-- <p class="mb-1"><a href="auth_forgot_pass.html">I forgot my user Password</a></p>
                    <p>New to the system? <a href="auth_register.html">Sign up</a></p> --}}
                    <small class="border-top d-block mt-3 pt-2">
                        <span> © 2022 -
                            <script>
                                document.write(new Date().getFullYear())
                            </script>
                        </span>
                        <a href="https://utkorshoit.com" target="_blank">Utkorsho IT</a>.
                        <span> All rights reserved.</span>
                    </small>
                </div>

            </div>

        </div>
    </main>
    <!-- End authentication ================================================ --
</x-guest-layout>
