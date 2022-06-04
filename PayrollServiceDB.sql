create database Payroll_Service
use Payroll_Service
create table employee_payroll(ID int identity(1,1) primary key,Name varchar(100),Salary int,Start_Date date)
INSERT into employee_payroll values ('Shravanthi',10000,'2022-01-03'),('Vishnu',20000,'2022-01-02'),('Bhagya',30000,'2022-01-01')
SELECT * from employee_payroll
SELECT Salary FROM employee_payroll
WHERE Name = 'Shravanthi'
SELECT * from employee_payroll WHERE Start_Date BETWEEN CAST('2022-01-02' AS DATE) AND GETDATE()