use [02 ����� ��������� ������������]



select ��������.�����_������, ������.������������� 
from �������� inner join ������
on ��������.�����_������ = ������.�����_������


select ��������.�����_������, ������.������������� 
from �������� inner join ������
on ��������.�����_������ = ������.�����_������ and ������.������������� like N'%���'


select ��������.�����_������, ������.������������� 
from ��������, ������
where ��������.�����_������ = ������.�����_������

select T1.�����_������, T2.������������� 
from �������� as T1, ������ as T2
where T1.�����_������ = T2.�����_������ and T2.������������� like N'%���'

select ��������.�����_������ as '����� ������', isnull(������.�������������, '***') as �������������
from �������� left outer join ������
on ��������.�����_������ = ������.�����_������

select ��������.�����_������ as '����� ������', isnull(������.�������������, '***') as �������������
from ������ right outer join ��������
on ��������.�����_������ = ������.�����_������

select ��������.�����_������ as '����� ������', isnull(������.�������������, '***') as �������������
from �������� right outer join ������
on ��������.�����_������ = ������.�����_������

select ��������.�����_������ as '����� ������', isnull(������.�������������, '***') as �������������
from �������� full outer join ������
on ��������.�����_������ = ������.�����_������

select ��������.�����_������ as '����� ������', isnull(������.�������������, '***') as �������������
from ������ full outer join ��������
on ��������.�����_������ = ������.�����_������

select ��������.�����_������ as '����� ������', isnull(������.�������������, '***') as �������������
from ������ cross join ��������
where ��������.�����_������ = ������.�����_������






----- inner join
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
