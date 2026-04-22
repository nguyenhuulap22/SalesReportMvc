namespace SalesReportMvc.Models
{
    public class Employee
    {
            public int EmployeeId { get; set; }
            public string FullName { get; set; } = string.Empty;
            public string? Position { get; set; }
            public string? Phone { get; set; }
            public string? Email { get; set; }
            public DateTime HireDate { get; set; }
            public bool IsActive { get; set; }

            public ICollection<Order> Orders { get; set; } = new List<Order>();
        }
    }
