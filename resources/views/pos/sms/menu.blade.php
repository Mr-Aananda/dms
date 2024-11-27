<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='sms.custom-sms' ? 'active' : '' }}" href="{{ route('sms.custom-sms') }}">
                <i class="bi bi-chat-right"></i>
                <span>Custom SMS</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='sms.group-sms' ? 'active' : '' }}" href="{{ route('sms.group-sms') }}">
                <i class="bi bi-chat-right"></i>
                <span>Group SMS</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='sms.report' ? 'active' : '' }}" href="{{ route('sms.report') }}">
                <i class="bi bi-chat-right"></i>
                <span>SMS Report</span>
            </a>
        </li>
    </ul>
</nav>
