<?php

namespace App\Models;

use Illuminate\Contracts\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;


class ProductTransferDetails extends Model
{
    use HasFactory;
    protected $fillable = [
        'product_transfer_id',
        'product_id',
        'quantity',
        'purchase_price',
        'quantity_in_unit',
    ];
    protected $casts = [
        'quantity_in_unit' => 'array'
    ];

    /**
     * @return BelongsTo
     */
    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }

    /**
     * get product transfer data
     * @return BelongsTo
     */
    public function productTransfer(): BelongsTo
    {
        return $this->belongsTo(ProductTransfer::class);
    }

    /*=== scope start ===*/
    public function scopeAddProductName(Builder $query)
    {
        return $query->addSelect([
            'product_name' => Product::select('name')
                ->whereColumn('products.id', 'product_transfer_details.product_id')
                ->limit(1),
        ]);
    }
    /*=== scope end ===*/
}
