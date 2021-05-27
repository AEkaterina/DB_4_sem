use [04_UNIVER]

-- 1
declare @vchar char(3) = 'var',
		@vvarchar varchar(5) = 'Hello',
		@vdatetime datetime,
		@vtime time,
		@vint int,
		@vsmallint smallint,
		@tinyint tinyint,
		@vnumeric numeric(12, 5);

set @vdatetime = GETDATE();
select @vtime = '15:32:12';

select @vint = 13488, @vsmallint = 32, @vnumeric = 135897.35971;
select @vchar vchar, @vvarchar vvarchar, @vdatetime vdatetime, @vtime vtime;

print'vint = ' + cast(@vint as varchar(10));
print'vsmallint = ' + cast(@vsmallint as varchar(10));
--print'vtinyint = ' + cast(@vtinyint as varchar(10));
print'vnumeric = ' + cast(@vnumeric as varchar(20));


-- 2 общая вместимость аудиторий. Когда общая вместимость превышает 200, то вывести количество аудиторий, среднюю вместимость аудиторий, коли-чество аудиторий, 
--вместимость которых меньше средней, и процент таких ауди-торий. Когда общая вместимость ауди-торий меньше 200, то вывести сообще-ние о размере общей вместимости
declare @capacity int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM),
		@count int,
		@avg numeric(8,4),
		@count_less int,
		@per numeric(4,2);
if @capacity >= 200
	begin
		set @count = (select count(*) from AUDITORIUM)
		set @avg = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM)
		set @count_less = (select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY < @avg)
		set @per = (cast(@count_less as numeric(4,2)) / cast(@count as numeric(4,2))) * 100
		select @count 'Количество аудиторий', @avg 'Средняя вместимость', @count_less 'Количество аудиторий, меньших средней',
				@per 'Процент аудиторий, меньших средней';
	end
else
	select @capacity 'Общая вместимость';

--3 глобальные переменные
print 'Число обработанных строк:';
print @@ROWCOUNT;
print 'Версия SQL Server:';
print @@VERSION;
print 'Системный идентификатор процесса:';
print @@SPID;
print 'Код последней ошибки:';
print @@ERROR;
print 'Имя сервера:';
print @@SERVERNAME;
print 'Уровень вложенности транзакции:';
print @@TRANCOUNT;
print 'Проверка результата считывания строк результирующего набора:';
print @@FETCH_STATUS;
print 'Уровень вложенности текущей процедуры:';
print @@NESTLEVEL;

--4 уравнение 
declare @z float, @t float = 3.58, @x float = 5.23;

if (@t > @x) set @z = POWER(sin(@t),2);
if (@t < @x) set @z = (4 * (@t + @x));
if (@t = @x) set @z = (1 - exp(@x - 2));

print 'z = ' + cast(@z as varchar(10));

-- преобразование полного ФИО студента в сокращенное 
declare @fio varchar(70) = 'Астапкина Екатерина Васильевна';
declare @short_fio varchar(30) = substring(@fio, 1, charindex(' ', @fio))
		+ substring(@fio, charindex(' ', @fio) + 1, 1) + '.'
		+ substring(@fio, charindex(' ', @fio, charindex(' ', @fio) + 1) + 1, 1) + '.';

print 'Полное имя: ' + @fio;
print 'Сокращенное имя: ' + @short_fio;


--поиск студентов, у которых день рож-дения в следующем месяце, и определе-ние их возраста
select STUDENT.NAME as 'Имя студента', STUDENT.BDAY as 'Дата рождения', (datediff(year, STUDENT.BDAY, getdate())) as 'Возраст'
from STUDENT
where month(STUDENT.BDAY) = (month(getdate()) + 1)

--5 конструкция IF… ELSE 
if ((select count(*) from AUDITORIUM) > 10)
	print 'Имеется больше 10 аудиторий';
else 
	print 'Имеется меньше аудиторий';

--6 с помощью CASE анализируются оценки, полученные студентами некоторого факультета при сдаче экзаменов.
select case
	when PROGRESS.NOTE between 8 and 10 then 'высокая'
	when PROGRESS.NOTE between 5 and 7 then 'средняя'
	when PROGRESS.NOTE = 4 then 'низкая'
	else 'не удовлетворительная'
	end Оценка, count(*) 'Количество'
from PROGRESS, STUDENT, GROUPS
where PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	and STUDENT.IDGROUP = GROUPS.IDGROUP
	and GROUPS.FACULTY = 'ИДиП'
group by case
	when PROGRESS.NOTE between 8 and 10 then 'высокая'
	when PROGRESS.NOTE between 5 and 7 then 'средняя'
	when PROGRESS.NOTE = 4 then 'низкая'
	else 'не удовлетворительная'
	end

--7 временная лок таблица
drop table #EXPLRE
create table #EXPLRE
(	id int not null,
	name varchar(10) not null,
	year int not null
);

set nocount on;
declare @i int = 0;
while @i < 10
	begin 
insert #EXPLRE (id, name, year)
	values (@i, ('student' + cast(@i as varchar(2))), cast(((2021 * @i)-500)as int));
set @i = @i + 1;
end;

select * from #EXPLRE;

--8 оператор return
declare @xx int = 0;
while @xx < 10
	begin
	print 'x = ' + cast(@xx as varchar(5));
	if (@xx = 5) return;
	set @xx = @xx + 1;
	end;

go

--9 ошибки
begin try
	insert into #EXPLRE values (null, null, null);
	end try
begin catch
	print 'ERROR_NUMBER: ' + CONVERT(varchar, ERROR_NUMBER());
	print 'ERROR_MESSAGE: ' + ERROR_MESSAGE();
	print 'ERROR_LINE: ' + CONVERT(varchar, ERROR_LINE());
	print 'ERROR_PROCEDURE: ' + CONVERT(varchar, ERROR_PROCEDURE());
	print 'ERROR_SEVERITY: ' + CONVERT(varchar, ERROR_SEVERITY());
	print 'ERROR_STATE: ' + CONVERT(varchar, ERROR_STATE());
end catch