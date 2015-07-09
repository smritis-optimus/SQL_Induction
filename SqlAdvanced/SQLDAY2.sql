/*No. 48:"Show ""Yes"" for employees whose salary is more than 50000 and age is less than 35 else ""No""
Soln:we add a column age and add the values in it
*/
USE MIS

go

ALTER TABLE Employee
ADD Age int

go

/*adding some more entries in table Employe*/
INSERT INTO Employee(empid,FirstName,LastName,Sex,Active_Status,salary,NewCol)
VALUES('1005','Varun','Singh','M','1','1000','vs'),
('1006','hari','Om','M','1','5000','ss'),('1007','Meher','Singh','F','1','7000','ss')

go

 /*Feeding values in age column*/
 UPDATE Employee SET age=24 WHERE empid=1001
UPDATE Employee SET age=24 WHERE empid=1002
UPDATE Employee SET age=23 WHERE empid=1003
UPDATE Employee SET age=22 WHERE empid=1004
UPDATE Employee SET age=24 WHERE empid=1005
UPDATE Employee SET age=44 WHERE empid=1006
UPDATE Employee SET age=39 WHERE empid=1007

 go

 SELECT FirstName,LastName,CASE
 WHEN Salary>5000 AND Age<35 THEN 'YES'
 ELSE 'NO'
 END
 FROM Employee

 go

 /*No. 49:show top 5 highest paid employees
2) show  top 5 alternate  highest paid employees"
Using rank function and changing the ascending and descending ordering of salary*/
USE MIS

go
SELECT * FROM(
SELECT empid,FirstName,LastName,Salary,
RANK() over(order by Salary desc) AS ranking
From Employee) as new
WHERE ranking<6

go

USE MIS

go
SELECT * FROM(
SELECT empid,FirstName,LastName,Salary,
RANK() over(order by Salary asc) AS ranking
From Employee) as new
WHERE ranking<6

go

/*No. 50:build a query using CTE 
*/
WITH EmployeeCTE(FirstName,Salary) AS
( SELECT FirstName,Salary
  FROM Employee
  WHERE Salary>5000
)
SELECT * FROM EmployeeCTE

go

/*No. 51:use "with rollup" and "with cube " on employee salary column.
Soln:Rollup and cube works as aggregate.So i am grouping the number of employees having same salary*/
USE MIS
go
SELECT COUNT(FirstName),Salary
FROM Employee
GROUP BY Salary WITH ROLLUP

go

USE MIS

go

SELECT COUNT(FirstName),Salary
FROM Employee
GROUP BY Salary WITH CUBE

go

/*No. 52:select all those employees who are only freshers (<6 months exp)
*/
USE MIS

go

CREATE TABLE Joining(
EmpId int PRIMARY KEY,
Ex int
)
INSERT INTO Joining VALUES('1001','4'),('1002','13'),('1003','7'),('1004','1'),('1005','15'),('1006','14'),('1007','2')

go

SELECT *
FROM Joining
EXCEPT
SELECT *
FROM Joining
WHERE Ex>6

go

SELECT *
FROM Joining
INTERSECT
SELECT *
FROM Joining
WHERE Ex<6

go


/*No. 54:use Running Aggregate on employee salary column.
*/
USE MIS

go
SELECT runn.empid, RunningTotal=SUM(runn.Salary) OVER (ORDER BY runn.empid)
FROM   Employee runn
ORDER BY runn.empid

go

/*No.55: use corelated subquery to find out top 3 employees(order by empid asc)*/
USE MIS

go
SELECT * FROM(
SELECT empid,FirstName,LastName,Salary,
RANK() over(order by Salary desc) AS ranking
From Employee) as new
WHERE ranking<4
order by empid asc
go

/*No. 56:Create a cluster index on employee_id column in the employee table.
Soln:It has already been created on empid so we cannot create another.The syntax would be like-*/

CREATE CLUSTERED INDEX Ci 
    ON dbo.Employee (empid)

go

/*No. 57:Create a non cluster index on department_id column in the employee table.
*/
USE MIS

go

CREATE NONCLUSTERED INDEX Nci
    ON Employee (depID)

	go

/*No. 58:E.g. Suppose employee_salary table, having column basic, HR & DA and Gross salary. By default Gross
 salary is empty. Use trigger to update the gross salary column as (Basic+HRA+DA)*12, whenever records are entered
  in the employee_salary table.
*/
USE MIS

go

CREATE TABLE EmployeeSalary(
Ba float,
Hr float,
Da float,
Gs float)

go

CREATE TRIGGER GrossSalary ON EmployeeSalary 
FOR INSERT
AS
UPDATE EmployeeSalary
SET gs=(Ba+Hr+Da)*12

INSERT INTO EmployeeSalary(Ba,Hr,Da) VALUES('18500','200','1000')

go

SELECT * FROM EMployeeSalary

go

