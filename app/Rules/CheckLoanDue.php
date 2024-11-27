<?php

namespace App\Rules;


use App\Models\Loan;
use App\Models\LoanInstallment;
use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class CheckLoanDue implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if ($this->checkLoanAmount($value)) {
            $fail("This {$attribute} is greater then remaining loan amount. please enter valid amount");
        }
    }

    /**
     * Check loan amount.
     *
     * @param  string  $value
     * @return bool
     */
    private function checkLoanAmount($value)
    {

        $loanId = request('loan_id');
        $loanDue = Loan::query()->addDue()->find($loanId);
        $remainingDue = abs($loanDue->due);

        if (request()->isMethod('patch')) {
            $installment = LoanInstallment::findOrFail(request()->route('loan_installment'));
            $previousAmount = abs($installment->amount);
            $remainingDue += $previousAmount;
        }

        return $value > abs($remainingDue);
    }
}
