<?php

namespace App\Http\Requests;

use App\Rules\NumericStringRule;
use Illuminate\Validation\Rule;
use App\Rules\UnitRelationValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class UnitRequest extends FormRequest
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
            // 'name' => 'required|string',
            'name' => [
                'required',
                'string',
                Rule::unique('units', 'name')
                    ->ignore($this->route('unit')),
            ],
            'label' => ['required', 'string', new UnitRelationValidationRule()],
            'relation' => ['required', 'string'],
            'description' => 'required|string',
        ];
    }
}
