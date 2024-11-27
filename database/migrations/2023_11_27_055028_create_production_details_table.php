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
        Schema::create('production_details', function (Blueprint $table) {
            $table->id();
            $table->date("date");
            $table->foreignId('production_id')
                ->constrained()
                ->cascadeOnUpdate()
                ->cascadeOnDelete();
            $table->foreignId('product_id')
                ->constrained()
                ->cascadeOnUpdate()
                ->cascadeOnDelete();
            // $table->foreignId('branch_id')
            // ->constrained()
            // ->cascadeOnUpdate()
            // ->cascadeOnDelete();
            $table->decimal('quantity')->default(0.00);
            $table->decimal('purchase_price', 10, 2)->default(0);
            $table->string('quantity_in_unit')->default(0.00);
            $table->string('production_type');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('production_details');
    }
};
