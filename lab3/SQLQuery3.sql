use UNIVER

alter table STUDENT add Дата_поступления date check (Дата_поступления <= getdate());
alter table STUDENT add Пол nchar(1) default 'м' check(Пол in('м', 'ж'));




