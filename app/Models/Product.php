<?php

namespace App\Models;

use App\Helpers\Converter;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use HasFactory,SoftDeletes;

    protected $fillable = [
        'name',
        'product_type',
        'barcode',
        'unit_id',
        'category_id',
        'subcategory_id',
        'brand_id',
        'branch_id',
        'user_id',
        'price_type',
        'purchase_price',
        'sale_price',
        'wholesale_price',
        'stock_alert',
        'divisor_number',
        'quantity_in_unit',
        'status',
        'description'
    ];

    protected $casts = ['quantity_in_unit' => 'array'];

    protected $appends = [
        'total_product_quantity_in_unit',
        'expired_date'
    ];

    /*=== accessor end ===*/

    /*=== relation start ===*/
    /**
     * Get Showroom with quantity
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function branches()
    {
        return $this->belongsToMany(Branch::class, 'stocks')
            ->withPivot(
                'id',
                'quantity',
                'purchase_price',
                'branch_id',
                'divisor_number',
            )
            ->as('stock');
    }

    /**
     * @return HasMany Stock
     */
    public function stock()
    {
        return $this->hasMany(Stock::class);
    }

    /**
     * get product category details
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
    /**
     * get product user details
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * return product brand details
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function brand()
    {
        return $this->belongsTo(Brand::class);
    }

    /**
     * @return BelongTo Stock
     */
    public function unit()
    {
        return $this->belongsTo(Unit::class);
    }

    /**
     * Get related subcategories
     *
     * @return HasMany
     */
    public function details(): HasMany
    {
        return $this->hasMany(Detail::class);
    }
    /**
     * Get related subcategories
     *
     * @return HasMany
     */
    public function productionDetails(): HasMany
    {
        return $this->hasMany(ProductionDetails::class);
    }
    /*=== relation end ===*/

    /*=== scope start ===*/

    /**
     * add total product quantity
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddTotalProductQuantity(Builder $query): Builder
    {
        return $query->select('products.*')
            ->selectRaw('(SELECT SUM(quantity) FROM stocks WHERE stocks.product_id = products.id) AS total_product_quantity');
    }

    /**
     * add product unit labels
     * @param Builder $query
     * @return Builder
     */
    // public function scopeAddProductUnitLabels(Builder $query): Builder
    // {

    // }

    /**
     * add total product quantity branch wise
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddTotalProductQuantityBranchWise(Builder $query): Builder
    {
        $branch_id = request()->branch_id;
        if ($branch_id) {
            return $query->addSelect([
                'total_product_quantity_branch_wise' => Stock::selectRaw("IF (ISNULL(SUM(quantity)), 0, SUM(quantity))")
                ->where('branch_id', $branch_id)
                    ->whereColumn('product_id', 'products.id')
            ]);
        } else {
            return $query->addSelect([
                'total_quantity' => Stock::selectRaw("IF (ISNULL(SUM(quantity)), 0, SUM(quantity))")
                ->whereColumn('product_id', 'products.id')
            ]);
        }
    }


    /**
     * add product category name
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddCategoryName(Builder $query): Builder
    {
        return $query->addSelect([
            'category_name' => Category::select('name')
                ->whereColumn('products.category_id', '=', 'categories.id')
        ]);
    }

    /**
     * add product category name
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddSubCategoryName(Builder $query): Builder
    {
        return $query->addSelect([
            'subcategory_name' => Category::select('name')
                ->whereColumn('products.subcategory_id', '=', 'categories.id')
        ]);
    }

    /**
     * add product brand name
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddBrandName(Builder $query): Builder
    {
        return $query->addSelect([
            'brand_name' => Brand::select('name')
                ->whereColumn('products.brand_id', '=', 'brands.id')
        ]);
    }

    /**
     * add product brand name
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddUnitName(Builder $query): Builder
    {
        return $query->addSelect([
            'unit_name' => Unit::selectRaw('CONCAT(units.name, " (", units.description, ")")')
            ->whereColumn('products.unit_id', '=', 'units.id')
        ]);
    }


    /**
     * get product unit label
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddUnitLabel(Builder $query): Builder
    {
        return $query->addSelect([
            'unit_label' => Unit::select('label')
                ->whereColumn('units.id', 'products.unit_id')
        ]);
    }

    /**
     * get product unit relation
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddUnitRelation(Builder $query): Builder
    {
        return $query->addSelect([
            'unit_relation' => Unit::select('relation')
                ->whereColumn('units.id', 'products.unit_id')
        ]);
    }

    /**
     * Add total quantity
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddDamageQuantity(Builder $query, $branch_id = null): Builder
    {
        $branch_id = request()->branch_id;
        if ($branch_id) {
            return $query->addSelect([
                'damage_quantity' => Stock::selectRaw("IF (ISNULL(SUM(damage_quantity)), 0, SUM(damage_quantity))")
                    ->where('branch_id', $branch_id)
                    ->whereColumn('product_id', 'products.id')
            ]);
        } else {
            return $query->addSelect([
                'damage_quantity' => Stock::selectRaw("IF (ISNULL(SUM(damage_quantity)), 0, SUM(damage_quantity))")
                    ->whereColumn('product_id', 'products.id')
            ]);
        }
    }


    /**
     * get total product quantity
     *
     * @return int|mixed
     */
    public function getTotalProductQuantityInUnitAttribute()
    {
        return Converter::convertToUpperUnit($this->total_product_quantity, $this->unit_label, $this->unit_relation);
    }

    public function getExpiredDateAttribute()
    {
        return null;
    }

    /*=== scope end ===*/
}
