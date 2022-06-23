create database StudentTest;
drop database quanlydiemhocvien;

create table tests(
TestID int primary key,
TestName  varchar(20)
);

create table students(
StudentID int primary key,
StudentName VarChar (20),
Age int
);

alter table students
add Status varchar(255);

create table studenttest(
StudentID int,
TestID int,
Date date,
Mark float,
foreign key (StudentID) references students(StudentID),
foreign key (TestID) references tests(TestID)
);

Insert into tests value (1,'EPC');
Insert into tests value (2,'DWMX');
Insert into tests value (3,'SQL1');
Insert into tests value (4,'SQL2');

Insert into students value (1, 'Nguyen Hong Ha',20);
Insert into students value (2, 'Truong Ngoc Anh',30);
Insert into students value (3, 'Tuan Minh',25);
Insert into students value (4, 'Dan Truong',22);

Insert into studenttest value (1, 1, '2006-07-17',8);
Insert into studenttest value (1, 2, '2006-07-18',5);
Insert into studenttest value (1, 3, '2006-07-19',7);
Insert into studenttest value (2, 1, '2006-07-17',7);
Insert into studenttest value (2, 2, '2006-07-18',4);
Insert into studenttest value (2, 3, '2006-07-19',2);
Insert into studenttest value (3, 1, '2006-07-17',10);
Insert into studenttest value (3, 3, '2006-07-19',1);

-- 2.Hiển thị danh sách các học viên đã tham gia thi, các môn thi được thi bởi các học viên đó,
-- điểm thi và ngày thi giống như hình sau:
create view markAll AS
select students.StudentName, tests.TestName, studenttest.Mark, studenttest.Date
from studenttest join students on studenttest.StudentID = students.StudentID
                 join tests on studenttest.TestID = tests.TestID;

-- 3.Hiển thị danh sách các bạn học viên chưa thi môn nào
select students.*
from students  left join studenttest on studenttest.StudentID = students.StudentID
where Mark is null;

-- 4.Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại và điểm thi
-- (điểm phải thi lại là điểm nhỏ hơn 5) như sau:               
select students.StudentName, tests.TestName, studenttest.mark, studenttest.date
from students   join studenttest on studenttest.StudentID = students.StudentID
				join tests on studenttest.testID = tests.testID
where Mark < 5;

-- 5.Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. 
-- Danh sách phải sắp xếp theo thứ tự điểm trung bình giảm dần(nếu không sắp xếp thì chỉ được ½ số điểm) như sau:
create view Average as			
select studentName, AVG(mark) as Average
FROM markAll
group by studentName
order by Average DESC;
DROP VIEW Average;

-- 6.Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất như sau:
select studentName, Max(average)
from average;

-- 7.Hiển thị điểm thi cao nhất của từng môn học. Danh sách phải được sắp xếp theo tên môn học như sau:
select TestName, Max(mark)
from markall
group by TestName
order by TestName;

-- 8.Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi nếu học viên chưa thi môn nào
 -- thì phần tên môn học để Null như sau:
select studentName, TestName
from students left join studenttest on studenttest.StudentID = students.StudentID
              left join tests on studenttest.testID = tests.testID;
              

-- 9.Sửa (Update) tuổi của tất cả các học viên mỗi người lên một tuổi.
UPDATE students
SET age = age - 1
where studentID > 0;

-- 10.Thêm trường tên là Status có kiểu Varchar(10) vào bảng Student.
alter table students
add Status varchar(10);

-- 11.Cập nhật(Update) trường Status sao cho những học viên nhỏ hơn 30 tuổi sẽ nhận giá trị ‘Young’, trường hợp còn lại nhận
-- giá trị ‘Old’ sau đó hiển thị toàn bộ nội dung bảng Student lên như sau:
SET SQL_SAFE_UPDATES = 0;
UPDATE students
SET Status = 'Young'
where age < 30;

UPDATE students
SET Status = 'Old'
where age >= 30;

-- 12.Tạo view tên là StudentTestList hiển thị danh sách học viên và điểm thi, dánh sách phải sắp xếp tăng dần theo ngày thi
create view StudentTestList as
select students.StudentName, tests.TestName, studenttest.Mark, studenttest.Date
from studenttest join students on studenttest.StudentID = students.StudentID
                 join tests on studenttest.TestID = tests.TestID
order By date ASC;

-- 13.Tạo một trigger tên là tgSetStatus sao cho khi sửa tuổi của học viên thi trigger này sẽ tự động cập nhật status theo quy tắc sau:	[2.5]
-- Nếu tuổi nhỏ hơn 30 thì Status=’Young’
-- Nếu tuổi lớn hơn hoặc bằng 30 thì Status=’Old’

-- 14.Tạo một stored procedure tên là spViewStatus, stored procedure này nhận vào 2 tham số:	[2.5]
-- Tham số thứ nhất là tên học viên					
-- Tham số thứ 2 là tên môn học
DELIMITER //
CREATE PROCEDURE spViewStatus (IN studentNameIP varchar(255), testNameIP varchar(255) )
Begin
select DISTINCT 'khong tim thay' as ketqua
from studenttest join students on studenttest.StudentID = students.StudentID
                 join tests on studenttest.TestID = tests.TestID
where  studentName <> studentNameIP or testName <> testNameIP;
End //
DELIMITER ;
DROP PROCEDURE IF EXISTS spViewStatus;
call spViewStatus('Nguyen Hong Ha','SQL1');

-- Nếu tên học viên hoặc tên môn học không tìm thây trong cơ sở dữ liệu thì hiện ra màn hình thông báo: ‘Khong tim thay’
-- Trường hợp còn lại thi hiển thị trạng thái của học viên đó với môn học đó theo quy tắc sau:
-- Hiển thị ‘Chua thi’ nếu học viên đó chưa thi môn đó
-- Hiển thị ‘Do’ nếu đã thi rồi và điểm lơn hơn hoặc bằng 5
-- Hiển thị ‘Trượt’ nếu đã thi rồi và điểm thi nhỏ hơn 5
