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
        Schema::create('parties', function (Blueprint $table) {
            $table->id();
            $table->string("genus", 45);
            $table->string("name");
            $table->string("company_name")->nullable();
            $table->string("phone", 20)->nullable();
            $table->string("email")->nullable();
            $table->longText("address")->nullable();
            $table->decimal("balance", 10, 2)->default(0)->comment('positive(+) balance means receivable and negative(-) is payable');
            $table->foreignId('user_id')
                ->nullable()
                ->comment('Creator')
                ->constrained()
                ->cascadeOnUpdate()
                ->nullOnDelete();
            $table->boolean("active")->default(true);
            $table->text("description")->nullable();
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('parties');
    }
};
