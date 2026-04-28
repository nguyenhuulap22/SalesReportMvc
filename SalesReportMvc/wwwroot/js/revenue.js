// Revenue Report JavaScript

function initRevenueChart(dates, values) {
    if (dates && dates.length > 0 && values && values.length > 0) {
        var ctx = document.getElementById('revenueChart').getContext('2d');
        return new Chart(ctx, {
            type: 'line',
            data: {
                labels: dates,
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: values,
                    borderColor: 'rgb(59, 130, 246)',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: 'rgb(59, 130, 246)',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 4,
                    pointHoverRadius: 6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                let label = context.dataset.label || '';
                                let value = context.raw;
                                return label + ': ' + new Intl.NumberFormat('vi-VN').format(value) + 'đ';
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value) {
                                return new Intl.NumberFormat('vi-VN').format(value) + 'đ';
                            }
                        },
                        title: {
                            display: true,
                            text: 'Doanh thu (VNĐ)'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Ngày'
                        }
                    }
                }
            }
        });
    }
    return null;
}


function applyFilters() {
    $('#pageInput').val(1);
    $('#filterForm').submit();
}

function resetFilters() {
    $('#fromDate').val('');
    $('#toDate').val('');
    $('#pageInput').val(1);
    $('#filterForm').submit();
}

function clearAllFilters() {
    window.location.href = '/report/revenue';
}


function exportToExcel() {
    var fromDate = $('#fromDate').val();
    var toDate = $('#toDate').val();
    var url = '/report/revenue/export-excel?';
    if (fromDate) url += 'fromDate=' + fromDate + '&';
    if (toDate) url += 'toDate=' + toDate;
    window.location.href = url;
}


function changePageSize() {
    var newSize = $('#pageSizeSelect').val();
    $('#pageSizeInput').val(newSize);
    $('#pageInput').val(1);
    $('#filterForm').submit();
}

function initRevenueEvents() {
   
    $('#pageSizeSelect').off('change').on('change', changePageSize);

   
    $('#resetFilter').off('click').on('click', resetFilters);

    
    $('#clearFilters').off('click').on('click', clearAllFilters);


    $('#exportExcelBtn').off('click').on('click', exportToExcel);
}

function initRevenuePage() {
    initRevenueEvents();

    if (typeof revenueChartData !== 'undefined') {
        initRevenueChart(revenueChartData.dates, revenueChartData.values);
    }
}

// Export module
window.RevenueModule = {
    init: initRevenuePage,
    initChart: initRevenueChart,
    exportExcel: exportToExcel,
    resetFilters: resetFilters
};