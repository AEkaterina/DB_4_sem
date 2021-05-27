use [02 ����� ��������� ������������]
go

--1
drop view Teacher
go

create view Teacher
	as select �������������.���_������������� [���],
			  �������������.��� [���],
			  �������������.������� [�������],
			  �������������.�������� [��������],
			  �������������.���� [����],
			  �������������.������� [�������]
	from �������������
go
select * from Teacher

--2
drop view Hours 
go

create view Hours
	as select ������.���_������� [��� �������],
			  COUNT(*) [����� ��������]
	from ������ join ��������
		on ��������.���_������ = ������.���_������
	group by ������.���_�������, ��������.����������_�����
go
select * from Hours

--3
drop view Profession
go
create view Profession
		as select ������.�����_������ [�����],
				  ������.��������� [���������],
				  ������.������������� [�������������],
				  ������.����������_��������� [����������]
		from ������
		where ������������� like '���������'
go

select * from Profession

insert into Profession values (25, '�����', '�������', 21)
select * from Profession

--4
drop view Groups
go

create view Groups
	as select ������.�����_������ [�����],
			  ������.��������� [���������],
			  ������.������������� [�������������],
			  ������.����������_��������� [����������]
		from ������
	where ������.��������� = '�������' with check option
go

select * from Groups

--insert into Groups values (35, '�������', '������������', 29)

--5
drop view Pay
go

create view Pay (���, ���_�������, �����)
	as select top 10 ���_������, ���_�������, �����_������
	from ������
	order by ���_������
go

select * from Pay

--6
--drop view Hours
go

alter view Hours with SCHEMABINDING
	as select ������.���_������� [��� �������],
		COUNT(*) [����� ��������]
	from dbo.������ join dbo.��������
		on ��������.���_������ = ������.���_������
	group by ������.���_�������, ��������.����������_�����
go

select * from Hours