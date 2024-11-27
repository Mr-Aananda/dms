<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Builder;

class SaleReturn extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'date',
        'return_no',
        'party_id',
        'branch_id',
        'user_id',
        'subtotal',
        'discount',
        'paid',
        'due',
        'paid_from',
        'previous_balance',
        'cash_id',
        'bank_account_id',
        'description',
    ];

    protected $appends = ['return_grand_total', 'return_total_paid', 'return_sale_amount', 'return_total_discount', 'return_due'];
    protected $casts = [
        'date' => 'date',
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
     * @return mixed|string
     */
    public function getReturnGrandTotalAttribute()
    {
        return ($this->subtotal + $this->labour_cost + $this->transport_cost) - $this->discount;
    }

    /**
     * @return mixed|string
     */
    public function getReturnSaleAmountAttribute()
    {
        return $this->subtotal - $this->discount;
    }

    /**
     * @return mixed|string
     */
    public function getReturnTotalPaidAttribute()
    {
        return $this->paid;
    }

    /**
     * get purchase total discount
     * @return float|int|mixed
     */
    public function getReturnTotalDiscountAttribute(): mixed
    {
        return $this->discount_type == 'flat' ? $this->discount : (($this->subtotal * $this->discount) / 100);
    }

    /**
     * return due
     * @return int
     */
    public function getReturnDueAttribute()
    {
        if (($this->return_grand_total - $this->paid) > 0) {
            return $this->return_grand_total - $this->paid;
        } else {
            return 0;
        }
    }

    /*=== scope start ===*/
    public function scopeAddPartyName(Builder $query): Builder
    {
        return $query->addSelect([
            'party_name' => Party::select('name')
                ->whereColumn('sale_returns.party_id', 'parties.id')
        ]);
    }

    /**
     * Add total purchase price
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddTotalPurchasePrice(Builder $query): Builder
    {
        return $query->addSelect([
            'total_purchase_price' => Detail::selectRaw("IF (ISNULL(SUM(purchase_price * quantity)), 0, SUM(purchase_price * quantity))")
            ->where('detailable_type', SaleReturn::class)
                ->whereColumn('detailable_id', 'sale_returns.id')
        ]);
    }
    /*=== scope end ===*/
}
