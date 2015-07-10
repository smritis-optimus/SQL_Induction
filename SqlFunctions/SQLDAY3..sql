/*NO.61:Create a function that takes input as year(integer) and returns a string that display 'leap year' &
Non-leap year' */

CREATE FUNCTION dbo.mis_IsLeapYr (@year int)
RETURNS varchar(30)
AS
BEGIN
    RETURN
	CASE WHEN(@year%400=0)
	THEN 'Leap Year'
    ELSE
	 CASE WHEN(@year%100=0)
	 THEN'Not Leap Year'
	  ELSE
	  CASE WHEN(@year%4=0)
	  THEN'Leap Year'
	  ELSE 'Not Leap Year'
END
END
END
END

go

SELECT dbo.mis_IsLeapYr(1900) AS 'IsLeapYear?'
SELECT dbo.mis_IsLeapYr(2000) AS 'IsLeapYear?'
SELECT dbo.mis_IsLeapYr(2006) AS 'IsLeapYear?'
SELECT dbo.mis_IsLeapYr(2015) AS 'IsLeapYear?'

go

/*No.62:"1) Create a stored procedure that takes input as 'employeid' and return the complete information regarding; personnel information, department information & salary information.
Note: the tables used will be Employee, Department, & Emp_Salary."
Soln:Inserting some values in EmployeeSalary table then creating a stored procedure

*/

USE MIS

go

INSERT INTO EmployeeSalary(Empid,Ba,Hr,Da) VALUES('1001','8000','2000','2000'),('1002','11000','3000','3000'),('1003','8000','3000','3000'),('1004','8000','2000','2000'),('1005','500','200','300'),('1006','3000','1000','1000'),('1007','3000','2000','2000')

go

CREATE PROCEDURE Emp( @Employeid int)
AS
BEGIN

SELECT E.empid,E.FirstName,E.LastName,E.Sex,D.depNAME,S.Ba,S.Da,S.Hr
FROM EMPLOYEE E JOIN DEPARTMENT D
ON E.depID=D.depID
JOIN EmployeeSalary S
ON S.Empid=E.empid
WHERE E.empid=@Employeid
END

go

--executing the procedure
EXEC Emp '1001'

/*No.63:Create a sample procedure having exception handles in it.
*/


CREATE PROCEDURE ErrChck(@Employeid int, @msg varchar(200))
AS
BEGIN TRY
SET @Employeid=1/0;
END TRY
BEGIN CATCH
PRINT 'Error:'
SET @msg=(SELECT ERROR_MESSAGE())
PRINT @msg;
END CATCH

go

EXEC ErrChck '1','error'

go