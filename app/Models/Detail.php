<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class Detail extends Model
{
    use HasFactory;
    protected $guarded = [];
    protected $casts = ['quantity_in_unit' => 'array' , 'date' => 'date'];

    /**
     * Get the parent commentable model (post or video).
     */
    public function detailable(): MorphTo
    {
        return $this->morphTo();
    }

    /*=== relationship start ===*/
    /**
     * get product details
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function product()
    {
        return $this->belongsTo(Product::class);
    }
    /*=== relationship end ===*/
    /**
     * get product details
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
    /*=== relationship end ===*/


    /*=== scope start ===*/
    /**
     * get product name
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddProductName(Builder $query): Builder
    {
        return $query->addSelect([
            'product_name' => Product::select('name')
                ->whereColumn('products.id', 'details.product_id')
                ->limit(1)
        ]);
    }
    /*=== scope end ===*/
}
