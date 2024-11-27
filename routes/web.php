<?php

use App\Http\Controllers\DashboardController;
use App\Http\Controllers\Pos\BarcodeController;
use App\Http\Controllers\Pos\CustomerController;
use App\Http\Controllers\Pos\CustomerDueManageController;
use App\Http\Controllers\Pos\DamageController;
use App\Http\Controllers\Pos\ExpenseController;
use App\Http\Controllers\Pos\IncomeRecordController;
use App\Http\Controllers\Pos\InvestController;
use App\Http\Controllers\Pos\InvestorController;
use App\Http\Controllers\Pos\InvestWithdrawController;
use App\Http\Controllers\Pos\Payroll\AdvancedSalaryController;
use App\Http\Controllers\Pos\Payroll\LoanAccountController;
use App\Http\Controllers\Pos\Payroll\LoanController;
use App\Http\Controllers\Pos\Payroll\LoanInstallmentController;
use App\Http\Controllers\Pos\Payroll\SalaryController;
use App\Http\Controllers\Pos\ProductController;
use App\Http\Controllers\Pos\ProductionController;
use App\Http\Controllers\Pos\ProductTransferController;
use App\Http\Controllers\Pos\PurchaseController;
use App\Http\Controllers\Pos\PurchaseReturnController;
use App\Http\Controllers\Pos\Reports\CashbookController;
use App\Http\Controllers\Pos\Reports\ExpenseReportController;
use App\Http\Controllers\Pos\Reports\IncomeReportController;
use App\Http\Controllers\Pos\Reports\LedgerController;
use App\Http\Controllers\Pos\Reports\NetProfitReportController;
use App\Http\Controllers\Pos\Reports\ProductionReportController;
use App\Http\Controllers\Pos\Reports\ProfitLossReportController;
use App\Http\Controllers\Pos\Reports\PurchaseReportController;
use App\Http\Controllers\Pos\Reports\SalaryReportController;
use App\Http\Controllers\Pos\Reports\SaleReportController;
use App\Http\Controllers\Pos\Reports\StockReportController;
use App\Http\Controllers\Pos\SaleController;
use App\Http\Controllers\Pos\SaleReturnController;
use App\Http\Controllers\Pos\Settings\BankAccountController;
use App\Http\Controllers\Pos\Settings\BankController;
use App\Http\Controllers\Pos\Settings\BranchController;
use App\Http\Controllers\Pos\Settings\BrandController;
use App\Http\Controllers\Pos\Settings\CashController;
use App\Http\Controllers\Pos\Settings\CategoryController;
use App\Http\Controllers\Pos\Settings\ExpenseCategoryController;
use App\Http\Controllers\Pos\Settings\IncomeSectorController;
use App\Http\Controllers\Pos\Settings\UnitController;
use App\Http\Controllers\Pos\SmsController;
use App\Http\Controllers\Pos\SmsTemplateController;
use App\Http\Controllers\Pos\StockController;
use App\Http\Controllers\Pos\SupplierController;
use App\Http\Controllers\Pos\SupplierDueManageController;
use App\Http\Controllers\Pos\TransactionController;
use App\Http\Controllers\Pos\WithdrawController;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UtilityController;
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return redirect()->route('login');
});
Route::get('/dashboard', [DashboardController::class, 'index'])->middleware(['auth', 'permission.add'])->name('dashboard');
// Route::get('/dashboard', function () {return view('dashboard');
// })->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile/{id}', [ProfileController::class, 'show'])->name('profile.show');
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});


// Route::get('/email/verify', function () {
//     return view('auth.verify-email');
// })->middleware('auth')->name('verification.notice');


// Route::get('/email/verify/{id}/{hash}', function (EmailVerificationRequest $request) {
//     $request->fulfill();

//     return redirect('/profile');
// })->middleware(['auth', 'signed'])->name('verification.verify');

// Route::post('/email/verification-notification', function (Request $request) {
//     $request->user()->sendEmailVerificationNotification();

//     return back()->with('message', 'Verification link sent!');
// })->middleware(['auth', 'throttle:6,1'])->name('verification.send');


Route::prefix('pos')
->middleware(['auth', 'permission.add'])
->group(function () {
    // roles
    Route::prefix('role')
    ->name('role.')
    ->group(function () {
        // custom role routes
    });
    // role resource controller
    Route::resource('role', RoleController::class);
    // user resource controller
    Route::resource('user', UserController::class);


    //Unit Controller
    Route::prefix('unit')->name('unit.')->group(function () {
        Route::get('trash', [UnitController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [UnitController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [UnitController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Unit resource controller
    Route::resource('unit', UnitController::class);

    //Branch Controller
    Route::prefix('branch')->name('branch.')->group(function () {
        Route::get('trash', [BranchController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [BranchController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [BranchController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Branch resource controller
    Route::resource('branch', BranchController::class);

    //Cash Controller
    Route::prefix('cash')->name('cash.')->group(function () {
        Route::get('trash', [CashController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [CashController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [CashController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Cash resource controller
    Route::resource('cash', CashController::class);

    //Brand Controller
    Route::prefix('brand')->name('brand.')->group(function () {
        Route::get('trash', [BrandController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [BrandController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [BrandController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Brand resource controller
    Route::resource('brand', BrandController::class);

    //Category Controller
    Route::prefix('category')->name('category.')->group(function () {
        Route::get('trash', [CategoryController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [CategoryController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [CategoryController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Category resource controller
    Route::resource('category', CategoryController::class);

    //Supplier Controller
    Route::prefix('supplier')->name('supplier.')->group(function () {
        Route::get('trash', [SupplierController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [SupplierController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [SupplierController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Supplier resource controllers
    Route::resource('supplier', SupplierController::class);

    //Customer Controller
    Route::prefix('customer')->name('customer.')->group(function () {
        Route::get('trash', [CustomerController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [CustomerController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [CustomerController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Customer resource controllers
    Route::resource('customer', CustomerController::class);

    //Product Controller
    Route::prefix('product')->name('product.')->group(function () {
        Route::get('trash', [ProductController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [ProductController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [ProductController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Product resource controller
    Route::resource('product', ProductController::class);

    //Bank Controller
    Route::prefix('bank')->name('bank.')->group(function () {
        Route::get('trash', [BankController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [BankController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [BankController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Bank resource controller
    Route::resource('bank', BankController::class);

    //Bank Account  Controller
    Route::prefix('bank-account')->name('bank-account.')->group(function () {
        Route::get('trash', [BankAccountController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [BankAccountController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [BankAccountController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Bank Account resource controller
    Route::resource('bank-account', BankAccountController::class);

    //Purchase Controller
    Route::prefix('purchase')->name('purchase.')->group(function () {
        Route::get('trash', [PurchaseController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [PurchaseController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [PurchaseController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Purchase resource controller
    Route::resource('purchase', PurchaseController::class);
    // Stock resource controller
    Route::resource('stock', StockController::class);

    //Purchase Return Controller
    Route::prefix('purchase-return')->name('purchase-return.')->group(function () {
        Route::get('trash', [PurchaseReturnController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [PurchaseReturnController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [PurchaseReturnController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Purchase Return resource controller
    Route::resource('purchase-return', PurchaseReturnController::class);

    //Sale Controller
    Route::prefix('sale')->name('sale.')->group(function () {
        Route::get('trash', [SaleController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [SaleController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [SaleController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Sale resource controller
    Route::resource('sale', SaleController::class);

    //Sale Return Controller
    Route::prefix('sale-return')->name('sale-return.')->group(function () {
        Route::get('trash', [SaleReturnController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [SaleReturnController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [SaleReturnController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Sale Return resource controller
    Route::resource('sale-return', SaleReturnController::class);

    //Damage Controller
    Route::prefix('damage')->name('damage.')->group(function () {
        Route::get('trash', [DamageController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [DamageController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [DamageController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Damage resource controller
    Route::resource('damage', DamageController::class);

    //Supplier Due Manage Controller
    Route::prefix('supplier-due')->name('supplier-due.')->group(function () {
        Route::get('trash', [SupplierDueManageController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [SupplierDueManageController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [SupplierDueManageController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Supplier due resource controller
    Route::resource('supplier-due', SupplierDueManageController::class);

    //Customer Due Manage Controller
    Route::prefix('customer-due')->name('customer-due.')->group(function () {
        Route::get('trash', [CustomerDueManageController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [CustomerDueManageController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [CustomerDueManageController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Customer due resource controller
    Route::resource('customer-due', CustomerDueManageController::class);

    //Production Controller
    Route::prefix('production')->name('production.')->group(function () {
        Route::get('trash', [ProductionController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [ProductionController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [ProductionController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Production resource controller
    Route::resource('production', ProductionController::class);

    //Product Transfer Controller
    Route::prefix('product-transfer')->name('product-transfer.')->group(function () {
        Route::get('trash', [ProductTransferController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [ProductTransferController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [ProductTransferController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Product Transfer resource controller
    Route::resource('product-transfer', ProductTransferController::class);

    //Expense Category Controller
    Route::prefix('expense-category')->name('expense-category.')->group(function () {
        Route::get('trash', [ExpenseCategoryController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [ExpenseCategoryController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [ExpenseCategoryController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Expense Category resource controller
    Route::resource('expense-category', ExpenseCategoryController::class);

    //Expense Controller
    Route::prefix('expense')->name('expense.')->group(function () {
        Route::get('trash', [ExpenseController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [ExpenseController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [ExpenseController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Expense resource controller
    Route::resource('expense', ExpenseController::class);

    //Withdraw Controller
    Route::prefix('withdraw')->name('withdraw.')->group(function () {
        Route::get('trash', [WithdrawController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [WithdrawController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [WithdrawController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Withdraw resource controller
    Route::resource('withdraw', WithdrawController::class);

    // Investor Controller
    Route::prefix('investor')->name('investor.')->group(function () {
        Route::get('trash', [InvestorController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [InvestorController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [InvestorController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Investor resource controller
    Route::resource('investor', InvestorController::class);

    // Invest Controller
    Route::prefix('invest')->name('invest.')->group(function () {
        Route::get('trash', [InvestController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [InvestController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [InvestController::class, 'permanentDelete'])->name('permanentDelete');
        Route::patch('/invests/{id}/toggle-automatic', [InvestController::class, 'toggleAutomatic'])->name('toggleAutomatic');
    });
    // Invest resource controller
    Route::resource('invest', InvestController::class);
    // Invest Withdraw Controller
    Route::prefix('invest-withdraw')->name('invest-withdraw.')->group(function () {
        Route::get('trash', [InvestWithdrawController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [InvestWithdrawController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [InvestWithdrawController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Invest Withdraw resource controller
    Route::resource('invest-withdraw', InvestWithdrawController::class);

    //Transaction Controller
    Route::prefix('transaction')->name('transaction.')->group(function () {
        Route::get('trash', [TransactionController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [TransactionController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [TransactionController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Transaction resource controller
    Route::resource('transaction', TransactionController::class);

    //Payroll Routes
    //Advanced Controller
    Route::prefix('advanced-salary')->name('advanced-salary.')->group(function () {
        Route::get('trash', [AdvancedSalaryController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [AdvancedSalaryController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [AdvancedSalaryController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Advanced resource controller
    Route::resource('advanced-salary', AdvancedSalaryController::class);
    //Salary Controller
    Route::prefix('salary')->name('salary.')->group(function () {
        Route::get('trash', [SalaryController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [SalaryController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [SalaryController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Salary resource controller
    Route::resource('salary', SalaryController::class);

    //Loan Account Controller
    Route::prefix('loan-account')->name('loan-account.')->group(function () {
        Route::get('trash', [LoanAccountController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [LoanAccountController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [LoanAccountController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Loan Account resource controller
    Route::resource('loan-account', LoanAccountController::class);

    //Loan Controller
    Route::prefix('loan')->name('loan.')->group(function () {
        Route::get('trash', [LoanController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [LoanController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [LoanController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Loan resource controller
    Route::resource('loan', LoanController::class);

    //Loan Installment Controller
    Route::prefix('loan-installment')->name('loan-installment.')->group(function () {
        Route::get('trash', [LoanInstallmentController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [LoanInstallmentController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [LoanInstallmentController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Loan Installment resource controller
    Route::resource('loan-installment', LoanInstallmentController::class);

    //Income sector Controller
    Route::prefix('income-sector')->name('income-sector.')->group(function () {
        Route::get('trash', [IncomeSectorController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [IncomeSectorController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [IncomeSectorController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Income sector resource controller
    Route::resource('income-sector', IncomeSectorController::class);

    //Income Record Controller
    Route::prefix('income-record')->name('income-record.')->group(function () {
        Route::get('trash', [IncomeRecordController::class, 'trash'])->name('trash');
        Route::get('restore/{id}', [IncomeRecordController::class, 'restore'])->name('restore');
        Route::get('permanentDelete/{id}', [IncomeRecordController::class, 'permanentDelete'])->name('permanentDelete');
    });
    // Income sector resource controller
    Route::resource('income-record', IncomeRecordController::class);




    Route::prefix('report')->group(function () {
        //Cashbook Report
        Route::get('cash-book', [CashbookController::class, 'index'])->name('report.cash-book');
        Route::get('cash-book-date-data', [CashBookController::class, 'cashBookDateData'])->name('report.cash-book-date-data');
        Route::post('closing-balance-store', [CashBookController::class, 'closingBalanceStore'])->name('report.closing-balance-store');
        //Ledger Reports
        Route::get('customer-ledger', [LedgerController::class, 'customerLedger'])->name('ledger.customer-ledger');
        Route::get('supplier-ledger', [LedgerController::class, 'supplierLedger'])->name('ledger.supplier-ledger');
        Route::get('product-ledger', [LedgerController::class, 'productLedger'])->name('ledger.product-ledger');

        //Purchase Report
        Route::get('purchase-quantity-report', [PurchaseReportController::class, 'purchaseQtyReport'])->name('report.purchase-qty-report');
        Route::get('purchase-voucher-report', [PurchaseReportController::class, 'purchaseVoucherReport'])->name('report.purchase-voucher-report');
        //Sale Report
        Route::get('sale-quantity-report', [SaleReportController::class, 'saleQtyReport'])->name('report.sale-qty-report');
        Route::get('sale-invoice-report', [SaleReportController::class, 'saleInvoiceReport'])->name('report.sale-invoice-report');
        //Stock Report
        Route::get('stock-report', [StockReportController::class, 'index'])->name('report.stock-report');
        //Production Report
        Route::get('production-report', [ProductionReportController::class, 'index'])->name('report.production-report');
        //Expense Report
        Route::get('expense-report', [ExpenseReportController::class, 'index'])->name('report.expense-report');
        Route::get('expense-yearly-report', [ExpenseReportController::class, 'yearlyReport'])->name('report.expense-yearly-report');
        Route::get('expense-report-details/{id}', [ExpenseReportController::class, 'details'])->name('report.expense-details-report');
        //Income Report
        Route::get('income-report', [IncomeReportController::class, 'index'])->name('report.income-report');
        //Profit Loss Report
        Route::get('profit-loss-report', [ProfitLossReportController::class, 'index'])->name('report.profit-loss-report');
        //Net Profit Report
        Route::get('net-profit-report', [NetProfitReportController::class, 'index'])->name('report.net-profit-report');
        //Salary Report
        Route::get('salary-report', [SalaryReportController::class, 'index'])->name('report.salary-report');
        Route::get('salary-monthly-report', [SalaryReportController::class, 'monthlyReport'])->name('report.salary-monthly-report');
        Route::get('/salary-report/{id}', [SalaryReportController::class, 'details'])->name('report.salary-details-report');
    });

    // barcode route
    Route::get('sale-barcode', [BarcodeController::class, 'saleBarcode'])->name('sale-barcode');
    Route::post('generate-sale-barcode', [BarcodeController::class, 'generateSaleBarcode'])->name('generate-sale-barcode');
    Route::get('single-sticker', [BarcodeController::class, 'singleSticker'])->name('single-sticker');
    Route::get('invoice-sticker', [BarcodeController::class, 'invoiceSticker'])->name('invoice-sticker');
    Route::post('generate-invoice-sticker', [BarcodeController::class, 'generateInvoiceSticker'])->name('generate-invoice-sticker');
});

// all utility route
Route::prefix('utility')
    ->middleware('auth')
    ->group(function () {
        Route::get('/get-all-branches', [UtilityController::class, 'getAllBranches']);
        Route::get('/get-all-products', [UtilityController::class, 'getAllProducts']);
        Route::get('/get-all-suppliers', [UtilityController::class, 'getAllSuppliers']);
        Route::get('/get-all-customers', [UtilityController::class, 'getAllCustomers']);
        Route::get('/get-all-banks', [UtilityController::class, 'getAllBanks']);
        Route::get('/get-all-bank-accounts', [UtilityController::class, 'getAllBankAccounts']);
        Route::get('/get-all-cashes', [UtilityController::class, 'getAllCashes']);
        Route::get('/get-product-for-branch/{id}', [BranchController::class, 'getProductForBranch']);
        Route::get('/get-branchId', [UtilityController::class, 'getBranchIdFromUser']);
        Route::get('/get-admin-rule', [UtilityController::class, 'getAdminRule']);
    });

//SMS routes
Route::prefix('sms')
        ->middleware('auth')
        ->group(function(){
            Route::get('/group-sms', [SmsController::class, 'groupSms'])->name('sms.group-sms');
            Route::post('/group-sms', [SmsController::class, 'groupSmsSend']);

            Route::get('/custom-sms', [SmsController::class, 'customSms'])->name('sms.custom-sms');
            Route::post('/custom-sms', [SmsController::class, 'customSmsSend']);

            Route::get('/template-sms', [SmsController::class, 'templateSms'])->name('sms.template-sms');
            Route::post('/template-sms', [SmsController::class, 'templateSmsSend']);

            Route::get('/sms-report', [SmsController::class, 'report'])->name('sms.report');

            //Sms template controller
            Route::resource('sms-template', SmsTemplateController::class);
        });

Route::get('/linkstorage', function () {
    Artisan::call('storage:link');
    return "Storage link create successfully";
});

Route::get('/migrate', function () {
    Artisan::call('migrate');
    return "Migrate successfully";
});

require __DIR__.'/auth.php';
