<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphTo;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletes;

class IncomeRecord extends Model
{
    use HasFactory,SoftDeletes;

    protected $fillable = [
        'income_sector_id',
        'user_id',
        'branch_id',
        'cash_id',
        'bank_account_id',
        'date',
        'amount',
        'income_by',
        'note',
    ];
    protected $casts = [
        'date' => 'date',
    ];

    /**
     * Add payment type formatted column
     *
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddPaymentMethod(Builder $query): Builder
    {
        return $query->selectSub("IF(
            income_records.transactionable_type = 'App\\\Models\\\Cash',
            'cash',
            IF(
                income_records.transactionable_type = 'App\\\Models\\\BankAccount',
                'bank_account',
                'unknown'
            )
        )", 'payment_method');
    }

    /**
     * get income sector details
     * @return BelongsTo
     */
    public function incomeSector(): BelongsTo
    {
        return $this->belongsTo(IncomeSector::class);
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
     * Get associated cost subcategory
     *
     * @return BelongsTo
     */
    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
    }
}
