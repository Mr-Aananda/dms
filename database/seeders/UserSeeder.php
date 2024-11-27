<?php

namespace Database\Seeders;

use App\Models\User;
use Database\Factories\UserFactory;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // default user create
        if (!User::where('email', UserFactory::DEFAULT_USER_EMAIL)->exists()) {
            User::factory()->default()->create();
        }
    }
}
