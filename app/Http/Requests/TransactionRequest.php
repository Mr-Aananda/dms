<?php

namespace App\Http\Requests;

use App\Rules\TransactionAmountValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class TransactionRequest extends FormRequest
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
        $transactionFromRules = ($this->input('transaction_from') === 'cash') ? 'exists:cashes,id' : 'exists:bank_accounts,id';
        $transactionToRules = ($this->input('transaction_to') === 'cash') ? 'exists:cashes,id' : 'exists:bank_accounts,id';
        return [
            'date' => 'required|date',
            'transaction_from' => 'required|string',
            'transaction_from_id' => 'required|integer|' . $transactionFromRules,
            'transaction_to' => 'required|string',
            'transaction_to_id' => 'required|integer|' . $transactionToRules,
            'amount' => ['required', 'numeric', 'min:1', new TransactionAmountValidationRule()],
            'note' => 'nullable|string',
        ];
    }
}
