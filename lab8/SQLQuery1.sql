use [04_UNIVER]
go


-- 1 
drop view Преподаватель
go
create view Преподаватель
	as select TEACHER.TEACHER [код],
			  TEACHER.TEACHER_NAME [имя преподавателя],
			  TEACHER.GENDER [пол],
			  TEACHER.PULPIT [код кафедры]
	from TEACHER
go
select * from Преподаватель


-- 2 Объяснить невозможность выполнения опе-раторов INSERT, UPDATE и DELETE для представления Количество кафедр. 
drop view Количество_кафедр
go
create view Количество_кафедр
	as select FACULTY.FACULTY_NAME [факультет],
			  COUNT(PULPIT.FACULTY) [количество]
	from FACULTY join PULPIT
		on FACULTY.FACULTY = PULPIT.FACULTY
	group by FACULTY.FACULTY_NAME
go
select * from Количество_кафедр


-- 3 только лекционные аудитории, допускать выполнение оператора INSERT, UPDATE и DELETE
drop view Аудитория
go
create view Аудитория
	as select AUDITORIUM.AUDITORIUM [код],
			  AUDITORIUM.AUDITORIUM_NAME [наименование аудитории],
			  AUDITORIUM.AUDITORIUM_TYPE [тип аудитории]
	from AUDITORIUM
	where AUDITORIUM_TYPE like '%ЛК%'
go
select * from Аудитория 

insert into Аудитория values ('test', 'aud_name', 'ЛК')
select * from Аудитория

update Аудитория
	set код = 'UPDATE' where [наименование аудитории] = 'aud_name'
select * from Аудитория

delete from Аудитория where код = 'UPDATE'
select * from Аудитория


-- 4 с учетом ограничения, задаваемого опцией WITH CHECK OPTION
drop view Лекционные_аудитории
go
create view Лекционные_аудитории
	as select AUDITORIUM.AUDITORIUM [код],
			  AUDITORIUM.AUDITORIUM_NAME [наименование аудитории],
			  AUDITORIUM.AUDITORIUM_TYPE [тип аудитории]
	from AUDITORIUM
	where AUDITORIUM_TYPE like '%ЛК%' with check option
go
select * from Лекционные_аудитории
go
--insert into Лекционные_аудитории values ('test', 'name', 'ЛБ')


-- 5 представление Дисциплины. Отображать все дисциплины в алфавитном порядке. Использовать секции TOP и ORDER BY.
drop view Дисциплины
go
create view Дисциплины (код, наименование_дисциплины, код_кафедры)
	as select top 50 SUBJECT, SUBJECT_NAME, PULPIT
	from SUBJECT
	order by SUBJECT
go
select * from Дисциплины


-- 6 Изменить представление задания 2 так, чтобы оно было привязано к базовым таблицам. Использовать опцию SCHEMABINDING. 
go
alter view Количество_кафедр with SCHEMABINDING
	as select FACULTY.FACULTY_NAME [факультет],
			  count(PULPIT.FACULTY) [количество]
	from dbo.FACULTY join dbo.PULPIT
		on FACULTY.FACULTY = PULPIT.FACULTY
	group by FACULTY.FACULTY_NAME
go
select * from Количество_кафедр

-- 8 представление для таблицы TIMETABLE в виде расписания, pivot
-- PIVOT(агрегатная функция
-- FOR столбец, содержащий значения, которые станут именами столбцов
-- IN ([значения по горизонтали],…)
-- )AS псевдоним таблицы (обязательно)
drop view Расписание
go
create view Расписание
	as select top(100) [День], [Пара], [1 группа], [2 группа], [4 группа], [5 группа], [6 группа], [7 группа], [8 группа], [9 группа], [10 группа]
		from (select top(100) DAY_NAME [День],
				convert(varchar, LESSON) [Пара],
				convert(varchar, IDGROUP) + ' группа' [Группа],
				[SUBJECT] + ' ' + AUDITORIUM [Дисциплина и аудитория]
			from TIMETABLE) tbl
		pivot
			(max([Дисциплина и аудитория]) 
			for [Группа]
			in ([1 группа], [2 группа], [4 группа], [5 группа], [6 группа], [7 группа], [8 группа], [9 группа], [10 группа])
			) as pvt
			order by 
				(case
					 when [День] like 'пн' then 1
					 when [День] like 'вт' then 2
					 when [День] like 'ср' then 3
					 when [День] like 'чт' then 4
					 when [День] like 'пт' then 5
					 when [День] like 'сб' then 6
				 end), [Пара] asc
go
select * from Расписание
