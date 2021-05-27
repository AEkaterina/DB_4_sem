use [04_UNIVER]

-- 1 
select max(AUDITORIUM_CAPACITY) [максимальная вместимость],
	   min(AUDITORIUM_CAPACITY) [минимальная вместимость],
	   avg(AUDITORIUM_CAPACITY) [средняя вместимость],
	   sum(AUDITORIUM_CAPACITY) [суммарная вместимость],
	   count(*) [общее количество аудиторий]
from AUDITORIUM


-- 2
select AUDITORIUM_TYPE.AUDITORIUM_TYPENAME as 'Тип аудитории',
	   max(AUDITORIUM_CAPACITY) [максимальная вместимость],
	   min(AUDITORIUM_CAPACITY) [минимальная вместимость],
	   avg(AUDITORIUM_CAPACITY) [средняя вместимость],
	   sum(AUDITORIUM_CAPACITY) [суммарная вместимость],
	   count(*) [общее количество аудиторий]
from AUDITORIUM inner join AUDITORIUM_TYPE
	on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM_TYPENAME


-- 3
select *
	from (select case when NOTE = 10 then '10'
		when NOTE between 8 and 9 then '8-9'
		when NOTE between 6 and 7 then '6-7'
		when NOTE between 4 and 5 then '4-5'
		else '<4' 
		end [Оценки], count(*)[Количество]
	from PROGRESS group by case
		when NOTE = 10 then '10'
		when NOTE between 8 and 9 then '8-9'
		when NOTE between 6 and 7 then '6-7'
		when NOTE between 4 and 5 then '4-5'
		else '<4' 
		end) as T
			order by case [Оценки]
				when '10' then 1
				when '8-9' then 2
				when '6-7' then 3
				when '4-5' then 4
				else 5 
				end


-- 4 средняя оценка каждого курса каждой сппециальности
select FACULTY.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   (GROUPS.YEAR_FIRST - 2010 + 1) as 'курс',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from STUDENT inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join GROUPS
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join FACULTY
	on FACULTY.FACULTY = GROUPS.FACULTY
group by FACULTY.FACULTY, GROUPS.PROFESSION, GROUPS.YEAR_FIRST
order by 'Средняя оценка' desc


-- только ОАиП и БД
select FACULTY.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   (GROUPS.YEAR_FIRST - 2010 + 1) as 'курс',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from STUDENT inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join GROUPS
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join FACULTY
	on FACULTY.FACULTY = GROUPS.FACULTY
where (PROGRESS.SUBJECT = 'БД' or PROGRESS.SUBJECT = 'ОАиП')
group by FACULTY.FACULTY, GROUPS.PROFESSION, GROUPS.YEAR_FIRST
order by 'Средняя оценка' desc


-- 5 на факультете ТОВ
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ТОВ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT


-- 5 rollup
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ТОВ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
	

-- 6 cube
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ТОВ'
group by cube (GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT)


-- 7
-- ТОВ
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ТОВ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
-- ХТиТ
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ХТиТ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT

-- ТОВ + ХТиТ
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ТОВ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
union
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ХТиТ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT

-- union all
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ТОВ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
union all
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ХТиТ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT


-- 8 пересечение 
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ТОВ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
intersect
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ХТиТ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT


-- 9 разница
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ТОВ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
except
select GROUPS.FACULTY as 'Факультет', 
	   GROUPS.PROFESSION as 'Специальность',
	   PROGRESS.SUBJECT as 'Дисциплина',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as 'средняя оценка'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = 'ХТиТ'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT


-- 10
select p1.SUBJECT as 'Дисциплина', 
	p1.NOTE as 'Оценка',
	(select count(*) from PROGRESS p2
	where p2.SUBJECT = p1.SUBJECT and p2.NOTE = p1.NOTE) as 'Количество'
from PROGRESS p1
group by p1.SUBJECT, p1.NOTE
having NOTE in (8, 9)

-- ex 12 Подсчитать кол-во студентов в каждой группе, на каждом факультете и всего в университете одним запросом
select GROUPS.FACULTY as 'Факультет', 
	STUDENT.IDGROUP as 'Группа',
	count(STUDENT.IDSTUDENT) as 'Кол-во студентов'
from STUDENT, GROUPS
where GROUPS.IDGROUP = STUDENT.IDGROUP
group by rollup (GROUPS.FACULTY, STUDENT.IDGROUP)

--Подсчитать кол-во аудиторий по типам и вместимости в корпусах и всего одним запросом
select AUDITORIUM_TYPE as 'Тип аудитории', 
	AUDITORIUM_CAPACITY as 'Вместимость',
	case 
		when AUDITORIUM.AUDITORIUM like '%-1' then '1'
		when AUDITORIUM.AUDITORIUM like '%-2' then '2'
		when AUDITORIUM.AUDITORIUM like '%-3' then '3'
		when AUDITORIUM.AUDITORIUM like '%-3a' then '3a'
		when AUDITORIUM.AUDITORIUM like '%-4' then '4'
		when AUDITORIUM.AUDITORIUM like '%-5' then '5'
	end 'Корпус', 
	count(*) as 'Количество'
from AUDITORIUM 
group by AUDITORIUM_TYPE, AUDITORIUM_CAPACITY,
	case 
		when AUDITORIUM.AUDITORIUM like '%-1' then '1'
		when AUDITORIUM.AUDITORIUM like '%-2' then '2'
		when AUDITORIUM.AUDITORIUM like '%-3' then '3'
		when AUDITORIUM.AUDITORIUM like '%-3a' then '3a'
		when AUDITORIUM.AUDITORIUM like '%-4' then '4'
		when AUDITORIUM.AUDITORIUM like '%-5' then '5'
	end with rollup