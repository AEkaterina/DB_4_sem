use [04_UNIVER]

--1 кластеризированый индекс
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'TEACHER'

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

drop index #EX1_CL on #EX1
drop table #EX1

--2 некластеризированый индекс
create table #EX2
	( TKEY int,
	  CC int identity(1,1),
	  TF varchar(100)
	);

	set nocount on;
	declare @i_2 int = 0;
	while (@i_2 < 10000)
	begin
		insert into #EX2(TKEY, TF) values(floor(30000*RAND()), REPLICATE('string', 10));
		if((@i_2 + 1)%1000 = 0)
			print 'Добавлена строк: ' + convert(varchar, @i_2 + 1);
		set @i_2 = @i_2 + 1;
	end;

	select count(*) [Количество строк] from #EX2;
	select * from #EX2;

	create index #EX2_NONCLU on #EX2(TKEY, CC);

	select * from #EX2 where TKEY > 1500 and CC < 4500;
	select * from #EX2 order by TKEY, CC;

	select * from #EX2 where CC = 2804; 

drop index #EX2_NONCLU on #EX2
drop table #EX2


--3 некластеризированный индекс покрытия
create table #EX3
	( TKEY int,
	  СС int identity(1,1),
	  TF varchar(100)
	);

set nocount on;
	declare @i_3 int = 0;
	while (@i_3 < 10000)
	begin
		insert into #EX3(TKEY, TF) values(floor(30000*RAND()), REPLICATE('string', 10));
		if((@i_3 + 1)%1000 = 0)
			print 'Добавлена строк: ' + convert(varchar, @i_3 + 1);
		set @i_3 = @i_3 + 1;
	end;

select count(*) [Количество строк] from #EX3;
select * from #EX3;

create index #EX3_TKEY_X on #EX3(TKEY) include (СС) 
select * from #EX3 where TKEY > 15000;

drop index #EX3_TKEY_X on #EX3
drop table #EX3


--4 некластеризированный фильтруемый индекс
create table #EX4
	( TKEY int,
	  СС int identity(1,1),
	  TF varchar(100)
	);

set nocount on;
	declare @i_4 int = 0;
	while (@i_4 < 10000)
	begin
		insert into #EX4(TKEY, TF) values(floor(30000*RAND()), REPLICATE('string', 10));
		if((@i_4 + 1)%1000 = 0)
			print 'Добавлена строк: ' + convert(varchar, @i_4 + 1);
		set @i_4 = @i_4 + 1;
	end;

select * from #EX4 where TKEY between 6738 and 19936;
select * from #EX4 where TKEY > 15000
select count(*) [количество строк] from #EX4

create index #EX4_FILTER on #EX4(TKEY) where (TKEY >= 15000 and TKEY < 20000);

select * from #EX4 where TKEY > 17000

drop index #EX4_FILTER on #EX4
drop table #EX4


--5  некластеризированный индекс, уровень фрагментации, реорганизация, перестройка
create table #EX5
	( TKEY int,
	  СС int identity(1,1),
	  TF varchar(100)
	);

set nocount on;
	declare @i_5 int = 0;
	while (@i_5 < 10000)
	begin
		insert into #EX5(TKEY, TF) values(floor(30000*RAND()), REPLICATE('string', 10));
		if((@i_5 + 1)%1000 = 0)
			print 'Добавлена строк: ' + convert(varchar, @i_5 + 1);
		set @i_5 = @i_5 + 1;
	end;

select * from #EX5;

use tempdb;

create index #EX5_TKEY on #EX5(TKEY);

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

insert top(10000) #EX5(TKEY, TF) select TKEY, TF from #EX5;

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

insert top(60000) #EX5(TKEY, TF) select TKEY, TF from #EX5;

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

alter index #EX5_TKEY on #EX5 reorganize;

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

alter index #EX5_TKEY on #EX5 rebuild with (online = off);

select name [Индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

--6 некластериированный индекс, fillfactor

create index #EX6_TKEY on #EX5(TKEY) with (fillfactor = 65);

insert top(50) percent into #EX5(TKEY, TF) select TKEY, TF from #EX5;

select name [Индекс], avg_fragmentation_in_percent[Фрагментация (%)]
	from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
	OBJECT_ID(N'#EX6_TKEY'), NULL, NULL, NULL) ss join sys.indexes ii
		on ss.object_id = ii.object_id and ss.index_id = ii.index_id
			where name is not null;

--drop index #EX5_TKEY on #EX5;
--drop index #EX6_TKEY on #EX5;
--drop table #EX5;