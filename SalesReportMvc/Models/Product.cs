namespace SalesReportMvc.Models
{
    public class Product
    {
            public int ProductId { get; set; }
            public string ProductName { get; set; } = string.Empty;
            public int CategoryId { get; set; }
            public decimal UnitPrice { get; set; }
            public int StockQuantity { get; set; }
            public string? Unit { get; set; }
            public DateTime CreatedDate { get; set; }
            public bool IsActive { get; set; }

            public Category? Category { get; set; }
            public ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
        }
    }
