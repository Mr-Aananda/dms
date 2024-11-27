<?php

namespace App\Http\Requests;

use App\Rules\ExpenseAmountValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class ExpenseRequest extends FormRequest
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
            "date"                      => 'required',
            "branch_id"                 => 'required|integer',
            "expense_category_id"       => 'nullable|integer',
            "expense_subcategory_id"    => 'nullable|integer',
            'payment_method'            => 'in:cash,bank_account',
            'cash_id'                   => 'nullable|integer|exists:cashes,id',
            'bank_account_id'           => 'nullable|integer|exists:bank_accounts,id',
            'transactionable_id'        => 'required',
            'amount'                    => ['required', 'numeric', 'min:1', new ExpenseAmountValidationRule()],
            // 'amount'                    => ['required', 'numeric', 'min:1'],
            "note"                      => 'nullable',
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
