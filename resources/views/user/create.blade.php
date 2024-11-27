@section('title', 'Create user')
<x-app-layout>
    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
        <!-- Start left menu -->
        @include('user.menu')
        <!-- End left menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right buttons -->
        </div>
    </div>
    <!-- End header widget -->
    <!-- Start body widget -->
    <div class="row">
        <div class="col-md-12">
            <div class="widget">
                <div class="widget-body">
                    <form action="{{ route('user.store') }}" method="POST">
                        @csrf
                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Name" for="name" required/>
                                <x-form.input type="text" id="name" name="name" placeholder="Enter user name" required autofocus/>
                            </div>

                            <div class="col-md-6">
                                <x-form.label name="Branch" required/>
                                <select id="branch" class="form-select @error('branch_id') is-invalid @enderror" name="branch_id" required>
                                    <option selected disabled> - Choose one -</option>
                                    @foreach($branches as $branch)
                                        <option
                                            value="{{$branch->id}}" {{ old('branch_id') == $branch->id || $loop->first ? 'selected' : '' }}>{{$branch->name}}</option>
                                    @endforeach
                                </select>
                                @error('branch_id')
                                <span class="invalid-feedback" role="alert">
                                    <strong class="text-danger">{{ $message }}</strong>
                                </span>
                                @enderror
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Phone" for="phone" required/>
                                <x-form.input type="number" id="phone" name="phone" placeholder="Enter user mobile no" required/>
                            </div>

                            <div class="col-md-6">
                                <x-form.label name="Email" for="email" required/>
                                <x-form.input type="email" id="email" name="email" placeholder="user@gmail.com" required/>
                            </div>

                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Password" required/>
                                <x-form.input type="password" name="password" placeholder="********" required/>
                            </div>
                            <div class="col-md-6">
                                <x-form.label name="Retype Password" required/>
                                <x-form.input type="password" name="password_confirmation" placeholder="********" required/>
                            </div>
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-md-12">
                                <x-form.label name="User Roles" required/>
                                <select id="roles" class="form-select @error('role') is-invalid @enderror"
                                        name="role"
                                        required>
                                    <option selected disabled> -Select User Roles- </option>
                                    @foreach($roles as $role)
                                        <option
                                            value="{{$role->name}}" {{ old('role') == $role->name  ? 'selected' : ''}}>{{$role->name}}</option>
                                    @endforeach
                                </select>
                                @error('role')
                                <span class="invalid-feedback" role="alert">
                                    <strong class="text-danger">{{ $message }}</strong>
                                </span>
                                @enderror
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-12 text-end">
                                <x-form.reset/>
                                <x-form.save name="Add User"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
    <!-- End body widget -->
    <!-- End main-bar -->
</x-app-layout>
