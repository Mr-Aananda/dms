<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class IncomeSector extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'user_id',
        'name',
        'note'
    ];

    /**
     * income records details
     * @return HasMany
     */
    public function incomeRecords(): HasMany
    {
        return $this->hasMany(IncomeRecord::class);
    }
}
