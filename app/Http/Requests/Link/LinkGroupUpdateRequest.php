<?php

namespace App\Http\Requests\Link;

use App\Helpers\PermissionHelper;
use Illuminate\Foundation\Http\FormRequest;

class LinkGroupUpdateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return PermissionHelper::userIsOwnerOfModal($this->route('link'), $this->user()->id);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'group_id' => ['required', 'exists:groups,id'],
        ];
    }
}
