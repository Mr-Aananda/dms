<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SalaryRequest extends FormRequest
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
            'employee_id' => 'required|integer|exists:App\Models\User,id',
            'salary_month' => 'required|date',
            'given_date' => 'required|date',
            'cash_id' => 'nullable|integer|exists:App\Models\Cash,id',
            'bank_account_id' => 'nullable|integer|exists:App\Models\BankAccount,id',
            'note' => 'nullable|string',
        ];
    }
}
