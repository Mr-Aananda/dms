@section('title', 'Dashboard')
<x-app-layout>
    <x-dashboard.square-card
        :cash-balance="$cashBalance"
        :bank-balance="$bankBalance"
        :total-product-price="$totalProductPrice"
        :total-invest="$totalInvest"
        {{-- :total-damage-product-price="$totalDamageProductPrice" --}}

        :this-month-sale-amount="$thisMonthSaleAmount"
        :last-month-sale-amount="$lastMonthSaleAmount"
        :month-sale-percentage="$monthSalePercentage"
        :total-sale-amount="$totalSaleAmount"

        :this-month-purchase-amount="$thisMonthPurchaseAmount"
        :last-month-purchase-amount="$lastMonthPurchaseAmount"
        :month-purchase-percentage="$monthPurchasePercentage"
        :total-purchase-amount="$totalPurchaseAmount"

        :this-month-total-expense="$thisMonthTotalExpense"
        :last-month-total-expense="$lastMonthTotalExpense"
        :month-expense-percentage="$monthExpensePercentage"
        :total-expense="$totalExpense"

        :this-month-total-income="$thisMonthTotalIncome"
        :last-month-total-income="$lastMonthTotalIncome"
        :month-income-percentage="$monthIncomePercentage"
        :total-income="$totalIncome"
     />
    <x-dashboard.circle-card
         :today-sale-amount="$todaySaleAmount"
         :previous-day-sale-amount="$previousDaySaleAmount"
         :today-sale-percentage="$previousDaySaleAmount"

         :today-purchase-amount="$todayPurchaseAmount"
         :previous-day-purchase-amount="$previousDayPurchaseAmount"
         :today-purchase-percentage="$todayPurchasePercentage"

         :today-expense="$todayExpense"
         :previous-day-expense="$previousDayExpense"
         :today-expense-percentage="$todayExpensePercentage"

         :today-income="$todayIncome"
         :previous-day-income="$previousDayIncome"
         :today-income-percentage="$todayIncomePercentage"

         :customer-due="$customerDue"
         :supplier-due="$supplierDue"
         :total-withdraw-amount="$totalWithdrawAmount"
     />

    <x-dashboard.chart
        :purchase-monthly-data="$purchaseMonthlyData"
        :sale-monthly-data="$saleMonthlyData"
        :daily-sale-data="$dailySaleData"
        :daily-purchase-data="$dailyPurchaseData"

        :today-sale-amount="$todaySaleAmount"
        :today-purchase-amount="$todayPurchaseAmount"
        :today-expense="$todayExpense"
        :today-income="$todayIncome"
    />


</x-app-layout>


