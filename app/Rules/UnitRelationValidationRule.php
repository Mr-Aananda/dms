<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Support\Str;

class UnitRelationValidationRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if ($this->startsWithSlash($value) || $this->endsWithSlash($value) || $this->hasConsecutiveSlashes($value)) {
            $fail("The {$attribute} cannot start or end with a slash, or have two consecutive slashes.");
        }
    }

    /**
     * Check if a string starts with a slash.
     *
     * @param  string  $value
     * @return bool
     */
    private function startsWithSlash($value)
    {
        return Str::startsWith($value, '/');
    }

    /**
     * Check if a string ends with a slash.
     *
     * @param  string  $value
     * @return bool
     */
    private function endsWithSlash($value)
    {
        return Str::endsWith($value, '/');
    }

    /**
     * Check if a string has two consecutive slashes.
     *
     * @param  string  $value
     * @return bool
     */
    private function hasConsecutiveSlashes($value)
    {
        return Str::contains($value, '//');
    }
}
