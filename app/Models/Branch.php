<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Branch extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'name',
        'location',
        'description',
        'active'
    ];


    /*=== relation start ===*/

    /**
     * Get products with quantity
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function products()
    {
        return $this->belongsToMany('\App\Models\Product', 'stocks')
            ->withPivot('quantity', 'id', 'purchase_price', 'damage_quantity')
            ->withTimestamps()
            ->as('stock');
    }

    /**
     * Get related bank accounts
     *
     * @return HasMany
     */
    public function users(): HasMany
    {
        return $this->hasMany(User::class);
    }


    /**
     * Get related users
     *
     * @return HasMany
     */
    public function stock(): HasMany
    {
        return $this->hasMany(Stock::class);
    }
    /*=== relation end ===*/
}
