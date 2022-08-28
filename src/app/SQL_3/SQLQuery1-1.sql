create table NHACUNGCAP(
	ManhaCC varchar(20) primary key ,
	TennhaCC nvarchar(255) not null unique,
	Diachi nvarchar(255) not null,
	SoDT varchar(20) not null unique,
	MaSoThue varchar(20) not null unique
);

create table LOAIDICHVU(
	MaLoaiDV varchar(20) primary key,
	TenLoaiDV nvarchar(255) not null unique
);

create table MUCPHI(
	MaMP varchar(20) primary key,
	DonGia decimal(16,0) not null check(DonGia >= 0) default 10000,
	MoTa nvarchar(255)
);

create table DONGXE(
	DongXe varchar(100) primary key,
	HangXe varchar(100) not null,
	SoChoNgoi int not null check(SoChoNgoi > 0) default 2
);

create table DANGKYCUNGCAP(
	MaDKCC varchar(20) primary key,
	MaNhaCC varchar(20) not null foreign key references NHACUNGCAP(MaNhaCC),
	MaLoaiDV varchar(20) not null foreign key references LOAIDICHVU(MaLoaiDV),
	DongXe varchar(100) not null foreign key references DONGXE(DongXe),
	MaMP varchar(20) not null foreign key References MUCPHI(MaMP),
	NgayBatDauCungCap date not null default GETDATE(),
	NgayKetThucCungCap date not null default GETDATE(),
	SoLuongXeDangKy int not null check(SoLuongXeDangKy > 0)
);

drop table DANGKYCUNGCAP;
drop table DONGXE;
drop table MUCPHI;
drop table LOAIDICHVU;
drop table NHACUNGCAP;

--CREATE DATA
insert into NHACUNGCAP(ManhaCC, TennhaCC, Diachi, SoDT,MaSoThue) 
values
('NCC001', N'Cty TNHH Toàn Pháp', N'Hai Chau', '05113999888', '568941'),
('NCC002', N'Cty Cổ phần Đông Du ', N'Lien Chau', '05113999889', '456789'),
('NCC003', N'Cty Nguyễn Văn A', N'Hoa Thuan', '05113999890', '3214456'),
('NCC004', N'Cty Cổ phần Toàn Cầu Xanh', N'Hai Chau', '05113658945', '513364'),
('NCC005', N'Cty TNHH AMA', N'Thanh Khe', '05113875466', '546546'),
('NCC006', N'Bà Trần Thị Bích Vân', N'Lien Chau', '05113587469', '524545'),
('NCC007', N'Cty TNHH Phan Thành', N'Thanh Khe', '05113987456', '113021'),
('NCC008', N'Ông Phan Đình Nam', N'Hoa Thuan', '05113532456', '121230'),
('NCC009', N'Tập đoàn Đông Nam Á', N'Lien Chau', '05113987121', '533654'),
('NCC010', N'Cty Cổ phần Rạng Đông', N'Lien Chau', '0511359654', '187864');

insert into LOAIDICHVU(MaLoaiDV, TenLoaiDV) 
values
('DV01', N'Dịch vụ thuê taxi'),
('DV02', N'Dịch vụ xe buýt công cộng theo tuyến cố định'),
('DV03', N'Dịch vụ xe cho thuê theo hợp đồng');

insert into MUCPHI(MaMP, DonGia, MoTa) 
values
('MP01',10000, N'Áp dụng từ 1/2015'),
('MP02',15000, N'Áp dụng từ 2/2015'),
('MP03',20000, N'Áp dụng từ 1/2010'),
('MP04',25000, N'Áp dụng từ 2/2011');

insert into DONGXE(DongXe, HangXe, SoChoNgoi) 
values
('Hiace', 'Toyota', 16),
('Vios', 'Toyota', 5),
('Escape', 'TFord', 5),
('Ceralo', 'KIA', 7),
('Forte', 'KIA', 5),
('Starex', 'Huyndai', 7),
('Grand-i10', 'Huyndai', 7);

insert into DANGKYCUNGCAP(MaDKCC, MaNhaCC, MaLoaiDV, DongXe, MaMP, NgayBatDauCungCap, NgayKetThucCungCap,SoLuongXeDangKy) 
values
('DK001','NCC001', 'DV01', 'Hiace', 'MP01','20151120', '20161120', 4),
('DK002','NCC002', 'DV02', 'Vios', 'MP02','20151120', '20171120', 3),
('DK003','NCC003', 'DV03', 'Escape', 'MP03','20171120', '20181120', 5),
('DK004','NCC001', 'DV01', 'Ceralo', 'MP04','20151120', '20191120', 7),
('DK005','NCC002', 'DV02', 'Forte', 'MP03','20191120', '20201120', 1),
('DK006','NCC003', 'DV03', 'Starex', 'MP04','20161110', '20211120', 2),
('DK007','NCC001', 'DV01', 'Ceralo', 'MP03','20151130', '20160125', 8),
('DK008','NCC001', 'DV01', 'Vios', 'MP02','20160228', '20160815', 9),
('DK009','NCC003', 'DV03', 'Grand-i10', 'MP02','20160427', '20161120', 10),
('DK0010','NCC001', 'DV01', 'Forte', 'MP02','20151121', '20160222', 4),
('DK0011', 'NCC007', 'DV01', 'Forte', 'MP01','20161225','20171120',5);


--READ
select * from NHACUNGCAP;
select * from LOAIDICHVU;
select * from MUCPHI;
select * from DONGXE;
select * from DANGKYCUNGCAP;

--Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ

select DongXe from DONGXE where SoChoNgoi >= 5;

--Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những
--dòng xe
--thuộc hãng xe “Toyota” với mức phí có đơn giá là 15.000 VNĐ/km hoặc những
--dòng xe
--thuộc hãng xe “KIA” với mức phí có đơn giá là 20.000 VNĐ/km

select * from NHACUNGCAP 
	where MaNhaCC in ( select MaNhaCC from DANGKYCUNGCAP 
		where MaDKCC in (select MaDKCC from DANGKYCUNGCAP 
			where MaMP in (select MaMP from MUCPHI where DonGia = 15000 ) and DongXe in (select DongXe from DONGXE where HangXe = 'Toyota')
			or MaMP in (select MaMP from MUCPHI where DonGia = 20000 ) and DongXe in (select DongXe from DONGXE where HangXe = 'KIA')
																																				)	
																																					);

--Câu 5: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên
--nhà cung cấp và giảm dần theo mã số thuế
select * from NHACUNGCAP order by TennhaCC asc;
select * from NHACUNGCAP order by  MaSoThue desc;


--Câu 6: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung
--cấp với yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày 

select count(*) as SolanDangKy, MaNhaCC from DANGKYCUNGCAP 
	where NgayBatDauCungCap = '20151120' group by MaNhaCC;


--Câu 7: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe
--chỉ được liệt kê một lần
SELECT DISTINCT HangXe
FROM DONGXE;

--Câu 8: Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia,
--HangXe, NgayBatDauCC, NgayKetThucCC của tất cả các lần đăng ký cung cấp phương
--tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương
--tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra

select DANGKYCUNGCAP.MaDKCC, DANGKYCUNGCAP.MaNhaCC, NHACUNGCAP.TenNhaCC, NHACUNGCAP.Diachi, NHACUNGCAP.MaSoThue, LOAIDICHVU.TenLoaiDV, 
MUCPHI.DonGia, DONGXE.HangXe, DANGKYCUNGCAP.NgayBatDauCungCap, DANGKYCUNGCAP.NgayKetThucCungCap from NHACUNGCAP 
inner join DANGKYCUNGCAP on DANGKYCUNGCAP.MaNhaCC = NHACUNGCAP.MaNhaCC 
inner join LOAIDICHVU on LOAIDICHVU.MaLoaiDV = NHACUNGCAP.MaLoaiDV 
inner join MUCPHI on MUCPHI.MaMP = NHACUNGCAP.MaMP
inner join DONGXE on DONGXE.DongXe = NHACUNGCAP.DongXe;


--Câu 9: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện
--thuộc dòng xe “Hiace” hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “Cerato”

select * from NHACUNGCAP 
	where MaNhaCC in (select MaNhaCC from DANGKYCUNGCAP where DongXe in ('Hiace', 'Ceralo'));

--Câu 10: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp
--phương tiện lần nào cả.

select * from NHACUNGCAP where MaNhaCC not in
(select MaNhaCC from DANGKYCUNGCAP);

