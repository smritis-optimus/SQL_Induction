CREATE DATABASE TEST2

go

USE TEST2

go


CREATE TABLE UserTable
(
UserID int,
Name varchar(30),
Country varchar(20),
Gender char
)

go

INSERT INTO UserTable VALUES
('101','Harsh','India','M'),
('102','Richa','Sri Lanka','F'),
('103','Richard','US','M'),
('104','Gopal','India','M'),
('105','Jennifer','US','F'),
('106','Karishma','India','F'),
('107','Clinton','US','M'),
('108','Sadhna','India','F')


CREATE TABLE PostTable
(
PostID int,
UserID int,
Post varchar(30)
)

go

INSERT INTO PostTable VALUES
('201','104','My name is Gopal'),
('202','101','Hello Friends'),
('203','105','Bon Voyage'),
('204','104','Cherishing Life'),
('205','108','Switching Lanes'),
('206','105','Feeling Nostalgic'),
('207','102','Sangakkara Rocks'),
('208','104','Bleeding Blue')

CREATE TABLE FriendRequest
(
RequestID int,
SenderID int,
RecievedID int,
Status varchar(30)
)

go

INSERT INTO FriendRequest Values
('301','101','102','Approved'),
('302','107','105','Rejected'),
('303','101','106','Approved'),
('304','108','101','Approved'),
('305','106','103','Approved'),
('306','104','108','Pending'),
('307','104','101','Approved'),
('308','105','102','Pending'),
('309','107','103','Approved'),
('310','106','102','Rejected')

CREATE TABLE PostLikes
(
LikeID int,
PostID int,
UserID int
)

go

INSERT INTO PostLikes VALUES
('401','203','102'),
('402','208','108'),
('403','204','106'),
('404','203','108'),
('405','207','102'),
('406','202','102'),
('407','203','106'),
('408','205','102'),
('409','204','107'),
('410','203','101')

SELECT * FROM UserTable

go

SELECT * FROM PostTable

go

SELECT * FROM FriendRequest


go

SELECT * FROM PostLikes

go

--query1: select country that posts maximum

SELECT Post.Country FROM
(SELECT P.UserID,DENSE_RANK()over(order by COUNT(P.PostID) desc) AS posting,U.Country
FROM PostTable P JOIN UserTable U
ON U.UserID=P.UserID
GROUP BY P.UserID,U.Country) Post
WHERE Post.posting=1

go


--query2:Select top poster of each country

--

SELECT TOP 1 Posting.Name FROM(
SELECT U.Name,COUNT(P.Post) AS No_of_Posts,U.Country
FROM PostTable P JOIN UserTable U
ON U.UserID=P.UserID
GROUP BY U.Country,U.Name)Posting
 WHERE Country='India'
 UNION
SELECT TOP 1 Posting.Name FROM(
SELECT U.Name,COUNT(P.Post) AS No_of_Posts,U.Country
FROM PostTable P JOIN UserTable U
ON U.UserID=P.UserID
GROUP BY U.Country,U.Name)Posting
 WHERE Country='Sri lanka'
 UNION
 SELECT TOP 1 Posting.Name FROM(
SELECT U.Name,COUNT(P.Post) AS No_of_Posts,U.Country
FROM PostTable P JOIN UserTable U
ON U.UserID=P.UserID
GROUP BY U.Country,U.Name)Posting
 WHERE Country='US'

 go


--query3:Post with third highest likes

SELECT Post.Post FROM(
SELECT DENSE_RANK()over(order by COUNT(PostLikes.PostID) desc) AS ranking,PostLikes.PostID,PostTable.Post
FROM PostLikes JOIN PostTable
on PostLikes.PostId=PostTable.PostID
GROUP BY PostLikes.PostID,PostTable.Post) Post
WHERE ranking=3

go


--quer4:Users whose post have maximum likes

SELECT Name FROM UserTable 
WHERE UserID=(
SELECT LikeTable.UserID FROM(
SELECT DENSE_RANK()over(order by COUNT(L.PostID) desc) AS ranking,P.UserID
FROM PostLikes L JOIN PostTable P
ON
L.PostID=P.PostID
GROUP BY P.UserID) LikeTable
WHERE ranking=1
)
go


--quey5:User who has no friend request accepted

SELECT Request.SenderID,UserTable.Name FROM(
SELECT SenderID,COUNT(CASE WHEN Status='Approved' THEN SenderID ELSE NULL END) AS Accepted,
COUNT(CASE WHEN Status='Rejected' THEN SenderID ELSE NULL END) AS Rejected,
COUNT(CASE WHEN Status='Pending' THEN SenderID ELSE NULL END) AS Pending
FROM FriendRequest
GROUP BY SenderID) Request
JOIN UserTable
ON Request.SenderID=UserTable.UserID
WHERE Request.Rejected>0 AND Request.Accepted=0

go


--query6:highest like post from each user

SELECT PostTable.UserID,PostTable.Post FROM (SELECT COUNT(L.PostID) AS HighestLikePost,P.PostID
FROM PostLikes L JOIN PostTable P
ON
L.PostID=P.PostID
GROUP BY P.PostID) LikeTable
LEFT JOIN PostTable
ON LikeTable.PostId=PostTable.PostID

go
--in context of the problem given,distinct values are not calculated
SELECT TOP 5 PostTable.UserID,PostTable.Post FROM (SELECT COUNT(L.PostID) AS HighestLikePost,P.PostID
FROM PostLikes L JOIN PostTable P
ON
L.PostID=P.PostID
GROUP BY P.PostID) LikeTable
LEFT JOIN PostTable
ON LikeTable.PostId=PostTable.PostID

go

--query 7:No. of post from each country


SELECT U.Country,COUNT(P.Post) AS Posts FROM 
PostTable P JOIN UserTable U 
ON P.UserID=U.UserID
GROUP BY U.Country

go

--query8:Country and gender wise post count

SELECT U.Country,U.Gender,COUNT(P.Post) AS Posts FROM 
PostTable P JOIN UserTable U 
ON P.UserID=U.UserID
GROUP BY U.Country,U.Gender

go


--query9:Takes userid and returns friend of the user

CREATE FUNCTION dbo.Test2_FriendCheck (@ID int)
RETURNS int
AS
BEGIN
    RETURN 
	(SELECT RecievedID FROM FriendRequest
	WHERE SenderID=@ID AND Status='Approved'
	UNION
  SELECT SenderID FROM FriendRequest
   WHERE RecievedID=@ID AND Status='Approved'
	)

   
END

SELECT dbo.Test2_FriendCheck(101) AS 'FriendID'

go

--Function unable to return multiple values checking if the concept is right

CREATE PROCEDURE FriendList( @Id int)
AS
BEGIN
(
SELECT RecievedID FROM FriendRequest
WHERE SenderID=@Id AND Status='Approved'
UNION
SELECT SenderID FROM FriendRequest
WHERE RecievedID=@Id AND Status='Approved'
)
END

go

EXEC FriendList '101'

go

--query 10:procedure that takes two userID and gives names of mutual friend

CREATE PROCEDURE Friend( @UserId1 int,@UserId2 int)
AS
BEGIN
(
SELECT RecievedID FROM FriendRequest
WHERE SenderID=@UserId1 AND Status='Approved'
UNION
SELECT SenderID FROM FriendRequest
WHERE RecievedID=@UserId1 AND Status='Approved'
)
INTERSECT
(
SELECT RecievedID FROM FriendRequest
WHERE SenderID=@UserId2 AND Status='Approved'
UNION
SELECT SenderID FROM FriendRequest
WHERE RecievedID=@UserId2 AND Status='Approved'
)
END

go

EXEC Friend '101','103'

go
