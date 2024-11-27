<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class BankAccount extends Model
{
    use HasFactory,SoftDeletes;
    protected $fillable = [
        'bank_id',
        'account_name',
        'account_number',
        'branch',
        'balance',
        'user_id',
        'description',
    ];

    protected $appends = ['custom_name'];

    public function getCustomNameAttribute()
    {
        return $this->bank?->name . ' ( ' . $this->account_name . ' - ' . $this->account_number . ' )';
    }


    /* ==== Relationship Start ==== */

    /**
     * @return BelongsTo
     */
    public function bank(): BelongsTo
    {
        return $this->belongsTo(Bank::class);
    }

    /**
     * Get related expenses
     *
     * @return MorphMany
     */
    public function expenses(): MorphMany
    {
        return $this->morphMany(Expense::class, 'transactionable');
    }

    /**
     * Get related withdraws
     *
     * @return MorphMany
     */
    public function withdraws(): MorphMany
    {
        return $this->morphMany(Withdraw::class, 'transactionable');
    }

    /**
     * Get related loans
     *
     * @return MorphMany
     */
    public function loans(): MorphMany
    {
        return $this->morphMany(Loan::class, 'transactionable');
    }

    /**
     * Get related loans installments
     *
     * @return MorphMany
     */
    public function loanInstallments(): MorphMany
    {
        return $this->morphMany(LoanInstallment::class, 'transactionable');
    }

    /**
     * Get related expenses
     *
     * @return MorphMany
     */
    public function incomeRecords(): MorphMany
    {
        return $this->morphMany(IncomeRecord::class, 'transactionable');
    }

    /**
     * Get related invest
     *
     * @return MorphMany
     */
    public function invests(): MorphMany
    {
        return $this->morphMany(Invest::class, 'transactionable');
    }

    /**
     * Get related invest
     *
     * @return MorphMany
     */
    public function investWithdraws(): MorphMany
    {
        return $this->morphMany(InvestWithdraw::class, 'transactionable');
    }

    /**
     * Get related users
     *
     * @return BelongsTo
     */
    public function transaction(): BelongsTo
    {
        return $this->belongsTo(Transaction::class, 'id', 'transaction_from_id');
    }


    /* ==== Relationship End ==== */

}
