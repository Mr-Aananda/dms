<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class DueManageRequest extends FormRequest
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
            'party_id' => 'required|integer',
            'cash_id' => 'nullable|integer',
            'bank_account_id' => 'nullable|integer',
            'date' => 'required|date',
            'type' => 'required|in:supplier,customer',
            'amount' => 'required|numeric',
            'adjustment' => 'nullable|numeric',
            'check_number' => 'nullable|numeric',
            'description' => 'nullable|string',
        ];
    }
}
