<?php

namespace App\Models;

use Illuminate\Contracts\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Collection;

class Category extends Model
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


    // /**
    //  * Get related product
    //  *
    //  * @return HasMany
    //  */
    // public function product(): HasMany
    // {
    //     return $this->hasMany(Product::class);
    // }

    public function subCategory()
    {
        return $this->hasMany(Category::class, 'parent_id', 'id')->where('active', 1);
    }

    public function parentCategory()
    {
        return $this->belongsTo(Category::class, 'parent_id', 'id');
    }
}
