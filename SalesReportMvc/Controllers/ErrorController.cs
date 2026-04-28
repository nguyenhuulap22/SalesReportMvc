using Microsoft.AspNetCore.Mvc;

namespace SalesReportMvc.Controllers
{
    public class ErrorController : Controller
    {
        [Route("error/404")]
        public IActionResult NotFound404()
        {
            return View();
        }

        
    }
}