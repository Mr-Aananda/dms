<?php

namespace App\Console\Commands;

use App\Models\Invest;
use App\Models\InvestWithdraw;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class MonthlyProfitAddition extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'monthly-profit-addition';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Automatically add profit to investments marked as automatic on a monthly basis';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        // Get the current date and the first day of the current month
        $currentDate = Carbon::now();
        $firstDayOfMonth = $currentDate->copy()->startOfMonth();

        // Fetch investments where isAutomatic is true
        $invests = Invest::where('isAutomatic', true)->get();

        foreach ($invests as $invest) {
            DB::transaction(function () use ($invest, $currentDate, $firstDayOfMonth) {
                // Calculate the profit amount
                $profitAmount = $this->calculateProfit($invest);

                // Determine the profit addition date
                $profitAdditionDate = $invest->profit_addition_date ?? $firstDayOfMonth;

                // Check if a profit addition or profit withdraw has already been made this month
                $alreadyAddedThisMonth = InvestWithdraw::where('invest_id', $invest->id)
                    ->where('type', 'profit_addition')
                    ->orWhere('type', 'profit_withdraw')
                    ->whereMonth('date', $currentDate->month)
                    ->whereYear('date', $currentDate->year)
                    ->exists();

                // Only add profit if it hasn't been added for the current month
                if (!$alreadyAddedThisMonth) {
                    // Update the investment amount
                    $invest->increment('amount', $profitAmount);

                    // Create an InvestWithdraw record
                    InvestWithdraw::create([
                        'user_id' => $invest->user_id,
                        'invest_id' => $invest->id,
                        'transactionable_type' => get_class($invest->transactionable),
                        'transactionable_id' => $invest->transactionable->id,
                        'date' => $currentDate,
                        'amount' => $profitAmount,
                        'branch_id' => $invest->branch_id,
                        'type' => 'profit_addition',
                        'created_at' => $profitAdditionDate,
                        'updated_at' => $profitAdditionDate,
                    ]);

                    // Update the profit addition date in the investment record
                    $invest->update(['profit_addition_date' => $profitAdditionDate]);
                }
            });
        }

        $this->info('Monthly profit addition completed.');
    }

    private function calculateProfit($invest)
    {
        // Example profit calculation logic
        return  $invest->profit_type == 'percentage' ? (abs($invest->amount) * $invest->profit) / 100 : $invest->profit; // For example, 5% profit
    }
}
