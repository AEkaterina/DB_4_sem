use [04_UNIVER]

--- 1
select FACULTY.FACULTY_NAME as 'Факультет', PULPIT.PULPIT_NAME as 'Кафедра'
	from FACULTY, PULPIT
	where FACULTY.FACULTY = PULPIT.FACULTY
		and PULPIT.FACULTY 
		in (select PROFESSION.FACULTY from PROFESSION 
			where (PROFESSION_NAME like '%технология%' or PROFESSION_NAME like '%технологии%'));


--- 2
select FACULTY.FACULTY_NAME as 'Факультет', PULPIT.PULPIT_NAME as 'Кафедра'
	from FACULTY inner join PULPIT
	on FACULTY.FACULTY = PULPIT.FACULTY 
		and PULPIT.FACULTY 
		in (select PROFESSION.FACULTY from PROFESSION 
			where (PROFESSION_NAME like '%технология%' or PROFESSION_NAME like '%технологии%'));


--- 3
select FACULTY.FACULTY_NAME as 'Факультет', PULPIT.PULPIT_NAME as 'Кафедра'
	from FACULTY inner join PULPIT
	on FACULTY.FACULTY = PULPIT.FACULTY
		inner join PROFESSION
		on FACULTY.FACULTY = PROFESSION.FACULTY
			where PROFESSION_NAME like '%технология%' or PROFESSION_NAME like '%технологии%'


--- 4
select * 
	from AUDITORIUM a
		where AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM aa
			where aa.AUDITORIUM_TYPE = a.AUDITORIUM_TYPE
				order by AUDITORIUM_CAPACITY desc)
		order by AUDITORIUM_CAPACITY desc


--- 5 
select FACULTY_NAME as 'Факультет' from FACULTY
	where not exists (select * from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY)

select FACULTY_NAME as 'Факультет' from FACULTY
	where exists (select * from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY)


--- 6
select top (1)
	(select avg(NOTE) from PROGRESS
		where PROGRESS.SUBJECT = N'ОАиП') [ОАиП],
	(select avg(NOTE) from PROGRESS
		where PROGRESS.SUBJECT = N'БД') [БД],
	(select avg(NOTE) from PROGRESS
		where PROGRESS.SUBJECT = N'СУБД') [СУБД]
from PROGRESS


--- 7 (список аудиторий, где вместимость >= макс. из ЛБ-К
select AUDITORIUM, AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM 
where AUDITORIUM_CAPACITY >= all
	(select AUDITORIUM_CAPACITY from AUDITORIUM
	where AUDITORIUM_TYPE like 'ЛБ-К')
order by AUDITORIUM_CAPACITY asc
select max(AUDITORIUM_CAPACITY) as 'макс. вместимость ЛБ-К' from AUDITORIUM where AUDITORIUM_TYPE like 'ЛБ-К'


--- 8 список аудиторий, где вместимость > хотя бы 1 из %ЛК%
select AUDITORIUM, AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM 
where AUDITORIUM_CAPACITY > any
	(select AUDITORIUM_CAPACITY from AUDITORIUM
	where AUDITORIUM_TYPE like '%ЛК%')
order by AUDITORIUM_CAPACITY asc
select min(AUDITORIUM_CAPACITY) as 'мин. вместимость %ЛК%' from AUDITORIUM where AUDITORIUM_TYPE like '%ЛК%'
