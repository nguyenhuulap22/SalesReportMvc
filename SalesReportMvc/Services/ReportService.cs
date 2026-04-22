using Microsoft.EntityFrameworkCore;
using SalesReportMvc.Data;
using SalesReportMvc.Models.ReportDtos;

namespace SalesReportMvc.Services
{
    public class ReportService : IReportService
    {
        private readonly AppDbContext _context;

        public ReportService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<List<ProductReportDto>> GetProductsReportAsync()
        {
            return await _context.Products
                .Include(p => p.Category)
                .Select(p => new ProductReportDto
                {
                    ProductId = p.ProductId,
                    ProductName = p.ProductName,
                    CategoryName = p.Category != null ? p.Category.CategoryName : "",
                    UnitPrice = p.UnitPrice,
                    StockQuantity = p.StockQuantity,
                    Unit = p.Unit ?? ""
                })
                .ToListAsync();
        }

        public async Task<List<InvoiceReportDto>> GetInvoiceReportAsync(int orderId)
        {
            return await _context.OrderDetails
                .Where(od => od.OrderId == orderId)
                .Include(od => od.Order)
                    .ThenInclude(o => o.Customer)
                .Include(od => od.Order)
                    .ThenInclude(o => o.Employee)
                .Include(od => od.Product)
                .Select(od => new InvoiceReportDto
                {
                    OrderCode = od.Order != null ? od.Order.OrderCode : "",
                    OrderDate = od.Order != null ? od.Order.OrderDate : DateTime.MinValue,
                    CustomerName = od.Order != null && od.Order.Customer != null ? od.Order.Customer.FullName : "Khách lẻ",
                    EmployeeName = od.Order != null && od.Order.Employee != null ? od.Order.Employee.FullName : "",
                    ProductName = od.Product != null ? od.Product.ProductName : "",
                    Quantity = od.Quantity,
                    UnitPrice = od.UnitPrice,
                    Discount = od.Discount,
                    SubTotal = od.SubTotal,
                    TotalAmount = od.Order != null ? od.Order.TotalAmount : 0
                })
                .ToListAsync();
        }

        public async Task<List<RevenueReportDto>> GetRevenueByDateAsync()
        {
            return await _context.Orders
                .Where(o => o.Status == "Paid")
                .GroupBy(o => o.OrderDate.Date)
                .Select(g => new RevenueReportDto
                {
                    SaleDate = g.Key,
                    Revenue = g.Sum(x => x.TotalAmount)
                })
                .OrderBy(x => x.SaleDate)
                .ToListAsync();
        }
    }
}