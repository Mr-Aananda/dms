@section('title', 'Cashbook')

<x-app-layout>

    <!-- Start main-bar -->
    <!-- Start header widget -->
    <div class="widget mb-3">
        <div class="widget-body d-flex">
            <!-- Start menu -->
        @include('pos.reports.cash-book.menu')
        <!-- End menu -->
            <!-- Start right buttons -->
            <div class="ms-auto">
                <button type="button" class="btn icon lg rounded collapsed" title="Search"
                        data-bs-toggle="collapse" data-bs-target="#tableSearch" aria-controls="tableSearch"
                        aria-expanded="false">
                    <i class="bi bi-search"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Print"
                        onclick="printable('print-widget')">
                    <i class="bi bi-printer"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Reloar" onclick="location.reload()">
                    <i class="bi bi-bootstrap-reboot"></i>
                </button>
                <button type="button" class="btn icon lg rounded" title="Go back" onclick="history.back()">
                    <i class="bi bi-arrow-left"></i>
                </button>
            </div>
            <!-- End right buttons -->
        </div>
        <!-- Start Filter Fill -->
        <div class="widget-body collapse {{ request()->search == '1' ? 'show' : '' }}" id="tableSearch">
            <form action="{{ route('report.cash-book') }}" method="get">
                <div class="row py-3 g-3">
                    <input hidden type="text" name="search" value="1">
                    <div class="col-md-4">
                        <label for="date" class="form-label">Date</label>
                        <input type="date" name="date" value="{{ request()->date ?: date('Y-m-d') }}" class="form-control">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-success d-block w-100" type="submit"><i class="bi bi-search"></i> Search</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- End Filter Fill -->
    </div>
    <!-- End header widget -->

    <div id="print-widget">
            <!-- Start print header -->
            <x-print.header/>
            <!-- End print header -->
            <!-- Start body widget -->
        <div class="widget">
            <div class="widget-head mb-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5>Cash Book</h5>
                        <p><small>Details are given below.</small></p>
                    </div>
                    <h5>Date: {{ request()->search ? \Carbon\Carbon::parse(request()->date)->format('d-M-Y') : date('d-M-Y') }}</h5>
                </div>
            </div>

            <div class="widget-body">
                <div class="row">
                    <div class="col-md-6">
                        <table class="table table-bordered table-sm table-striped-columns">
                            <thead>
                                <tr>
                                    <th>Income Details</th>
                                    <th class="text-end">Amount</th>
                                    <th class="text-end print-none"" style="max-width: 30px" >Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Opening Balance</td>
                                    <td class="text-end">{{number_format($data['opening_balance']->amount ?? 0,2)}}</td>
                                </tr>
                                <!-- Sale History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-primary">Sale :</th>
                                </tr>

                                @foreach ($data['sales'] as $sale )
                                <tr>
                                    <td>
                                        {{$sale->party?->name ?? ''}} ({{$sale->party?->phone ?? ''}})
                                        {{-- <br>
                                        @if ($sale->note)
                                            <span> <strong>Note:</strong> {{ $sale->note }}</span>
                                        @endif --}}
                                    </td>
                                    <td class="text-end">{{number_format($sale->paid,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('sale.show', $sale->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Sale:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_sale'],2)}}
                                    </td>
                                </tr>
                                <!-- Sale History -->
                                <!-- Due Recieve History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-primary">Due Recieve:</th>
                                </tr>

                               @foreach ($data['due_receives'] as $due )
                                <tr>
                                    <td>
                                        {{$due->party?->name ?? ''}} ({{$due->party?->phone ?? ''}})
                                        <br>
                                        @if ($due->description)
                                            <span> <strong>Note:</strong> {{ $due->description }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">
                                        {{number_format($due->amount,2)}}
                                    </td>
                                </tr>

                               @endforeach
                                <tr>
                                    <th>Total Due Recieve:</th>
                                    <td class="text-end">
                                        {{number_format($data['total_due_receive'],2)}}
                                    </td>
                                </tr>
                                <!-- Due Recieve History -->
                                <!-- Purchase Return History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-primary">Purchase Return:</th>
                                </tr>
                                @foreach ($data['purchase_returns'] as $return )
                                <tr>
                                    <td>
                                        {{$return->party?->name ?? ''}} ({{$return->party?->address ?? ''}})
                                        {{-- <br>
                                        @if ($return->note)
                                            <span> <strong>Note:</strong> {{ $return->note }}</span>
                                        @endif --}}
                                    </td>
                                    <td class="text-end">{{number_format($return->return_total_paid,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('purchase-return.show', $return->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Purchase Return:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_purchase_return'],2)}}
                                    </td>
                                </tr>
                                <!-- Purchase Return History -->

                                <!-- Investment History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-primary">Investments:</th>
                                </tr>
                                @foreach ($data['invests'] as $invest )
                                <tr>
                                    <td>
                                        {{$invest->investor?->name ?? ''}}
                                        <br>
                                        @if ($invest->note)
                                            <span> <strong>Note:</strong> {{ $invest->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format($invest->amount,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('invest.show', $invest->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Invest:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_invest'],2)}}
                                    </td>
                                </tr>

                                <!-- Daily Expense History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-primary">Daily Incomes:</th>
                                </tr>
                                @foreach ($data['incomes'] as $income )
                                <tr>
                                    <td>
                                        {{$income->incomeSector?->name ?? ''}}
                                        <br>
                                        @if ($income->note)
                                            <span> <strong>Note:</strong> {{ $income->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format($income->amount,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('income-record.show', $income->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Income:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_income'],2)}}
                                    </td>
                                </tr>
                                <!-- Daily Expense History -->

                                 <!-- Advance History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-primary">Advanced Recieved :</th>
                                </tr>

                                @foreach ($data['advances_recieved'] as $advance )
                                <tr>
                                    <td>
                                        {{$advance->employee?->name ?? ""}}
                                        <br>
                                        @if ($advance->note)
                                            <span> <strong>Note:</strong> {{ $advance->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format($advance->amount,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('advanced-salary.show', $advance->employee_id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Advanced Recieved:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format(abs($data['total_advanced_recieved']),2)}}
                                    </td>
                                </tr>
                                <!-- Advance History -->

                                 <!-- Loan Taken History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-primary">Loan Taken :</th>
                                </tr>

                                @foreach ($data['loan_taken'] as $loan )
                                <tr>
                                    <td>
                                        {{$loan->loanAccount?->name ?? ""}}
                                        <br>
                                        @if ($loan->note)
                                            <span> <strong>Note:</strong> {{ $loan->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format($loan->amount,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('loan.show', $loan->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Taken Loan:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_loan_taken'],2)}}
                                    </td>
                                </tr>
                                <!-- Loan Taken History -->

                                <!-- All Grand Total-->
                                <tr>
                                    <th class="fs-5">Grand Total :</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_sale']
                                        + $data['total_due_receive']
                                        + $data['total_purchase_return']
                                        + $data['total_invest']
                                        + $data['total_income']
                                        + $data['total_advanced_recieved']
                                        + $data['total_loan_taken']
                                        + ($data['opening_balance']->amount ?? 0), 2)}}
                                        {{-- {{number_format($data['total_sale'] + $data['total_due_receive'] + $data['total_purchase_return'] , 2)}} --}}
                                    </td>
                                </tr>
                                <!-- All Grand Total-->
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <table class="table table-bordered table-sm table-striped-columns">
                            <thead>
                                <tr>
                                    <th>Expenditure Details</th>
                                    <th class="text-end">Amount</th>
                                    <th class="text-end print-none"" style="max-width: 30px" >Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Purchase History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-danger">Purchase :</th>
                                </tr>

                                @foreach ($data['purchases'] as $purchase )
                                <tr>
                                    <td>{{$purchase->party?->name ?? ''}} ({{$purchase->party?->phone ?? ''}})</td>
                                    <td class="text-end">{{number_format($purchase->paid,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('purchase.show', $purchase->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Purchase:</th>
                                    <td class="text-end">
                                        {{number_format($data['total_purchase'],2)}}
                                    </td>
                                </tr>
                                <!-- Purchase History -->
                                 <!-- Due Paid History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-danger">Due Paid:</th>
                                </tr>

                               @foreach ($data['due_payments'] as $payment )
                                <tr>
                                    <td>
                                        {{$payment->party?->name ?? ''}} ({{$payment->party?->phone ?? ''}})
                                        <br>
                                        @if ($payment->description)
                                            <span> <strong>Note:</strong> {{ $payment->description }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">
                                        {{number_format(abs($payment->amount),2)}}
                                    </td>
                                </tr>

                               @endforeach
                                <tr>
                                    <th>Total Due Paid:</th>
                                    <td class="text-end">
                                        {{number_format(abs($data['total_due_payment']),2)}}
                                    </td>
                                </tr>
                                <!-- Due Paid History -->
                                <!-- Sale Return History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-danger">Sale Return:</th>
                                </tr>
                                @foreach ($data['sale_returns'] as $return )
                                <tr>
                                    <td>
                                        {{$return->party?->name ?? ''}} ({{$return->party?->phone ?? ''}})
                                        {{-- <br>
                                        @if ($return->note)
                                            <span> <strong>Note:</strong> {{ $return->note }}</span>
                                        @endif --}}
                                    </td>
                                    <td class="text-end">{{number_format($return->return_total_paid,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('sale-return.show', $return->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Sale Return:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_sale_return'],2)}}
                                    </td>
                                </tr>
                                <!-- Sale Return History -->

                                <!-- Daily Expense History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-danger">Daily Expenses:</th>
                                </tr>
                                @foreach ($data['expenses'] as $expense )
                                <tr>
                                    <td>
                                        {{$expense->expenseCategory?->name ?? ''}}
                                        {{ $expense->expenseSubcategory ? '( ' . $expense->expenseSubcategory->name . ' )' : '' }}
                                        <br>
                                        @if ($expense->note)
                                            <span> <strong>Note:</strong> {{ $expense->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format($expense->amount,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('expense.show', $expense->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Expense:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_expense'],2)}}
                                    </td>
                                </tr>
                                <!-- Daily Expense History -->
                                <!-- Withdraw History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-danger">Withdraw:</th>
                                </tr>
                                @foreach ($data['withdraws'] as $withdraw )
                                <tr>
                                    <td>
                                        {{$withdraw->user?->name ?? ''}}
                                        <br>
                                        @if ($withdraw->note)
                                            <span> <strong>Note:</strong> {{ $withdraw->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format($withdraw->amount,2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('withdraw.show', $withdraw->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Withdraw:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_withdraw'],2)}}
                                    </td>
                                </tr>
                                <!-- Withdraw History -->

                                 <!-- Salary History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-danger">Salary :</th>
                                </tr>

                                @foreach ($data['salaries'] as $salary )
                                <tr>
                                    <td>
                                        {{$salary->employee?->name ?? ""}}
                                        <br>
                                        @if ($salary->note)
                                            <span> <strong>Note:</strong> {{ $salary->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format($salary->details->sum('amount'),2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('salary.show', $salary->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Salary:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_salary'],2)}}
                                    </td>
                                </tr>
                                <!-- Salary History -->

                                <!-- Advance Given History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-danger">Advanced Salary :</th>
                                </tr>

                                @foreach ($data['advances'] as $advance )
                                <tr>
                                    <td>
                                        {{$advance->employee?->name ?? ""}}
                                        <br>
                                        @if ($advance->note)
                                            <span> <strong>Note:</strong> {{ $advance->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format(abs($advance->amount),2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('advanced-salary.show', $advance->employee_id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Advanced Salary:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format(abs($data['total_advanced']),2)}}
                                    </td>
                                </tr>
                                <!-- Advance History -->

                                <!-- Loan Given History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-danger">Loan Given :</th>
                                </tr>

                                @foreach ($data['loan_given'] as $loan )
                                <tr>
                                    <td>
                                        {{$loan->loanAccount?->name ?? ""}}
                                        <br>
                                        @if ($loan->note)
                                            <span> <strong>Note:</strong> {{ $loan->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format(abs($loan->amount),2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('loan.show', $loan->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Given Loan:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format(abs($data['total_loan_given']),2)}}
                                    </td>
                                </tr>
                                <!-- Loan Given History -->
                                <!-- Invest profit/add History -->
                                <tr>
                                    <th colspan="3" class="fs-5 text-danger">Invest Withdraw :</th>
                                </tr>

                                @foreach ($data['invests_withdraws'] as $withdraw )
                                <tr>
                                    <td>
                                        {{$withdraw->invest?->investor?->name ?? ""}}
                                        ( {{$withdraw->type ?? ""}} )
                                        <br>
                                        @if ($withdraw->note)
                                            <span> <strong>Note:</strong> {{ $withdraw->note }}</span>
                                        @endif
                                    </td>
                                    <td class="text-end">{{number_format(abs($withdraw->amount),2)}}</td>
                                    <td class="text-end print-none">
                                        <a href="{{ route('invest.show', $withdraw->invest->id) }}" class="btn btn-primary sm">
                                            <i class="bi bi-eye-fill"></i>
                                        </a>
                                    </td>
                                </tr>
                                @endforeach
                                <tr>
                                    <th>Total Invest Withdraw:</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_invest_withdraw'],2)}}
                                    </td>
                                </tr>
                                <!-- Invest profit/add History -->


                                <!-- All Grand Total-->
                                <tr>
                                    <th class="fs-5">Expenditure Total :</th>
                                    <td class="text-end fw-bold">
                                        {{number_format($data['total_purchase']
                                        + abs($data['total_due_payment'])
                                        + $data['total_sale_return']
                                        + $data['total_expense']
                                        + $data['total_withdraw']
                                        + $data['total_invest_withdraw']
                                        + $data['total_salary']
                                        + abs($data['total_advanced'])
                                        + abs($data['total_loan_given'])
                                         , 2)}}
                                    </td>
                                </tr>
                                <!-- All Grand Total-->

                            </tbody>
                        </table>

                    </div>
                    <div class="col-md-12">
                        <table class="table table-bordered table-sm">
                            <tbody>
                                <tr>
                                    <td class="fw-bold fs-5">Cash in hand : </td>
                                    <td class="text-end fw-bold">
                                        @if (request()->search)
                                            {{number_format(($data['total_sale']
                                            + $data['total_due_receive']
                                            + $data['total_purchase_return']
                                            + $data['total_invest']
                                            + abs($data['total_advanced_recieved'])
                                            + $data['total_loan_taken']
                                            + ($data['opening_balance']->amount ?? 0))
                                            -
                                            ($data['total_purchase']
                                            + abs($data['total_due_payment'])
                                            + $data['total_sale_return']
                                            + $data['total_expense']
                                            + $data['total_withdraw']
                                            + $data['total_invest_withdraw']
                                            + $data['total_salary']
                                            + abs($data['total_advanced'])
                                            + abs($data['total_loan_given'])
                                            ), 2)}}
                                        @else
                                        {{number_format($data['cash_balance'],2 )}}

                                        @endif
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-12">
                        <!-- Start Modal button -->
                        <button class="btn btn-primary print-none float-end" data-bs-toggle="modal" data-bs-target="#closingBalanceModal">
                            <i class="bi bi-arrow-right"></i>
                            Cash Close
                        </button>
                        <!-- End Modal button  -->
                        <!-- Start Modal -->
                        <div class="modal fade" id="closingBalanceModal" tabindex="-1" aria-labelledby="closingBalanceModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="closingBalanceModalLabel">Create Closing Balance</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="{{ route('report.closing-balance-store') }}" method="POST">
                                            @csrf
                                            <div class="mb-3">
                                                <label for="date" class="form-label required">Date:</label>
                                                <input type="date" name="date" class="form-control" value="{{ date('Y-m-d') }}" id="date" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="amount" class="form-label required">Amount:</label>
                                                <input type="number" name="amount" class="form-control" value="{{ $data['cash_balance'] }}" id="amount" placeholder="0.00" required readonly>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Save</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- End Modal-->
                    </div>
                </div>
            </div>
            <!-- End body widget -->
        </div>
    </div>
    <!-- End main-bar-->
</x-app-layout>
