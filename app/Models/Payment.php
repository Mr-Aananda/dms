<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class Payment extends Model
{
    use HasFactory;
    protected $guarded = [];

    protected $casts = [
        'date' => 'date',
    ];

    /**
     * Get the parent commentable model (post or video).
     */
    public function paymentable(): MorphTo
    {
        return $this->morphTo();
    }

    /*=== relationship start ===*/
    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     * get cash details
     */
    public function cash()
    {
        return $this->belongsTo(Cash::class);
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     * get bank account details
     */
    public function bankAccount()
    {
        return $this->belongsTo(BankAccount::class);
    }
    /*=== relationship end ===*/

    /*=== scope start ===*/
    public function scopeAddPaymentMethod(Builder $query): Builder
    {
        return $query->addSelect([
            'cash_name' => Cash::select('name')
                ->whereColumn('cashes.id', 'payments.cash_id'),

            'bank_name' => BankAccount::select('account_name')
                ->whereColumn('bank_accounts.id', 'payments.bank_account_id')
        ]);
    }

    public function scopeAddPaymentBy(Builder $query): Builder
    {
        return $query->addSelect([
            'user_name' => User::select('name')
                ->whereColumn('users.id', 'payments.user_id'),
        ]);
    }
    /*=== scope end ===*/
}
