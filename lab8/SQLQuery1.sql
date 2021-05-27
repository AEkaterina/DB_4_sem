use [04_UNIVER]
go


-- 1 
drop view �������������
go
create view �������������
	as select TEACHER.TEACHER [���],
			  TEACHER.TEACHER_NAME [��� �������������],
			  TEACHER.GENDER [���],
			  TEACHER.PULPIT [��� �������]
	from TEACHER
go
select * from �������������


-- 2 ��������� ������������� ���������� ���-������� INSERT, UPDATE � DELETE ��� ������������� ���������� ������. 
drop view ����������_������
go
create view ����������_������
	as select FACULTY.FACULTY_NAME [���������],
			  COUNT(PULPIT.FACULTY) [����������]
	from FACULTY join PULPIT
		on FACULTY.FACULTY = PULPIT.FACULTY
	group by FACULTY.FACULTY_NAME
go
select * from ����������_������


-- 3 ������ ���������� ���������, ��������� ���������� ��������� INSERT, UPDATE � DELETE
drop view ���������
go
create view ���������
	as select AUDITORIUM.AUDITORIUM [���],
			  AUDITORIUM.AUDITORIUM_NAME [������������ ���������],
			  AUDITORIUM.AUDITORIUM_TYPE [��� ���������]
	from AUDITORIUM
	where AUDITORIUM_TYPE like '%��%'
go
select * from ��������� 

insert into ��������� values ('test', 'aud_name', '��')
select * from ���������

update ���������
	set ��� = 'UPDATE' where [������������ ���������] = 'aud_name'
select * from ���������

delete from ��������� where ��� = 'UPDATE'
select * from ���������


-- 4 � ������ �����������, ����������� ������ WITH CHECK OPTION
drop view ����������_���������
go
create view ����������_���������
	as select AUDITORIUM.AUDITORIUM [���],
			  AUDITORIUM.AUDITORIUM_NAME [������������ ���������],
			  AUDITORIUM.AUDITORIUM_TYPE [��� ���������]
	from AUDITORIUM
	where AUDITORIUM_TYPE like '%��%' with check option
go
select * from ����������_���������
go
--insert into ����������_��������� values ('test', 'name', '��')


-- 5 ������������� ����������. ���������� ��� ���������� � ���������� �������. ������������ ������ TOP � ORDER BY.
drop view ����������
go
create view ���������� (���, ������������_����������, ���_�������)
	as select top 50 SUBJECT, SUBJECT_NAME, PULPIT
	from SUBJECT
	order by SUBJECT
go
select * from ����������


-- 6 �������� ������������� ������� 2 ���, ����� ��� ���� ��������� � ������� ��������. ������������ ����� SCHEMABINDING. 
go
alter view ����������_������ with SCHEMABINDING
	as select FACULTY.FACULTY_NAME [���������],
			  count(PULPIT.FACULTY) [����������]
	from dbo.FACULTY join dbo.PULPIT
		on FACULTY.FACULTY = PULPIT.FACULTY
	group by FACULTY.FACULTY_NAME
go
select * from ����������_������

-- 8 ������������� ��� ������� TIMETABLE � ���� ����������, pivot
-- PIVOT(���������� �������
-- FOR �������, ���������� ��������, ������� ������ ������� ��������
-- IN ([�������� �� �����������],�)
-- )AS ��������� ������� (�����������)
drop view ����������
go
create view ����������
	as select top(100) [����], [����], [1 ������], [2 ������], [4 ������], [5 ������], [6 ������], [7 ������], [8 ������], [9 ������], [10 ������]
		from (select top(100) DAY_NAME [����],
				convert(varchar, LESSON) [����],
				convert(varchar, IDGROUP) + ' ������' [������],
				[SUBJECT] + ' ' + AUDITORIUM [���������� � ���������]
			from TIMETABLE) tbl
		pivot
			(max([���������� � ���������]) 
			for [������]
			in ([1 ������], [2 ������], [4 ������], [5 ������], [6 ������], [7 ������], [8 ������], [9 ������], [10 ������])
			) as pvt
			order by 
				(case
					 when [����] like '��' then 1
					 when [����] like '��' then 2
					 when [����] like '��' then 3
					 when [����] like '��' then 4
					 when [����] like '��' then 5
					 when [����] like '��' then 6
				 end), [����] asc
go
select * from ����������
