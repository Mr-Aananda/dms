<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class LoanAccountRequest extends FormRequest
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
            'name' => 'required|max:50',
            'phone' => 'nullable|max:50',
            'address' => 'nullable|max:150',
            'note' => 'nullable|max:500',
        ];
    }
}