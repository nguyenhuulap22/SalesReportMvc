// Invoice Report JavaScript
(function ($) {
    'use strict';

    window.InvoiceModule = {
        config: {
            exportPdfBtn: '#exportPdfBtn',
            printBtn: '#printBtn'
        },

        init: function () {
            this.attachEvents();
        },

        attachEvents: function () {
            var self = this;

            $(this.config.exportPdfBtn).on('click', function () {
                self.exportToPDF();
            });

            if ($(this.config.printBtn).length) {
                $(this.config.printBtn).on('click', function () {
                    self.printInvoice();
                });
            }
        },

        exportToPDF: function () {
            alert('Chức năng xuất PDF đang được phát triển');
        },

        printInvoice: function () {
            window.print();
        },

        formatCurrency: function (amount) {
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(amount);
        }
    };

    $(document).ready(function () {
        if (typeof InvoiceModule !== 'undefined') {
            InvoiceModule.init();
        }
    });
})(jQuery);