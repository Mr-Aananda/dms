<?php

namespace App\Rules;

use App\Models\BankAccount;
use App\Models\Cash;
use App\Models\Expense;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Support\Facades\Log;

class ExpenseAmountValidationRule implements ValidationRule
{
    protected $message;
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
        $previous_amount = 0;

        if (request('payment_method') == 'cash' && request('transactionable_id')) {
            $transactionable = Cash::findOrFail(request()->transactionable_id);
        } else if (request('payment_method') == 'bank_account' && request('transactionable_id')) {
            $transactionable = BankAccount::findOrFail(request()->transactionable_id);
        }

        if(request()->isMethod('patch')) {
            $expense = Expense::findOrFail(request()->route('expense'));
            $previous_amount = $expense->amount;
        }

        $balanceBeforeTransaction = $transactionable ? $value > ($transactionable->balance + $previous_amount) : 0;

        return $balanceBeforeTransaction;
    }

}
