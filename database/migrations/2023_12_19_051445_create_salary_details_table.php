<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('salary_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('salary_id')
                ->constrained()
                ->cascadeOnUpdate()
                ->cascadeOnDelete();
            $table->string('purpose')->comment('the purpose of salary amount');
            $table->decimal('amount', 10, 2)->default(0.00)->comment('positive balance means give amount to user, negative balance means take amount from user');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('salary_details');
    }
};
