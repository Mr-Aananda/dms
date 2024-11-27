<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Investor extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'user_id',
        'name',
        'phone',
        'balance',
        'address',
        'note',
    ];

    /* ==== Relationship Start ==== */

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
     * Get related invests
     *
     * @return HasMany
     */
    public function invests(): HasMany
    {
        return $this->hasMany(Invest::class);
    }

    /* ==== Relationship End ==== */
}
