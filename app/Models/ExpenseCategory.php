<?php

namespace App\Models;

use Illuminate\Contracts\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Collection;

class ExpenseCategory extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'user_id',
        'parent_id',
        'name',
        'description',
        'active'
    ];


    /*=== Local Scope Start ===*/
    public function scopeParent(Builder $query): Builder
    {
        return $query->where('parent_id', '=', null);
    }

    public function scopeChildren(Builder $query): Builder
    {
        return $query->where('parent_id', '!=', null);
    }
    /*=== Local Scope End ===*/

    /**
     * Generate category tree
     *
     * @return Collection
     */
    public static function tree(): Collection
    {
        $allCategories = static::get();
        $rootCategories = $allCategories->whereNull('parent_id');

        self::formatTree($rootCategories, $allCategories);

        return $rootCategories;
    }

    /**
     * Format the tree
     *
     * @param  Collection  $categories
     * @param  Collection  $allCategories
     * @return void
     */
    private static function formatTree(Collection $categories, Collection $allCategories): void
    {
        foreach ($categories as $category) {
            $category->children = $allCategories->where('parent_id', $category->id)->values();

            if ($category->children->isNotEmpty()) {
                self::formatTree($category->children, $allCategories);
            }
        }
    }


    /*=== accessor start ===*/
    public function getTextAttribute()
    {
        return $this->name;
    }
    /*=== accessor end ===*/


    public function subCategory()
    {
        return $this->hasMany(ExpenseCategory::class, 'parent_id', 'id')->where('active', 1);
    }

    public function parentCategory()
    {
        return $this->belongsTo(ExpenseCategory::class, 'parent_id', 'id');
    }

    /**
     * Get associated expenses
     *
     * @return HasMany
     */
    public function expenses(): HasMany
    {
        return $this->hasMany(Expense::class);
    }
}
