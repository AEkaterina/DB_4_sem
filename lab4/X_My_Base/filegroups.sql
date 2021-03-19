drop database [02 Курсы повышения квалификации]

use master
create database [02 Курсы повышения квалификации]

on primary
( name = N'COURSE_mdf', filename=N'D:\studing\2k 2 sem\DB\DB_4_sem\lab4\X_My_Base\COURSE_mdf.mdf',
  size = 5120Kb, maxsize = 10240Kb, filegrowth = 1024Kb),
( name = N'COURSE_ndf', filename=N'D:\studing\2k 2 sem\DB\DB_4_sem\lab4\X_My_Base\COURSE_ndf.ndf',
  size = 5120Kb, maxsize = 10240Kb, filegrowth = 10%),
  
filegroup G1
( name = N'COURSE_fg1_1', filename=N'D:\studing\2k 2 sem\DB\DB_4_sem\lab4\X_My_Base\COURSE_g1_1.ndf',
  size = 10240Kb, maxsize = 15360Kb, filegrowth = 1024Kb),
( name = N'COURSE_fg1_2', filename=N'D:\studing\2k 2 sem\DB\DB_4_sem\lab4\X_My_Base\COURSE_g1_2.ndf',
  size = 2048Kb, maxsize = 5120Kb, filegrowth = 1024Kb)

log on
( name = N'COURSE_log', filename=N'D:\studing\2k 2 sem\DB\DB_4_sem\lab4\X_My_Base\COURSE_log.ldf',
  size = 5120Kb, maxsize = UNLIMITED, filegrowth = 1024Kb)
