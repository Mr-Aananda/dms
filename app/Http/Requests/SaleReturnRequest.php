<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SaleReturnRequest extends FormRequest
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
            'discount' => 'nullable|numeric',
            'paid' => 'nullable|numeric',
            'previous_balance' => 'nullable|numeric',
            'note' => 'nullable|string'

        ];
    }
}