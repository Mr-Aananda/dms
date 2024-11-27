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
        Schema::create('purchases', function (Blueprint $table) {
            $table->id();
            $table->date("date");
            $table->string("voucher_no", 45);
            $table->foreignId('party_id')
                ->comment('Supplier id')
                ->constrained()
                ->cascadeOnUpdate()
                ->cascadeOnDelete();
            $table->foreignId('branch_id')
                ->constrained()
                ->cascadeOnUpdate()
                ->cascadeOnDelete();
            $table->foreignId('user_id')
                ->nullable()
                ->comment('Creator')
                ->constrained()
                ->cascadeOnUpdate()
                ->nullOnDelete();
            $table->decimal("subtotal", 12, 2);
            $table->decimal('discount', 10, 2)->default(0);
            $table->string('discount_type')->default('flat')->comment('percentage/flat');
            $table->decimal("paid", 12, 2)->default(0.00);
            $table->decimal("previous_balance", 12, 2)->default(0.00)
                ->comment('party balance before completing purchase');
            $table->text("note")->nullable();
            $table->SoftDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('purchases');
    }
};
