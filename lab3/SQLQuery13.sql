use UNIVER

create table STUDENT (
	�����_������� int primary key identity (1, 1),
	��� nvarchar (50) not null,
	����_�������� date not null,
	��� nchar default '�' check (��� in ('�', '�')),
	����_����������� date not null
);