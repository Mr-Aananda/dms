<?php

namespace App\Http\Requests;

use Illuminate\Validation\Rule;
use Illuminate\Foundation\Http\FormRequest;

class ProductRequest extends FormRequest
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
            'name' => 'required|string|max:250',
            'category_id' => 'required|exists:categories,id',
            'subcategory_id' => 'nullable|exists:categories,id',
            'barcode' => [
                'nullable',
                'string',
                Rule::unique('products', 'barcode')
                    ->ignore($this->route('product')),
            ],
            'unit_id' => 'required|exists:units,id',
            'brand_id' => 'nullable|exists:brands,id',
            'sale_price' => 'nullable|numeric',
            'purchase_price' => 'nullable|numeric',
            'wholesale_price' => 'nullable|numeric',
            'price_type' => 'required|numeric',
            // 'stock_alert' => 'nullable|numeric',
            'quantity_in_unit' => 'nullable|array',
            // 'product_type' => 'required|string',
            'status' => 'required',
            'description' => 'nullable|string|max:250',
        ];
    }

    /**
     * Get custom attributes for validator errors.
     *
     * @return array<string, string>
     */
    public function attributes(): array
    {
        return [
            'category_id' => 'category',
            'subcategory_id' => 'category',
            'unit_id' => 'unit',
            'price_type' => 'price_type'
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
            'category_id.exists' => 'Category field is required',
            'subcategory_id.exists' => 'Subcategory field is required',
            'unit_id.exists' => 'Unit field is required',
            'price_type' => 'Price type field is required',
        ];
    }
}
