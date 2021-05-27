use [02 Курсы повышения квалификации]
go

--1
drop view Teacher
go

create view Teacher
	as select Преподаватель.Код_преподавателя [код],
			  Преподаватель.Имя [имя],
			  Преподаватель.Фамилия [фамилия],
			  Преподаватель.Отчество [отчество],
			  Преподаватель.Стаж [стаж],
			  Преподаватель.Телефон [телефон]
	from Преподаватель
go
select * from Teacher

--2
drop view Hours 
go

create view Hours
	as select Оплата.Тип_занятия [тип занятия],
			  COUNT(*) [общая нагрузка]
	from Оплата join Нагрузка
		on Нагрузка.Код_оплаты = Оплата.Код_оплаты
	group by Оплата.Тип_занятия, Нагрузка.Количество_часов
go
select * from Hours

--3
drop view Profession
go
create view Profession
		as select Группа.Номер_группы [номер],
				  Группа.Отделение [отделение],
				  Группа.Специальность [Специальность],
				  Группа.Количество_студентов [количество]
		from Группа
		where Специальность like 'Экономика'
go

select * from Profession

insert into Profession values (25, 'Очное', 'Инженер', 21)
select * from Profession

--4
drop view Groups
go

create view Groups
	as select Группа.Номер_группы [номер],
			  Группа.Отделение [отделение],
			  Группа.Специальность [Специальность],
			  Группа.Количество_студентов [количество]
		from Группа
	where Группа.Отделение = 'Дневное' with check option
go

select * from Groups

--insert into Groups values (35, 'Заочное', 'Преподавание', 29)

--5
drop view Pay
go

create view Pay (код, тип_занятия, сумма)
	as select top 10 Код_оплаты, Тип_занятия, Сумма_оплаты
	from Оплата
	order by Код_оплаты
go

select * from Pay

--6
--drop view Hours
go

alter view Hours with SCHEMABINDING
	as select Оплата.Тип_занятия [тип занятия],
		COUNT(*) [общая нагрузка]
	from dbo.Оплата join dbo.Нагрузка
		on Нагрузка.Код_оплаты = Оплата.Код_оплаты
	group by Оплата.Тип_занятия, Нагрузка.Количество_часов
go

select * from Hours