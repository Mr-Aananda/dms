<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\HasMany;

class User extends Authenticatable implements MustVerifyEmail
{
    use HasApiTokens, HasFactory, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'phone',
        'user_id',
        'branch_id',
        'active',
        'password',
        'email_verified_at'
    ];

    /**
     * Get related users
     *
     * @return BelongsTo
     */
    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
    }

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    /**
     * get user all salaries
     * @return HasMany
     */
    public function salaries()
    {
        return $this->hasMany(Salary::class, 'employee_id', 'id');
    }


    /** scope start */
    /**
     * get user total advanced amount
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddTotalAdvancedPaidAmount(Builder $query): Builder
    {
        return $query->addSelect([
            'total_advanced_paid' => AdvancedSalary::where('amount', '<', 0)
            ->selectRaw("IF(ISNULL(SUM(amount)), 0, SUM(amount))")
            ->whereColumn('employee_id', 'users.id')
        ]);
    }

    /**
     * get total advanced receive
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddTotalAdvancedReceiveAmount(Builder $query): Builder
    {
        return $query->addSelect([
            'total_advanced_receive' => AdvancedSalary::where('amount', '>', 0)
            ->selectRaw("IF(ISNULL(SUM(amount)), 0, SUM(amount))")
            ->whereColumn('employee_id', 'users.id')
        ]);
    }
    /** scope end */
}
