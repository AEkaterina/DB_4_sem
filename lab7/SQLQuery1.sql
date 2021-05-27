use [04_UNIVER]

-- 1 
select max(AUDITORIUM_CAPACITY) [������������ �����������],
	   min(AUDITORIUM_CAPACITY) [����������� �����������],
	   avg(AUDITORIUM_CAPACITY) [������� �����������],
	   sum(AUDITORIUM_CAPACITY) [��������� �����������],
	   count(*) [����� ���������� ���������]
from AUDITORIUM


-- 2
select AUDITORIUM_TYPE.AUDITORIUM_TYPENAME as '��� ���������',
	   max(AUDITORIUM_CAPACITY) [������������ �����������],
	   min(AUDITORIUM_CAPACITY) [����������� �����������],
	   avg(AUDITORIUM_CAPACITY) [������� �����������],
	   sum(AUDITORIUM_CAPACITY) [��������� �����������],
	   count(*) [����� ���������� ���������]
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
		end [������], count(*)[����������]
	from PROGRESS group by case
		when NOTE = 10 then '10'
		when NOTE between 8 and 9 then '8-9'
		when NOTE between 6 and 7 then '6-7'
		when NOTE between 4 and 5 then '4-5'
		else '<4' 
		end) as T
			order by case [������]
				when '10' then 1
				when '8-9' then 2
				when '6-7' then 3
				when '4-5' then 4
				else 5 
				end


-- 4 ������� ������ ������� ����� ������ ��������������
select FACULTY.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   (GROUPS.YEAR_FIRST - 2010 + 1) as '����',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from STUDENT inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join GROUPS
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join FACULTY
	on FACULTY.FACULTY = GROUPS.FACULTY
group by FACULTY.FACULTY, GROUPS.PROFESSION, GROUPS.YEAR_FIRST
order by '������� ������' desc


-- ������ ���� � ��
select FACULTY.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   (GROUPS.YEAR_FIRST - 2010 + 1) as '����',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from STUDENT inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join GROUPS
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join FACULTY
	on FACULTY.FACULTY = GROUPS.FACULTY
where (PROGRESS.SUBJECT = '��' or PROGRESS.SUBJECT = '����')
group by FACULTY.FACULTY, GROUPS.PROFESSION, GROUPS.YEAR_FIRST
order by '������� ������' desc


-- 5 �� ���������� ���
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '���'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT


-- 5 rollup
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '���'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
	

-- 6 cube
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '���'
group by cube (GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT)


-- 7
-- ���
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '���'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
-- ����
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '����'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT

-- ��� + ����
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '���'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
union
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '����'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT

-- union all
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '���'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
union all
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '����'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT


-- 8 ����������� 
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '���'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
intersect
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '����'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT


-- 9 �������
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '���'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
except
select GROUPS.FACULTY as '���������', 
	   GROUPS.PROFESSION as '�������������',
	   PROGRESS.SUBJECT as '����������',
	   round(avg(cast(PROGRESS.NOTE as float(4))),2) as '������� ������'
from GROUPS inner join STUDENT
	on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where GROUPS.FACULTY = '����'
group by GROUPS.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT


-- 10
select p1.SUBJECT as '����������', 
	p1.NOTE as '������',
	(select count(*) from PROGRESS p2
	where p2.SUBJECT = p1.SUBJECT and p2.NOTE = p1.NOTE) as '����������'
from PROGRESS p1
group by p1.SUBJECT, p1.NOTE
having NOTE in (8, 9)

-- ex 12 ���������� ���-�� ��������� � ������ ������, �� ������ ���������� � ����� � ������������ ����� ��������
select GROUPS.FACULTY as '���������', 
	STUDENT.IDGROUP as '������',
	count(STUDENT.IDSTUDENT) as '���-�� ���������'
from STUDENT, GROUPS
where GROUPS.IDGROUP = STUDENT.IDGROUP
group by rollup (GROUPS.FACULTY, STUDENT.IDGROUP)

--���������� ���-�� ��������� �� ����� � ����������� � �������� � ����� ����� ��������
select AUDITORIUM_TYPE as '��� ���������', 
	AUDITORIUM_CAPACITY as '�����������',
	case 
		when AUDITORIUM.AUDITORIUM like '%-1' then '1'
		when AUDITORIUM.AUDITORIUM like '%-2' then '2'
		when AUDITORIUM.AUDITORIUM like '%-3' then '3'
		when AUDITORIUM.AUDITORIUM like '%-3a' then '3a'
		when AUDITORIUM.AUDITORIUM like '%-4' then '4'
		when AUDITORIUM.AUDITORIUM like '%-5' then '5'
	end '������', 
	count(*) as '����������'
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