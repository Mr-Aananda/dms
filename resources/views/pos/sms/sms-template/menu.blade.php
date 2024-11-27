<nav class="navbar navbar-expand-lg">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='sms-template.create' ? 'active' : '' }}" href="{{ route('sms-template.create') }}">
                <i class="bi bi-chat-right"></i>
                <span>Add Template</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link {{Route::currentRouteName() =='sms-template.index' ? 'active' : '' }}" href="{{ route('sms-template.index') }}">
                <i class="bi bi-chat-right-text"></i>
                <span>All Templates</span>
            </a>
        </li>
    </ul>
</nav>
