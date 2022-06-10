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

-------UC11 - NOrmalization and ER Diagram ----------------

create table Company
(compId INT PRIMARY KEY, compName varchar(20));
SELECT* from Company

create table employee
(empId int PRIMARY KEY,Name varchar(20),compId INT REFERENCES Company(compId) ,Phone varchar(20),Address varchar(200),Gender char);
select* from employee

create Table payroll
(empId INT REFERENCES employee(empId), BasicPay decimal,Deduction decimal, TaxablePay decimal ,IncomeTax decimal,NetPay decimal);
select* from payroll

CREATE TABLE DEPARTMENT(
DeptName VARCHAR(10),
empId INT REFERENCES employee(empId),
deptId int PRIMARY KEY);
select* from DEPARTMENT;

-------------Inserting values into Company table---------------------------------
Insert Into Company Values (1,'BridgeLabs');
Insert Into Company Values (2,'Wipro');
Insert Into Company Values (3,'Infosys');
Insert Into Company Values (4,'Amazon');
SELECT* from Company
-------------Inserting values into employee table---------------------------------
Insert Into employee Values (19,'Shravanthi',1,'1234567891','Alwal,Secunderabad','F');
Insert Into employee Values (20,'Tony',2,'1234567892','Alwal,Secunderabad','M');
Insert Into employee Values (24,'Vishnu',4,'1234567890','Kanuru,Vijayawada','M');
Insert Into employee Values (23,'Hema',3,'1234567898','Kanuru,Vijayawada','F');

select* from employee
-------------Inserting values into DEPARTMENT table---------------------------------
Insert Into DEPARTMENT Values ('Production',22,16);
Insert Into DEPARTMENT Values ('Developer',19,04);
Insert Into DEPARTMENT Values ('HR',23,08);
Insert Into DEPARTMENT Values ('Sales',24,19);
Insert Into DEPARTMENT Values ('Marketing',20,13);


select* from DEPARTMENT;
-------------Inserting values into payroll table---------------------------------
Insert Into payroll Values (22,20000,1000,180,200,19000);
Insert Into payroll Values (19,30000,1500,240,300,28500);
Insert Into payroll Values (20,35000,1500,240,300,33500);
Insert Into payroll Values (23,40000,1500,240,300,38500);
Insert Into payroll Values (24,45000,1500,240,300,43500);


select* from payroll

-----------UC13-Ensuring All retrieve queries from UC6 to UC10 with new table---------
------------Retreive_UC_4-Ability to Retrive Values From Employee_payroll Table in dataBase------------------
select company.compId,company.compName,
  Employee.empId,Employee.Name,Employee.Phone,Employee.Address,Employee.Gender,
  Payroll.BasicPay,Payroll.Deduction,Payroll.TaxablePay,Payroll.IncomeTax,Payroll.NetPay,
  department.DeptName,department.deptId 
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId;
------------Retreive_UC_5-Ability to Retrive Salry of a Particular Employee From Employee_payroll Table in dataBase------------------
select company.compId,company.compName,
  Employee.empId,Employee.Name,Employee.Phone,Employee.Address,Employee.Gender,
  Payroll.BasicPay,Payroll.Deduction,Payroll.TaxablePay,Payroll.IncomeTax,Payroll.NetPay,
  department.DeptName,department.deptId
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
where (payroll.BasicPay=30000);

------------UC_7-Ability to Find SUM,Avg,Min,Max,Count From Employee_payroll Table in dataBase------------------


select sum(Payroll.BasicPay)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId;

select Avg(Payroll.BasicPay)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId;

select Min(Payroll.BasicPay)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId;

select Max(Payroll.BasicPay)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId

select Count(*)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
