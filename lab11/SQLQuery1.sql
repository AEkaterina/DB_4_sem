use [04_UNIVER]
 
--1 список дисциплин на кафедре ИСиТ в одну строку через запятую

declare @sub char(30), @out char(500) = '';
declare EX1 cursor
		for select SUBJECT from SUBJECT
		where SUBJECT.PULPIT = 'ИСиТ';
	open EX1;
	fetch EX1 into @sub;
	print 'Дисципоины на кафедре ИСиТ';
	while @@FETCH_STATUS = 0
	begin
		set @out = rtrim(@sub) + ',' + @out;
		fetch EX1 into @sub;
	end;
	print @out;
close EX1;
deallocate EX1;

--2 отличие глобального курсора от локального 
declare loc cursor local
	for select AUDITORIUM, AUDITORIUM_CAPACITY from AUDITORIUM;
declare @aud char(10), @cap int;
	open loc;
	fetch loc into @aud, @cap;
	print '1.' + rtrim(@aud) + ' ' + cast(@cap as varchar(10));
	go
declare @aud char(10), @cap int;
	fetch loc into @aud, @cap;
	print '2.' + rtrim(@aud) + ' ' + cast(@cap as varchar(10));
	go
	--ошибка курсор и именем loc не сущетсвует 

declare glob cursor global
	for select AUDITORIUM, AUDITORIUM_CAPACITY from AUDITORIUM;
declare @aud char(10), @cap int;
	open glob;
	fetch glob into @aud, @cap;
	print '1.' + rtrim(@aud) + ' ' + cast(@cap as varchar(10));
	go
declare @aud char(10), @cap int;
	fetch glob into @aud, @cap;
	print '2.' + rtrim(@aud) + ' ' + cast(@cap as varchar(10));
	close glob;
	deallocate glob;
go

--3 отличие статических курсоров от динамических
declare @pul char(10), @gen char(1), @name char(50);
declare stat cursor local static
	for select PULPIT, GENDER, TEACHER_NAME from TEACHER
	where PULPIT = 'ИСиТ';
open stat;
print 'Количество строк: ' + convert(varchar, @@CURSOR_ROWS);
insert into TEACHER values ('ВАП', 'Ангелина', 'ж', 'ИСиТ');
update TEACHER set TEACHER_NAME = 'Володина Ангелина Павловна' where TEACHER = 'ВАП';
fetch stat into @pul, @gen, @name;
while @@FETCH_STATUS = 0
begin
	print rtrim(@pul) + ' ' + @gen + ' ' + rtrim(@name);
	fetch stat into @pul, @gen, @name;
end;
close stat;
delete TEACHER where TEACHER = 'ВАП';
go

--4 свойства навигации в результирующем наборе курсора с атрибутом SCROLL
declare @num int, @name char(50);
declare EX4_Scroll cursor local dynamic scroll
for select ROW_NUMBER() over (order by NAME asc) N, NAME from STUDENT
open EX4_Scroll;
fetch last from EX4_Scroll into @num, @name;
print char(9) + 'LAST:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
fetch first from EX4_Scroll into @num, @name;
print char(9) + 'FIRST:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
fetch absolute 20 from EX4_SCROLL into @num, @name;
print char(9) + 'ABSOLUTE 20:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
fetch relative 10 from EX4_SCROLL into @num, @name;
print char(9) + 'RELATIVE 10:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
fetch relative -10 from EX4_SCROLL into @num, @name;
print char(9) + 'RELATIVE -10:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
fetch absolute -20 from EX4_SCROLL into @num, @name;
print char(9) + 'ABSOLUTE -20:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
fetch next from EX4_SCROLL into @num, @name;
print char(9) + 'NEXT:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
fetch prior from EX4_SCROLL into @num, @name;
print char(9) + 'PRIOR:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
close EX4_SCROLL;
go

--5 конструкция CURRENT OF 
insert into FACULTY values ('TEST', 'testing current of'); 
declare @fac varchar(5), @full varchar(50); 
declare EX5_current cursor local dynamic scroll 
	for select FACULTY, FACULTY_NAME from FACULTY
	for update; 
open EX5_current 
fetch first from EX5_current into @fac, @full; 
print @fac + ' ' + @full;
update FACULTY set FACULTY = 'THIS' where current of EX5_current; 
fetch first from EX5_current into @fac, @full; 
print @fac + ' ' + @full;
delete FACULTY where current of EX5_current;
close EX5_current;
go

--6 из таблицы удаляются строки, содержащие информацию о студентах, получивших оценки ниже 4
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) values 
	('КГ',   1026,  '06.05.2013',1),
	('КГ',   1027,  '06.05.2013',3),
	('КГ',   1028,  '06.05.2013',1),
	('КГ',   1029,  '06.05.2013',2),
	('КГ',   1030,  '06.05.2013',2),
	('КГ',   1031,  '06.05.2013',3)

select NAME, NOTE 
from PROGRESS 
	inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where NOTE < 4

declare EX6 cursor local 
for	select NAME, NOTE 
from PROGRESS inner join STUDENT 
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where NOTE < 4
declare @student nvarchar(20), @mark int;  
open EX6;  
fetch EX6 into @student, @mark;
while @@FETCH_STATUS = 0
	begin 		
		delete PROGRESS where current of EX6;	
		fetch  EX6 into @student, @mark;  
	end
close EX6;
		
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE) values ('КГ',   1025,  '06.05.2013',3)
select NAME, NOTE 
from PROGRESS inner join STUDENT
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where NOTE<4

go
		
-- +1 к оценке конкретного студента (IDSTUDENT) - id 1025
declare Mark cursor local 
for	select NAME, NOTE 
from PROGRESS inner join STUDENT 
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where PROGRESS.IDSTUDENT = 1025;
declare @student nvarchar(20), @mark int;  
open Mark;  
fetch  Mark into @student, @mark;
update PROGRESS set NOTE = NOTE + 1 where CURRENT OF Mark;
close Mark;

select NAME, NOTE 
from PROGRESS inner join STUDENT
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where PROGRESS.IDSTUDENT = 1025

update PROGRESS set NOTE = NOTE - 1 where IDSTUDENT = 1025;
go

-- 8
select FACULTY.FACULTY, PULPIT.PULPIT, SUBJECT.SUBJECT, count(TEACHER.TEACHER)
	from FACULTY 
		inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
		left outer join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
		left outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT
	group by FACULTY.FACULTY, PULPIT.PULPIT, SUBJECT.SUBJECT
	order by FACULTY asc, PULPIT asc, SUBJECT asc;

declare EX8 cursor local static 
	for select FACULTY.FACULTY, PULPIT.PULPIT, SUBJECT.SUBJECT, count(TEACHER.TEACHER)
	from FACULTY 
		inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
		left outer join SUBJECT on PULPIT.PULPIT = SUBJECT.PULPIT
		left outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT
	group by FACULTY.FACULTY, PULPIT.PULPIT, SUBJECT.SUBJECT
	order by FACULTY asc, PULPIT asc, SUBJECT asc;
declare @faculty char(10), @pulpit char(10), @subject char(10), @cnt_teacher int;
declare @temp_fac char(10), @temp_pul char(10), @list varchar(100), @DISCIPLINES char(12) = 'Дисциплины: ', @DISCIPLINES_NONE char(16) = 'Дисциплины: нет.';
	open EX8;
		fetch EX8 into @faculty, @pulpit, @subject, @cnt_teacher;
		while @@FETCH_STATUS = 0
			begin
				print 'Факультет ' + rtrim(@faculty) + ': ';
				set @temp_fac = @faculty;
				while (@faculty = @temp_fac)
					begin
						print char(9) + 'Кафедра ' + rtrim(@pulpit) + ': ';
						print char(9) + char(9) + 'Количество преподавателей: ' + rtrim(@cnt_teacher) + '.';
						set @list = @DISCIPLINES;

						if(@subject is not null)
							begin
								if(@list = @DISCIPLINES)
									set @list += rtrim(@subject);
								else
									set @list += ', ' + rtrim(@subject);
							end;
						if (@subject is null) set @list = @DISCIPLINES_NONE;

						set @temp_pul = @pulpit;
						fetch EX8 into @faculty, @pulpit, @subject, @cnt_teacher;
						while (@pulpit = @temp_pul)
							begin
								if(@subject is not null)
									begin
										if(@list = @DISCIPLINES)
											set @list += rtrim(@subject);
										else
											set @list += ', ' + rtrim(@subject);
									end;
								fetch EX8 into @faculty, @pulpit, @subject, @cnt_teacher;
								if(@@FETCH_STATUS != 0) break;
							end;
						if(@list != @DISCIPLINES_NONE)
							set @list += '.';
						print char(9) + char(9) + @list;
						if(@@FETCH_STATUS != 0) break;
					end;
			end;
	close EX8;
	deallocate EX8;
go