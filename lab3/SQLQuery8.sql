use UNIVER

select * from STUDENT where Дата_поступления between '01-09-2019' and '15-10-2019';
select * from STUDENT where Фамилия_студента like '%ова';
select * from STUDENT where Номер_зачетки in (325875, 873596, 479325);