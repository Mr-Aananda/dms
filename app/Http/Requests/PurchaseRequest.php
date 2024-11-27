<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PurchaseRequest extends FormRequest
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
            'date' => 'required|date',
            'branch_id' => 'required|integer',
            'party_id' => 'required|integer',
            'subtotal' => 'required|numeric',
            // 'payment_type' => 'required|string',
            // 'cash_id' => 'nullable|integer',
            // 'bank_account_id' => 'nullable|integer',
            'discount' => 'nullable|numeric',
            'discount_type' => 'required|string',
            'previous_balance' => 'nullable|numeric',
            'paid' => 'nullable|numeric',
            'note' => 'nullable|string',
        ];
    }
}
