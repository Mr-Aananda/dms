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
        Schema::create('expenses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('expense_category_id')
                ->nullable()
                ->constrained('expense_categories')
                ->cascadeOnUpdate()
                ->nullOnDelete();
            $table->foreignId('expense_subcategory_id')
                ->nullable()
                ->constrained('expense_categories')
                ->cascadeOnUpdate()
                ->nullOnDelete();
            $table->foreignId('branch_id')
                ->nullable()
                ->constrained()
                ->cascadeOnUpdate()
                ->nullOnDelete();
            $table->foreignId('user_id')
            ->nullable()
            ->comment('Creator')
            ->constrained()
            ->cascadeOnUpdate()
            ->nullOnDelete();
            $table->date('date');
            $table->decimal('amount')->default(0);
            $table->morphs('transactionable');
            $table->text('note')->nullable();
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('expenses');
    }
};
