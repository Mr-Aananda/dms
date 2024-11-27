<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class DueManage extends Model
{
    use HasFactory,SoftDeletes;
    protected $guarded = [];

    protected $casts = [
        'date' => 'date',
    ];

    /**
     * Supplier type
     */
    const TYPE_SUPPLIER = 'supplier';
    /**
     * Customer type
     */
    const TYPE_CUSTOMER = 'customer';

    /**
     * customer
     * @param Builder $query
     * @return Builder
     */
    public function scopeCustomer(Builder $query): Builder
    {
        return $query->whereType(self::TYPE_CUSTOMER);
    }

    /**
     * supplier
     * @param Builder $query
     * @return Builder
     */
    public function scopeSupplier(Builder $query): Builder
    {
        return $query->whereType(self::TYPE_SUPPLIER);
    }

    /**
     * get party details
     * @return BelongsTo
     */
    public function party(): BelongsTo
    {
        return $this->belongsTo(Party::class);
    }

    /**
     * get cash details
     * @return BelongsTo
     */
    public function cash(): BelongsTo
    {
        return $this->belongsTo(Cash::class);
    }

    /**
     * @return BelongsTo
     * get bank account details
     */
    public function bankAccount(): BelongsTo
    {
        return $this->belongsTo(BankAccount::class);
    }
}
