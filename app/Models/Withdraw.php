<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\MorphTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Withdraw extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'date',
        'amount',
        'transactionable_type',
        'transactionable_id',
        'cash_id',
        'bank_account_id',
        'user_id',
        'note'
    ];

    protected $casts = [
        'date' => 'date',
    ];


    /* ==== Local Scope Start ==== */

    /**
     * Add payment type formatted column
     *
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddPaymentMethod(Builder $query): Builder
    {
        return $query->selectSub("IF(
            withdraws.transactionable_type = 'App\\\Models\\\Cash',
            'cash',
            IF(
                withdraws.transactionable_type = 'App\\\Models\\\BankAccount',
                'bank_account',
                'unknown'
            )
        )", 'payment_method');
    }

    /* ==== Local Scope End==== */

    /* ==== Relationship Start ==== */

    /**
     * Get associated cost subcategory
     *
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get transaction
     *
     * @return MorphTo
     */
    public function transactionable(): MorphTo
    {
        return $this->morphTo();
    }

    /* ==== Relationship End ==== */
}
