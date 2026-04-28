# Sales Report System - Hệ thống báo cáo bán hàng

Hệ thống báo cáo doanh thu, sản phẩm và hóa đơn xây dựng trên **ASP.NET Core MVC** với **Entity Framework Core** và **RDLC**.

## Công nghệ sử dụng

| Công nghệ | Version | Mục đích |
|-----------|---------|----------|
| ASP.NET Core MVC | .NET 10 | Framework chính |
| Entity Framework Core | 9.x | ORM, kết nối database |
| SQL Server | 2019+ | Database |
| Bootstrap 5 | - | Giao diện responsive |
| Font Awesome 6 | - | Icon |
| Chart.js | - | Biểu đồ |
| Microsoft.Reporting.NETCore | - | Xuất PDF (RDLC) |
##  Yêu cầu hệ thống
- [.NET SDK 8.0+](https://dotnet.microsoft.com/download)
- [SQL Server](https://www.microsoft.com/sql-server/sql-server-downloads) (LocalDB hoặc SQL Server Express)
- [Visual Studio 2022+](https://visualstudio.microsoft.com/) hoặc [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

## Tạo Database
###  Cài EF Core tools (nếu chưa có)
dotnet tool install --global dotnet-ef

###  Tạo migration
dotnet ef migrations add InitialCreate

###  Cập nhật database
dotnet ef database update

###  Restore packages
dotnet restore

# Build project
dotnet build

###  Run project
dotnet run

### insert dữ liệu từ file DataInsert.sql