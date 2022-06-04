create database Payroll_Service
use Payroll_Service
create table employee_payroll(ID int identity(1,1) primary key,Name varchar(100),Salary int,Start_Date date)
INSERT into employee_payroll values ('Shravanthi',10000,'2022-01-03'),('Vishnu',20000,'2022-01-02'),('Bhagya',30000,'2022-01-01')
select * from employee_payroll