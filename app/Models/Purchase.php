<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Purchase extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'date',
        'voucher_no',
        'party_id',
        'branch_id',
        'cash_id',
        'bank_account_id',
        'user_id',
        'subtotal',
        'discount_type',
        'discount',
        // 'payment_type',
        'paid',
        'previous_balance',
        'note',
    ];

    protected $casts = [
        'date' => 'date',
    ];
    protected $appends = [
        'total_discount',
        'grand_total',
        'total_paid','total_due'
    ];


    /**
     * Get all of the post's comments.
     */
    public function details(): MorphMany
    {
        return $this->morphMany(Detail::class, 'detailable');
    }

    /**
     * Get all of the post's comments.
     */
    public function payments(): MorphMany
    {
        return $this->morphMany(Payment::class, 'paymentable');
    }

    /**
     * purchase cost details
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function purchaseCost()
    {
        return $this->hasOne(PurchaseCost::class);
    }

    /**
     * get business group details
     * @return BelongsTo
     */
    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
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
     * get bank account details
     * @return BelongsTo
     */
    public function bankAccount(): BelongsTo
    {
        return $this->belongsTo(BankAccount::class);
    }

    /**
     * Supplier
     * @return BelongsTo
     */
    public function party(): BelongsTo
    {
        return $this->belongsTo(Party::class);
    }

    /**
     * user
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * get purchase total discount
     * @return float|int|mixed
     */
    public function getTotalDiscountAttribute(): mixed
    {
        return $this->discount_type == 'flat' ? $this->discount : (($this->subtotal * $this->discount) / 100);
    }

    /**
     * @return mixed|string
     */
    public function getGrandTotalAttribute()
    {
        return ($this->subtotal + $this->purchaseCost?->labour_cost + $this->purchaseCost?->transport_cost) - $this->total_discount;
    }

    /**
     * @return mixed|string
     */
    public function getTotalPaidAttribute()
    {
        return $this->paid;
    }
    /**
     * @return mixed|string
     */
    public function getTotalDueAttribute()
    {
        return ($this->grandTotal - $this->paid) - $this->previous_balance;
    }

    /*=== scope start ===*/
    public function scopeAddPartyName(Builder $query): Builder
    {
        return $query->addSelect([
            'party_name' => Party::select('name')
                ->whereColumn('purchases.party_id', 'parties.id')
        ]);
    }

    public function scopeAddSaleTotal(Builder $query): Builder
    {
        return $query->addSelect([
            'total_sale_price' => Detail::selectRaw("IF (ISNULL(SUM(sale_price * quantity)), 0, SUM(sale_price * quantity))")
                ->where('detailable_type', Purchase::class)
                ->whereColumn('detailable_id', 'purchases.id')
        ]);
    }
    /*=== scope end ===*/
}
