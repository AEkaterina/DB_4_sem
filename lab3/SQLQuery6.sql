use UNIVER

select *from STUDENT;
select Номер_зачетки, Фамилия_студента from STUDENT;
select count(*)from STUDENT;
select * from STUDENT where Пол = 'м';
select distinct Номер_группы from STUDENT;
select top 4 * from STUDENT;