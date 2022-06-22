create database quanlybanhang;

create table nhacungcap(
MaNhaCC int primary Key,
TenNhaCC  varchar(255),
DiaChi varchar(255),
SoDT varchar(255),
MaSoThue varchar(255)
);

create table loaidichvu(
MaloaiDV int primary key,
TenLoaiDV varchar(255)
);
create table DangKyCungCap(
MaDKCC int primary key,
MaNhaCC int,
MaloaiDV int,
DongXe varchar(255),
MaMP int,
NgayBatDauCungCap date,
NgayKetThucCungCap date,
SoLuongXeDangKy int,
foreign key (MaNhaCC) references nhacungcap(MaNhaCC),
foreign key (MaLoaiDV) references loaidichvu(MaLoaiDV),
foreign key (DongXe) references dongxe(DongXe),
foreign key (MaMP) references mucphi(MaMP)

);

create table mucphi(
MaMP int primary key,
DonGia int ,
MoTa varchar(255)
);


create table dongxe(
 DongXe varchar(255) primary key,
 HangXe varchar(255),
 SoChoNgoi int
);

INSERT INTO dangkycungcap  VALUES (1, 1, 1, 'Camry', 2, '2022-06-20', '2022-06-25', 5);
INSERT INTO dangkycungcap  VALUES (2, 1, 2, 'Fortuner', 2, '2022-06-10', '2022-06-15', 3);
INSERT INTO dangkycungcap  VALUES (3, 2, 1, 'Mazda CX8', 2, '2022-06-01', '2022-06-10', 4);
INSERT INTO dangkycungcap  VALUES (4, 2, 2, 'Mazda 6', 1, '2020-06-05', '2020-06-15', 3);

# Câu3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ
select *
from dongxe
where SoChoNgoi > 5;

#Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe
#thuộc hãng xe “Toyota” với mức phí có đơn giá là 200 hoặc những dòng xe
#thuộc hãng xe “Mazda” với mức phí có đơn giá là 100
select nhacungcap.*, dongxe.DongXe, dongxe.HangXe, mucphi.DonGia, mucphi.MoTa
from dangkycungcap join nhacungcap on dangkycungcap.MaNhaCC = nhacungcap.MaNhaCC
				   join dongxe on dangkycungcap.DongXe = dongxe.DongXe
                   join mucphi on dangkycungcap.MaMP = mucphi.MaMP
where (dongxe.HangXe ="Toyota" and mucphi.DonGia = 200) or (dongxe.HangXe ="Mazda" and mucphi.DonGia = 100);

#Câu 5: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp và giảm dần theo mã số thuế
select *
order by TenNhaCC ASC, MaSoThue DESC;

#Câu 6: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với yêu cầu chỉ đếm cho những nhà cung
#cấp thực hiện đăng ký cung cấp có ngày bắt đầu cung cấp là “01/06/2022”
select nhacungcap.*, count(TenNhaCC) as 'Số lần cung cấp'
from dangkycungcap join nhacungcap on dangkycungcap.MaNhaCC = nhacungcap.MaNhaCC
where NgayBatDauCungCap >= '2022-06-01'
group by TenNhaCC;

#Câu 7: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe chỉ được liệt kê một lần
select HangXe
from dongxe
group by HangXe;

#Câu 8: Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia, HangXe, NgayBatDauCC, NgayKetThucCC 
#của tất cả các lần đăng ký cung cấp phương tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương
#tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra
select *
from nhacungcap left join dangkycungcap on dangkycungcap.MaNhaCC = nhacungcap.MaNhaCC
				left join dongxe on dangkycungcap.DongXe = dongxe.DongXe
				left join mucphi on dangkycungcap.MaMP = mucphi.MaMP;

#Câu 9: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện thuộc dòng xe “Mazda 6” 
#hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “Fortune”

select nhacungcap.*, dongxe.DongXe, dangkycungcap.MaDKCC, dangkycungcap.NgayBatDauCungCap, dangkycungcap.NgayKetThucCungCap
from nhacungcap  join dangkycungcap on dangkycungcap.MaNhaCC = nhacungcap.MaNhaCC
				 join dongxe on dangkycungcap.DongXe = dongxe.DongXe
where dangkycungcap.DongXe = 'Mazda 6' or dangkycungcap.DongXe = 'Fortuner';

#Câu 10: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp phương tiện lần nào cả.
select *
from nhacungcap  left join dangkycungcap on dangkycungcap.MaNhaCC = nhacungcap.MaNhaCC
where MaDKCC is null;