use [04_UNIVER]

--- 1
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	from AUDITORIUM inner join AUDITORIUM_TYPE
	on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE

--- 2
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	from AUDITORIUM inner join AUDITORIUM_TYPE
	on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like N'%компьютер%'

--- 3 
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM, AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE

select T1.AUDITORIUM, T2.AUDITORIUM_TYPENAME
from AUDITORIUM as T1, AUDITORIUM_TYPE as T2
where T1.AUDITORIUM_TYPE = T2.AUDITORIUM_TYPE and T2.AUDITORIUM_TYPENAME like N'%компьютер%'

--- 4

select FACULTY.FACULTY as 'Факультет',
	   PULPIT.PULPIT as 'Кафедра',
	   PROFESSION.PROFESSION as 'Специальность',
	   [SUBJECT].SUBJECT as 'Дисциплина',
	   STUDENT.NAME as 'Имя студента',
	   case 
			when (PROGRESS.NOTE = 6) then 'шесть'
			when (PROGRESS.NOTE = 7) then 'семь'
			when (PROGRESS.NOTE = 8) then 'восемь'
		end 'Оценка'
		from PROGRESS
			inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
			inner join [SUBJECT] on [SUBJECT].[SUBJECT] = PROGRESS.[SUBJECT]
			inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
			inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
			inner join PULPIT on PULPIT.PULPIT = [SUBJECT].PULPIT
			inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
		where PROGRESS.NOTE between 6 and 8
		order by PROGRESS.NOTE desc, FACULTY.FACULTY asc, PULPIT.PULPIT asc, PROFESSION.PROFESSION asc, STUDENT.NAME asc

--- 5

select FACULTY.FACULTY as 'Факультет',
	   PULPIT.PULPIT as 'Кафедра',
	   PROFESSION.PROFESSION as 'Специальность',
	   [SUBJECT].SUBJECT as 'Дисциплина',
	   STUDENT.NAME as 'Имя студента',
	   case 
			when (PROGRESS.NOTE = 6) then 'шесть'
			when (PROGRESS.NOTE = 7) then 'семь'
			when (PROGRESS.NOTE = 8) then 'восемь'
		end 'Оценка'
		from PROGRESS
			inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
			inner join [SUBJECT] on [SUBJECT].[SUBJECT] = PROGRESS.[SUBJECT]
			inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
			inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
			inner join PULPIT on PULPIT.PULPIT = [SUBJECT].PULPIT
			inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
		where PROGRESS.NOTE between 6 and 8
		order by 
		(case 
			when (PROGRESS.NOTE = 6) then 3
			when (PROGRESS.NOTE = 7) then 1
			when (PROGRESS.NOTE = 8) then 2
		end )

--- 6

select PULPIT.PULPIT_NAME as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
from PULPIT left outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

--- 7
select PULPIT.PULPIT_NAME as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
from TEACHER left outer join PULPIT on PULPIT.PULPIT = TEACHER.PULPIT

select PULPIT.PULPIT_NAME as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
from TEACHER right outer join PULPIT on PULPIT.PULPIT = TEACHER.PULPIT


--- 8
---коммутативность
select PULPIT.PULPIT_NAME as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

select PULPIT.PULPIT_NAME as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
from TEACHER full outer join PULPIT on PULPIT.PULPIT = TEACHER.PULPIT

--- содержит inner join
select PULPIT.PULPIT_NAME as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
from PULPIT inner join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

--- null правой
select isnull(PULPIT.PULPIT_NAME, '***') as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT
where PULPIT.PULPIT_NAME is not null and TEACHER.TEACHER_NAME is null

---null левая
select isnull(PULPIT.PULPIT_NAME, '***') as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT
where PULPIT.PULPIT_NAME is null and TEACHER.TEACHER_NAME is not null

--- правая и левая
select isnull(PULPIT.PULPIT_NAME, '***') as 'Кафедра', isnull(TEACHER.TEACHER_NAME, '***') as 'Преподаватель'
from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

---9
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM cross join AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
