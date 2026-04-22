namespace SalesReportMvc.Models
{
    public class Order
    {
            public int OrderId { get; set; }
            public string OrderCode { get; set; } = string.Empty;
            public int? CustomerId { get; set; }
            public int EmployeeId { get; set; }
            public DateTime OrderDate { get; set; }
            public decimal TotalAmount { get; set; }
            public string? Note { get; set; }
            public string Status { get; set; } = "Paid";

            public Customer? Customer { get; set; }
            public Employee? Employee { get; set; }
            public ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
        }
    }
