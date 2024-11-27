<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Contracts\Database\Eloquent\Builder;

class ProductionDetails extends Model
{
    use HasFactory;
    protected $fillable = [
        'production_id',
        'date',
        'product_id',
        'purchase_price',
        'quantity',
        'quantity_in_unit',
        'production_type',
    ];
    protected $casts = ['quantity_in_unit' => 'array'];

    /**
     * get production data
     * @return BelongsTo
     */
    public function production(): BelongsTo
    {
        return $this->belongsTo(Production::class);
    }

    /**
     * get product details
     * @return BelongsTo
     */
    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    /*=== scope start ===*/
    public function scopeAddProductName(Builder $query)
    {
        return $query->addSelect([
            'product_name' => Product::select('name')
                ->whereColumn('products.id', 'production_details.product_id')
                ->limit(1),
        ]);
    }
    /*=== scope end ===*/
}
