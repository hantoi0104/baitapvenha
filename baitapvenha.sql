create database test2;
create table students(
studentID int primary key,
studentName varchar(255),
age int,
email varchar(255)
);

create table classes(
classID int primary key,
className varchar(50)
);

create table classstudent(
studentID int,
classID int,
foreign key (studentID) references students(studentID),
foreign key (classID) references classes(classID)
);

create table subjects(
subjectID int primary key,
subjectName varchar(255)
);

create table marks(
mark int,
subjectID int,
studentID int,
foreign key (subjectID) references subjects(subjectID),
foreign key (studentID) references students(studentID)
);

insert into students value(1, 'Nguyen Quang An', 18, 'an@yahoo.com');
insert into students value(2, 'Nguyen Cong Vinh', 20, 'vinh@yahoo.com');
insert into students value(3, 'Nguyen Van Quyet', 19, 'quyet@yahoo.com');
insert into students value(4, 'Pham Thanh Binh', 25, 'binh@yahoo.com');
insert into students value(5, 'Phan Van Tai Em', 30, 'taiem@yahoo.com');

insert into classes value(1 , 'C0706L'), (2 , 'C0708G');
insert into classstudent value (1, 1), (2, 1), (3, 2), (4, 2), (5, 2);
insert into subjects value(1, 'SQL'), (2, 'Java'), (3, 'C'), (4, 'Visual'), (5, 'Basic');
insert into marks value(8, 1, 1), (4, 2, 1), (9, 1, 1), (7, 1, 3), (3, 1, 4), (5, 2, 5), (8, 3, 3), (1, 3, 5), (3, 2, 4);

# 1, Hien thi danh sach tat ca cac hoc vien 
select * from students;

# 2, Hien thi danh sach tat ca cac mon hoc
select * from subjects;

# 3, Tinh diem trung binh 
select avg(mark) from marks;

# 4, Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
select subjects.subjectName, max(mark) from marks join subjects
on marks.subjectID = subjects.subjectID;

# 5, Danh so thu tu cua diem theo chieu giam
select * from marks
order by mark DESC;

# 6, Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
alter table subjects 
modify subjectName NVARCHAR(4000);

# 7, Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
update subjects 
set subjectName = 'Day la mon hoc' 
where subjectID = 1;


# 8, Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50

# 9, Loai bo tat ca quan he giua cac bang
alter table classstudent, marks
drop foreign key;
ALTER TABLE Orders
DROP FOREIGN KEY FK_PersonOrder;

# 10, Xoa hoc vien co StudentID la 1
delete from students 
where studentID = 1;

# 11, Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table students
add status bit default 1;

# 12, Cap nhap gia tri Status trong bang Student thanh 0
update students
set status = 0 ;





