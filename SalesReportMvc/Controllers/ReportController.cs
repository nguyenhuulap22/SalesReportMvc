using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SalesReportMvc.Data;
using SalesReportMvc.Services;
using SalesReportMvc.Models.ReportDtos;
using SalesReportMvc.Models;
using System.Text;

namespace SalesReportMvc.Controllers
{
    [Route("report")]
    public class ReportController : Controller
    {
        private readonly AppDbContext _context;
        private readonly IReportService _reportService;
        private readonly IPdfExportService _pdfExportService;

        public ReportController(AppDbContext context, IReportService reportService, IPdfExportService pdfExportService)
        {
            _context = context;
            _reportService = reportService;
            _pdfExportService = pdfExportService;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            return View();
        }

        [Route("test-db")]
        public IActionResult TestDb()
        {
            var count = _context.Categories.Count();
            return Content("Kết nối thành công. Số category = " + count);
        }

        // ========== PRODUCTS WITH PAGINATION ==========
        [Route("products")]
        public async Task<IActionResult> Products(int page = 1, int pageSize = 10, string search = "", string category = "", string stock = "")
        {
            var allData = await _reportService.GetProductsReportAsync();
            var allCategories = allData.Select(p => p.CategoryName).Distinct().OrderBy(x => x).ToList();
            ViewBag.AllCategories = allCategories;
            ViewBag.TotalCategories = allCategories.Count();

            if (!string.IsNullOrEmpty(search))
            {
                allData = allData.Where(p => p.ProductName.Contains(search, StringComparison.OrdinalIgnoreCase)).ToList();
            }

            if (!string.IsNullOrEmpty(category))
            {
                allData = allData.Where(p => p.CategoryName == category).ToList();
            }

            if (!string.IsNullOrEmpty(stock))
            {
                allData = stock switch
                {
                    "low" => allData.Where(p => p.StockQuantity < 10).ToList(),
                    "medium" => allData.Where(p => p.StockQuantity >= 10 && p.StockQuantity <= 50).ToList(),
                    "high" => allData.Where(p => p.StockQuantity > 50).ToList(),
                    _ => allData
                };
            }

            var totalRecords = allData.Count();
            var pagedData = allData.Skip((page - 1) * pageSize).Take(pageSize).ToList();
            var totalInventoryValue = pagedData.Sum(x => x.UnitPrice * x.StockQuantity);
            var lowStockCount = pagedData.Count(x => x.StockQuantity < 10);

            string GetPageUrl(int p) => $"/report/products?page={p}&pageSize={pageSize}&search={Uri.EscapeDataString(search)}&category={Uri.EscapeDataString(category)}&stock={Uri.EscapeDataString(stock)}";

            ViewBag.Pagination = new PaginationModel
            {
                CurrentPage = page,
                PageSize = pageSize,
                TotalRecords = totalRecords,
                GetPageUrl = GetPageUrl
            };

            ViewBag.Search = search;
            ViewBag.Category = category;
            ViewBag.Stock = stock;
            ViewBag.TotalInventoryValue = totalInventoryValue;
            ViewBag.LowStockCount = lowStockCount;

            return View(pagedData);
        }

        // ========== REVENUE WITH PAGINATION ==========
        [Route("revenue")]
        public async Task<IActionResult> Revenue(int page = 1, int pageSize = 10, DateTime? fromDate = null, DateTime? toDate = null)
        {
            var allData = await _reportService.GetRevenueByDateAsync();

            if (fromDate.HasValue)
            {
                allData = allData.Where(r => r.SaleDate >= fromDate.Value).ToList();
                ViewBag.FromDate = fromDate.Value.ToString("yyyy-MM-dd");
            }

            if (toDate.HasValue)
            {
                allData = allData.Where(r => r.SaleDate <= toDate.Value).ToList();
                ViewBag.ToDate = toDate.Value.ToString("yyyy-MM-dd");
            }

            var totalRecords = allData.Count();
            var totalRevenue = allData.Sum(x => x.Revenue);
            var avgRevenue = allData.Any() ? allData.Average(x => x.Revenue) : 0;
            var maxRevenue = allData.Any() ? allData.Max(x => x.Revenue) : 0;
            var minRevenue = allData.Any() ? allData.Min(x => x.Revenue) : 0;
            var pagedData = allData.Skip((page - 1) * pageSize).Take(pageSize).ToList();

            string GetPageUrl(int p) => $"/report/revenue?page={p}&pageSize={pageSize}&fromDate={ViewBag.FromDate}&toDate={ViewBag.ToDate}";

            ViewBag.Pagination = new PaginationModel
            {
                CurrentPage = page,
                PageSize = pageSize,
                TotalRecords = totalRecords,
                GetPageUrl = GetPageUrl
            };

            ViewBag.TotalRevenue = totalRevenue;
            ViewBag.AvgRevenue = avgRevenue;
            ViewBag.MaxRevenue = maxRevenue;
            ViewBag.MinRevenue = minRevenue;
            ViewBag.FromDateFilter = fromDate;
            ViewBag.ToDateFilter = toDate;
            ViewBag.ChartDates = allData.Select(x => x.SaleDate.ToString("dd/MM")).ToList();
            ViewBag.ChartValues = allData.Select(x => x.Revenue).ToList();

            return View(pagedData);
        }

        // ========== INVOICE ==========
        [Route("invoice/{id:int}")]
        public async Task<IActionResult> Invoice(int id = 1)
        {
            // Kiểm tra nếu id không hợp lệ
            if (id <= 0)
            {
                return RedirectToAction("NotFound404");
            }

            var data = await _reportService.GetInvoiceReportAsync(id);
            if (data == null || !data.Any())
            {
                return RedirectToAction("NotFound404");
            }

            ViewBag.OrderId = id;
            return View(data);
        }

        // ========== API ==========
        [Route("get-statistics")]
        public async Task<IActionResult> GetStatistics()
        {
            var totalProducts = await _context.Products.CountAsync();
            var totalCategories = await _context.Categories.CountAsync();
            var totalOrders = await _context.Orders.CountAsync(o => o.Status == "Paid");
            var totalRevenue = await _context.Orders.Where(o => o.Status == "Paid").SumAsync(o => o.TotalAmount);

            return Json(new
            {
                totalProducts,
                totalCategories,
                totalOrders,
                totalRevenue = totalRevenue
            });
        }

        // ========== INVOICE BY CODE ==========
        // ========== INVOICE BY CODE ==========
        [Route("invoice/bycode/{orderCode}")]
        public async Task<IActionResult> InvoiceByCode(string orderCode)
        {
            if (string.IsNullOrEmpty(orderCode))
            {
                ViewBag.Error = "Vui lòng nhập mã hóa đơn";
                return View("Invoice", new List<InvoiceReportDto>());
            }

            var order = await _context.Orders.FirstOrDefaultAsync(o => o.OrderCode == orderCode);
            if (order == null)
            {
                ViewBag.Error = $"Không tìm thấy hóa đơn có mã: {orderCode}";
                return View("Invoice", new List<InvoiceReportDto>());
            }

            var data = await _reportService.GetInvoiceReportAsync(order.OrderId);
            if (data == null || !data.Any())
            {
                ViewBag.Error = $"Không có chi tiết cho hóa đơn: {orderCode}";
                return View("Invoice", new List<InvoiceReportDto>());
            }

            ViewBag.OrderId = order.OrderId;
            return View("Invoice", data);
        }

        // ========== 404 ERROR PAGE ==========
        [Route("404")]
        [Route("notfound")]
        [Route("error/404")]
        public IActionResult NotFound404()
        {
            Response.StatusCode = 404;
            return View();
        }

        // ========== EXPORT TO EXCEL ==========
        [Route("products/export-excel")]
        public async Task<IActionResult> ExportProductsExcel(string search = "", string category = "", string stock = "")
        {
            var allData = await _reportService.GetProductsReportAsync();

            if (!string.IsNullOrEmpty(search))
            {
                allData = allData.Where(p => p.ProductName.Contains(search, StringComparison.OrdinalIgnoreCase)).ToList();
            }
            if (!string.IsNullOrEmpty(category))
            {
                allData = allData.Where(p => p.CategoryName == category).ToList();
            }
            if (!string.IsNullOrEmpty(stock))
            {
                allData = stock switch
                {
                    "low" => allData.Where(p => p.StockQuantity < 10).ToList(),
                    "medium" => allData.Where(p => p.StockQuantity >= 10 && p.StockQuantity <= 50).ToList(),
                    "high" => allData.Where(p => p.StockQuantity > 50).ToList(),
                    _ => allData
                };
            }

            var html = GenerateProductsExcelHtml(allData);
            var bytes = Encoding.UTF8.GetBytes(html);

            return File(bytes, "application/vnd.ms-excel", $"ProductReport_{DateTime.Now:yyyyMMdd}.xls");
        }

        [Route("revenue/export-excel")]
        public async Task<IActionResult> ExportRevenueExcel(DateTime? fromDate = null, DateTime? toDate = null)
        {
            var allData = await _reportService.GetRevenueByDateAsync();

            if (fromDate.HasValue)
            {
                allData = allData.Where(r => r.SaleDate >= fromDate.Value).ToList();
            }
            if (toDate.HasValue)
            {
                allData = allData.Where(r => r.SaleDate <= toDate.Value).ToList();
            }

            var html = GenerateRevenueExcelHtml(allData);
            var bytes = Encoding.UTF8.GetBytes(html);

            return File(bytes, "application/vnd.ms-excel", $"RevenueReport_{DateTime.Now:yyyyMMdd}.xls");
        }

        // ========== EXPORT TO PDF ==========
        [Route("products/export-pdf")]
        public async Task<IActionResult> ExportProductsPDF(string search = "", string category = "", string stock = "")
        {
            var allData = await _reportService.GetProductsReportAsync();

            if (!string.IsNullOrEmpty(search))
            {
                allData = allData.Where(p => p.ProductName.Contains(search, StringComparison.OrdinalIgnoreCase)).ToList();
            }
            if (!string.IsNullOrEmpty(category))
            {
                allData = allData.Where(p => p.CategoryName == category).ToList();
            }
            if (!string.IsNullOrEmpty(stock))
            {
                allData = stock switch
                {
                    "low" => allData.Where(p => p.StockQuantity < 10).ToList(),
                    "medium" => allData.Where(p => p.StockQuantity >= 10 && p.StockQuantity <= 50).ToList(),
                    "high" => allData.Where(p => p.StockQuantity > 50).ToList(),
                    _ => allData
                };
            }

            var pdfBytes = _pdfExportService.ExportToPdf("ProductReport", allData, "Báo cáo sản phẩm");
            return File(pdfBytes, "application/pdf", $"ProductReport_{DateTime.Now:yyyyMMdd}.pdf");
        }

        [Route("revenue/export-pdf")]
        public async Task<IActionResult> ExportRevenuePDF(DateTime? fromDate = null, DateTime? toDate = null)
        {
            var allData = await _reportService.GetRevenueByDateAsync();

            if (fromDate.HasValue)
            {
                allData = allData.Where(r => r.SaleDate >= fromDate.Value).ToList();
            }
            if (toDate.HasValue)
            {
                allData = allData.Where(r => r.SaleDate <= toDate.Value).ToList();
            }

            var pdfBytes = _pdfExportService.ExportToPdf("RevenueReport", allData, "Báo cáo doanh thu");
            return File(pdfBytes, "application/pdf", $"RevenueReport_{DateTime.Now:yyyyMMdd}.pdf");
        }

        [Route("invoice/{id}/export-pdf")]
        public async Task<IActionResult> ExportInvoicePDF(int id)
        {
            var data = await _reportService.GetInvoiceReportAsync(id);
            if (data == null || !data.Any())
            {
                return RedirectToAction("NotFound404");
            }

            var pdfBytes = _pdfExportService.ExportToPdf($"Invoice_{id}", data, $"Hóa đơn {id}");
            return File(pdfBytes, "application/pdf", $"Invoice_{id}_{DateTime.Now:yyyyMMdd}.pdf");
        }

        // ========== PRIVATE HELPER METHODS ==========
        private string GenerateProductsExcelHtml(List<ProductReportDto> data)
        {
            var sb = new StringBuilder();
            sb.AppendLine("<html><head><meta charset='UTF-8'>");
            sb.AppendLine("<style>");
            sb.AppendLine("th { background-color: #4472C4; color: white; padding: 8px; }");
            sb.AppendLine("td { padding: 6px; border: 1px solid #ddd; }");
            sb.AppendLine("table { border-collapse: collapse; width: 100%; }");
            sb.AppendLine("</style>");
            sb.AppendLine("</head><body>");
            sb.AppendLine($"<h2>Báo cáo sản phẩm</h2>");
            sb.AppendLine($"<p>Ngày xuất: {DateTime.Now:dd/MM/yyyy HH:mm:ss}</p>");
            sb.AppendLine("<table>");
            sb.AppendLine("<thead><tr>");
            sb.AppendLine("<th>Mã SP</th><th>Tên sản phẩm</th><th>Danh mục</th><th>Đơn giá</th><th>Tồn kho</th><th>Đơn vị</th><th>Giá trị tồn</th>");
            sb.AppendLine("</tr></thead><tbody>");

            foreach (var item in data)
            {
                sb.AppendLine("<tr>");
                sb.AppendLine($"<td>{item.ProductId}</td>");
                sb.AppendLine($"<td>{item.ProductName}</td>");
                sb.AppendLine($"<td>{item.CategoryName}</td>");
                sb.AppendLine($"<td>{item.UnitPrice:N0}đ</td>");
                sb.AppendLine($"<td>{item.StockQuantity}</td>");
                sb.AppendLine($"<td>{item.Unit}</td>");
                sb.AppendLine($"<td>{(item.UnitPrice * item.StockQuantity):N0}đ</td>");
                sb.AppendLine("</tr>");
            }

            sb.AppendLine("</tbody></table>");
            sb.AppendLine($"<p><strong>Tổng giá trị tồn kho: {data.Sum(x => x.UnitPrice * x.StockQuantity):N0}đ</strong></p>");
            sb.AppendLine("</body></html>");

            return sb.ToString();
        }

        private string GenerateRevenueExcelHtml(List<RevenueReportDto> data)
        {
            var sb = new StringBuilder();
            var totalRevenue = data.Sum(x => x.Revenue);

            sb.AppendLine("<html><head><meta charset='UTF-8'>");
            sb.AppendLine("<style>");
            sb.AppendLine("th { background-color: #4472C4; color: white; padding: 8px; }");
            sb.AppendLine("td { padding: 6px; border: 1px solid #ddd; }");
            sb.AppendLine("table { border-collapse: collapse; width: 100%; }");
            sb.AppendLine("</style>");
            sb.AppendLine("</head><body>");
            sb.AppendLine($"<h2>Báo cáo doanh thu</h2>");
            sb.AppendLine($"<p>Ngày xuất: {DateTime.Now:dd/MM/yyyy HH:mm:ss}</p>");
            sb.AppendLine("</table>");
            sb.AppendLine("<thead><tr>");
            sb.AppendLine("<th>Ngày</th><th>Doanh thu (VNĐ)</th><th>Tỷ lệ</th>");
            sb.AppendLine("</tr></thead><tbody>");

            foreach (var item in data)
            {
                var percentage = totalRevenue > 0 ? (item.Revenue / totalRevenue * 100) : 0;
                sb.AppendLine("<tr>");
                sb.AppendLine($"<td>{item.SaleDate:dd/MM/yyyy}</td>");
                sb.AppendLine($"<td>{item.Revenue:N0}đ</td>");
                sb.AppendLine($"<td>{percentage:F1}%</td>");
                sb.AppendLine("</tr>");
            }

            sb.AppendLine("</tbody></table>");
            sb.AppendLine($"<p><strong>Tổng doanh thu: {totalRevenue:N0}đ</strong></p>");
            sb.AppendLine("</body></html>");

            return sb.ToString();
        }
    }
}