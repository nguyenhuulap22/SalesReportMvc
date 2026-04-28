using System;

namespace SalesReport.Reporting
{
    public class ProductReportDto
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string CategoryName { get; set; }
        public decimal UnitPrice { get; set; }
        public int StockQuantity { get; set; }
        public string Unit { get; set; }
    }
}