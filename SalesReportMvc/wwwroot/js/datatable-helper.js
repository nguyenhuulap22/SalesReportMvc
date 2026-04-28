(function ($) {
    'use strict';
    window.DataTableHelper = {
        defaults: {
            searchInput: '#searchInput',
            categoryFilter: '#categoryFilter',
            stockFilter: '#stockFilter',
            resetButton: '#resetFilter',
            tableId: '#dataTable',
            visibleCountId: '#visibleCount',
            columnMapping: {
                nameColumn: 1,      
                categoryColumn: 2,  
                stockColumn: 4      
            },
            // Các loại lọc
            filterTypes: {
                stock: {
                    low: { condition: (stock) => stock < 10, label: 'Còn ít' },
                    medium: { condition: (stock) => stock >= 10 && stock <= 50, label: 'Trung bình' },
                    high: { condition: (stock) => stock > 50, label: 'Nhiều' }
                }
            }
        },

        init: function (options) {
            var config = $.extend(true, {}, this.defaults, options);

            $(config.tableId).data('datatable-config', config);

            this.attachEvents(config);

            this.filterTable(config);
        },

        attachEvents: function (config) {
            $(config.searchInput).off('keyup.datatable').on('keyup.datatable', function () {
                window.DataTableHelper.filterTable(config);
            });

            $(config.categoryFilter).off('change.datatable').on('change.datatable', function () {
                window.DataTableHelper.filterTable(config);
            });

            
            $(config.stockFilter).off('change.datatable').on('change.datatable', function () {
                window.DataTableHelper.filterTable(config);
            });

            
            $(config.resetButton).off('click.datatable').on('click.datatable', function () {
                window.DataTableHelper.resetFilters(config);
            });
        },

        filterTable: function (config) {
            var searchText = $(config.searchInput).val().toLowerCase();
            var category = $(config.categoryFilter).val();
            var stockFilter = $(config.stockFilter).val();
            var visibleCount = 0;

            $(config.tableId + ' tbody tr').each(function () {
                var $row = $(this);
                var productName = $row.find('td:eq(' + config.columnMapping.nameColumn + ')').text().toLowerCase();
                var productCategory = $row.find('td:eq(' + config.columnMapping.categoryColumn + ')').text().trim();
                var stockText = $row.find('td:eq(' + config.columnMapping.stockColumn + ')').text().trim();
                var stock = parseInt(stockText) || 0;

                var matchSearch = searchText === '' || productName.indexOf(searchText) > -1;
                var matchCategory = category === '' || productCategory === category;
                var matchStock = true;

                if (stockFilter && config.filterTypes.stock[stockFilter]) {
                    matchStock = config.filterTypes.stock[stockFilter].condition(stock);
                }

                if (matchSearch && matchCategory && matchStock) {
                    $row.show();
                    visibleCount++;
                } else {
                    $row.hide();
                }
            });

            if (config.visibleCountId) {
                $(config.visibleCountId).text(visibleCount);
            }

            $(config.tableId).trigger('filtered.datatable', [visibleCount]);
        },

        resetFilters: function (config) {
            $(config.searchInput).val('');
            $(config.categoryFilter).val('');
            $(config.stockFilter).val('');
            this.filterTable(config);
        },

        // Xuất Excel
        exportToExcel: function (tableId, filename) {
            var table = $(tableId).clone();
            var html = '<html><head><meta charset="UTF-8">' +
                '<style>th, td { border: 1px solid #ddd; padding: 8px; }</style>' +
                '</head><body>' + table[0].outerHTML + '</body></html>';

            var blob = new Blob([html], { type: 'application/vnd.ms-excel' });
            var link = document.createElement('a');
            var now = new Date();
            var timestamp = now.getFullYear() +
                ('0' + (now.getMonth() + 1)).slice(-2) +
                ('0' + now.getDate()).slice(-2) + '_' +
                ('0' + now.getHours()).slice(-2) +
                ('0' + now.getMinutes()).slice(-2);
            var fileName = filename + '_' + timestamp + '.xls';

            link.download = fileName;
            link.href = URL.createObjectURL(blob);
            link.click();
            URL.revokeObjectURL(link.href);
        },

        // In bảng
        printTable: function (tableId, title) {
            var printContent = $(tableId).clone();
            var printWindow = window.open('', '_blank');
            printWindow.document.write('<html><head><title>' + title + '</title>');
            printWindow.document.write('<style>');
            printWindow.document.write('th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }');
            printWindow.document.write('table { border-collapse: collapse; width: 100%; }');
            printWindow.document.write('th { background-color: #f2f2f2; }');
            printWindow.document.write('</style>');
            printWindow.document.write('</head><body>');
            printWindow.document.write('<h2>' + title + '</h2>');
            printWindow.document.write(printContent[0].outerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
            printWindow.close();
        }
    };

})(jQuery);