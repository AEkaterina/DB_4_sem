use [02 ����� ��������� ������������]

select * from ������
select * from ��������
select * from ������
select * from �������������

-- 1 ������ ��������� �� ������� ���� � ���� ������ ����� �������
declare @prof char(20), @out char(300) = '';
declare EX1 cursor 
		for select ������������� from ������ 
	where ���������='�������'; 
	open EX1
	fetch EX1 into @prof;
	print '������ �������� ���������: ';
	while @@FETCH_STATUS = 0
		begin
			set @out = rtrim(@prof) + ', ' + @out;
			fetch EX1 into @prof;
		end;
	print @out;
close EX1;
deallocate EX1;

-- 2 ������� ����������� ������� �� ����������
declare EX2_local cursor local
	for select �������������, ����������_��������� from ������
declare @pr char(30), @count int;
	open EX2_local;
	fetch EX2_local into @pr, @count;
	print '1. ' + rtrim(@pr) + ' ' + convert(varchar,@count);
	go
-- ������: ������ EX2_local �� ����������
--declare @pr char(10), @count int;
--	fetch EX2_local into @pr, @count;
--	print '2. ' + rtrim(@pr) + ' ' + convert(varchar,@count);
--	go

declare EX2_global cursor global
	for select �������������, ����������_��������� from ������
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

-- 3 ������� ������������ ������� �� �������������
declare EX3_group cursor local dynamic
	for select ���������, ����������_���������, ������������� from ������
	where ��������� = '�������';
declare @ot char(15), @kol int, @ppf char(50);
	open EX3_group;
	print '���������� �����: ' + convert(varchar, @@CURSOR_ROWS);
	insert into ������ values (43, '����', '�������', 16);
	update ������ set ����������_��������� = 29 where ������������� = '����';
	fetch EX3_group into @ot, @kol, @ppf;
	while @@FETCH_STATUS = 0
		begin
			print rtrim(@ot) + ' ' + convert(varchar, @kol) + ' ' + rtrim(@ppf);
			fetch EX3_group into @ot, @kol, @ppf;
		end;
	close EX3_group;
delete ������ where ����������_��������� = '����';
go

-- 4 scroll ������
declare EX4_SCROLL cursor local dynamic scroll
	for select ROW_NUMBER() over (order by ������������� asc) N, �������������
	from ������
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
insert into ������ values (238974, '������', 1500); 

declare EX5_CURRENT cursor local scroll dynamic
	for select ���_�������, �����_������ from ������
	for update; 
declare @fac varchar(5), @full varchar(50); 
	open EX5_CURRENT 
		fetch first from EX5_CURRENT into @fac, @full; 
		print @fac + ' ' + @full;
		update ������ set �����_������ = 4 where current of EX5_CURRENT; 
		fetch first from EX5_CURRENT into @fac, @full; 
		print @fac + ' ' + @full;
		delete ������ where current of EX5_CURRENT;
	close EX5_CURRENT;
go

-- 6 ��������� c��������� � �������� < 1�
--insert into ���������� values 
--	('����', 'TEST', 0.28),
--	('����', 'TEST', 0.92),
--	('����', 'TEST', 0.73),
--	('����', 'TEST', 0.61)

--select ���_����������, ������_������� 
--from ���������� 
--	inner join ������ on ����������.����� = ������.��������_������
--where ������_������� < 1

--declare EX6_1 cursor local 
--	for	select ���_����������, ������_������� 
--	from ���������� 
--		inner join ������ on ����������.����� = ������.��������_������
--	where ������_������� < 1
--declare @student nvarchar(20), @mark int;  
--	open EX6_1;  
--		fetch  EX6_1 into @student, @mark;
--		while @@FETCH_STATUS = 0
--			begin 		
--				delete ���������� where current of EX6_1;	
--				fetch  EX6_1 into @student, @mark;  
--			end
--	close EX6_1;

--select ���_����������, ������_������� 
--from ���������� 
--	inner join ������ on ����������.����� = ������.��������_������
--where ������_������� < 1
--go
		
---- ex 6.2: +1 � ������ ����������� �������� (IDSTUDENT) - id 1025
--declare EX6_2 cursor local 
--	for	select ���_����������, ������_������� 
--	from ����������
--	where ���_���������� = '����'
--declare @student nvarchar(20), @mark real;  
--	open EX6_2;  
--		fetch  EX6_2 into @student, @mark;
--		update ���������� set ������_������� += 100 where CURRENT OF EX6_2;
--	close EX6_2;

--update ���������� set ������_������� -= 100 where ���_���������� = '����';
--go