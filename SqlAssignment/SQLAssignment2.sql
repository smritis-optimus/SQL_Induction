USE MIS

go

CREATE TABLE t_emp(
Empid int IDENTITY(1001,2) PRIMARY KEY,
Emp_Code varchar(20),
Emp_f_name varchar(20) NOT NULL,
Emp_m_name varchar(20),
Emp_l_name varchar(20),
Emp_DOB date CHECK(Emp_DOB BETWEEN '01/01/1997' and GETDATE()),
Emp_DOJ date NOT NULL
)

go

INSERT INTO t_emp(Emp_Code,Emp_f_name,Emp_m_name,Emp_l_name,Emp_DOB,Emp_DOJ) VALUES
('OPT20110105','Manmohan','','Singh','1999-02-25','2010-05-25'),
('OPT20100915','Alfred','Joseph','Lawrence','1998-02-28','2013-10-15'),
('OPT20150707','Smriti','','Singh','1998-10-07','2015-07-06')

go

CREATE TABLE t_activity(
Activity_id int PRIMARY KEY,
Activity_description varchar(30)
)

go

INSERT INTO t_activity VALUES
('1','Code Analyis'),
('2','Lunch'),
('3','Coding'),
('4','Knowledge Transition'),
('5','Database')

go


CREATE TABLE t_atten_det(
Atten_id int IDENTITY(1001,1),
Emp_id int FOREIGN KEY REFERENCES t_emp(Empid),
Activity_id  int FOREIGN KEY REFERENCES t_activity(Activity_id),
Atten_start_datetime date,
Atten_end_hrs int
)

go

INSERT INTO t_atten_det VALUES
('1005','5','2011-02-13 10:00:00','2'),
('1005','1','2011-01-14 10:00:00','3'),
('1005','3','2011-01-14 13:00:00','5'),
('1003','5','2011-02-16 10:00:00','8'),
('1003','5','2011-02-17 10:00:00','8'),
('1003','5','2011-02-19 10:00:00','7')

go

CREATE TABLE t_salary(
Salary_id int,
Emp_id int,
Changed_date date,
New_Salary decimal(10,2)
)

go

INSERT INTO t_salary VALUES
('1001','1003','2011-02-16','20000'),
('1002','1003','2011-01-05','25000'),
('1003','1005','2011-02-16','26000')

go

SELECT * FROM t_emp
SELECT * FROM t_activity
SELECT * FROM t_atten_det
SELECT * FROM t_salary


--query1:full name and date of birth of employees whose birthdate falls in last day of any month
SELECT CONCAT(Emp_f_name,' ',Emp_m_name,' ',Emp_l_name) Name,Emp_DOB
FROM t_emp
WHERE DATEPART(dd,Emp_DOB)=DATEPART(dd,EOMONTH(Emp_DOB))

go

--query2:display employee full name,got increment in salary?,previous salary,current salary,total worked hours,last worked activity and hours worked in that


SELECT CONCAT(Emp_f_name,' ',Emp_m_name,' ',Emp_l_name) Name,
(SELECT MAX(New_salary) ) Current_salary,
(SELECT (SELECT TOP 1 New_Salary FROM  (SELECT TOP 2 New_salary FROM t_salary order by New_Salary)AS Previous_salary)) Previous_Salary ,
(SELECT SUM(Atten_end_hrs)  FROM t_atten_det WHERE t_atten_det.Emp_id=t_emp.Empid) Total_worked_hours,
(SELECT MAX(New_salary) )-(SELECT TOP 1 New_Salary FROM  (SELECT TOP 2 New_salary FROM t_salary order by New_Salary) INCREMENT) INCREMENT ,
(SELECT Activity_description from t_activity JOIN t_atten_det ON
t_activity.Activity_id=t_atten_det.Activity_id  WHERE
t_activity.Activity_id=t_atten_det.Activity_id 
AND Atten_start_datetime=(SELECT MAX(Atten_start_datetime) FROM t_atten_det)
GROUP BY t_atten_det.Emp_id , Activity_description) Last_worked_activity, 
(SELECT SUM(Atten_end_hrs)  from t_activity JOIN t_atten_det ON 
t_activity.Activity_id=t_atten_det.Activity_id  WHERE
t_activity.Activity_id=t_atten_det.Activity_id 
AND Atten_start_datetime=(SELECT MAX(Atten_start_datetime) FROM t_atten_det)
GROUP BY t_atten_det.Emp_id , Activity_description) hours_worked_in_last_activity
FROM  t_salary JOIN t_emp  
ON t_emp.Empid=t_salary.Emp_id  
GROUP BY Emp_f_name,Emp_m_name,Emp_l_name ,t_emp.Empid

go
