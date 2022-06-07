create database Payroll_Service
use Payroll_Service

create table employee_payroll(ID int identity(1,1) primary key,Name varchar(100),Salary int,Start_Date date)

INSERT into employee_payroll values ('Shravanthi',10000,'2022-01-03'),('Vishnu',20000,'2022-01-02'),('Bhagya',30000,'2022-01-01')

SELECT * from employee_payroll
SELECT Salary FROM employee_payroll
WHERE Name = 'Shravanthi'

SELECT * from employee_payroll WHERE Start_Date BETWEEN CAST('2022-01-02' AS DATE) AND GETDATE()

Alter table employee_payroll add Gender varchar(10)
UPDATE employee_payroll set Gender ='F' where name = 'Shravanthi' or name ='Bhagya';
UPDATE employee_payroll set Gender ='M' where Name='Vishnu';

SELECT SUM(salary) FROM employee_payroll WHERE gender = 'F' GROUP BY gender;

SELECT AVG(salary) from employee_payroll
SELECT AVG(salary) from employee_payroll WHERE gender = 'F' GROUP BY gender;

SELECT Min(salary) from employee_payroll
SELECT Min(salary) from employee_payroll WHERE gender = 'F' GROUP BY gender;

SELECT Max(salary) from employee_payroll
SELECT Max(salary) from employee_payroll WHERE gender = 'F' GROUP BY gender;

SELECT Count(Name) from employee_payroll
SELECT Count(Name) from employee_payroll where gender ='F' GROUP BY gender;
SELECT Count(Name) from employee_payroll where gender ='M' GROUP BY gender;

----UC8 --- Extend by adding PhoneNumber, Address, Department -----------

alter table employee_payroll add phonenumber varchar(50),address varchar(200) not null default 'ABC Colony',department varchar(50);

update employee_payroll set phonenumber='9000000001', department='Sales' where name='Vishnu';
update employee_payroll set phonenumber='9000000002', department='Marketing' where name='Bhagya';
update employee_payroll set phonenumber='9000000003', department='Sales' where name='Shravanthi';

-----UC9--Extend employee_payroll to have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay---

alter table employee_payroll add BasicPay decimal, Deductions decimal, TaxablePay decimal, IncomeTax decimal, NetPay decimal;

update employee_payroll set BasicPay=Salary;
alter table employee_payroll drop column Salary;

update employee_payroll set Deductions=1000 where department = 'sales';
update employee_payroll set Deductions=2000 where department = 'Marketing';

update employee_payroll set IncomeTax=250;
update employee_payroll set TaxablePay=500;

update employee_payroll set NetPay = (BasicPay-Deductions);

select * from employee_payroll;

------UC10 -- Add Terisa in sales and marketing departments-------

Insert into employee_payroll Values ('Terisa','2022-01-05','F','9000000005','ABC Colony','Sales',15000,1000,500,250,14000);
Insert into employee_payroll Values ('Terisa','2022-01-05','F','9000000005','ABC Colony','Marketing',15000,1000,500,250,14000);
