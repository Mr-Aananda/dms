  <!-- Start Navbar =================================== -->
<header>
    <nav class="navbar primary">
        <div class="container-fluid">
                <!-- Start Left logo area ======================================= -->
                    <x-nav-logo-component/>
                <!-- End Left logo area ======================================= -->
            <!-- Start navmenu ======================================= -->
            <ul class="navbar-nav ms-auto mb-lg-0">

                @php
                    $user=Auth::user();
                @endphp

                <!-- Service button ======================================= -->
                <li class="nav-item dropdown service">
                    <a class="nav-link" href="#" role="button" id="service-dropdown" data-bs-toggle="dropdown"
                        aria-expanded="false"><i class="bi bi-grid"></i></a>
                    <div class="dropdown-menu" aria-labelledby="service-dropdown">
                        <p class="fw-bold mb-0 px-2 border-bottom text-primary">SMS Module</p>
                        <ul>
                            <li>
                                <x-navbar-link
                                    name="SMS"
                                    route="sms.group-sms"
                                    url="group-sms"
                                    icon="bi bi-chat-right"
                                />
                            </li>
                            <li>
                                <x-navbar-link
                                    name="SMS Template"
                                    route="sms-template.index"
                                    url="sms-temaplate"
                                    icon="bi bi-chat-right-text"
                                />
                            </li>
                            <li>
                                <x-navbar-link
                                    name="Report"
                                    route="sms.report"
                                    url="sms-report"
                                    icon="bi bi-envelope"
                                />
                            </li>
                        </ul>

                        <p class="fw-bold mb-0 px-2 border-bottom text-primary">User & Role/Permission</p>
                        <ul>
                            <li>
                                <x-navbar-link
                                    name="User"
                                    route="user.index"
                                    url="user"
                                    icon="bi bi-people"
                                />
                            </li>
                            <li>
                                <x-navbar-link
                                    name="Role"
                                    route="role.index"
                                    url="role"
                                    icon="bi bi-shield-lock"
                                />
                            </li>
                        </ul>
                    </div>
                </li>

                <!-- User button ======================================= -->
                <li class="nav-item dropdown">
                    <a class="nav-link user-button" href="#" role="button" id="user-dropdown" data-bs-toggle="dropdown"
                        aria-expanded="false">
                        <img src="{{Vite::asset('resources/template/assets/images/users/user-blue.webp')}}" alt="user">
                    </a>
                    <div class="dropdown-menu" aria-labelledby="user-dropdown">
                        <ul>
                            <li>
                                <a href="{{ route('profile.show', \Illuminate\Support\Facades\Auth::user()->id) }}" class="dropdown-item double-line">
                                {{-- <img src="{{Vite::asset('resources/template/assets/images/users/user-blue.webp')}}" alt="Admin"> --}}
                                 <img src="https://ui-avatars.com/api/?name={{ $user->name }}&background=random&size=300"
                                    class="rounded" alt="{{ $user->name }}">
                                <div>
                                    <h5>{{ $user->name ?? ''}}</h5>
                                    <span>{{\Illuminate\Support\Facades\Auth::user()->roles->first()->name ?? ''}}</span>
                                    {{-- <span>Admin</span> --}}
                                </div>
                                </a>
                            </li>
                            <li>
                                <hr>
                            </li>
                            <li>
                                <a class="dropdown-item" href="{{ route('profile.show', \Illuminate\Support\Facades\Auth::user()->id) }}">
                                <i class="bi bi-person"></i>
                                    <span>Profile</span>
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="https://www.facebook.com/theutkarshoit">
                                <i class="bi bi-question-circle"></i>
                                    <span>Help &amp; Support</span>
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="{{ route('logout') }}"
                                    onclick="event.preventDefault();
                                    document.getElementById('logout-form').submit();">
                                    <i class="bi bi-box-arrow-right"></i>
                                    Logout
                                </a>
                                <form id="logout-form" class="d-none" action="{{ route('logout') }}" method="POST">
                                    @csrf
                                </form>
                            </li>
                        </ul>
                    </div>
                </li>


            </ul>
            <!-- End navmenu ======================================= -->

            <!-- Start search-bar =================================== -->
            <div class="search-bar" id="search-bar">
                <form class="h-100">
                    <input class="form-control" id="search-input" type="text" placeholder="Search">
                    <button type="button" class="close-button" onclick="shearchFunction()"><i class="bi bi-x-lg"></i></button>
                </form>
            </div>
            <!-- End search-bar =================================== -->


        </div>
    </nav>
</header>
  <!-- End Navbar =================================== -->
