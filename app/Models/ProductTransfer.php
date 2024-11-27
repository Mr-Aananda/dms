<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductTransfer extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'date',
        'transfer_no',
        'from_branch_id',
        'to_branch_id',
        'note',
        'user_id',
    ];

    protected $casts = [
        'date' => 'date',
    ];

    /**
     * get from business details
     * @return BelongsTo
     */
    public function fromBranch(): BelongsTo
    {
        return $this->belongsTo(Branch::class, 'from_branch_id', 'id');
    }

    /**
     * get to business details
     * @return BelongsTo
     */
    public function toBranch(): BelongsTo
    {
        return $this->belongsTo(Branch::class, 'to_branch_id', 'id');
    }

    /**
     * get user details
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * get transfer product details
     * @return HasMany
     */
    public function productTransferDetails(): HasMany
    {
        return $this->hasMany(ProductTransferDetails::class);
    }
}
