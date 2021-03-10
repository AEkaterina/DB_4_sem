use UNIVER

create table STUDENT (
	Номер_зачетки int primary key identity (1, 1),
	ФИО nvarchar (50) not null,
	Дата_рождения date not null,
	Пол nchar default 'м' check (Пол in ('м', 'ж')),
	Дата_поступления date not null
);