<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\MorphTo;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;

class LoanInstallment extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'user_id',
        'loan_id',
        'date',
        'amount',
        'adjustment',
        'note',
        'transactionable_type',
        'transactionable_id',
    ];

    protected $casts = [
        'date' => 'date',
    ];


    /* ==== Mutator Start ==== */

    public function setAdjustmentAttribute($value)
    {
        $this->attributes['adjustment'] = $value ?? 0;
    }

    /* ==== Mutator End ==== */

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
                    loan_installments.transactionable_type = 'App\\\Models\\\Cash',
                    'cash',
                    IF(
                        loan_installments.transactionable_type = 'App\\\Models\\\BankAccount',
                        'bank_account',
                        'unknown'
                    )
                )", 'payment_method');
    }

    /* ==== Local Scope End ==== */

    /* ==== Relationship Start ==== */

    /**
     * Get associated loan
     *
     * @return BelongsTo
     */
    public function loan(): BelongsTo
    {
        return $this->belongsTo(Loan::class);
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
     * get product user details
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /* ==== Relationship End ==== */
}
