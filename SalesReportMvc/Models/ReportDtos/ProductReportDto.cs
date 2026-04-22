namespace SalesReportMvc.Models.ReportDtos
{
    public class ProductReportDto
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; } = string.Empty;
        public string CategoryName { get; set; } = string.Empty;
        public decimal UnitPrice { get; set; }
        public int StockQuantity { get; set; }
        public string Unit { get; set; } = string.Empty;
    }
}