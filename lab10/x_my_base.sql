use [02 Курсы повышения квалификации]

----1 кластеризированый индекс
exec sp_helpindex 'Группа'
exec sp_helpindex 'Нагрузка'
exec sp_helpindex 'Оплата'
exec sp_helpindex 'Преподаватель'

create table #EX1
(	tind int,
	tfield varchar(100)
);

set nocount on;
declare @i_1 int = 0;
while (@i_1 < 1000)
	begin
		insert into #EX1 values (floor(2000*rand()), replicate('string', 10));
		if((@i_1 + 1) % 100 = 0) print @i_1
		set @i_1 = @i_1 + 1;
	end;

select * from #EX1 where tind between 1500 and 2000 order by tind;

checkpoint;
DBCC DROPCLEANBUFFERS;

create clustered index #EX1_CL on #EX1(tind asc);
select * from #EX1 where tind between 1500 and 2000 order by tind;

--drop index #EX1_CL on #EX1
--drop table #EX1

----2 некластеризированый индекс
	select count(*) [Количество строк] from Нагрузка;
	select * from Нагрузка;

	create index #EX2_NONCLU on Нагрузка(Номер_группы, Количество_часов);

	select * from Нагрузка where Количество_часов > 90 and Номер_группы < 13;
	select * from Нагрузка;

	select * from Нагрузка where Номер_группы = 12; 

drop index #EX2_NONCLU on #EX


----3 некластеризированный индекс покрытия
select count(*) [Количество строк] from Нагрузка;
select * from Нагрузка;

create index #EX3_TKEY_X on Нагрузка(Номер_группы) include (Количество_часов) 
select * from Нагрузка where Номер_группы > 12;

drop index #EX3_TKEY_X on Нагрузка

--4 некластеризированный фильтруемый индекс
select * from Нагрузка where Количество_часов between 80 and 120;
select * from Нагрузка where Количество_часов > 90;
select count(*) [количество строк] from Нагрузка;

create index #EX4_FILTER on Нагрузка(Количество_часов) where (Количество_часов >= 70 and Количество_часов < 150);

select * from Нагрузка where Количество_часов > 100;

drop index #EX4_FILTER on Нагрузка;

----5  некластеризированный индекс, уровень фрагментации, реорганизация, перестройка
select * from Нагрузка;

create index #EX5_TKEY on Нагрузка(Количество_часов);

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

insert top(10000) Нагрузка(Количество_часов, Номер_группы) select Количество_часов, Номер_группы from Нагрузка;

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

insert top(60000) Нагрузка(Количество_часов, Номер_группы) select Количество_часов, Номер_группы from Нагрузка;

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

alter index #EX5_TKEY on Нагрузка reorganize;

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

alter index #EX5_TKEY on Нагрузка rebuild with (online = off);

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

----6 некластериированный индекс, fillfactor

create index #EX6_TKEY on Нагрузка(Номер_группы) with (fillfactor = 65);

insert top(50) percent into Нагрузка(Количество_часов, Номер_группы) select Количество_часов, Номер_группы from Нагрузка;

select name [Индекс], avg_fragmentation_in_percent[Фрагментация (%)]
	from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
	OBJECT_ID(N'#EX6_TKEY'), NULL, NULL, NULL) ss join sys.indexes ii
		on ss.object_id = ii.object_id and ss.index_id = ii.index_id
			where name is not null;

drop index #EX5_TKEY on #EX5;
drop index #EX6_TKEY on #EX5;
