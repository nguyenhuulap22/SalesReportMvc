using Microsoft.AspNetCore.Mvc;
using SalesReportMvc.Data;
using SalesReportMvc.Services;

namespace SalesReportMvc.Controllers
{
    public class ReportController : Controller
    {
        private readonly AppDbContext _context;
        private readonly IReportService _reportService;

        public ReportController(AppDbContext context, IReportService reportService)
        {
            _context = context;
            _reportService = reportService;
        }

        public IActionResult TestDb()
        {
            var count = _context.Categories.Count();
            return Content("Kết nối thành công. Số category = " + count);
        }

        public async Task<IActionResult> Products()
        {
            var data = await _reportService.GetProductsReportAsync();
            return View(data);
        }

        public async Task<IActionResult> Invoice(int id = 1)
        {
            var data = await _reportService.GetInvoiceReportAsync(id);
            return View(data);
        }

        public async Task<IActionResult> Revenue()
        {
            var data = await _reportService.GetRevenueByDateAsync();
            return View(data);
        }
    }
}