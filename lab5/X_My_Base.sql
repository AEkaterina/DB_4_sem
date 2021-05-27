use [02 Курсы повышения квалификации]



select Нагрузка.Номер_группы, Группа.Специальность 
from Нагрузка inner join Группа
on Нагрузка.Номер_группы = Группа.Номер_группы


select Нагрузка.Номер_группы, Группа.Специальность 
from Нагрузка inner join Группа
on Нагрузка.Номер_группы = Группа.Номер_группы and Группа.Специальность like N'%ика'


select Нагрузка.Номер_группы, Группа.Специальность 
from Нагрузка, Группа
where Нагрузка.Номер_группы = Группа.Номер_группы

select T1.Номер_группы, T2.Специальность 
from Нагрузка as T1, Группа as T2
where T1.Номер_группы = T2.Номер_группы and T2.Специальность like N'%ика'

select Нагрузка.Номер_группы as 'Номер группы', isnull(Группа.Специальность, '***') as Специальность
from Нагрузка left outer join Группа
on Нагрузка.Номер_группы = Группа.Номер_группы

select Нагрузка.Номер_группы as 'Номер группы', isnull(Группа.Специальность, '***') as Специальность
from Группа right outer join Нагрузка
on Нагрузка.Номер_группы = Группа.Номер_группы

select Нагрузка.Номер_группы as 'Номер группы', isnull(Группа.Специальность, '***') as Специальность
from Нагрузка right outer join Группа
on Нагрузка.Номер_группы = Группа.Номер_группы

select Нагрузка.Номер_группы as 'Номер группы', isnull(Группа.Специальность, '***') as Специальность
from Нагрузка full outer join Группа
on Нагрузка.Номер_группы = Группа.Номер_группы

select Нагрузка.Номер_группы as 'Номер группы', isnull(Группа.Специальность, '***') as Специальность
from Группа full outer join Нагрузка
on Нагрузка.Номер_группы = Группа.Номер_группы

select Нагрузка.Номер_группы as 'Номер группы', isnull(Группа.Специальность, '***') as Специальность
from Группа cross join Нагрузка
where Нагрузка.Номер_группы = Группа.Номер_группы






----- inner join
--select PULPIT.PULPIT_NAME as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
--from PULPIT inner join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

----- null правой
--select isnull(PULPIT.PULPIT_NAME, '***') as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
--from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT
--where PULPIT.PULPIT_NAME is not null and TEACHER.TEACHER_NAME is null

-----null левая
--select isnull(PULPIT.PULPIT_NAME, '***') as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
--from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT
--where PULPIT.PULPIT_NAME is null and TEACHER.TEACHER_NAME is not null

----- правая и левая
--select isnull(PULPIT.PULPIT_NAME, '***') as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
--from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT



--select FACULTY.FACULTY as 'Факультет',
--	   PULPIT.PULPIT as 'Кафедра',
--	   PROFESSION.PROFESSION as 'Специальность',
--	   [SUBJECT].SUBJECT as 'Дисциплина',
--	   STUDENT.NAME as 'Имя студента',
--	   case 
--			when (PROGRESS.NOTE = 6) then 'шесть'
--			when (PROGRESS.NOTE = 7) then 'семь'
--			when (PROGRESS.NOTE = 8) then 'восемь'
--		end 'Оценка'
--		from PROGRESS
--			inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
--			inner join [SUBJECT] on [SUBJECT].[SUBJECT] = PROGRESS.[SUBJECT]
--			inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
--			inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
--			inner join PULPIT on PULPIT.PULPIT = [SUBJECT].PULPIT
--			inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
--		where PROGRESS.NOTE between 6 and 8
--		order by PROGRESS.NOTE desc, FACULTY.FACULTY asc, PULPIT.PULPIT asc, PROFESSION.PROFESSION asc, STUDENT.NAME asc

----- 5

--select FACULTY.FACULTY as 'Факультет',
--	   PULPIT.PULPIT as 'Кафедра',
--	   PROFESSION.PROFESSION as 'Специальность',
--	   [SUBJECT].SUBJECT as 'Дисциплина',
--	   STUDENT.NAME as 'Имя студента',
--	   case 
--			when (PROGRESS.NOTE = 6) then 'шесть'
--			when (PROGRESS.NOTE = 7) then 'семь'
--			when (PROGRESS.NOTE = 8) then 'восемь'
--		end 'Оценка'
--		from PROGRESS
--			inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
--			inner join [SUBJECT] on [SUBJECT].[SUBJECT] = PROGRESS.[SUBJECT]
--			inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
--			inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
--			inner join PULPIT on PULPIT.PULPIT = [SUBJECT].PULPIT
--			inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
--		where PROGRESS.NOTE between 6 and 8
--		order by 
--		(case 
--			when (PROGRESS.NOTE = 6) then 3
--			when (PROGRESS.NOTE = 7) then 1
--			when (PROGRESS.NOTE = 8) then 2
--		end )
