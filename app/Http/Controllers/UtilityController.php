<?php

namespace App\Http\Controllers;

use App\Models\Bank;
use App\Models\BankAccount;
use App\Models\Branch;
use App\Models\Cash;
use App\Models\Party;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UtilityController extends Controller
{
    /**
     * get all branch
     *
     */
    public function getAllBranches()
    {
        return response(Branch::where('active', 1)->get(), 200);
    }
    /**
     * get user branch
     *
     */
    public function getBranchIdFromUser()
    {
        return response()->json(Auth::user()->branch_id, 200);
    }
    /**
     * get admin rule
     *
     */
    public function getAdminRule()
    {
        // Retrieve the currently authenticated user
        $user = Auth::user();

        if ($user) {
            // Check if the user has the role of "Administrator"
            $isAdmin = collect($user->roles)->contains('name', 'Administrator');

            return response(['isAdmin' => $isAdmin], 200);
        } else {
            // If no user is authenticated, consider isAdmin as false
            return response(['isAdmin' => false], 200);
        }
    }
    /**
     * get all branch
     *
     */
    public function getAllProducts()
    {
        return response(Product::with('branches', 'stock')->where('status', 1)
            ->addUnitLabel()
            ->addUnitRelation()
            ->addDamageQuantity()
            ->orderBy('name')
            ->get(), 200);
    }

    /**
     * get all Suppliers
     *
     */
    public function getAllSuppliers()
    {
        return response(Party::supplier()->where('active', 1)->get(), 200);
    }

    /**
     * get all Suppliers
     *
     */
    public function getAllCustomers()
    {
        return response(Party::customer()->where('active', 1)->get(), 200);
    }

    /**
     * get all Suppliers
     *
     */
    public function getAllBanks()
    {
        return response(Bank::with('bankAccounts')->get(), 200);
    }
    /**
     * get all Suppliers
     *
     */
    public function getAllBankAccounts()
    {
        return response(BankAccount::all(), 200);
    }
    /**
     * get all Cashes
     *
     */
    public function getAllCashes()
    {
        return response(Cash::where('active', 1)->get(), 200);
    }
}
