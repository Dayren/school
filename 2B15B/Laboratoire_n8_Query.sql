--	QUESTION 1
CREATE DATABASE Admin_data
ON PRIMARY (NAME=Administration_data,
FILENAME = 'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Administration.mdf',
SIZE= 4Mb,
MAXSIZE = 6Mb,
FILEGROWTH = 1%)
LOG ON (NAME=Administration_log,
FILENAME='C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Administration.ldf',
SIZE=1Mb,
MAXSIZE=5Mb,
FILEGROWTH=1Mb)

--QUESTION 2 : instruction pour vérifier si la db a bien été crée
exec sp_helpdb Admin_data

--QUESTION 3
alter database Admin_data
modify name=AdministrationCommunale

--Question 4
drop database AdministrationCommunale

