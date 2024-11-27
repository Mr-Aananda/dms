<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class InvestRequest extends FormRequest
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
            'investor_id' => 'required|integer|exists:App\Models\Investor,id',
            'branch_id' => 'required|integer|exists:App\Models\branch,id',
            'date' => 'required|date',
            'note' => 'nullable|string',
            'transactionable_id' => 'required',
            // 'transactionable.id' => 'required|integer|' . ($this->payment_method == 'cash') ? 'exists:cashes,id' : 'exists:bank_accounts,id',
            'amount' => 'required|numeric' ,
            'profit' => 'nullable|numeric',
            'profit_type' => 'nullable|string',
            'profit_addition_date' => 'nullable|date',
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
