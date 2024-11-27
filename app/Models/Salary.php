<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Salary extends Model
{
    use HasFactory;
    protected $guarded = [];

    /**
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * get from business details
     * @return BelongsTo
     */
    public function employee(): BelongsTo
    {
        return $this->belongsTo(User::class, 'employee_id', 'id');
    }

    /**
     * get salary details
     * @return HasMany
     */
    public function details(): HasMany
    {
        return $this->hasMany(SalaryDetails::class);
    }

    /**
     * get advanced details
     * @return HasOne
     */
    public function advancedSalary(): HasOne
    {
        return $this->hasOne(AdvancedSalary::class);
    }

    /** scope start */
    /**
     * get user total advanced amount
     * @param Builder $query
     * @return Builder
     */
    public function scopeAddTotalSalaryPaidAmount(Builder $query): Builder
    {
        return $query->addSelect([
            'total_salary_paid' => SalaryDetails::selectRaw("IF(ISNULL(SUM(amount)), 0, SUM(amount))")
            ->whereColumn('salary_id', 'salaries.id')
        ]);
    }

    /** scope start */
}
