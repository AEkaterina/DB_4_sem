use [02 Курсы повышения квалификации]

select * from Группа
select * from Нагрузка
select * from Оплата
select * from Преподаватель

-- 1 список дисциплин на кафедре ИСиТ в одну строку через запятую
declare @prof char(20), @out char(300) = '';
declare EX1 cursor 
		for select Специальность from Группа 
	where Отделение='Дневное'; 
	open EX1
	fetch EX1 into @prof;
	print 'Группы дневного отделения: ';
	while @@FETCH_STATUS = 0
		begin
			set @out = rtrim(@prof) + ', ' + @out;
			fetch EX1 into @prof;
		end;
	print @out;
close EX1;
deallocate EX1;

-- 2 отличие глобального курсора от локального
declare EX2_local cursor local
	for select Специальность, Количество_студентов from Группа
declare @pr char(30), @count int;
	open EX2_local;
	fetch EX2_local into @pr, @count;
	print '1. ' + rtrim(@pr) + ' ' + convert(varchar,@count);
	go
-- ошибка: курсор EX2_local не существует
--declare @pr char(10), @count int;
--	fetch EX2_local into @pr, @count;
--	print '2. ' + rtrim(@pr) + ' ' + convert(varchar,@count);
--	go

declare EX2_global cursor global
	for select Специальность, Количество_студентов from Группа
declare @pr char(10), @count int;
	open EX2_global;
	fetch EX2_global into @pr, @count;
	print '1. ' + rtrim(@pr) + ' ' + convert(varchar,@count);
	go
declare @pr char(10), @count int;
	fetch EX2_global into @pr, @count;
	print '2. ' + rtrim(@pr) + ' ' + convert(varchar,@count);
close EX2_global;
deallocate EX2_global;
go

-- 3 отличие статического курсора от динамического
declare EX3_group cursor local dynamic
	for select Отделение, Количество_студентов, Специальность from Группа
	where Отделение = 'Дневное';
declare @ot char(15), @kol int, @ppf char(50);
	open EX3_group;
	print 'Количество строк: ' + convert(varchar, @@CURSOR_ROWS);
	insert into Группа values (43, 'ТЕСТ', 'Дневное', 16);
	update Группа set Количество_студентов = 29 where Специальность = 'ТЕСТ';
	fetch EX3_group into @ot, @kol, @ppf;
	while @@FETCH_STATUS = 0
		begin
			print rtrim(@ot) + ' ' + convert(varchar, @kol) + ' ' + rtrim(@ppf);
			fetch EX3_group into @ot, @kol, @ppf;
		end;
	close EX3_group;
delete Группа where Количество_студентов = 'ТЕСТ';
go

-- 4 scroll запрос
declare EX4_SCROLL cursor local dynamic scroll
	for select ROW_NUMBER() over (order by Специальность asc) N, Специальность
	from Группа
declare @num int, @name char(50);
	open EX4_SCROLL;
		fetch last from EX4_SCROLL into @num, @name;
		print char(9) + 'LAST:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
		fetch first from EX4_SCROLL into @num, @name;
		print char(9) + 'FIRST:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
		fetch next from EX4_SCROLL into @num, @name;
		print char(9) + 'NEXT:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
		fetch absolute 5 from EX4_SCROLL into @num, @name;
		print char(9) + 'ABSOLUTE 5:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
		fetch relative 2 from EX4_SCROLL into @num, @name;
		print char(9) + 'RELATIVE 2:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
		fetch prior from EX4_SCROLL into @num, @name;
		print char(9) + 'PRIOR:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
		fetch absolute -7 from EX4_SCROLL into @num, @name;
		print char(9) + 'ABSOLUTE -7:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
		fetch relative -1 from EX4_SCROLL into @num, @name;
		print char(9) + 'RELATIVE -1:' + char(10) + convert(varchar, @num) + ' ' + rtrim(@name);
	close EX4_SCROLL;
go

--5 current of
insert into Оплата values (238974, 'ОПЛАТА', 1500); 

declare EX5_CURRENT cursor local scroll dynamic
	for select Тип_занятия, Сумма_оплаты from Оплата
	for update; 
declare @fac varchar(5), @full varchar(50); 
	open EX5_CURRENT 
		fetch first from EX5_CURRENT into @fac, @full; 
		print @fac + ' ' + @full;
		update Оплата set Сумма_оплаты = 4 where current of EX5_CURRENT; 
		fetch first from EX5_CURRENT into @fac, @full; 
		print @fac + ' ' + @full;
		delete Оплата where current of EX5_CURRENT;
	close EX5_CURRENT;
go

-- 6 удаляются cотрудники с пределом < 1р
--insert into СОТРУДНИКИ values 
--	('Биба', 'TEST', 0.28),
--	('Боба', 'TEST', 0.92),
--	('Лупа', 'TEST', 0.73),
--	('Пупа', 'TEST', 0.61)

--select Имя_сотрудника, Предел_расхода 
--from СОТРУДНИКИ 
--	inner join ОТДЕЛЫ on СОТРУДНИКИ.Отдел = ОТДЕЛЫ.Название_отдела
--where Предел_расхода < 1

--declare EX6_1 cursor local 
--	for	select Имя_сотрудника, Предел_расхода 
--	from СОТРУДНИКИ 
--		inner join ОТДЕЛЫ on СОТРУДНИКИ.Отдел = ОТДЕЛЫ.Название_отдела
--	where Предел_расхода < 1
--declare @student nvarchar(20), @mark int;  
--	open EX6_1;  
--		fetch  EX6_1 into @student, @mark;
--		while @@FETCH_STATUS = 0
--			begin 		
--				delete СОТРУДНИКИ where current of EX6_1;	
--				fetch  EX6_1 into @student, @mark;  
--			end
--	close EX6_1;

--select Имя_сотрудника, Предел_расхода 
--from СОТРУДНИКИ 
--	inner join ОТДЕЛЫ on СОТРУДНИКИ.Отдел = ОТДЕЛЫ.Название_отдела
--where Предел_расхода < 1
--go
		
---- ex 6.2: +1 к оценке конкретного студента (IDSTUDENT) - id 1025
--declare EX6_2 cursor local 
--	for	select Имя_сотрудника, Предел_расхода 
--	from СОТРУДНИКИ
--	where Имя_сотрудника = 'Олег'
--declare @student nvarchar(20), @mark real;  
--	open EX6_2;  
--		fetch  EX6_2 into @student, @mark;
--		update СОТРУДНИКИ set Предел_расхода += 100 where CURRENT OF EX6_2;
--	close EX6_2;

--update СОТРУДНИКИ set Предел_расхода -= 100 where Имя_сотрудника = 'Олег';
--go