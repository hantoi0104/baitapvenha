create database TicketFilm;
create table phong(
idPhong int primary key,
tenPhong varchar(255),
trangthai varchar(255)
);

create table phim(
idPhim int primary key,
tenPhim varchar(255),
loaiPhim varchar(255),
thoiGian int
);

create table ghe(
idGhe int primary key,
idPhong int,
soGhe varchar (255),
foreign key (idPhong) references phong(idPhong)
);
 
 drop table ve;
 
create table ve(
idPhim int,
idGhe int ,
ngaychieu date,
trangthai varchar(255),
primary key (idPhim, idGhe),
foreign key (idPhim) references phim(idPhim),
foreign key (idGhe) references ghe(idGhe)
);

Insert into phim values ( 1, 'Em bé Hà Nôi', 'Tâm lý', 90 ), (2, 'Nhiệm vụ bất khả thi', 'Hành động', 100 ),
						( 3, 'Dị nhân', 'Viễn tưởng', 90), ( 4 , 'Cuốn theo chiều gió', 'Tình cảm', 120);
                        
Insert into phong values ( 1, 'phong chieu 1', 'Trong' ), (2, 'phong chieu 2', 'Trong' ), ( 3, 'phong chieu 3', 'Day');

Insert into ghe values ( 1,  1, 'A3' ), ( 2,  1, 'B5' ), ( 3,  2, 'A7' ), ( 4,  2, 'D1' ), ( 5,  3, 'T2' );

Insert into ve values ( 1,  1, '2008-10-20', 'Da ban' ), ( 1,  3, '2008-11-20', 'Da ban' ), ( 1,  4, '2008-12-23', 'Da ban' ),
( 2,  1, '2009-02-14', 'Da ban' ), ( 3,  1, '2009-02-14', 'Da ban' ), ( 2,  5, '2009-03-08', 'Chua ban' ), ( 2,  3, '2009-03-08', 'Chua ban' );

-- 2.Hiển thị danh sách các phim (chú ý: danh sách phải được sắp xếp theo trường Thoi_gian)				
select *
from Phim
order by thoiGian;


-- 3.Hiển thị Ten_phim có thời gian chiếu dài nhất
select tenPhim, max(thoigian) as 'thoi gian dai nhat'
from Phim;

-- 4.Hiển thị Ten_Phim có thời gian chiếu ngắn nhất
select tenPhim, min(thoigian) as 'thoi gian ngan nhat'
from Phim;

-- 5.Hiển thị danh sách So_Ghe mà bắt đầu bằng A
select *
from Ghe
where soghe like 'A%';

-- 6. Sửa cột Trang_thai của bảng tblPhong sang kiểu nvarchar(25)			
ALTER TABLE phong
modify trangthai NVARCHAR(255) ;
 
-- 7.Cập nhật giá trị cột Trang_thai của bảng tblPhong theo các luật sau:			
-- Nếu Trang_thai = 0 thì gán Trang_thai=’Đang sửa’
-- Nếu Trang_thai = 1 thì gán Trang_thai=’Đang sử dụng’
-- Nếu Trang_thai = null thì gán Trang_thai=’Unknow’
-- Sau đó hiển thị bảng tblPhong 
update phong
set trangthai = if(trangthai = 0, 'Dang sua', 'Dang su dung')
where idphong > 0;

-- 8.Hiển thị danh sách tên phim mà  có độ dài >15 và < 25 ký tự 			
select *
from phim
where length(tenphim) > 15 and length(tenphim) > 25;

-- 9.Hiển thị Ten_Phong và Trang_Thai trong bảng tblPhong  trong 1 cột với tiêu đề ‘Trạng thái phòng chiếu’
select concat(tenphong, ' - ', trangthai) as 'trang thai phong chieu'
from phong;

-- 10. Tạo bảng mới có tên tblRank với các cột sau: STT(thứ hạng sắp xếp theo Ten_Phim), TenPhim, Thoi_gian	
create table tblRank(
Stt int AUTO_INCREMENT primary key,
TenPhim varchar(255),
Thoigian int 
);
insert into tblRank(tenphim, thoiGian) 
SELECT phim.tenphim, phim.thoiGian FROM phim;
    
-- 11. Trong bảng tblPhim :
-- a.Thêm trường Mo_ta kiểu nvarchar(max)	
alter table Phim
add moTa nvarchar(255);	
				
-- b.Cập nhật trường Mo_ta: thêm chuỗi “Đây là bộ phim thể loại  ” + nội dung trường LoaiPhim			
update Phim
set mota = concat ('Đây là bộ phim thể loại',' ', loaiphim)
where idphim > 0;
						
-- c.Hiển thị bảng tblPhim sau khi cập nhật		
select *
from phim;	
	
-- d.Cập nhật trường Mo_ta: thay chuỗi “bộ phim” thành chuỗi “film”

-- e.Hiển thị bảng tblPhim sau khi cập nhật	
select *
from phim;	
-- 12.Xóa tất cả các khóa ngoại trong các bảng trên.						

-- 13.Xóa dữ liệu ở bảng tblGhe

-- 14.Hiển thị ngày giờ hiện tại và ngày giờ hiện tại cộng thêm 5000 phút
