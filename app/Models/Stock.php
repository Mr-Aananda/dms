<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Stock extends Model
{
    use HasFactory;
    protected $fillable = [
        'product_id',
        'branch_id',
        'quantity',
        'damage_quantity',
        'divisor_number',
        'purchase_price',
    ];

    /**
     * Get the total SMS count across all records.
     */
    public function getTotalSendSmsCountAttribute()
    {
        return Sms::sum('total_sms');
    }

    /*=== Relationship Start ===*/
    /**
     * Get associated parent
     *
     * @return BelongsTo
     */
    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }

    /*=== Relationship End ===*/
}
