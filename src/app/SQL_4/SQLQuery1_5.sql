create table Products(
	Id varchar(20) primary key,
	Name nvarchar(100) not null unique,
	DeScriptions nvarchar(255) not null,
	Unit nvarchar(100) not null,
	Price decimal(16,0) not null check(Price >= 0) default 0

);

create table Customers(
	Id varchar(20) primary key,
	Name nvarchar(100) not null,
	Address nvarchar(255) not null,
	PhoneNumber varchar(20) not null unique
);

create table Orders(
	Id varchar(20) primary key,
	OrderDate date not null default GETDATE(),
	GrandTotal decimal(16,0) not null default 0 check(GrandTotal >= 0),
	CustomerId varchar(20) not null foreign key references Customers(Id)
);

create table Order_Product(
	Quantity int not null check(Quantity > 0),
	SubTotal decimal(16,0) not null check(SubTotal > 0) default 100,
	OrderId varchar(20) not null foreign key references Orders(Id),
	ProductId varchar(20) not null foreign key references Products(Id)
);

--drop table Order_Product;
--drop table Orders;
--drop table Customers;
--drop table Products;

--CREATE DATA
insert into Products 
values
('SP000001', N'Máy tính T450', N'Máy nhập mới', N'chiếc', 1000),
('SP000002', N'Diện thoại Nokia5670', N'Điện thoại đang hot', N'chiếc', 400),
('SP000003', N'Máy in Samsung 450', N'Máy in đang ế', N'chiếc', 100);

insert into Customers 
values
('0000001', N'Nguyễn Văn An', N'111, Nguyễn Trãi, Thanh Xuân, Hà Nội', '09347479234'),
('0000002', N'Nguyễn Duy Quốc', N'135, Minh Khai, Bắc Từ Liêm, Hà Nội','03838328288'),
('0000003', N'Hoàng Duy Quốc', N'131, Tân Lộc, Lộc Hà, Hà Tĩnh','09337324832');

insert into Orders(Id, OrderDate, CustomerId) 
values
('OD01', '2019-03-29', '0000001'),
('OD02', '2019-02-22', '0000003'), 
('OD03', '2019-09-02', '0000002'),
('OD04', '2019-05-12', '0000003');
 
insert into Order_Product 
values 
(3, 3000, 'OD01', 'SP000001'),
(2, 800, 'OD02', 'SP000002'),
(20, 2000, 'OD01', 'SP000003'),
(4, 4000, 'OD03', 'SP000001'),
(10, 1000, 'OD03', 'SP000003'),
(7, 7000, 'OD04', 'SP000001'),
(4, 1600, 'OD04', 'SP000002');


update Orders
set GrandTotal = (
	select sum(SubTotal)
	from Order_Product
	where OrderId = 'OD01'
)
where Id = 'OD01';

update Orders
set GrandTotal = (
	select sum(SubTotal)
	from Order_Product
	where OrderId = 'OD02'
)
where Id = 'OD02';


update Orders
set GrandTotal = (
	select sum(SubTotal)
	from Order_Product
	where OrderId = 'OD03'
)
where Id = 'OD03';

update Orders
set GrandTotal = (
	select sum(SubTotal)
	from Order_Product
	where OrderId = 'OD04'
)
where Id = 'OD04';

--READ
select * from Products;
select * from Customers;
select * from Orders;
select * from Order_Product;

--CÁC CÂU LỆNH TRUY VẤN
--4.a Liệt kê danh sách khách hàng đã mua ở cửa hàng
select Name from Customers;

--4.b Liệt kê danh sách sản phẩm của cửa hàng
select Name from Products;

--4.c Liệt kê danh sách các đơn đặt hàng của cửa hàng
select Orders.Id, Customers.Name, Customers.PhoneNumber, Customers.Address, Orders.OrderDate, Orders.GrandTotal from Orders
inner join Customers on Customers.Id = Orders.CustomerId;

--5.aLiệt kê danh sách khách hàng theo thứ thự alphabet.
select Name from Customers order by Name asc;

--5.b Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá giảm dần.
select Name from Products order by Name desc;

--5.c Liệt kê các sản phẩm mà khách hàng Nguyễn Văn An đã mua.
select Name from Products 
	where Id in (
		select ProductId from Order_Product
			where OrderId in (
				select Id from Orders 
					where CustomerId in ('0000001')
														)
	
															);

--6.a Số khách hàng đã mua ở cửa hàng.
select count(Id) as SoLuongKhachDaMuaOCuaHang from Customers;


--6.b Số mặt hàng mà cửa hàng bán.
select count(*) as SoMatHangMaCuaHangBan from Products;

--6.c Tổng tiền của từng đơn hàng.
select Id, GrandToTal from Orders;

--7. Thay đổi những thông tin sau từ cơ sở dữ liệu
--a) Viết câu lệnh để thay đổi trường giá tiền của từng mặt hàng là dương(>0).
alter table Products add constraint check_price check(Price > 0);

ALTER TABLE Products
ADD CONSTRAINT check_product_price_positive
CHECK(Price > 0);



--b) Viết câu lệnh để thay đổi ngày đặt hàng của khách hàng phải nhỏ hơn ngày hiện tại.
alter table Orders add constraint check_order_date check(OrderDate < GETDATE());


--c) Viết câu lệnh để thêm trường ngày xuất hiện trên thị trường của sản phẩm

alter table Products 
add Date_of_appearance date;

--8. Thực hiện các yêu cầu sau
--a) Đặt chỉ mục (index) cho cột Tên hàng và Người đặt hàng để tăng tốc độ truy vấn dữ liệu trên các cột này.


create index index_order_name on Customers(Name);
create index index_product_name on Products(Name);

--b) Xây dựng các view sau đây:
--◦ View_KhachHang với các cột: Tên khách hàng, Địa chỉ, Điện thoại
create view View_KhachHang as
select Customers.Name as Ten_khach_hang, Customers.Address as Dia_chi, Customers.PhoneNumber as Dien_thoai
from Customers;

--◦ View_SanPham với các cột: Tên sản phẩm, Giá bán
create view View_SanPhamm as
select Products.Name as Ten_san_pham, Products.Price as Gia_ban from Products;

--◦ View_KhachHang_SanPham với các cột: Tên khách hàng, Số điện thoại, Tên sản phẩm, Số lượng, Ngày mua

create view View_KhachHang_SanPham as
select Customers.Name as Ten_khach_hang, Customers.PhoneNumber as Do_dien_thoai, Products.Name as Ten_san_pham,
Order_Product.Quantity as So_luong, Orders.OrderDate as Ngay_mua from Order_Product
inner join Products on Products.Id = Order_Product.ProductId
inner join Orders on Orders.Id = Order_Product.OrderId
inner join Customers on Customers.Id = Orders.CustomerId;

select * from View_KhachHang_SanPham;

--c) Viết các Store Procedure (Thủ tục lưu trữ) sau:
--◦ SP_TimKH_MaKH: Tìm khách hàng theo mã khách hàng
create procedure SP_TimKH_MaKH @id varchar(20) as
select * from Customers where Id in (@id);

exec SP_TimKH_MaKH @id = '0000001';

--◦ SP_TimKH_MaHD: Tìm thông tin khách hàng theo mã hóa đơn
create procedure SP_TimKH_MaHD @id_order varchar(20) as
select * from Customers where Id in (
	select CustomerId from Orders where Id in (@id_order));

exec SP_TimKH_MaHD @id_order = 'OD02';

--◦ SP_SanPham_MaKH: Liệt kê các sản phẩm được mua bởi khách hàng có mã được truyền vào Store.