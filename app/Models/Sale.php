<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Sale extends Model
{
    use HasFactory,SoftDeletes;
    protected $guarded = [];
    protected $appends = [
        'grand_total',
        'total_paid',
        'sale_amount',
        'total_discount'
    ];
    protected $casts = [
        'date' => 'date',
    ];

    /**
     * Get all the post's comments.
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
    public function getGrandTotalAttribute()
    {
        return ($this->subtotal + $this->labour_cost + $this->transport_cost) - $this->discount;
    }

    /**
     * @return mixed|string
     */
    public function getSaleAmountAttribute()
    {
        return $this->subtotal - $this->discount;
    }

    /**
     * @return mixed|string
     */
    public function getTotalPaidAttribute()
    {
        return $this->paid;
    }

    /**
     * get purchase total discount
     * @return float|int|mixed
     */
    public function getTotalDiscountAttribute(): mixed
    {
        return $this->discount_type == 'flat' ? $this->discount : (($this->subtotal * $this->discount) / 100);
    }

    /*=== scope start ===*/
    public function scopeAddPartyName(Builder $query): Builder
    {
        return $query->addSelect([
            'party_name' => Party::select('name')
                ->whereColumn('sales.party_id', 'parties.id')
        ]);
    }

    /**
     * Add total purchase price
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddTotalPurchasePrice(Builder $query): Builder
    {
        // return $query->addSelect([
        //     'total_purchase_price' => Detail::selectRaw("IF (ISNULL(SUM(purchase_price * quantity)), 0, SUM(purchase_price * quantity))")
        //     ->where('detailable_type', Sale::class)
        //     ->whereColumn('detailable_id', 'sales.id')
        // ]);

        return $query->addSelect([
            'total_purchase_price' => Detail::selectRaw("IF (ISNULL(SUM(d.purchase_price / p.divisor_number * d.quantity)), 0, SUM(d.purchase_price / p.divisor_number * d.quantity))")
            ->from('details as d')
            ->leftJoin('products as p', 'd.product_id', '=', 'p.id')
            ->where('d.detailable_type', Sale::class)
                ->whereColumn('d.detailable_id', 'sales.id')
        ]);

    }

    public function scopeAddMrpTotal(Builder $query): Builder
    {
         return $query->addSelect([
             'total_mrp_price' => Detail::selectRaw("IF (ISNULL(SUM(wholesale_price * quantity)), 0, SUM(wholesale_price * quantity))")
                 ->where('detailable_type', Sale::class)
                 ->whereColumn('detailable_id', 'sales.id')
         ]);
    }
    /*=== scope end ===*/

}
