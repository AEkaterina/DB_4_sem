use UNIVER 

create table RESULTS (
	ID int primary key identity (1,1),
	STUDENT_NAME nvarchar(20),
	OOP int,
	Java int,
	Web int,
	DB int,
	AVER_VALUE as (OOP + Java + Web + DB)/4
);