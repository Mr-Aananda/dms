<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UserRequest extends FormRequest
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
        $userId = $this->route('user') ? $this->route('user') : null;
        $rules = [
            'name' => 'required|string',
            'email' => 'required|email|unique:users,email,' . $userId,
            'phone' => 'required|regex:/^\+?\d{1,3}?\s?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$/|min:11|max:14|unique:users,phone,' . $userId,
            'password' => [
                'nullable',
                'string',
                'min:8',             // must be at least 10 characters in length
                //                'regex:/[a-z]/',      // must contain at least one lowercase letter
                //                'regex:/[A-Z]/',      // must contain at least one uppercase letter
                //                'regex:/[0-9]/',      // must contain at least one digit
                //                'regex:/[@$!%*#?&]/', // must contain a special character
                'confirmed',
            ],
            'password_confirmation' => 'nullable',
            'role' => 'required',
            'branch_id' => 'nullable|integer',
        ];
        return $rules;
    }
}
