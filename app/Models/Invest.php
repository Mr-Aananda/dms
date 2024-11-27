<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\MorphTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Invest extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'user_id',
        'investor_id',
        'branch_id',
        'date',
        'amount',
        'profit',
        'profit_type',
        'note',
        'transactionable_type',
        'transactionable_id',
        'status',
        'isAutomatic',
        'profit_addition_date',
    ];

    protected $casts = [
        'date' => 'date',
    ];
    protected $dates = [
        'profit_addition_date',
    ];

    /* ==== Local Scope Start ==== */

    /**
     * Add loan account name
     *
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddInvestorName(Builder $query): Builder
    {
        return $query->addSelect([
            'investor_name' => Investor::select('name')
                ->whereColumn('investor_id', 'investors.id')
                ->limit(1)
        ]);
    }

    /**
     * Add payment type formatted column
     *
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddPaymentMethod(Builder $query): Builder
    {
        return $query->selectSub("IF(
            invests.transactionable_type = 'App\\\Models\\\Cash',
            'cash',
            IF(
                invests.transactionable_type = 'App\\\Models\\\BankAccount',
                'bank_account',
                'unknown'
            )
        )", 'payment_method');
    }

    /* ==== Local Scope End ==== */

    /* ==== Relationship Start ==== */

    /**
     * Get associated investor
     *
     * @return BelongsTo
     */
    public function investor(): BelongsTo
    {
        return $this->belongsTo(Investor::class);
    }

    /**
     * Get related invest withdraw
     *
     * @return HasMany
     */
    public function investWithdraws(): HasMany
    {
        return $this->hasMany(InvestWithdraw::class);
    }

    /**
     * Get associated branch
     *
     * @return BelongsTo
     */
    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
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

    // Accessor for profit_addition_date to handle null values
    public function getProfitAdditionDateAttribute($value)
    {
        return $value ? Carbon::parse($value) : null;
    }
}
