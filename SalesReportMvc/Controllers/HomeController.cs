using Microsoft.AspNetCore.Mvc;
using SalesReportMvc.Models;
using System.Diagnostics;

namespace SalesReportMvc.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            // Chuyển hướng thẳng đến Report/Index
            return RedirectToAction("Index", "Report");
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
