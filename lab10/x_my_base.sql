use [02 ����� ��������� ������������]

----1 ����������������� ������
exec sp_helpindex '������'
exec sp_helpindex '��������'
exec sp_helpindex '������'
exec sp_helpindex '�������������'

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

----2 ������������������� ������
	select count(*) [���������� �����] from ��������;
	select * from ��������;

	create index #EX2_NONCLU on ��������(�����_������, ����������_�����);

	select * from �������� where ����������_����� > 90 and �����_������ < 13;
	select * from ��������;

	select * from �������� where �����_������ = 12; 

drop index #EX2_NONCLU on #EX


----3 �������������������� ������ ��������
select count(*) [���������� �����] from ��������;
select * from ��������;

create index #EX3_TKEY_X on ��������(�����_������) include (����������_�����) 
select * from �������� where �����_������ > 12;

drop index #EX3_TKEY_X on ��������

--4 �������������������� ����������� ������
select * from �������� where ����������_����� between 80 and 120;
select * from �������� where ����������_����� > 90;
select count(*) [���������� �����] from ��������;

create index #EX4_FILTER on ��������(����������_�����) where (����������_����� >= 70 and ����������_����� < 150);

select * from �������� where ����������_����� > 100;

drop index #EX4_FILTER on ��������;

----5  �������������������� ������, ������� ������������, �������������, �����������
select * from ��������;

create index #EX5_TKEY on ��������(����������_�����);

select name [������], avg_fragmentation_in_percent [������������(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

insert top(10000) ��������(����������_�����, �����_������) select ����������_�����, �����_������ from ��������;

select name [������], avg_fragmentation_in_percent [������������(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

insert top(60000) ��������(����������_�����, �����_������) select ����������_�����, �����_������ from ��������;

select name [������], avg_fragmentation_in_percent [������������(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

alter index #EX5_TKEY on �������� reorganize;

select name [������], avg_fragmentation_in_percent [������������(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

alter index #EX5_TKEY on �������� rebuild with (online = off);

select name [������], avg_fragmentation_in_percent [������������(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5_TKEY'), NULL, NULL, NULL) ss
join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id
	where name is not null;

----6 ������������������� ������, fillfactor

create index #EX6_TKEY on ��������(�����_������) with (fillfactor = 65);

insert top(50) percent into ��������(����������_�����, �����_������) select ����������_�����, �����_������ from ��������;

select name [������], avg_fragmentation_in_percent[������������ (%)]
	from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
	OBJECT_ID(N'#EX6_TKEY'), NULL, NULL, NULL) ss join sys.indexes ii
		on ss.object_id = ii.object_id and ss.index_id = ii.index_id
			where name is not null;

drop index #EX5_TKEY on #EX5;
drop index #EX6_TKEY on #EX5;
