<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PurchaseCost extends Model
{
    use HasFactory;
    protected $fillable = [
        'purchase_id',
        'labour_cost',
        'labour_cost_adjust_to_supplier',
        'transport_cost',
        'transport_cost_adjust_to_supplier',
    ];

    /**
     * return purchase details
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function purchase()
    {
        return $this->belongsTo(Purchase::class);
    }
}
