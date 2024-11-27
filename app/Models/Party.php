<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Party extends Model
{
    use HasFactory,SoftDeletes;

    /**
     * Supplier type
     */
    const GENUS_SUPPLIER = 'supplier';
    /**
     * Customer type
     */
    const GENUS_CUSTOMER = 'customer';

    protected $fillable = [
        'genus',
        'name',
        'company_name',
        'phone',
        'email',
        'address',
        'balance',
        'user_id',
        'active',
        'description',
    ];

    protected $appends = ['custom_name'];

    public function getCustomNameAttribute()
    {
        return $this->name . ' ( ' . $this->phone . ' )';
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

    /**
     * get sale
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function sales()
    {
        return $this->hasMany(Sale::class);
    }

    /**
     * get sale
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function purchases()
    {
        return $this->hasMany(Purchase::class);
    }

    /* === Scope start === */
    /**
     * Customer
     *
     * @param Builder $query
     * @return Builder
     */
    public function scopeCustomer(Builder $query): Builder
    {
        return $query->whereGenus(self::GENUS_CUSTOMER);
    }

    /**
     * Supplier
     *
     * @param Builder $query
     * @return Builder
     */
    public function scopeSupplier(Builder $query): Builder
    {
        return $query->whereGenus(self::GENUS_SUPPLIER);
    }

    /*=== Scope end ===*/
}
