using SalesReport.Reporting;
namespace SalesReportMvc.Services
{
    public interface IReportService
    {
        Task<List<ProductReportDto>> GetProductsReportAsync();
        Task<List<InvoiceReportDto>> GetInvoiceReportAsync(int orderId);
        Task<List<RevenueReportDto>> GetRevenueByDateAsync();
    }
}