use [02 ����� ��������� ������������]

--- 1 

select ��������.�����_������, ������.������������� 
from �������� inner join ������
on ��������.�����_������ = ������.�����_������

--- 2
select ��������.�����_������, ������.������������� 
from �������� inner join ������
on ��������.�����_������ = ������.�����_������ and ������.������������� like N'%���'

--- 3 
select ��������.�����_������, ������.������������� 
from ��������, ������
where ��������.�����_������ = ������.�����_������

select T1.�����_������, T2.������������� 
from �������� as T1, ������ as T2
where T1.�����_������ = T2.�����_������ and T2.������������� like N'%���'

--- 6


--select PULPIT.PULPIT_NAME as '�������', isnull(TEACHER.TEACHER_NAME, '***') as '�������������'
--from PULPIT left outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

----- 7
--select PULPIT.PULPIT_NAME as '�������', isnull(TEACHER.TEACHER_NAME, '***') as '�������������'
--from TEACHER left outer join PULPIT on PULPIT.PULPIT = TEACHER.PULPIT

--select PULPIT.PULPIT_NAME as '�������', isnull(TEACHER.TEACHER_NAME, '***') as '�������������'
--from TEACHER right outer join PULPIT on PULPIT.PULPIT = TEACHER.PULPIT


----- 8
-----���������������
--select PULPIT.PULPIT_NAME as '�������', isnull(TEACHER.TEACHER_NAME, '***') as '�������������'
--from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

--select PULPIT.PULPIT_NAME as '�������', isnull(TEACHER.TEACHER_NAME, '***') as '�������������'
--from TEACHER full outer join PULPIT on PULPIT.PULPIT = TEACHER.PULPIT

----- �������� inner join
--select PULPIT.PULPIT_NAME as '�������', isnull(TEACHER.TEACHER_NAME, '***') as '�������������'
--from PULPIT inner join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

----- null ������
--select isnull(PULPIT.PULPIT_NAME, '***') as '�������', isnull(TEACHER.TEACHER_NAME, '***') as '�������������'
--from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT
--where PULPIT.PULPIT_NAME is not null and TEACHER.TEACHER_NAME is null

-----null �����
--select isnull(PULPIT.PULPIT_NAME, '***') as '�������', isnull(TEACHER.TEACHER_NAME, '***') as '�������������'
--from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT
--where PULPIT.PULPIT_NAME is null and TEACHER.TEACHER_NAME is not null

----- ������ � �����
--select isnull(PULPIT.PULPIT_NAME, '***') as '�������', isnull(TEACHER.TEACHER_NAME, '***') as '�������������'
--from PULPIT full outer join TEACHER on PULPIT.PULPIT = TEACHER.PULPIT

-----9
--select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
--from AUDITORIUM cross join AUDITORIUM_TYPE
--where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE


--- 4


----- 4

--select FACULTY.FACULTY as '���������',
--	   PULPIT.PULPIT as '�������',
--	   PROFESSION.PROFESSION as '�������������',
--	   [SUBJECT].SUBJECT as '����������',
--	   STUDENT.NAME as '��� ��������',
--	   case 
--			when (PROGRESS.NOTE = 6) then '�����'
--			when (PROGRESS.NOTE = 7) then '����'
--			when (PROGRESS.NOTE = 8) then '������'
--		end '������'
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

--select FACULTY.FACULTY as '���������',
--	   PULPIT.PULPIT as '�������',
--	   PROFESSION.PROFESSION as '�������������',
--	   [SUBJECT].SUBJECT as '����������',
--	   STUDENT.NAME as '��� ��������',
--	   case 
--			when (PROGRESS.NOTE = 6) then '�����'
--			when (PROGRESS.NOTE = 7) then '����'
--			when (PROGRESS.NOTE = 8) then '������'
--		end '������'
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
