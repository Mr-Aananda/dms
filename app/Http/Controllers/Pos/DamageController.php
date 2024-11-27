<?php

namespace App\Http\Controllers\Pos;

use App\Http\Controllers\Controller;
use App\Http\Requests\DamageRequest;
use App\Models\Branch;
use App\Models\Damage;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Exception;
use Illuminate\Support\Facades\DB;

class DamageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $damages = Damage::query();

        if (request()->search) {
            // set date
            $date = [];
            if (request()->from_date != null) {
                $date[] = date(request()->from_date);

                if (request()->to_date != null) {
                    $date[] = date(request()->to_date);
                } else {
                    if (request()->from_date != null) {
                        $date[] = date('Y-m-d');
                    }
                }
                if (count($date) > 0) {
                    $damages = $damages->whereBetween('date', $date);
                }
            }
        }

        if (\request('damage_no')) {
            $damages = $damages->where('damage_no', \request('damage_no'));
        }

        if (\request('branch_id')) {
            $damages = $damages->where('branch_id', \request('branch_id'));
        }

        $damages = $damages
            ->latest()
            ->paginate(30)->withQueryString();

        $total_damage = $damages->sum('grand_total');
        $branches = Branch::select('id', 'name')->where('active', 1)->get();

        return view('pos.damage.index', compact('damages', 'total_damage', 'branches'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pos.damage.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(DamageRequest $request)
    {
        $damage_data = $request->validated();
        $damage_data['user_id'] = Auth::user()->id;
        $damage_data['damage_no'] = 'Damage' . '-' . str_pad(Damage::max('id') + 1, 8, '0', STR_PAD_LEFT);

        DB::beginTransaction();
        try {
            // create new damage
            $damage = Damage::create($damage_data);

            $this->saveDamageDetails($request, $damage);

            DB::commit();
            return response()->json($damage, 200);
        } catch (Exception $exception) {
            DB::rollback();
            // return response()->json($exception, 500);
            return response()->json(['error' => $exception->getMessage()], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $damage = Damage::with(['details' => function($query){
            $query->addProductName()
            ->with(['product' => function ($query){
                $query->select('id', 'name', 'divisor_number', 'barcode', 'unit_id', 'purchase_price', 'wholesale_price', 'sale_price')
                    ->addCategoryName()
                    ->addBrandName()
                    ->addUnitName()
                    ->addUnitLabel()
                    ->addUnitRelation();
            }]);
        }])->findOrFail($id);

        return view('pos.damage.show', compact('damage'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $damage = Damage::with('details.product')->findOrFail($id);
        $damage['formatted_date'] = $damage->date->format('Y-m-d');
        return view('pos.damage.edit', compact('damage'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(DamageRequest $request, string $id)
    {
        $damage_data = $request->validated();

        DB::beginTransaction();
        try {
            $damage = Damage::findOrFail($id);

            $this->updateOldDamageDetails($damage);

            $damage->update($damage_data);

            $this->saveDamageDetails($request, $damage);


            DB::commit();
            return response()->json($damage, 200);
        } catch (Exception $exception) {
            DB::rollback();
            // return response()->json($exception, 500);
            return response()->json(['error' => $exception->getMessage()], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        Damage::findOrFail($id)->delete();

        return redirect()->route('damage.index')->withSuccess('Damage delete successfully!');
    }


    /**
     * Display a listing of the trashes.
     */
    public function trash()
    {
        $damages = Damage::latest()->onlyTrashed()
            ->paginate(30)
            ->withQueryString();

        return view('pos.damage.trash', compact('damages'));
    }

    /**
     * restore deleted member
     * @param $id
     * @return mixed
     */
    public function restore($id)
    {
        // restore by id
        Damage::withTrashed()->find($id)->restore();

        // view
        return redirect()->back()->withSuccess('Damage restore successfully.');
    }

    /**
     * permanently deleted data
     * @param $id
     * @return mixed
     */
    public function permanentDelete($id): mixed
    {
        $damage = Damage::withTrashed()->findOrFail($id);

        $this->updateOldDamageDetails($damage);

        $damage->forceDelete();

        return redirect()->back()->withSuccess('Damage deleted permanently.');
    }

    /**
     * save damage details product
     * @param $products
     * @param $damage
     * @return void
     */
    public function saveDamageDetails($request, $damage)
    {
        $products = json_decode($request->input('products'), true);
        foreach ($products as $product) {
            $_product = Product::findOrFail($product['id']);
            $damage_data = [
                'date' => $damage->date,
                'product_id' => $product['id'],
                // 'branch_id' => $damage->branch_id,
                'quantity' => $product['quantity'],
                'quantity_in_unit' => $product['quantity_in_unit'],
                'purchase_price' => $product['purchase_price'],
            ];
            // create sale details
            $damage->details()->create($damage_data);

            $previousStock = $_product->branches
                ->where('id', $request->branch_id)
                ->where('stock.purchase_price', $product['purchase_price'])
                ->first();

            $previousStock->stock->increment('damage_quantity', $product['quantity']);

            $previousStock->stock->decrement('quantity', $product['quantity']);
        }
    }

    /**
     *
     * @param $oldDamage
     * @return void
     */
    public function updateOldDamageDetails($oldDamage)
    {
        if (count($oldDamage->details) > 0) {
            foreach ($oldDamage->details as $detail) {

                $product = Product::findOrFail($detail->product_id);

                $previousStock = $product->branches
                        ->where('id', $oldDamage->branch_id)
                        ->where('stock.purchase_price', $detail->purchase_price)
                        ->first();

                if ($previousStock) {
                    // increment damage quantity from branch
                    $previousStock->stock->decrement('damage_quantity', $detail->quantity);
                    // decrement quantity from warehouse
                    $previousStock->stock->increment('quantity', $detail->quantity);
                } else { // no previous warehouse exists
                    //add new stock in for products
                    $product->branches()->attach([
                        $oldDamage->branch_id =>  [
                            'quantity' => $detail->quantity,
                            'damage_quantity' => (-1 * $detail->quantity),
                            'purchase_price' => $detail->purchase_price,
                            'divisor_number' => $product->divisor_number,
                            'created_at' => now(),
                            'updated_at' => now()
                        ]
                    ]);
                }

                $detail->delete();
            }
        }
    }
}
