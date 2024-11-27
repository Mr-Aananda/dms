<?php

namespace App\Http\Requests;

use App\Rules\CheckLoanDue;
use Illuminate\Foundation\Http\FormRequest;

class LoanInstallmentRequest extends FormRequest
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
            'loan_id' => 'required|integer|exists:loans,id',
            'date' => 'required|date',
            'transactionable_id' => 'required',
            'amount' => ['required', 'numeric', new CheckLoanDue()],
            'adjustment' => 'nullable|numeric',
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
