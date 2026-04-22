namespace SalesReportMvc.Models
{
    public class Customer
    {
      
        public int CustomerId { get; set; }
        public string FullName { get; set; } = string.Empty;
        public string? Phone { get; set; }
        public string? Email { get; set; }
        public string? Address { get; set; }
        public DateTime CreatedDate { get; set; }

        public ICollection<Order> Orders { get; set; } = new List<Order>();
    }
    
}
