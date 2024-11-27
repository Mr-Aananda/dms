<?php

namespace App\Http\Requests;

use Illuminate\Validation\Rule;

use Illuminate\Foundation\Http\FormRequest;

class CashRequest extends FormRequest
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
            'name' => [
                'required',
                'string',
                Rule::unique('cashes', 'name')
                    ->where('branch_id', $this->branch_id)
                    ->ignore($this->route('cash')),
            ],
            'branch_id' => 'required|integer|exists:branches,id',
            'balance' => 'nullable|numeric',
            'description' => 'nullable|string|max:250',
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
            'name.unique' => 'Cash with this name already exists for the selected branch.',
        ];
    }
}
