<?php

namespace App\Http\Controllers;

use App\Http\Requests\UserRequest;
use App\Models\Branch;
use App\Models\User;
use App\Services\PermissionService\PermissionService;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    private $user;
    private $data;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user_query = User::query();
        //search
        if (\request()->name) {
            $user_query->where('name', 'LIKE', '%' . request()->name . '%');
        }
        if (\request()->phone) {
            $user_query->where('phone', 'LIKE', '%' . request()->phone . '%');
        }
        if (\request()->status == '1' || \request()->status == '0') {
            //            return 'ol';
            $user_query->where('active', request()->status);
        }

        $users = $user_query->latest()->paginate(30)->withQueryString();

        $this->data['total_user'] = count(User::all());
        $this->data['total_active_user'] = count(User::where('active', '1')->get());
        $this->data['total_inactive_user'] = count(User::where('active', '0')->get());

        return view('user.index', compact('users'))->with($this->data);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $roles = Role::all();
        $branches = Branch::all();
        return view('user.create', compact('roles', 'branches'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(UserRequest $request)
    {
        $request->validated();
        DB::transaction(function () use ($request) {
            $user_data = $this->getUserData($request);
            $user = User::create($user_data);
            if ($request->role) {
                $user->assignRole($request->role);
            }
            $this->user = $user;
        });

        if ($this->user) {
            return redirect()->back()->withSuccess('User create successfully');
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id, PermissionService $permissionService)
    {
        $data = [];
        $data['user'] = User::query()
            ->with('roles:id,name')
            ->findOrFail($id);
        $data['assigned_permission_area_groups'] = $permissionService->availablePermissionAreaGroupsByUser($data['user']);
        $data['assigned_partial_permission_groups'] = $permissionService->availablePartialPermissionGroupsByUser($data['user']);
        return view('user.show')->with($data);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $user = User::findOrFail($id);
        $roles = Role::all();
        $branches = Branch::all();

        return view('user.edit', compact('user', 'roles', 'branches'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UserRequest $request, string $id)
    {
        $request->validated();
        DB::transaction(function () use ($request, $id) {
            $user = User::findOrFail($id);
            $user_data = $this->getUserData($request, 'update');

            $user->update($user_data);

            if ($request->role) {
                $user->assignRole($request->role);
            }
            $this->user = $user;
        });
        if ($this->user) {
            return redirect()->route('user.index')->withSuccess('User updated successfully');
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        DB::transaction(function () use ($id) {
            $user = User::find($id);
            $user->delete();
        });
        return redirect()->back()->withSuccess('User deleted Successfully.');
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
            'phone' => $request->phone,
            'email' => $request->email,
            'branch_id' => $request->branch_id,
            'active' => '1',
            'email_verified_at' => now(),
        ];



        $create_date = [
            'password' => Hash::make($request->password),
        ];
        if ($from === 'update') {
            if ($request->password != Null) {
                $primary_data['password'] = Hash::make($request->password);
            }
            $primary_data['active'] = $request->active;
            return $primary_data;
        } else {
            return array_merge($primary_data, $create_date);
        }
    }
}
