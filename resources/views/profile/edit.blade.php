@section('title', 'Edit Profile')

<x-app-layout>
    <!-- Start main-bar ================================================ -->

    <!-- Start body widget =================================== -->
    <div class="widget mb-5">

        <div class="widget-head mb-3">
            <h5>Update Profile</h5>
            <p><small>Must fill star (<span class="text-danger fw-bold">*</span>) pointed boxes</small></p>
        </div>

        <div class="widget-body" id="root">
            <form action="{{ route('user.update', $user->id) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PATCH')

                        <div class="row g-3 mb-2">
                            <div class="col-md-12">
                                <x-form.label name="Name" for="name" required/>
                                <x-form.input type="text" id="name" name="name" value="{{ old('name') ?? $user->name }}" placeholder="Enter user name" required/>
                            </div>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Phone" for="phone" required/>
                                <x-form.input type="number" id="phone" name="phone" value="{{ old('phone') ?? $user->phone }}" placeholder="Enter user mobile no" required/>
                            </div>

                            <div class="col-md-6">
                                <x-form.label name="Email" for="email" required/>
                                <x-form.input type="email" id="email" name="email" value="{{ old('email') ?? $user->email }}" placeholder="user@gmail.com" required/>
                            </div>

                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <x-form.label name="Password"/>
                                <x-form.input type="password" name="password" placeholder="********"/>
                            </div>
                            <div class="col-md-6">
                                <x-form.label name="Retype Password"/>
                                <x-form.input type="password" name="password_confirmation" placeholder="********"/>
                            </div>
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <x-form.label name="User Roles" required/>
                                <select id="roles" class="form-select @error('role') is-invalid @enderror"
                                        name="role"
                                        required>
                                    <option selected disabled>Select User Roles</option>
                                    @foreach($roles as $role)
                                        <option
                                            value="{{$role->name}}" {{ old('role', $user->roles?->first()?->name) == $role?->name ? 'selected':'' }}>{{$role->name}}</option>
                                    @endforeach
                                </select>
                                @error('role')
                                <span class="invalid-feedback" role="alert">
                                    <strong class="text-danger">{{ $message }}</strong>
                                </span>
                                @enderror
                            </div>

                            <div class="col-md-6">
                                <x-form.label name="Status" required/>
                                <select id="status" class="form-select" name="active">
                                    <option selected disabled>Select Status</option>
                                    <option
                                        value="1" {{ $user->active == '1' ? 'selected' : '' }}>
                                        Active
                                    </option>
                                    <option
                                        value="0" {{ $user->active == '0' ? 'selected' : '' }}>
                                        Inactive
                                    </option>

                                </select>
                            </div>
                        </div>


                <div class="text-end">
                    <x-form.reset/>
                    <x-form.save name="Update Profile"/>
                </div>
            </form>
        </div>

    </div>
    <!-- End body widget =================================== -->
</x-app-layout>