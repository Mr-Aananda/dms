<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Damage extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'date',
        'damage_no',
        'branch_id',
        'user_id',
        'note',
    ];

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
     * get business group details
     * @return BelongsTo
     */
    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
    }

    /**
     * user
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

}
