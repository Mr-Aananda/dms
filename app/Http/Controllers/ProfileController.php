<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileUpdateRequest;
use App\Models\User;
use Illuminate\Http\RedirectResponse;
use App\Services\PermissionService\PermissionService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redirect;
use Illuminate\View\View;
use Spatie\Permission\Models\Role;

class ProfileController extends Controller
{
    protected $user;
    /**
     * Display the user's profile form.
     */
    public function show(string $id, PermissionService $permissionService)
    {
        $data = [];

        $data['user'] = User::query()
            ->with('roles:id,name')
            ->findOrFail($id);

        $data['assigned_permission_area_groups'] = $permissionService->availablePermissionAreaGroupsByUser($data['user']);

        $data['assigned_partial_permission_groups'] = $permissionService->availablePartialPermissionGroupsByUser($data['user']);
        return view('profile.show')->with($data);
    }

    /**
     * Display the user's profile form.
     */
    public function edit(string $id)
    {
        $user = User::with('userDetails', 'address')->findOrFail($id);
        $roles = Role::all();

        return view('profile.edit', compact('user', 'roles'));
    }

    /**
     * Update the user's profile information.
     */
    public function update(ProfileUpdateRequest $request, string $id)
    {
        $request->validated();
        DB::transaction(function () use ($request, $id) {
            $user = User::findOrFail($id);
            $user_data = $this->getUserData($request, 'update');

            $user->update($user_data);

            $this->user = $user;
        });
        if ($this->user) {
            return redirect()->route('profile.show', $id)->withSuccess('Profile updated successfully');
        }
    }

    /**
     * Delete the user's account.
     */
    public function destroy(Request $request): RedirectResponse
    {
        $request->validateWithBag('userDeletion', [
            'password' => ['required', 'current_password'],
        ]);

        $user = $request->user();

        Auth::logout();

        $user->delete();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return Redirect::to('/');
    }

    /**
     * get member data
     * @param $request
     * @return array
     */
    public function getUserData($request, $from = 'create'): array
    {
        $primary_data = [
            'name' => $request->name,
            'phone' => $request->phone_one,
            'email' => $request->email,
        ];
        if ($request->password != null) {
            $primary_data['password'] = Hash::make($request->password);
        }

        return $primary_data;
    }
}
