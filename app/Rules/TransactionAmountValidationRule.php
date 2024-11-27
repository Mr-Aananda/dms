<?php

namespace App\Rules;

use App\Models\BankAccount;
use App\Models\Cash;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class TransactionAmountValidationRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if ($this->isAmountInsufficient($value)) {
            $fail("The {$attribute} is insufficient.");
        }
    }


    /**
     * Check if a string starts with a slash.
     *
     * @param  string  $value
     * @return bool
     */
    private function isAmountInsufficient($value)
    {
        $transactionable = null;

        if (request('transaction_from') == 'cash') {
            $transactionable = Cash::findOrFail(request()->transaction_from_id);
        } else {
            $transactionable = BankAccount::findOrFail(request()->transaction_from_id);
        }

        $balanceBeforeTransaction = $value > $transactionable->balance;

        return $balanceBeforeTransaction;
    }
}
