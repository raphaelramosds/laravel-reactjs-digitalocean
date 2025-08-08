<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        User::firstOrCreate(['email' => 'admin@artemarca.com'], [
            'name' => "Administrator",
            'email' => 'admin@artemarca.com',
            'password' => Hash::make(config('app.admin_password')),
        ]);
    }
}
