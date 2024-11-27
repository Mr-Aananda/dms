<?php

namespace App\Http\Requests;

use App\Rules\CheckSameDateMonth;
use Illuminate\Foundation\Http\FormRequest;

class InvestWithdrawRequest extends FormRequest
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
            "date"                      => ['required', new CheckSameDateMonth()],
            'payment_method'            => 'in:cash,bank_account',
            'invest_id'                 => 'required|integer|exists:invests,id',
            'branch_id'                 => 'required|integer|exists:branches,id',
            'cash_id'                   => 'nullable|integer|exists:cashes,id',
            'bank_account_id'           => 'nullable|integer|exists:bank_accounts,id',
            'transactionable_id'        => 'required',
            'amount'                    => 'required|numeric',
            'type'                      => 'required',
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
