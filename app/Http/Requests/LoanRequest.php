<?php

namespace App\Http\Requests;

use App\Rules\LoanAmountValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class LoanRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'loan_account_id' => 'required|integer|exists:App\Models\LoanAccount,id',
            'date' => 'required|date',
            'expired_date' => 'required|date',
            'note' => 'nullable|string',
            'transactionable_id' => 'required',
            // 'transactionable.id' => 'required|integer|' . ($this->payment_method == 'cash') ? 'exists:cashes,id' : 'exists:bank_accounts,id',
            // 'amount' => ['required', 'numeric', new LoanAmountLessOrEqualToTransactionableBalanceRule],
            'amount' => ['required', 'numeric', 'min:1', new LoanAmountValidationRule()],
            'profit' => 'nullable|numeric',
            'profit_type' => 'nullable|string',
        ];
    }

    /**
     * Get the error messages for the defined validation rules.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'transactionable_id.required' => 'Please select a cash or bank account.',
        ];
    }
}
