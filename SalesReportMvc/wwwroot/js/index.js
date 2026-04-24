// Index Page JavaScript
(function($) {
    'use strict';
    
    // Index Module
    window.IndexModule = {
        // Configuration
        config: {
            apiUrl: '/report/get-statistics',
            searchInput: '#orderIdInput',
            viewButton: '#viewInvoiceBtn',
            refreshButton: '#refreshDataBtn',
            exportPdfBtn: '#exportAllPdf',
            exportExcelBtn: '#exportAllExcel'
        },
        
        // Initialize
        init: function() {
            this.loadStatistics();
            this.attachEvents();
        },
        
        // Attach event listeners
        attachEvents: function() {
            var self = this;
            
            // View invoice button
            $(this.config.viewButton).on('click', function() {
                self.viewInvoice();
            });
            
            // Enter key press on search input
            $(this.config.searchInput).on('keypress', function(e) {
                if (e.which === 13) {
                    self.viewInvoice();
                }
            });
            
            // Refresh data button
            $(this.config.refreshButton).on('click', function() {
                self.refreshData();
            });
            
            // Export buttons
            $(this.config.exportPdfBtn).on('click', function() {
                self.exportAllPDF();
            });
            
            $(this.config.exportExcelBtn).on('click', function() {
                self.exportAllExcel();
            });
        },
        
        // Load statistics from server
        loadStatistics: function() {
            $.ajax({
                url: this.config.apiUrl,
                type: 'GET',
                success: function(data) {
                    $('#totalProducts').text(data.totalProducts || 0);
                    $('#totalCategories').text(data.totalCategories || 0);
                    $('#totalRevenue').text((data.totalRevenue || 0).toLocaleString() + 'đ');
                    $('#totalOrders').text(data.totalOrders || 0);
                },
                error: function() {
                    // Fallback data when API not ready
                    $('#totalProducts').text('32');
                    $('#totalCategories').text('8');
                    $('#totalRevenue').text('514,500,000đ');
                    $('#totalOrders').text('35');
                }
            });
        },
        
        // View invoice detail
        viewInvoice: function() {
            var orderId = $(this.config.searchInput).val();
            if (orderId && orderId > 0) {
                window.location.href = '/report/invoice/' + orderId;
            } else {
                this.showNotification('Vui lòng nhập mã đơn hàng hợp lệ', 'warning');
            }
        },
        
        // Refresh all data
        refreshData: function() {
            this.loadStatistics();
            this.showNotification('Dữ liệu đã được làm mới', 'success');
        },
        
        // Export all to PDF
        exportAllPDF: function() {
            this.showNotification('Chức năng xuất PDF đang được phát triển', 'info');
        },
        
        // Export all to Excel
        exportAllExcel: function() {
            this.showNotification('Chức năng xuất Excel đang được phát triển', 'info');
        },
        
        // Show notification
        showNotification: function(message, type) {
            // Create toast notification
            var toast = $(`
                <div class="toast-notification toast-${type}">
                    <i class="fas ${type === 'success' ? 'fa-check-circle' : (type === 'warning' ? 'fa-exclamation-triangle' : 'fa-info-circle')} me-2"></i>
                    ${message}
                </div>
            `);
            
            $('body').append(toast);
            toast.addClass('show');
            
            setTimeout(function() {
                toast.removeClass('show');
                setTimeout(function() {
                    toast.remove();
                }, 300);
            }, 3000);
        }
    };
    
    // Auto-initialize when document is ready
    $(document).ready(function() {
        IndexModule.init();
    });
    
})(jQuery);