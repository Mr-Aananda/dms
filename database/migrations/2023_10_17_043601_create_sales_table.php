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
        Schema::create('sales', function (Blueprint $table) {
            $table->id();
            $table->date("date");
            $table->string("invoice_no", 45);
            $table->foreignId('party_id')
                ->comment('Customer id')
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
            $table->decimal('labour_cost', 10, 2)->default(0.00);
            $table->decimal('transport_cost', 10, 2)->default(0.00);
            $table->decimal("paid", 12, 2)->default(0.00);
            $table->decimal("due", 12, 2)->default(0.00);
            $table->decimal("change", 10, 2)->default(0.00);
            $table->decimal("previous_balance", 12, 2)
            ->comment('customer previous balance before completing sale')
            ->default(0.00);
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
        Schema::dropIfExists('sales');
    }
};
