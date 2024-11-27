<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Builder;

class PurchaseReturn extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'date',
        'return_no',
        'return_type',
        'party_id',
        'branch_id',
        'cash_id',
        'bank_account_id',
        'user_id',
        'subtotal',
        'discount',
        'previous_balance',
        'paid',
        'paid_from',
        'note',
    ];

    protected $casts = [
        'date' => 'date',
    ];
    protected $appends = ['return_grand_total', 'return_total_paid', 'return_due', 'return_type_name'];


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

    /**
     * get return type name in head line name
     * @return string
     */
    public function getReturnTypeNameAttribute()
    {
        return ucwords(str_replace("_", " ", $this->return_type));
    }

    /*=== scope start ===*/
    public function scopeAddPartyName(Builder $query): Builder
    {
        return $query->addSelect([
            'party_name' => Party::select('name')
                ->whereColumn('purchase_returns.party_id', 'parties.id')
        ]);
    }
    /*=== scope end ===*/
}
