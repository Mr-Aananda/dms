<!-- Chart -->
<div class="col-12 widget">
    <div class="my-5 chartjs">
        <div class="row">
            <div class="col-12 col-md-6">
                <canvas id="purchase-chart"></canvas>
            </div>
            <div class="col-12 col-md-6">
                <canvas id="sale-chart"></canvas>
            </div>
            <div class="col-12 col-md-6 mt-5">
                <canvas id="daily-chart"></canvas>
            </div>
            <div class="col-12 col-md-6 mt-5">
                <div style="height: 350px;">
                    <canvas id="doughnut-chart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Chart -->
@push('script')

<script>
     const purchase = document.getElementById('purchase-chart');
        new Chart(purchase, {
            type: 'bar',
            data: {
            labels: {!! json_encode(array_keys($purchaseMonthlyData)) !!},
            datasets: [{
                label: 'Purchase',
                backgroundColor: 'rgb(12, 168, 192)',
                data: {!! json_encode(array_values($purchaseMonthlyData)) !!},
            }]
            },
            options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
            }
        });

    const sale = document.getElementById('sale-chart');
        new Chart(sale, {
            type: 'bar',
            data: {
            labels: {!! json_encode(array_keys($saleMonthlyData)) !!},
            datasets: [{
                label: 'Sale',
                backgroundColor: 'rgb(12, 168, 192)',
                data: {!! json_encode(array_values($saleMonthlyData)) !!},
            }]
            },
            options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
            }
        });

        // this chart for Daily
        let dailyChart = document.getElementById('daily-chart').getContext('2d');
        new Chart(dailyChart, {
            // The type of chart we want to create
            type: 'line',

            // The data for our dataset
            data: {
                labels: {!! json_encode(array_keys($dailySaleData)) !!},
                datasets: [{
                    label: 'Sale',
                    backgroundColor: 'transparent',
                    borderColor: 'rgb(12, 168, 192)',
                    data: {!! json_encode(array_values($dailySaleData)) !!},
                },

                {
                    label: 'Purchase',
                    backgroundColor: 'transparent',
                    borderColor: 'rgb(244, 124, 142)',
                    data: {!! json_encode(array_values($dailyPurchaseData)) !!},
                },

                ]
            },

            // Configuration options go here
            options: {}
        });
        // End Daily chart

        let doughnutDaliy = document.getElementById('doughnut-chart').getContext('2d');
            new Chart(doughnutDaliy, {
                type: 'doughnut',
                data: {
                    labels: [
                        'Sale: {{$todaySaleAmount }}',
                        'Purchase: {{ $todayPurchaseAmount}}',
                        'Partial Income: {{ $todayIncome }}',
                        'Expense: {{ $todayExpense }}',
                    ],
                    datasets: [{
                        data: [
                            {{$todaySaleAmount }},
                            {{ $todayPurchaseAmount}},
                            {{ $todayIncome }},
                            {{ $todayExpense }},
                        ],
                        backgroundColor: ["#0CA8C0", "#FFCE56","#bb3ded", "#FF6384"],
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    width: 200,
                    height: 200,
                }
            });

</script>

@endpush

