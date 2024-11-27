<?php

namespace App\Rules;

use App\Models\InvestWithdraw;
use Carbon\Carbon;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class CheckSameDateMonth implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if ($this->checkDateMonth($value)) {
            $fail("Profit withdrawal/addition already exist for the this  month.");
        }
    }

    /**
     * Check loan amount.
     *
     * @param  string  $value
     * @return bool
     */
    private function checkDateMonth($value)
    {
        $date = Carbon::parse($value)->format('Y-m');

        // Check only if the type is profit_addition or profit_withdraw
        if (request()->input('type') !== 'invest_withdraw') {
            $investId = request()->input('invest_id');

            // Check if both profit addition and profit withdrawal exist for the same invest_id and month or date
            $bothExists = InvestWithdraw::where('invest_id', $investId)
            ->whereIn('type', ['profit_addition', 'profit_withdraw'])
            ->whereRaw('DATE_FORMAT(date, "%Y-%m") = ?', [$date])
            ->exists();

            // Fail validation if both profit addition and profit withdrawal exist
            if ($bothExists) {
                return true;
            }
        }

        return false;

    }
}
