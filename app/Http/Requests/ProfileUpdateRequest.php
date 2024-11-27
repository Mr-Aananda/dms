<?php

namespace App\Http\Requests;

use App\Models\User;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

class ProfileUpdateRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\Rule|array|string>
     */
    public function rules(): array
    {
        return [
           'name' => 'required|string',
            'email' => 'required|email|unique:users,email,' . Auth::user()->id,
            'phone' => 'required|regex:/^\+?\d{1,3}?\s?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$/|min:11|max:14|unique:users,phone,' . Auth::user()->id,
            'password' => [
                'nullable',
                'string',
                'min:8',
                'confirmed', ],
            'password_confirmation' => 'nullable',
        ];
    }
}
