<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class IncomeRecordRequest extends FormRequest
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
            'income_sector_id' => 'required|integer',
            "branch_id"                 => 'required|integer',
            'payment_method'            => 'in:cash,bank_account',
            'cash_id'                   => 'nullable|integer|exists:cashes,id',
            'bank_account_id'           => 'nullable|integer|exists:bank_accounts,id',
            'transactionable_id'        => 'required|integer',
            'date' => 'required|date',
            'amount' => 'required|numeric',
            'income_by' => 'nullable|string',
            'note' => 'nullable|string',
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
