<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Unit extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'user_id',
        'name',
        'label',
        'relation',
        'code',
        'description'
    ];

    protected $appends = ['unit_labels'];

    public function getUnitLabelsAttribute()
    {
        return explode('/', $this->label);
    }

    /**
     * get unit products
     * @return HasMany
     */
    public function products(): HasMany
    {
        return $this->hasMany(Product::class);
    }
}
