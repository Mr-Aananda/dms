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
        Schema::create('details', function (Blueprint $table) {
            $table->id();
            $table->date('date')->nullable();
            $table->foreignId('product_id')
                ->constrained()
                ->cascadeOnUpdate()
                ->cascadeOnDelete();
            // $table->foreignId('branch_id')
            // ->constrained()
            // ->cascadeOnUpdate()
            // ->cascadeOnDelete();
            $table->morphs('detailable');
            $table->decimal('quantity', 10, 2)->default(0);
            $table->string('quantity_in_unit')->default(0);
            $table->decimal('purchase_price', 10, 2)->default(0);
            $table->decimal('sale_price', 10, 2)->default(0);
            $table->decimal('wholesale_price', 10, 2)->default(0);
            $table->decimal('return_price', 10, 2)->default(0);
            $table->decimal('discount', 10, 2)->default(0.00);
            $table->enum('discount_type', ['flat', 'percentage'])->default('flat');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('details');
    }
};
