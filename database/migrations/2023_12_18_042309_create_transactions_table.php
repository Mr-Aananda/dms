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
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->foreignId('user_id')
                ->nullable()
                ->comment('Creator')
                ->constrained()
                ->cascadeOnUpdate()
                ->nullOnDelete();
            $table->enum('transaction_from', ['bank', 'cash'])->comment('From where the transaction took place');
            $table->string('transaction_from_id')->comment('bank account or cash id');
            $table->enum('transaction_to', ['bank', 'cash'])->comment('Where the transaction take place?');
            $table->string('transaction_to_id')->comment('bank account or cash id');
            $table->decimal('amount', 12, 2)->default(0.00);
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
        Schema::dropIfExists('transactions');
    }
};
