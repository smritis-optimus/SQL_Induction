/* ques5:Query to create a database 
soln:I created a database named MIS*/

CREATE DATABASE MIS

go


/* ques6:Write queries to create "Employee" table with Employee Id is numeric, first, Last names are string
 of maximum up to 50 characters, Sex is one character, Active status is Boolean.
 soln:A table is created with the given details*/
 USE MIS
 go

CREATE TABLE Employee
(
Empid int NOT NULL,
FirstName varchar(50),
LastName varchar(50),
Sex char,
ActiveStatus Bit,
Salary Float
)

go

/*ques7:"Suppose a MIS system having an ""Employee"" table. Write query to create table and uses following 
constraints 
•NOT NULL
•UNIQUE
•PRIMARY KEY
•FOREIGN KEY
•CHECK
•DEFAULT
for different attributes of the Employee table. "
soln:the given table is altered using  ALTER TABLE command*/
USE MIS

go

ALTER TABLE Employee
ADD UNIQUE (Empid)

go

ALTER TABLE EMPLOYEE
ADD PRIMARY KEY (Empid)

go


/* to create va foriegn key we make a new column desID which will be connected to designation table
so we create a DESIGNATION table also*/
USE MIS

go

ALTER TABLE Employee
ADD DesID int

go

USE MIS

go

CREATE TABLE Designation
(
Desid int NOT NULL,
DesName varchar(50),
PRIMARY KEY (desid)
)

go

ALTER TABLE Employee
ADD FOREIGN KEY (DesID)
REFERENCES Designation(Desid)

go

ALTER TABLE Employee
ADD CHECK (Empid>0)

go

ALTER TABLE Employee
ADD NewCol VARCHAR(50)
CONSTRAINT MIS_EMPLOYEE_NewCol DEFAULT '' NOT NULL

go

/*ques14:Create a table of Designation and drop it
soln:Creating a table and droping it*/
USE MIS

go

CREATE TABLE DNation(
DId INT NOT NULL PRIMARY KEY,
DName VARCHAR(50) NOT NULL,
EName VARCHAR(50) NOT NULL
)

go

DROP TABLE DNation

go

/*ques15:Create a unique index on the first name and
 last name  and a full text index on first name of the employee table
soln:we use the syntax UNIQUE INDEX */
CREATE UNIQUE INDEX EIndex
ON Employee (FirstName,LastName)

go

CREATE FULLTEXT INDEX ON Employee(FirstName)

/*ques16:Alter the table employees. Modify designation column to take integer value and create a new table 
for designation which is related to employee by designation id
soln:This is already done while making foriegn key in ques3*/

/*ques17:Find Employee salary in a particular range using  In operator
soln: we use In operator to check salary of employees where salary can be 5000or6000or7000or8000or9000or10000
WE FIRST ADD SOME RECORDS TO THE TABLE*/
INSERT INTO Designation(Desid,DesName)VALUES('101','Developer')

go

SELECT * FROM Designation

go

INSERT INTO Employee(Empid,FirstName,LastName,Sex,ActiveStatus,Salary,NewCol)
VALUES('1001','Ram','Kumar','M','1','7000','rk'),('1002','Abhay','Kumar','M','1','12000','ak'),
('1003','Kishore','','M','1','9000','ks'),('1004','Smriti','Singh','F','1','7000','ss')

go

SELECT * FROM Employee
WHERE Salary IN(5000,6000,7000,8000,9000,10000)

go

/*ques18:Find Employee salary in a particular range using  Between operator
soln:the salary column is checked for salary in range 5000-10000*/
USE MIS

go

SELECT * FROM Employee
WHERE Salary BETWEEN 5000 AND 10000;

go

/*ques19:Display column using alias name from  Employee table
soln: alias naming is done using AS operator*/
USE MIS

go

SELECT Salary AS Pay
FROM Employee

go

/*ques20:Display employee details using Join with employee slabs table.
soln:we will first make a new table employee slab and then apply join*/
USE MIS

go

CREATE TABLE ESlab(
Empid int NOT NULL PRIMARY KEY,
DepName varchar(30),
Position varchar(30)
)

go

INSERT INTO ESlab VALUES('1001','Administration','Assistant'),('1004','Engineer','Developer'),
('1007','Administration','Manager'),('1009','Management','Assistant')

go

SELECT Employee.Empid,ESlAB.DepName,Employee.Salary
FROM Employee JOIN ESlab
ON Employee.=Empid=ESlab.Empid

go

/*ques21:Same as above using Inner join
*/
SELECT Employee.Empid,ESlAB.DepName,Employee.Salary
FROM Employee INNER JOIN ESlab
ON Employee.Empid=ESlab.Empid

go


/*ques22:Create a sample employee management system, having table Employee & Department. Employees are
 associated with some department, there are some employees exist which doesn't associated with any department
  yet. Display all the employees and their department information whether they are associated with some 
  department or not.
SOLN:add a column for department id in employee table.create a table department and then employee table is left
 joined with department table*/
 ALTER TABLE Employee
 ADD DepID int
 USE MIS

 go

 /*Feeding values in depID column*/
 UPDATE Employee SET DepID=701 WHERE Empid=1001
UPDATE Employee SET DepID=705 WHERE Empid=1002
UPDATE Employee SET DepID=705 WHERE Empid=1003
UPDATE Employee SET DepID=702 WHERE Empid=1004

 go

CREATE TABLE Department(
DepID int  NOT NULL PRIMARY KEY,
DepName varchar(30),
NumEmp INT CHECK(NumEmp>=0)
)
INSERT INTO Department VALUES('701','Administration','3'),('702','Engineer','10'),
('703','Testing','0'),('704','Management','5')

go

SELECT Employee.Empid,Employee.FirstName,Employee.LastName,DepartmentT.DepName
FROM Employee LEFT JOIN Department
ON Employee.depID=Department.depID

go

/*ques23:Same case as above but there are some department also exist which doesn't have any employees
 associated with it. Display all the departments and number of employees associated with it.
soln:using RIGHT JOIN*/
USE MIS

go

SELECT Department.DepName,Department.NumEmp
FROM Employee RIGHT JOIN DepartmentT
ON Employee.DepID=Department.DepID

go

/*ques24:Same case as above. Display all the employees and departments whether they are associated with 
each other or not.
soln:we will use full outer join*/
USE MIS

go

SELECT Employee.Empid,Employee.FirstName,Employee.LastName,Department.DepName
FROM Employee FULL OUTER JOIN Department
ON Employee.DepID=Department.DepID

go

/*ques25:Suppose a ERP system having multiple table for employees of different companies. Create tables for 
3 companies such as "ABC", "LMN" & "XYZ" and display all the employees of all the companies.
soln:creating a database erp syaytem with three tables abc,lmn and xyz*/
CREATE DATABASE ERP
USE ERP

go

CREATE TABLE ABC(
Empid int PRIMARY KEY,
EmpName varchar(30),
Sex char,
Dep varchar(30)
)
CREATE TABLE LMN(
Empid int NOT NULL PRIMARY KEY,
EmpName varchar(30),
Sex char,
Dep varchar(30)
)
CREATE TABLE XYZ(
Empid int NOT NULL PRIMARY KEY,
EmpName varchar(30),
Sex char,
Dep varchar(30)
)
/*feeding the values*/
USE ERP

go

INSERT INTO ABC VALUES('1','Pawan','M','Adminstartion'),('2','Uday','M','Management')
INSERT INTO LMN VALUES('3','Kishan','M','Engineer'),('4','Smriti','F','Engineer')
INSERT INTO XYZ VALUES('5','Praveen','M',''),('6','Suraj','M','')

go

USE ERP

go

SELECT EmpName FROM ABC
UNION
SELECT EmpName FROM LMN
UNION
SELECT EmpName FROM XYZ

go


/*ques26:Create a backup system where records are being saved in another table in different database. Write 
queries to insert data of "Employee" table "Employee_Backup" table in another database.
*/
USE MIS

go

SELECT * into  ERP.dbo.Employee_Backup
FROM Employee

go

USE ERP

go

SELECT * FROM Employee_Backup

go

/*ques27:increment the salary of all employee by 5000  
*/
USE MIS
go
UPDATE Employee
SET Salary=Salary+ 5000
go

/*ques28:create a view with details of managers whose salary is more than 60000. Add a column date of joining
 in the employee table and display in view the joining date in the format specified in #1 of previous exercise
*/
USE MIS

go

ALTER TABLE Employee
ADD Doj date 

go

CREATE VIEW 
SELECT Employee.Empid,Employee.FirstName
FROM Employee JOIN Designation
WHERE DESIGNATION.DesName='MANAGER'
ON Employee.DesID=Designation.desid
AND Salary>60000

/*ques29:"1.Get current date in the format specified in example -Mon  20th sep 10, 1:30 pm
2. Get unix timestamp of date 1st Jan 2010 also display this date in the same format.
3. Add 2 days in current date and display in format specified in 1st point"
*/
SELECT CONVERT(VARCHAR(24),GETDATE(),113) AS DATE6

go

SELECT DATEADD(DAY,2,'2010-01-01')

go

/*ques30:Count sum of a column in which one of the values is Null
*/


/*ques31:get the details of the employee whose last name is null

*/
USE MIS

go

SELECT * FROM Employee
WHERE LastName IS NULL

go

/*ques32:Calculate 12.75 % of salary as pf for all employees and display it in decimals with 2 digits after 
decimal point
*/
USE MIS

go

SELECT Salary,
ROUND(Salary*.1275,2) AS PF
FROM Employee

go

/*ques34: List the employee list whose salary is greater than average employee salary.
*/
USE MIS

go

SELECT * FROM Employee
WHERE Salary>(SELECT AVG(Salary) FROM Employee)

go

/*ques35: List all the departments and respective employee count in it. Use Employee and department table*/
SELECT Department.DepName,COUNT(Employee.FirstName) AS EmpCount FROM Employee
LEFT JOIN Department
ON DepartmentT.DepID=Employee.DepID
WHERE Department.DepName IS NOT NULL
GROUP BY Department.DepName

go

/*ques36:List the employee list whose salary is lesser than highest employee salary.*/
USE MIS

go

SELECT * FROM Employee
WHERE Salary<(SELECT MAX(Salary) FROM Employee)

go

/*ques37:List the employee list whose salary is lesser than lowest employee salary.*/
USE MIS

go

SELECT * FROM Employee
WHERE Salary>(SELECT MIN(Salary) FROM Employee)

go

/*ques38:Display sum of all the employees salary.*/
USE MIS

go

SELECT SUM(Salary) FROM Employee

go
/*ques39:List all the departments and respective employee count in it. Use Employee and department table.*/
--Repeated question.Same as 35

/*ques40:List all the customers have a total order of less than 2000. Use Order table having OrderId, orderDate,
 order, customername.*/
 USE MIS

 go

CREATE TABLE OrderEmp(
 OrderId INT,
 orderDate DATE,
 orders INT,
 custName VARCHAR(30)
 )


 go

SELECT custName, COUNT(OrderID) AS NumberOfOrders
 FROM OrderEmp
 GROUP BY custName
HAVING COUNT(OrderID) < 2000


 go

/*ques41:select the content of the "LastName" and "FirstName" columns from employee table, and convert the "LastName" column to uppercase*/
USE MIS
SELECT UPPER(LastName) AS Lname, FirstName
FROM Employee;

go

/*ques42:select the content of the "LastName" and "FirstName" columns from employee table, and convert the "LastName" column to lowercase*/
USE MIS
SELECT LOWER(LastName) AS Lname, FirstName
FROM Employee;

go

/*ques43:select the length of the values in the "Names" column in employee table.*/
USE MIS

go

SELECT LEN(FirstName) AS NameLen
FROM Employee

go

/*ques44:Display the employee name and the salary rounded to the nearest integer from the employee_salary table.*/
USE MIS

go

SELECT FirstName,LastName,ROUND(Salary,0)AS ApproxS
FROM Employee

go

/*ques45:Display list of all the employee with the current date information.*/
SELECT *,CAST(GETDATE() AS DATE) FROM Employee

go

/*ques46:*/

SELECT CONVERT(VARCHAR(19),GETDATE()) AS DATE1
SELECT CONVERT(VARCHAR(10),GETDATE(),10) AS DATE2
SELECT CONVERT(VARCHAR(10),GETDATE(),110) AS DATE3
SELECT CONVERT(VARCHAR(11),GETDATE(),6) AS DATE4
SELECT CONVERT(VARCHAR(11),GETDATE(),106) AS DATE5
SELECT CONVERT(VARCHAR(24),GETDATE(),113) AS DATE6

go

/*ques47:use cast() to change datatype of empid column to Varchar(10)*/
USE MIS

go

SELECT CAST(Empid AS VARCHAR(10))
FROM Employee

go
