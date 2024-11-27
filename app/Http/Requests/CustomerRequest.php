<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CustomerRequest extends FormRequest
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
            // 'genus' => 'required|max:50',
            'email' => 'nullable|max:50|email',
            'phone' => 'nullable|max:50',
            'address' => 'nullable|max:150',
            'description' => 'nullable|max:500',
            'balance' => 'nullable|numeric|min:0',
        ];
    }
}
