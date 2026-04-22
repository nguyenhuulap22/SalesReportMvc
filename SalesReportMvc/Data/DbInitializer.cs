using SalesReportMvc.Models;

namespace SalesReportMvc.Data
{
    public static class DbInitializer
    {
        public static void Seed(AppDbContext context)
        {
            if (context.Categories.Any()) return;

            var categories = new List<Category>
            {
                new Category { CategoryName = "Điện thoại", Description = "Sản phẩm điện thoại" },
                new Category { CategoryName = "Laptop", Description = "Sản phẩm laptop" },
                new Category { CategoryName = "Phụ kiện", Description = "Phụ kiện công nghệ" }
            };
            context.Categories.AddRange(categories);
            context.SaveChanges();

            var products = new List<Product>
            {
                new Product { ProductName = "iPhone 15", CategoryId = 1, UnitPrice = 22000000, StockQuantity = 10, Unit = "Cái", CreatedDate = DateTime.Now, IsActive = true },
                new Product { ProductName = "Samsung Galaxy S24", CategoryId = 1, UnitPrice = 18000000, StockQuantity = 15, Unit = "Cái", CreatedDate = DateTime.Now, IsActive = true },
                new Product { ProductName = "Dell Inspiron 15", CategoryId = 2, UnitPrice = 16500000, StockQuantity = 8, Unit = "Cái", CreatedDate = DateTime.Now, IsActive = true },
                new Product { ProductName = "Chuột Logitech M331", CategoryId = 3, UnitPrice = 350000, StockQuantity = 30, Unit = "Cái", CreatedDate = DateTime.Now, IsActive = true },
                new Product { ProductName = "Bàn phím cơ RK61", CategoryId = 3, UnitPrice = 850000, StockQuantity = 20, Unit = "Cái", CreatedDate = DateTime.Now, IsActive = true }
            };
            context.Products.AddRange(products);
            context.SaveChanges();

            var customers = new List<Customer>
            {
                new Customer { FullName = "Nguyễn Văn A", Phone = "0909000001", Email = "a@gmail.com", Address = "TP.HCM", CreatedDate = DateTime.Now },
                new Customer { FullName = "Trần Thị B", Phone = "0909000002", Email = "b@gmail.com", Address = "Bình Dương", CreatedDate = DateTime.Now }
            };
            context.Customers.AddRange(customers);
            context.SaveChanges();

            var employees = new List<Employee>
            {
                new Employee { FullName = "Phạm Minh H", Position = "Nhân viên bán hàng", Phone = "0911000001", Email = "h@shop.com", HireDate = DateTime.Now, IsActive = true },
                new Employee { FullName = "Võ Thị K", Position = "Thu ngân", Phone = "0911000002", Email = "k@shop.com", HireDate = DateTime.Now, IsActive = true }
            };
            context.Employees.AddRange(employees);
            context.SaveChanges();

            var orders = new List<Order>
            {
                new Order
                {
                    OrderCode = "ORD001",
                    CustomerId = 1,
                    EmployeeId = 1,
                    OrderDate = DateTime.Now.AddDays(-2),
                    TotalAmount = 22350000,
                    Note = "Khách thanh toán tiền mặt",
                    Status = "Paid"
                },
                new Order
                {
                    OrderCode = "ORD002",
                    CustomerId = 2,
                    EmployeeId = 2,
                    OrderDate = DateTime.Now.AddDays(-1),
                    TotalAmount = 18850000,
                    Note = "Khách chuyển khoản",
                    Status = "Paid"
                }
            };
            context.Orders.AddRange(orders);
            context.SaveChanges();

            var orderDetails = new List<OrderDetail>
            {
                new OrderDetail { OrderId = 1, ProductId = 1, Quantity = 1, UnitPrice = 22000000, Discount = 0, SubTotal = 22000000 },
                new OrderDetail { OrderId = 1, ProductId = 4, Quantity = 1, UnitPrice = 350000, Discount = 0, SubTotal = 350000 },
                new OrderDetail { OrderId = 2, ProductId = 2, Quantity = 1, UnitPrice = 18000000, Discount = 0, SubTotal = 18000000 },
                new OrderDetail { OrderId = 2, ProductId = 5, Quantity = 1, UnitPrice = 850000, Discount = 0, SubTotal = 850000 }
            };
            context.OrderDetails.AddRange(orderDetails);
            context.SaveChanges();
        }
    }
}