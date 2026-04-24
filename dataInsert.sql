-- ======================================================
-- 1. TẠO DATABASE 
-- ======================================================
-- CREATE DATABASE SalesReportDb;
-- GO
-- USE SalesReportDb;
-- GO

-- ======================================================
-- 2. XÓA DỮ LIỆU CŨ (Nếu có)
-- ======================================================
-- Xóa theo thứ tự khóa ngoại
DELETE FROM OrderDetails;
DELETE FROM Orders;
DELETE FROM Products;
DELETE FROM Categories;
DELETE FROM Customers;
DELETE FROM Employees;

-- Reset Identity (SQL Server)
DBCC CHECKIDENT ('Categories', RESEED, 0);
DBCC CHECKIDENT ('Products', RESEED, 0);
DBCC CHECKIDENT ('Customers', RESEED, 0);
DBCC CHECKIDENT ('Employees', RESEED, 0);
DBCC CHECKIDENT ('Orders', RESEED, 0);
DBCC CHECKIDENT ('OrderDetails', RESEED, 0);

-- ======================================================
-- 3. INSERT CATEGORIES (Danh mục sản phẩm)
-- ======================================================
INSERT INTO Categories (CategoryName, Description) VALUES
(N'Điện thoại di động', N'Các loại điện thoại thông minh, flagship, tầm trung'),
(N'Laptop', N'Máy tính xách tay các loại, gaming, văn phòng'),
(N'Máy tính bảng', N'Tablet, iPad, máy tính bảng Android'),
(N'Phụ kiện', N'Tai nghe, sạc dự phòng, ốp lưng, cáp, phụ kiện khác'),
(N'Đồng hồ thông minh', N'Smartwatch các loại, đồng hồ thể thao'),
(N'Màn hình', N'Màn hình máy tính, màn hình gaming, màn hình chuyên nghiệp'),
(N'Bàn phím', N'Bàn phím cơ, bàn phím không dây, bàn phím văn phòng'),
(N'Chuột', N'Chuột máy tính các loại, chuột gaming, chuột không dây'),
(N'Linh kiện máy tính', N'RAM, SSD, VGA, CPU, Mainboard'),
(N'Thiết bị mạng', N'Router, Switch, WiFi Extender, Card mạng'),
(N'Tai nghe', N'Tai nghe có dây, không dây, headphone, earbuds'),
(N'Camera an ninh', N'Camera giám sát, camera IP, hành trình');
GO

-- ======================================================
-- 4. INSERT PRODUCTS (Sản phẩm)
-- ======================================================
INSERT INTO Products (ProductName, CategoryId, UnitPrice, StockQuantity, Unit, CreatedDate, IsActive) VALUES

-- Điện thoại di động (CategoryId = 1)
(N'iPhone 15 Pro Max 256GB', 1, 29990000, 45, N'Chiếc', GETDATE(), 1),
(N'iPhone 15 Pro 128GB', 1, 26990000, 52, N'Chiếc', GETDATE(), 1),
(N'Samsung Galaxy S24 Ultra 256GB', 1, 27990000, 38, N'Chiếc', GETDATE(), 1),
(N'Samsung Galaxy S24 Plus 256GB', 1, 22990000, 41, N'Chiếc', GETDATE(), 1),
(N'Xiaomi 14 Pro 256GB', 1, 17990000, 63, N'Chiếc', GETDATE(), 1),
(N'Google Pixel 8 Pro 128GB', 1, 19990000, 25, N'Chiếc', GETDATE(), 1),
(N'OnePlus 12 256GB', 1, 18990000, 30, N'Chiếc', GETDATE(), 1),
(N'Vivo X100 Pro 256GB', 1, 20990000, 28, N'Chiếc', GETDATE(), 1),

-- Laptop (CategoryId = 2)
(N'MacBook Pro M3 Pro 14" 512GB', 2, 39990000, 28, N'Chiếc', GETDATE(), 1),
(N'MacBook Air M2 13" 256GB', 2, 24990000, 35, N'Chiếc', GETDATE(), 1),
(N'Dell XPS 15 9530', 2, 35990000, 22, N'Chiếc', GETDATE(), 1),
(N'ASUS ROG Zephyrus G14', 2, 32990000, 18, N'Chiếc', GETDATE(), 1),
(N'Lenovo ThinkPad X1 Carbon Gen 11', 2, 38990000, 15, N'Chiếc', GETDATE(), 1),
(N'HP Spectre x360 14"', 2, 28990000, 20, N'Chiếc', GETDATE(), 1),
(N'MSI Stealth 14 Studio', 2, 34990000, 12, N'Chiếc', GETDATE(), 1),
(N'Acer Swift Edge 16', 2, 23990000, 25, N'Chiếc', GETDATE(), 1),

-- Máy tính bảng (CategoryId = 3)
(N'iPad Pro 12.9" M2 256GB', 3, 28990000, 32, N'Chiếc', GETDATE(), 1),
(N'iPad Air 10.9" 64GB', 3, 15990000, 28, N'Chiếc', GETDATE(), 1),
(N'Samsung Galaxy Tab S9 Ultra', 3, 23990000, 24, N'Chiếc', GETDATE(), 1),
(N'Xiaomi Pad 6 128GB', 3, 8990000, 35, N'Chiếc', GETDATE(), 1),
(N'Lenovo Tab P12', 3, 10990000, 20, N'Chiếc', GETDATE(), 1),

-- Phụ kiện (CategoryId = 4)
(N'AirPods Pro 2', 4, 4990000, 85, N'Chiếc', GETDATE(), 1),
(N'Samsung Galaxy Buds2 Pro', 4, 3990000, 72, N'Chiếc', GETDATE(), 1),
(N'Sạc nhanh 65W GaN', 4, 890000, 120, N'Cái', GETDATE(), 1),
(N'Ốp lưng iPhone 15 Pro', 4, 250000, 200, N'Cái', GETDATE(), 1),
(N'Cáp Type-C 2m', 4, 150000, 300, N'Sợi', GETDATE(), 1),
(N'Sạc dự phòng 20000mAh', 4, 550000, 95, N'Cái', GETDATE(), 1),
(N'Đế tản nhiệt laptop', 4, 350000, 60, N'Cái', GETDATE(), 1),

-- Đồng hồ thông minh (CategoryId = 5)
(N'Apple Watch Series 9', 5, 12990000, 42, N'Chiếc', GETDATE(), 1),
(N'Samsung Galaxy Watch 6 Classic', 5, 8990000, 38, N'Chiếc', GETDATE(), 1),
(N'Xiaomi Watch S3', 5, 3490000, 55, N'Chiếc', GETDATE(), 1),
(N'Garmin Venu 3', 5, 11990000, 20, N'Chiếc', GETDATE(), 1),

-- Màn hình (CategoryId = 6)
(N'LG UltraGear 27" 4K 144Hz', 6, 9990000, 15, N'Cái', GETDATE(), 1),
(N'Samsung Odyssey G7 32" 240Hz', 6, 14990000, 12, N'Cái', GETDATE(), 1),
(N'Dell UltraSharp 27" 4K', 6, 11990000, 18, N'Cái', GETDATE(), 1),
(N'ASUS ROG Swift 32"', 6, 16990000, 10, N'Cái', GETDATE(), 1),

-- Bàn phím (CategoryId = 7)
(N'Logitech MX Keys', 7, 1990000, 45, N'Cái', GETDATE(), 1),
(N'Keychron K2 Pro', 7, 2490000, 32, N'Cái', GETDATE(), 1),
(N'Razer BlackWidow V4 Pro', 7, 3590000, 22, N'Cái', GETDATE(), 1),
(N'Corsair K70 RGB Pro', 7, 3290000, 18, N'Cái', GETDATE(), 1),

-- Chuột (CategoryId = 8)
(N'Logitech MX Master 3S', 8, 2590000, 48, N'Cái', GETDATE(), 1),
(N'Razer DeathAdder V3 Pro', 8, 1790000, 35, N'Cái', GETDATE(), 1),
(N'Apple Magic Mouse', 8, 1990000, 28, N'Cái', GETDATE(), 1),
(N'Logitech G502 X Plus', 8, 2290000, 40, N'Cái', GETDATE(), 1);
GO

-- ======================================================
-- 5. INSERT CUSTOMERS (Khách hàng)
-- ======================================================
INSERT INTO Customers (FullName, Phone, Email, Address, CreatedDate) VALUES
(N'Nguyễn Văn An', '0987654321', 'an.nguyen@email.com', N'123 Đường Lê Lợi, Quận 1, TP.HCM', GETDATE()),
(N'Trần Thị Bình', '0978123456', 'binh.tran@email.com', N'456 Đường Nguyễn Huệ, Quận 2, TP.HCM', GETDATE()),
(N'Lê Văn Cường', '0965234789', 'cuong.le@email.com', N'789 Đường Võ Văn Tần, Quận 3, TP.HCM', GETDATE()),
(N'Phạm Thị Dung', '0945678912', 'dung.pham@email.com', N'321 Đường Phạm Ngũ Lão, Quận 4, TP.HCM', GETDATE()),
(N'Hoàng Văn Em', '0934567891', 'em.hoang@email.com', N'654 Đường Cách Mạng Tháng 8, Quận 5, TP.HCM', GETDATE()),
(N'Ngô Thị Phương', '0923456789', 'phuong.ngo@email.com', N'987 Đường Trần Hưng Đạo, Quận 6, TP.HCM', GETDATE()),
(N'Đỗ Văn Giáp', '0912345678', 'giap.do@email.com', N'147 Đường Lý Thường Kiệt, Quận 7, TP.HCM', GETDATE()),
(N'Vũ Thị Hà', '0901234567', 'ha.vu@email.com', N'258 Đường Nguyễn Trãi, Quận 8, TP.HCM', GETDATE()),
(N'Bùi Văn Inh', '0891234567', 'inh.bui@email.com', N'369 Đường Xô Viết Nghệ Tĩnh, Quận 9, TP.HCM', GETDATE()),
(N'Đặng Thị Khánh', '0881234567', 'khanh.dang@email.com', N'741 Đường Phạm Văn Đồng, Quận 10, TP.HCM', GETDATE()),
(N'Lý Thị Lan', '0871234567', 'lan.ly@email.com', N'852 Đường Láng, Quận Đống Đa, Hà Nội', GETDATE()),
(N'Trương Văn Minh', '0861234567', 'minh.truong@email.com', N'963 Đường Nguyễn Văn Cừ, Quận Long Biên, Hà Nội', GETDATE()),
(N'Huỳnh Thị Ngọc', '0851234567', 'ngoc.huynh@email.com', N'159 Đường Bạch Đằng, Quận Hải Châu, Đà Nẵng', GETDATE()),
(N'Phan Văn Phúc', '0841234567', 'phuc.phan@email.com', N'753 Đường Hùng Vương, Quận Ninh Kiều, Cần Thơ', GETDATE()),
(N'Lâm Thị Quỳnh', '0831234567', 'quynh.lam@email.com', N'357 Đường Lê Hồng Phong, Quận Ngô Quyền, Hải Phòng', GETDATE());
GO

-- ======================================================
-- 6. INSERT EMPLOYEES (Nhân viên)
-- ======================================================
INSERT INTO Employees (FullName, Phone, Email, Position, HireDate, IsActive) VALUES
(N'Trần Văn Anh', '0901111111', 'anh.tran@company.com', N'Quản lý bán hàng', '2020-01-15',1),
(N'Nguyễn Thị Bích', '0902222222', 'bich.nguyen@company.com', N'Nhân viên bán hàng', '2021-03-20',1),
(N'Lê Hoàng Công', '0903333333', 'cong.le@company.com', N'Nhân viên bán hàng', '2021-05-10',1),
(N'Phạm Thúy Dung', '0904444444', 'dung.pham@company.com', N'Nhân viên bán hàng', '2022-01-05',1),
(N'Hoàng Minh Em', '0905555555', 'em.hoang@company.com', N'Kế toán', '2020-06-01',1);
GO

-- ======================================================
-- 7. INSERT ORDERS (Đơn hàng)
-- ======================================================
INSERT INTO Orders (OrderCode, CustomerId, EmployeeId, OrderDate, TotalAmount, Note, Status) VALUES
-- Tháng 1/2025
('ORD2025010001', 1, 2, '2025-01-05 10:30:00', 0, N'Mua iPhone 15 Pro Max + ốp lưng', N'Paid'),
('ORD2025010002', 2, 3, '2025-01-10 14:15:00', 0, N'Mua MacBook Pro M3', N'Paid'),
('ORD2025010003', 3, 2, '2025-01-12 09:45:00', 0, N'Mua Apple Watch Series 9', N'Paid'),
('ORD2025010004', NULL, 4, '2025-01-15 16:20:00', 0, N'Mua Samsung Odyssey G7', N'Paid'),
('ORD2025010005', 4, 3, '2025-01-18 11:00:00', 0, N'Mua ASUS ROG Zephyrus G14', N'Paid'),
('ORD2025010006', 5, 2, '2025-01-20 13:30:00', 0, N'Mua AirPods Pro 2 + sạc dự phòng', N'Paid'),
('ORD2025010007', NULL, 4, '2025-01-22 15:45:00', 0, N'Mua Logitech MX Master 3S', N'Paid'),
('ORD2025010008', 6, 3, '2025-01-25 10:00:00', 0, N'Mua Logitech MX Keys', N'Paid'),
('ORD2025010009', 7, 2, '2025-01-28 14:30:00', 0, N'Mua Samsung S24 Ultra', N'Paid'),
('ORD2025010010', 8, 4, '2025-01-30 09:15:00', 0, N'Mua iPad Pro 12.9', N'Paid'),
('ORD2025010011', 9, 2, '2025-01-31 11:45:00', 0, N'Mua Dell XPS 15', N'Paid'),

-- Tháng 2/2025
('ORD2025020012', 1, 3, '2025-02-03 11:30:00', 0, N'Mua sạc nhanh 65W', N'Paid'),
('ORD2025020013', 10, 2, '2025-02-05 15:20:00', 0, N'Mua Xiaomi 14 Pro', N'Paid'),
('ORD2025020014', NULL, 4, '2025-02-08 10:45:00', 0, N'Mua Keychron K2 Pro', N'Paid'),
('ORD2025020015', 2, 2, '2025-02-10 14:00:00', 0, N'Mua MacBook Air M2', N'Paid'),
('ORD2025020016', 3, 3, '2025-02-12 09:30:00', 0, N'Mua Galaxy Buds2 Pro', N'Paid'),
('ORD2025020017', 11, 4, '2025-02-15 16:30:00', 0, N'Mua Google Pixel 8 Pro', N'Paid'),
('ORD2025020018', 4, 2, '2025-02-18 10:15:00', 0, N'Mua OnePlus 12', N'Paid'),
('ORD2025020019', NULL, 3, '2025-02-20 13:45:00', 0, N'Mua Samsung Tab S9 Ultra', N'Paid'),
('ORD2025020020', 5, 4, '2025-02-22 11:00:00', 0, N'Mua Razer BlackWidow V4 Pro', N'Paid'),
('ORD2025020021', 6, 2, '2025-02-25 15:30:00', 0, N'Mua Dell UltraSharp 27"', N'Paid'),
('ORD2025020022', 12, 3, '2025-02-27 09:45:00', 0, N'Mua Garmin Venu 3', N'Paid'),

-- Tháng 3/2025
('ORD2025030023', 7, 4, '2025-03-01 09:00:00', 0, N'Mua iPhone 15 Pro', N'Paid'),
('ORD2025030024', 8, 2, '2025-03-03 14:30:00', 0, N'Mua cáp Type-C + ốp lưng', N'Paid'),
('ORD2025030025', NULL, 3, '2025-03-05 10:15:00', 0, N'Mua 3 ốp lưng iPhone', N'Paid'),
('ORD2025030026', 13, 4, '2025-03-07 16:00:00', 0, N'Mua Xiaomi Watch S3', N'Paid'),
('ORD2025030027', 1, 2, '2025-03-10 11:30:00', 0, N'Mua MacBook Pro M3 Pro', N'Paid'),
('ORD2025030028', 9, 3, '2025-03-12 09:15:00', 0, N'Mua Vivo X100 Pro', N'Paid'),
('ORD2025030029', 14, 4, '2025-03-15 14:45:00', 0, N'Mua ASUS ROG Swift 32"', N'Paid'),
('ORD2025030030', 10, 2, '2025-03-18 10:30:00', 0, N'Mua Corsair K70 RGB Pro', N'Paid'),
('ORD2025030031', 15, 3, '2025-03-20 15:00:00', 0, N'Mua Logitech G502 X Plus', N'Paid'),
('ORD2025030032', NULL, 4, '2025-03-22 11:15:00', 0, N'Mua MSI Stealth 14 Studio', N'Paid'),
('ORD2025030033', 1, 2, '2025-03-25 13:45:00', 0, N'Mua MacBook Air M2', N'Paid'),
('ORD2025030034', 2, 3, '2025-03-28 09:30:00', 0, N'Mua iPhone 15 Pro Max', N'Paid'),
('ORD2025030035', NULL, 4, '2025-03-30 16:20:00', 0, N'Mua Samsung Galaxy S24 Ultra', N'Paid');
GO

-- ======================================================
-- 8. INSERT ORDER DETAILS (Chi tiết đơn hàng)
-- ======================================================
-- ORD2025010001: iPhone 15 Pro Max + Ốp lưng
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(1, 1, 1, 29990000, 0, 29990000),
(1, 25, 2, 250000, 0, 500000);

-- ORD2025010002: MacBook Pro M3
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(2, 9, 1, 39990000, 0, 39990000);

-- ORD2025010003: Apple Watch Series 9
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(3, 29, 1, 12990000, 0, 12990000);

-- ORD2025010004: Samsung Odyssey G7
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(4, 34, 1, 14990000, 0, 14990000);

-- ORD2025010005: ASUS ROG Zephyrus G14
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(5, 12, 1, 32990000, 0, 32990000);

-- ORD2025010006: AirPods Pro 2 + Sạc dự phòng
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(6, 23, 1, 4990000, 0, 4990000),
(6, 27, 1, 550000, 0, 550000);

-- ORD2025010007: Logitech MX Master 3S
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(7, 40, 1, 2590000, 0, 2590000);

-- ORD2025010008: Logitech MX Keys
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(8, 36, 1, 1990000, 0, 1990000);

-- ORD2025010009: Samsung S24 Ultra
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(9, 3, 1, 27990000, 0, 27990000);

-- ORD2025010010: iPad Pro 12.9
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(10, 17, 1, 28990000, 0, 28990000);

-- ORD2025010011: Dell XPS 15
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(11, 11, 1, 35990000, 0, 35990000);

-- ORD2025020012: Sạc nhanh 65W
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(12, 24, 1, 890000, 0, 890000);

-- ORD2025020013: Xiaomi 14 Pro
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(13, 5, 1, 17990000, 0, 17990000);

-- ORD2025020014: Keychron K2 Pro
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(14, 37, 1, 2490000, 0, 2490000);

-- ORD2025020015: MacBook Air M2
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(15, 10, 1, 24990000, 0, 24990000);

-- ORD2025020016: Galaxy Buds2 Pro
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(16, 24, 1, 3990000, 0, 3990000);

-- ORD2025020017: Google Pixel 8 Pro
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(17, 6, 1, 19990000, 0, 19990000);

-- ORD2025020018: OnePlus 12
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(18, 7, 1, 18990000, 0, 18990000);

-- ORD2025020019: Samsung Tab S9 Ultra
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(19, 19, 1, 23990000, 0, 23990000);

-- ORD2025020020: Razer BlackWidow V4 Pro
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(20, 38, 1, 3590000, 0, 3590000);

-- ORD2025020021: Dell UltraSharp 27"
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(21, 35, 1, 11990000, 0, 11990000);

-- ORD2025020022: Garmin Venu 3
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(22, 32, 1, 11990000, 0, 11990000);

-- ORD2025030023: iPhone 15 Pro
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(23, 2, 1, 26990000, 0, 26990000);

-- ORD2025030024: Cáp Type-C + Ốp lưng
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(24, 26, 2, 150000, 0, 300000),
(24, 25, 1, 250000, 0, 250000);

-- ORD2025030025: 3 ốp lưng iPhone
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(25, 25, 3, 250000, 0, 750000);

-- ORD2025030026: Xiaomi Watch S3
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(26, 31, 1, 3490000, 0, 3490000);

-- ORD2025030027: MacBook Pro M3 Pro
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(27, 9, 1, 39990000, 0, 39990000);

-- ORD2025030028: Vivo X100 Pro
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(28, 8, 1, 20990000, 0, 20990000);

-- ORD2025030029: ASUS ROG Swift 32"
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(29, 35, 1, 16990000, 0, 16990000);

-- ORD2025030030: Corsair K70 RGB Pro
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(30, 39, 1, 3290000, 0, 3290000);

-- ORD2025030031: Logitech G502 X Plus
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(31, 43, 1, 2290000, 0, 2290000);

-- ORD2025030032: MSI Stealth 14 Studio
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(32, 15, 1, 34990000, 0, 34990000);

-- ORD2025030033: MacBook Air M2
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(33, 10, 1, 24990000, 0, 24990000);

-- ORD2025030034: iPhone 15 Pro Max
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(34, 1, 1, 29990000, 0, 29990000);

-- ORD2025030035: Samsung Galaxy S24 Ultra
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice, Discount, SubTotal) VALUES
(35, 3, 1, 27990000, 0, 27990000);
GO

-- ======================================================
-- 9. UPDATE TOTALAMOUNT FOR ORDERS
-- ======================================================
UPDATE Orders SET TotalAmount = (
    SELECT ISNULL(SUM(SubTotal), 0) 
    FROM OrderDetails 
    WHERE OrderDetails.OrderId = Orders.OrderId
);
GO

-- ======================================================
-- 10. KIỂM TRA DỮ LIỆU
-- ======================================================
-- Kiểm tra số lượng bản ghi
SELECT 'Categories' as TableName, COUNT(*) as TotalRecords FROM Categories UNION ALL
SELECT 'Products', COUNT(*) FROM Products UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers UNION ALL
SELECT 'Employees', COUNT(*) FROM Employees UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM OrderDetails;
GO

-- Xem danh sách đơn hàng và tổng tiền
SELECT 
    OrderId,
    OrderCode,
    CustomerName = ISNULL(C.FullName, N'Khách lẻ'),
    EmployeeName = E.FullName,
    OrderDate,
    TotalAmount,
    [Status]
FROM Orders O
LEFT JOIN Customers C ON O.CustomerId = C.CustomerId
LEFT JOIN Employees E ON O.EmployeeId = E.EmployeeId
ORDER BY OrderDate DESC;
GO

-- Thống kê doanh thu theo tháng
SELECT 
    YEAR(OrderDate) as [Năm],
    MONTH(OrderDate) as [Tháng],
    COUNT(DISTINCT OrderId) as [Số đơn hàng],
    COUNT(DISTINCT CustomerId) as [Số khách hàng],
    ISNULL(SUM(TotalAmount), 0) as [Doanh thu],
    FORMAT(ISNULL(SUM(TotalAmount), 0), 'N0') as [Doanh thu (VND)]
FROM Orders
WHERE Status = 'Paid'
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY [Năm] DESC, [Tháng] DESC;
GO

-- Thống kê sản phẩm bán chạy nhất
SELECT TOP 10
    P.ProductId,
    P.ProductName,
    C.CategoryName,
    COUNT(OD.OrderDetailId) as [Số lần bán],
    SUM(OD.Quantity) as [Tổng số lượng],
    SUM(OD.SubTotal) as [Tổng doanh thu],
    FORMAT(SUM(OD.SubTotal), 'N0') as [Doanh thu (VND)]
FROM Products P
INNER JOIN Categories C ON P.CategoryId = C.CategoryId
INNER JOIN OrderDetails OD ON P.ProductId = OD.ProductId
INNER JOIN Orders O ON OD.OrderId = O.OrderId
WHERE O.Status = 'Paid'
GROUP BY P.ProductId, P.ProductName, C.CategoryName
ORDER BY SUM(OD.Quantity) DESC;
GO

-- Thống kê khách hàng mua nhiều nhất
SELECT TOP 10
    C.CustomerId,
    C.FullName,
    C.Phone,
    C.Email,
    COUNT(O.OrderId) as [Số đơn hàng],
    ISNULL(SUM(O.TotalAmount), 0) as [Tổng chi tiêu],
    FORMAT(ISNULL(SUM(O.TotalAmount), 0), 'N0') as [Chi tiêu (VND)]
FROM Customers C
INNER JOIN Orders O ON C.CustomerId = O.CustomerId
WHERE O.Status = 'Paid'
GROUP BY C.CustomerId, C.FullName, C.Phone, C.Email
ORDER BY SUM(O.TotalAmount)
GO

SELECT * from OrderDetails