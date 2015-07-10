USE MIS
go

/*Creating all the tables */

CREATE TABLE t_product_master(
Product_ID varchar(20) PRIMARY KEY,
Product_Name varchar(30),
Cost_Per_Item decimal(10,2)
)

go

INSERT INTO t_product_master VALUES('P1','Pen','10'),('P2','Scale','15'),('P3','Notebook','25')

go

SELECT * FROM t_product_master

go

CREATE TABLE t_user_master(
User_ID varchar(20) PRIMARY KEY,
User_Name varchar(30)
)

go

INSERT INTO t_user_master VALUES('U1','Alfred Lawrence'),('U2','Willaim Paul'),('U3','Edward Filip')

go

SELECT * FROM t_user_master

go

CREATE TABLE t_transaction(
User_ID varchar(20),
Product_ID varchar(20),
Transaction_Date date,
Transaction_Type varchar(20),
Transaction_Amount decimal(10,2)
)

go

INSERT INTO t_transaction VALUES('U1','P1','2010-10-25','Order','150'),
('U1','P1','2010-11-20','Payment','750'),
('U1','P1','2010-11-20','Order','200'),
('U1','P3','2010-11-25','Order','50'),
('U3','P2','2010-11-26','Order','100'),
('U2','P1','2010-12-15','Order','75'),
('U3','P2','2011-01-15','Payment','250')

go

SELECT User_ID,Product_ID,CONVERT(VARCHAR(10), CAST(Transaction_Date AS DATETIME) , 103)AS Transaction_Date,Transaction_Type,Transaction_Amount FROM t_transaction

go

SELECT U.User_Name,P.Product_Name,
SUM(CASE
 WHEN Transaction_Type='Order' THEN Transaction_Amount ELSE 0.0 END) Ordered_Quantity,
SUM(CASE 
WHEN Transaction_Type='Payment' THEN Transaction_Amount ELSE 0.0 END) Amount_Paid,
MAX(T.Transaction_Date) Last_Transaction_Date,
(SUM(CASE
 WHEN Transaction_Type='Order' THEN Transaction_Amount ELSE 0.0 END)*P.Cost_Per_Item)-SUM(CASE 
WHEN Transaction_Type='Payment' THEN Transaction_Amount ELSE 0.0 END) Balance
FROM t_transaction T JOIN t_product_master P
ON T.Product_ID=P.Product_ID
JOIN t_user_master U
ON T.User_ID=U.User_ID
GROUP BY U.User_Name,P.Product_Name,T.User_ID,T.Product_ID,P.Cost_Per_Item