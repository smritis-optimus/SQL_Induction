CREATE DATABASE Test

go

USE Test

go

CREATE TABLE Employee(
Id int,
Name varchar(30),
Gender varchar(20),
Basic decimal(10,2),
HR decimal(10,2),
DA decimal(10,2),
TAX decimal(10,2),
DepID int
)

go

INSERT INTO Employee VALUES
('1','Anil','Male','10000','5000','1000','400','1'),
('2','Sanjana','Female','12000','6000','1000','500','2'),
('3','Johnny','Male','5000','2500','500','200','3'),
('4','Suresh','Male','6000','3000','500','250','1'),
('5','Anglia','Female','11000','5500','1000','500','4'),
('6','Saurabh','Male','12000','6000','1000','600','1'),
('7','Manish','Male','4000','2000','500','150','2'),
('8','Neeraj','Male','5000','2500','500','200','3'),
('9','Suman','Female','5000','2500','500','200','4'),
('10','Tina','Female','6000','3000','500','220','1')

go

CREATE TABLE Department(
DEpID int,
DeptName varchar(20),
DeptHeadID int)

go

INSERT INTO Department VALUES
('1','HR','1'),
('2','Admin','2'),
('3','Sales','9'),
('4','Engineering','5')

go

CREATE TABLE EmployeeAttendance(
EmpID int,
Date date,
WorkingDays int,
PresentDays int
)

go

INSERT INTO EmployeeAttendance VALUES
('1','2010-01-01','22','21'),
('1','2010-02-01','20','20'),
('1','2010-03-01','22','20'),
('2','2010-01-01','22','22'),
('2','2010-02-01','20','20'),
('2','2010-03-01','22','22'),
('3','2010-01-01','22','21'),
('3','2010-02-01','20','20'),
('3','2010-03-01','22','21'),
('4','2010-01-01','22','21'),
('4','2010-02-01','20','19'),
('4','2010-03-01','22','22'),
('5','2010-01-01','22','22'),
('5','2010-02-01','20','20'),
('5','2010-03-01','22','22'),
('6','2010-01-01','22','21'),
('6','2010-02-01','20','20'),
('6','2010-03-01','22','20'),
('7','2010-01-01','22','21'),
('7','2010-02-01','20','20'),
('7','2010-03-01','22','21'),
('8','2010-01-01','22','21'),
('8','2010-02-01','20','20'),
('8','2010-03-01','22','21'),
('9','2010-01-01','22','22'),
('9','2010-02-01','20','20'),
('9','2010-03-01','22','21'),
('10','2010-01-01','22','22'),
('10','2010-02-01','20','20'),
('10','2010-03-01','22','22')

go

--query1:Display gender wise employee in each department

SELECT D.DeptName,E.Gender,COUNT(E.Name) AS NO_of_Employess
FROM Department D JOIN Employee E
ON D.DepID=e.DepID
GROUP BY E.Gender, D.DeptName

go

--query2:Display results as total salary
SELECT D.DeptName,COUNT(E.Name) AS NO_of_Employess,MAX(E.Basic+E.DA+E.HR) AS Highest_Gross_Salary,SUM(E.Basic+E.HR+E.DA-E.TAX) AS TOTAL_SALARY
FROM Department D JOIN Employee E
ON D.DepID=E.DepID
GROUP BY D.DeptName

go

--query3:Departmnt name with highest gross salary in each department
SELECT D.DeptName,COUNT(E.Name) AS NO_of_Employess,MAX(E.Basic+E.HR+E.DA) As Highest_Gross_Salary
FROM Department D JOIN Employee E
ON D.DepID=E.DepID
GROUP BY D.DeptName

go

--query4:Name and id of employees having gross salary more than 15000

SELECT Id,Name
FROM Employee
Where (Basic+HR+DA-TAX)>15000

go


--query5:employee id and name with second highest basic salary
--if some have same basic
SELECT * FROM(
SELECT Id,Basic,
DENSE_RANK()over(order by Basic desc) AS Rankb
FROM Employee
) Emp
WHERE Rankb=2

--if basic is different for all
SELECT TOP 1 Basic,Id FROM(
SELECT TOP 2 Basic,ID FROM Employee
ORDER BY Basic desc) AS Emp
ORDER BY Basic

go


--query6:Department name having Employee more than 3

SELECT * FROM(
SELECT D.DeptName,COUNT(E.Name) AS NO_of_Employees
FROM Department D JOIN Employee E
ON D.DepID=E.DepID
GROUP BY D.DeptName) AS EMP
WHERE NO_of_Employees>3

go

--quey7:Department name nad their respective head name

SELECT D.DeptName,E.Name AS Dept_Head_Name
FROM Department D JOIN Employee E
ON D.DeptHeadID=E.ID
GROUP BY D.DeptName,E.Name


go

--query8:employee with 100% attendance

SELECT EMP.Name FROM(
SELECT E.Name,SUM(A.WorkingDays)-SUM(A.PresentDays) AS Attendance
FROM Employee E JOIN EmployeeAttendance A
ON E.Id=A.EmpID
GROUP BY A.EmpID,E.Name) AS EMP
WHERE EMP.Attendance=0
go

--query9:Employee list having lowest attendance

SELECT EMP.Name FROM(
SELECT E.Name,
RANK()over(order by SUM(A.WorkingDays)-SUM(A.PresentDays) desc) AS Attendance
FROM Employee E JOIN EmployeeAttendance A
ON E.Id=A.EmpID
GROUP BY A.EmpID,E.Name) AS EMP
WHERE Attendance=1

go

--query10:Employee namesa with more than 3 leaves

SELECT EMP.Name FROM(
SELECT E.Name,SUM(A.WorkingDays)-SUM(A.PresentDays) AS Attendance
FROM Employee E JOIN EmployeeAttendance A
ON E.Id=A.EmpID
GROUP BY A.EmpID,E.Name) AS EMP
WHERE EMP.Attendance>3

go