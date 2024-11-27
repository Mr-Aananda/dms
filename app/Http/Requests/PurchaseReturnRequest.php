<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PurchaseReturnRequest extends FormRequest
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
            'return_type' => 'required|string',
            'branch_id' => 'required|integer',
            'party_id' => 'required|integer',
            'subtotal' => 'required|numeric',
            'discount' => 'nullable|numeric',
            'previous_balance' => 'nullable|numeric',
            'paid' => 'nullable|numeric',
            'note' => 'nullable|string',

        ];
    }
}
