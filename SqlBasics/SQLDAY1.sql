/* ques1:Query to create a database 
soln:I created a database named MIS*/

CREATE DATABASE MIS

go


/* ques2:Write queries to create "Employee" table with Employee Id is numeric, first, Last names are string
 of maximum up to 50 characters, Sex is one character, Active status is Boolean.
 soln:A table is created with the given details*/
 USE MIS
 go

CREATE TABLE EMPLOYEE
(
empid int NOT NULL,
FirstName varchar(50),
LastName varchar(50),
Sex char,
Active_Status Bit,
Salary Float
)

go

/*ques3:"Suppose a MIS system having an ""Employee"" table. Write query to create table and uses following 
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
ALTER TABLE EMPLOYEE
ADD UNIQUE (empid)
go

ALTER TABLE EMPLOYEE
ADD PRIMARY KEY (empid)
go


/* to create va foriegn key we make a new column desID which will be connected to designation table
so we create a DESIGNATION table also*/
USE MIS
go
ALTER TABLE EMPLOYEE
ADD DesID int
go

USE MIS
go
CREATE TABLE DESIGNATION
(
desid int NOT NULL,
DesName varchar(50),
PRIMARY KEY (desid)
)
go
ALTER TABLE EMPLOYEE
ADD FOREIGN KEY (DesID)
REFERENCES DESIGNATION(desid)
go

ALTER TABLE EMPLOYEE
ADD CHECK (empid>0)
go

ALTER TABLE EMPLOYEE
ADD NewCol VARCHAR(50)
CONSTRAINT MIS_EMPLOYEE_NewCol DEFAULT '' NOT NULL
go

/*ques4:Create a table of Designation and drop it
soln:Creating a table and droping it*/
USE MIS
go
CREATE TABLE dNATION(
dID INT NOT NULL PRIMARY KEY,
dNAME VARCHAR(50) NOT NULL,
eNAME VARCHAR(50) NOT NULL
)

go
DROP TABLE dNATION
go

/*ques5:Create a unique index on the first name and
 last name  and a full text index on first name of the employee table
soln:we use the syntax UNIQUE INDEX */
CREATE UNIQUE INDEX EIndex
ON EMPLOYEE (FirstName,LastName)
go
CREATE FULLTEXT INDEX ON EMPLOYEE(FirstName)

/*ques6:Alter the table employees. Modify designation column to take integer value and create a new table 
for designation which is related to employee by designation id
soln:This is already done while making foriegn key in ques3*/

/*ques7:Find Employee salary in a particular range using  In operator
soln: we use In operator to check salary of employees where salary can be 5000or6000or7000or8000or9000or10000
WE FIRST ADD SOME RECORDS TO THE TABLE*/
INSERT INTO DESIGNATION(desid,DesName)VALUES('101','Developer')
go
SELECT * FROM DESIGNATION
go
INSERT INTO EMPLOYEE(empid,FirstName,LastName,Sex,Active_Status,salary,NewCol)
VALUES('1001','Ram','Kumar','M','1','7000','rk'),('1002','Abhay','Kumar','M','1','12000','ak'),
('1003','Kishore','','M','1','9000','ks'),('1004','Smriti','Singh','F','1','7000','ss')
go
SELECT * FROM EMPLOYEE
WHERE Salary IN(5000,6000,7000,8000,9000,10000)
go

/*ques8:Find Employee salary in a particular range using  Between operator
soln:the salary column is checked for salary in range 5000-10000*/
USE MIS
go
SELECT * FROM EMPLOYEE
WHERE Salary BETWEEN 5000 AND 10000;
go

/*ques9:Display column using alias name from  Employee table
soln: alias naming is done using AS operator*/
USE MIS
go
SELECT Salary AS Pay
FROM EMPLOYEE
go

/*ques10:Display employee details using Join with employee slabs table.
soln:we will first make a new table employee slab and then apply join*/
USE MIS
go
CREATE TABLE ESlab(
empid int NOT NULL PRIMARY KEY,
DepName varchar(30),
Position varchar(30)
)
go

INSERT INTO ESlab VALUES('1001','Administration','Assistant'),('1004','Engineer','Developer'),
('1007','Administration','Manager'),('1009','Management','Assistant')
go
SELECT EMPLOYEE.empid,ESlAB.DepName,EMPLOYEE.Salary
FROM EMPLOYEE JOIN ESlab
ON EMPLOYEE.empid=ESlab.empid
go

/*ques11:Same as above using Inner join
*/
SELECT EMPLOYEE.empid,ESlAB.DepName,EMPLOYEE.Salary
FROM EMPLOYEE INNER JOIN ESlab
ON EMPLOYEE.empid=ESlab.empid
go


/*ques12:Create a sample employee management system, having table Employee & Department. Employees are
 associated with some department, there are some employees exist which doesn't associated with any department
  yet. Display all the employees and their department information whether they are associated with some 
  department or not.
SOLN:add a column for department id in employee table.create a table department and then employee table is left
 joined with department table*/
 ALTER TABLE EMPLOYEE
 ADD depID int
 USE MIS
 go
 /*Feeding values in depID column*/
 UPDATE EMPLOYEE SET depID=701 WHERE empid=1001
UPDATE EMPLOYEE SET depID=705 WHERE empid=1002
UPDATE EMPLOYEE SET depID=705 WHERE empid=1003
UPDATE EMPLOYEE SET depID=702 WHERE empid=1004
 go
CREATE TABLE DEPARTMENT(
depID int  NOT NULL PRIMARY KEY,
depNAME varchar(30),
numE INT CHECK(numE>=0)
)
INSERT INTO DEPARTMENT VALUES('701','Administration','3'),('702','Engineer','10'),
('703','Administration','5'),('704','Management','5')
go
SELECT EMPLOYEE.empid,EMPLOYEE.FirstName,EMPLOYEE.LastName,DEPARTMENT.depNAME
FROM EMPLOYEE LEFT JOIN DEPARTMENT
ON EMPLOYEE.depID=DEPARTMENT.depID
go

/*ques13:Same case as above but there are some department also exist which doesn't have any employees
 associated with it. Display all the departments and number of employees associated with it.
soln:using RIGHT JOIN*/
USE MIS
go
SELECT DEPARTMENT.depNAME,EMPLOYEE.FirstName
FROM EMPLOYEE RIGHT JOIN DEPARTMENT
ON EMPLOYEE.depID=DEPARTMENT.depID
go

/*ques14:Same case as above. Display all the employees and departments whether they are associated with 
each other or not.
soln:we will use full outer join*/
USE MIS
go
SELECT EMPLOYEE.empid,EMPLOYEE.FirstName,EMPLOYEE.LastName,DEPARTMENT.depNAME
FROM EMPLOYEE FULL OUTER JOIN DEPARTMENT
ON EMPLOYEE.depID=DEPARTMENT.depID
go

/*ques15:Suppose a ERP system having multiple table for employees of different companies. Create tables for 
3 companies such as "ABC", "LMN" & "XYZ" and display all the employees of all the companies.
soln:creating a database erp syaytem with three tables abc,lmn and xyz*/
CREATE DATABASE ERP
USE ERP
go
CREATE TABLE ABC(
empid int NOT NULL PRIMARY KEY,
empName varchar(30),
sex char,
dep varchar(30)
)
CREATE TABLE LMN(
empid int NOT NULL PRIMARY KEY,
empName varchar(30),
sex char,
dep varchar(30)
)
CREATE TABLE XYZ(
empid int NOT NULL PRIMARY KEY,
empName varchar(30),
sex char,
dep varchar(30)
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
SELECT empNAME FROM ABC
UNION
SELECT empNAME FROM LMN
UNION
SELECT empNAME FROM XYZ
go

/*ques16:Create a backup system where records are being saved in another table in different database. Write 
queries to insert data of "Employee" table "Employee_Backup" table in another database.
*/
USE MIS
go
SELECT * into  ERP.dbo.Employee_Backup
FROM EMPLOYEE
go
USE ERP
go
SELECT * FROM Employee_Backup
go

/*ques17:increment the salary of all employee by 5000  
*/
USE MIS
go
UPDATE EMPLOYEE
SET Salary=Salary+ 5000
go

/*ques18:create a view with details of managers whose salary is more than 60000. Add a column date of joining
 in the employee table and display in view the joining date in the format specified in #1 of previous exercise
*/
USE MIS
go
ALTER TABLE EMPLOYEE
ADD DOJ date 
go
CREATE VIEW 
SELECT EMPLOYEE.empid,EMPLOYEE.FirstName
FROM EMPLOYEE JOIN DESIGNATION
WHERE DESIGNATION.DesName='MANAGER'
ON EMPLOYEE.DesID=DESIGNATION.desid
AND Salary>60000

/*ques19:"1.Get current date in the format specified in example -Mon  20th sep 10, 1:30 pm
2. Get unix timestamp of date 1st Jan 2010 also display this date in the same format.
3. Add 2 days in current date and display in format specified in 1st point"
*/
SELECT CONVERT(VARCHAR(24),GETDATE(),113) AS DATE6
go

SELECT DATEADD(DAY,2,'2010-01-01')

go

/*ques20:Count sum of a column in which one of the values is Null
*/
SELECT SUM(COUNT(isnull(empid,0)) 
         +COUNT( isnull(FirstName,0) )
         + COUNT(isnull(LastName,0))
         +COUNT(isnull(Sex,0))
         + COUNT(isnull(Active_Status,0) )
		  + COUNT(isnull(Sex,0) )
		   + COUNT(isnull(DesID,0) )
		    + COUNT(isnull(depID,0) )
			 + COUNT(isnull(DOJ,0) )
			  + COUNT(isnull(NewCol,0) ))
AS TOTAL FROM EMPLOYEE

go

/*ques21:get the details of the employee whose last name is null

*/
USE MIS
go
SELECT * FROM EMPLOYEE
WHERE LastName IS NULL
go

/*ques22:Calculate 12.75 % of salary as pf for all employees and display it in decimals with 2 digits after 
decimal point
*/
USE MIS
go
SELECT Salary,
ROUND(Salary*.1275,2) AS PF
FROM EMPLOYEE
go
/*ques23: List the employee list whose salary is greater than average employee salary.
*/
USE MIS
go
SELECT * FROM EMPLOYEE
WHERE Salary>(SELECT AVG(Salary) FROM EMPLOYEE)

go

/*ques24: List all the departments and respective employee count in it. Use Employee and department table*/
SELECT DEPARTMENT.depNAME,COUNT(EMPLOYEE.FirstName) AS empCount FROM EMPLOYEE
LEFT JOIN DEPARTMENT
ON DEPARTMENT.depID=EMPLOYEE.depID
GROUP BY DEPARTMENT.depNAME

go

/*ques25:List all the customers have a total order of less than 2000. Use Order table having OrderId, orderDate,
 order, customername.*/
 USE MIS
 go
 CREATE TABLE OrderS(
 OrderId INT NOT NULL PRIMARY KEY,
 orderDate DATE,
 orders INT,
 custName VARCHAR(30)
 )
 go
 SELECT custName FROM Orders
 GROUP BY custName
 HAVING COUNT(orders)<2000

 go

/*ques26:select the content of the "LastName" and "FirstName" columns from employee table, and convert the "LastName" column to uppercase*/
USE MIS
SELECT UPPER(LastName) AS Lname, FirstName
FROM EMPLOYEE;

go

/*ques27:select the content of the "LastName" and "FirstName" columns from employee table, and convert the "LastName" column to lowercase*/
USE MIS
SELECT LOWER(LastName) AS Lname, FirstName
FROM EMPLOYEE;

go

/*ques28:select the length of the values in the "Names" column in employee table.*/
USE MIS
go
SELECT LEN(FirstName) AS NameLen
FROM EMPLOYEE

go

/*ques29:Display the employee name and the salary rounded to the nearest integer from the employee_salary table.*/
USE MIS
go
SELECT FirstName,LastName,ROUND(Salary,0)AS ApproxS
FROM EMPLOYEE

go

/*ques30:Display list of all the employee with the current date information.*/
SELECT *,CAST(GETDATE() AS DATE) FROM EMPLOYEE 

go

/*ques31:*/

SELECT CONVERT(VARCHAR(19),GETDATE()) AS DATE1
SELECT CONVERT(VARCHAR(10),GETDATE(),10) AS DATE2
SELECT CONVERT(VARCHAR(10),GETDATE(),110) AS DATE3
SELECT CONVERT(VARCHAR(11),GETDATE(),6) AS DATE4
SELECT CONVERT(VARCHAR(11),GETDATE(),106) AS DATE5
SELECT CONVERT(VARCHAR(24),GETDATE(),113) AS DATE6
go

/*ques32:use cast() to change datatype of empid column to Varchar(10)*/
USE MIS
go
SELECT CAST(empid AS VARCHAR(10))
FROM EMPLOYEE
go
