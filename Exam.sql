USE MASTER
GO
CREATE DATABASE Bakery

USE Bakery
GO
-- 01 PRODUCTS

CREATE TABLE Products (
Id INT PRIMARY KEY IDENTITY NOT NULL,
Name NVARCHAR(25) UNIQUE NOT NULL,
Description NVARCHAR(250),
Recipe NVARCHAR(MAX),
Price MONEY CHECK (Price >= 0)
)

-- 02 •	Countries 

CREATE TABLE Countries (
Id INT PRIMARY KEY IDENTITY NOT NULL,
Name NVARCHAR(50) UNIQUE NOT NULL
)

-- 03 Customers

CREATE TABLE Customers (
Id INT PRIMARY KEY IDENTITY NOT NULL,
FirstName NVARCHAR(25),
LastName NVARCHAR(25),
Age INT CHECK (Age >= 0),
Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
PhoneNumber CHAR(10) CHECK (PhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), 
CountryId INT FOREIGN KEY REFERENCES Countries(Id) NOT NULL
)

-- 04 Feedbacks

CREATE TABLE Feedbacks (
Id INT PRIMARY KEY IDENTITY,
ProductId INT FOREIGN KEY REFERENCES Products(Id) NOT NULL,
CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
Rate DECIMAL (10,2) CHECK (Rate >=0 AND Rate <=10),
Description NVARCHAR(255)
)

-- 05 Distributors

CREATE TABLE Distributors (
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(25) UNIQUE,
CountryId INT FOREIGN KEY REFERENCES Countries(Id) NOT NULL,
AddressText NVARCHAR(30),
Summary NVARCHAR(200)
)

-- 06 Ingredients

CREATE TABLE Ingredients (
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(30),
OriginCountryId INT FOREIGN KEY REFERENCES Countries(Id) NOT NULL,
Description NVARCHAR(200),
DistributorId INT FOREIGN KEY REFERENCES Distributors(Id) NOT NULL
)

-- 07 ProductsIngredients

CREATE TABLE ProductsIngredients (
ProductId INT FOREIGN KEY REFERENCES Products(Id) NOT NULL,
IngredientId INT FOREIGN KEY REFERENCES Ingredients(Id) NOT NULL,
PRIMARY KEY (ProductId, IngredientId)
)

-- Section 2. DML (15 pts)

INSERT INTO Distributors VALUES
('Deloitte & Touche',2,'6 Arch St #9757','Customizable neutral traveling'),
('Congress Title',13,'58 Hancock St','Customer loyalty'),
('Kitchen People',1,'3 E 31st St #77','Triple-buffered stable delivery'),
('General Color Co Inc',21,'6185 Bohn St #72','Focus group'),
('Beck Corporation',23,'21 E 64th Ave','Quality-focused 4th generation hardware')

INSERT INTO Customers VALUES
('Francoise','Rautenstrauch',15,'M','0195698399',5),
('Kendra','Loud',22,'F','0063631526',11),
('Lourdes','Bauswell',50,'M','0139037043',8),
('Hannah','Edmison',18,'F','0043343686',1),
('Tom','Loeza',31,'M','0144876096',23),
('Queenie','Kramarczyk',30,'F','0064215793',29),
('Hiu','Portaro',25,'M','0068277755',16),
('Josefa','Opitz',43,'F','0197887645',17)

--3.	Update

UPDATE Ingredients
SET DistributorId=35
WHERE Name IN ('Bay Leaf', 'Paprika', 'Poppy')

UPDATE Ingredients
SET OriginCountryId=14
WHERE OriginCountryId=8

-- DELETE

DELETE FROM Feedbacks
WHERE CustomerId=14 OR ProductId=5

-- Section 3. Querying (40 pts)

-- 5.	Products by Price

SELECT p.Name, p.Price, p.Description FROM Products AS p
ORDER BY p.Price DESC, p.Name

-- 6.	Ingredients

SELECT I.Name, I.Description, I.OriginCountryId FROM Ingredients AS I
WHERE I.OriginCountryId IN (1, 10, 20)
ORDER BY I.Id

-- 7.	Ingredients from Bulgaria and Greece

SELECT TOP 15 I.Name, I.Description, C.Name FROM Ingredients AS I
JOIN Countries AS C ON I.OriginCountryId=C.Id
WHERE C.Name IN ('Bulgaria', 'Greece')
ORDER BY I.Name, C.Name

-- 8.	Best Rated Products

SELECT TOP(10) P.Name
       , P.Description
	   , AVG(F.Rate) AS AverageRate
	   , COUNT(F.Rate) AS FeedbacksAmount
FROM Products AS P
LEFT OUTER JOIN Feedbacks AS F ON P.Id=F.ProductId
GROUP BY P.Name, P.Description
ORDER BY AverageRate DESC, FeedbacksAmount

-- 9.	Negative Feedback

SELECT F.ProductId, F.Rate, F.Description, F.CustomerId, C.Age, C.Gender FROM Feedbacks AS F
LEFT OUTER JOIN Customers AS C ON F.CustomerId=C.Id
WHERE F.Rate < 5
ORDER BY F.ProductId DESC, F.Rate

-- 10.	Customers without Feedback

SELECT CASE 
		WHEN C.FirstName IS NULL THEN C.LastName
		WHEN C.LastName IS NULL THEN C.FirstName
		ELSE
		C.FirstName + ' ' + C.LastName
		END AS CustomerName
       , C.PhoneNumber, C.Gender 
  FROM Customers AS C
 WHERE C.Id NOT IN (SELECT DISTINCT F.CustomerId FROM Feedbacks AS F)
 ORDER BY C.Id ASC

-- 11.	Honorable Mentions

SELECT P.Id
	   , CASE 
		     WHEN C.FirstName IS NULL THEN C.LastName
		     WHEN C.LastName IS NULL THEN C.FirstName
		     ELSE
		     C.FirstName + ' ' + C.LastName
		     END AS CustomerName
	   , F.Description
  FROM Products AS P
  JOIN Feedbacks AS F ON P.Id=F.ProductId
  JOIN Customers AS C ON F.CustomerId=C.Id
  WHERE p.Id IN (SELECT P.Id FROM Products AS P
					JOIN Feedbacks F ON P.Id=F.ProductId
                    GROUP BY P.Id
					HAVING COUNT(F.CustomerId) >= 3)
  ORDER BY P.Id, CustomerName, F.Id


-- 12.	Customers by Criteria

SELECT C.FirstName, C.Age, C.PhoneNumber FROM Customers AS C
LEFT OUTER JOIN Countries AS CN ON C.CountryId=CN.Id
WHERE (C.Age >= 21 AND C.FirstName LIKE '%an%') OR 
      (C.PhoneNumber LIKE '%38' AND CN.Name NOT LIKE 'Greece')
ORDER BY C.FirstName, C.Age DESC

-- 13.	Middle Range Distributors

SELECT D.Name AS DistributorName
       , I.Name AS IngredientName
	   , P.Name AS ProductName,
	   AVG(FB.Rate) AS AverageRate
	   FROM Ingredients AS I
JOIN ProductsIngredients AS PIN ON I.Id=PIN.IngredientId
JOIN Products AS P ON PIN.ProductId=P.Id
JOIN Distributors AS D ON I.DistributorId=D.Id
JOIN Feedbacks AS FB ON P.Id=FB.ProductId
WHERE P.Id IN (SELECT P.Id FROM Products AS P
                JOIN Feedbacks AS F ON P.Id=F.ProductId
                GROUP BY P.Id
                HAVING AVG(F.Rate) BETWEEN 5 AND 8)
GROUP BY D.Name, I.Name, P.Name
ORDER BY DistributorName, IngredientName, ProductName

-- 14.	The Most Positive Country


SELECT TOP 1 WITH TIES CNT.Name AS CountryName, AVG(F.Rate) AS FeedbackRate 
  FROM Customers AS C
  JOIN Countries AS CNT ON C.CountryId=CNT.Id
  JOIN Feedbacks AS F ON C.Id=F.CustomerId
  GROUP BY CNT.Name
  ORDER BY FeedbackRate DESC

-- 16

CREATE VIEW v_UserWithCountries
AS
SELECT CASE 
		     WHEN C.FirstName IS NULL THEN C.LastName
		     WHEN C.LastName IS NULL THEN C.FirstName
		     ELSE
		     C.FirstName + ' ' + C.LastName
		     END AS CustomerName
			 , C.Age
			 , C.Gender
			 , CNT.Name
FROM Customers AS C
JOIN Countries AS CNT ON C.CountryId=CNT.Id;

SELECT TOP 5 * FROM v_UserWithCountries
ORDER BY Age

-- 17
GO

CREATE FUNCTION udf_GetRating(@name NVARCHAR(MAX))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @feedbackRating NVARCHAR(10)
	DECLARE @rating DECIMAL (8,2)

	SET @rating = (SELECT AVG(F.Rate) 
  FROM Products AS P
  LEFT JOIN Feedbacks AS F ON P.Id=F.ProductId
  WHERE P.Name=@name
  GROUP BY P.Name)

	IF (@rating IS NULL)
		SET @feedbackRating='No rating'
    ELSE IF (@rating < 5)
		SET @feedbackRating = 'Bad'
	ELSE IF (@rating BETWEEN 5 AND 8)
		SET @feedbackRating = 'Average'
	ELSE 
		SET @feedbackRating = 'Good'

	RETURN @feedbackRating
END

-- 18.	Send Feedback

CREATE PROC usp_SendFeedback(@CustomerId INT
							 , @ProductId INT
							 , @Rate DECIMAL (8,2)
							 , @Description NVARCHAR(255))
AS
BEGIN
	DECLARE @maxCustomerFeedbackCount INT = 3
	DECLARE @CustomerFeedbackCount INT
	SET @CustomerFeedbackCount = (SELECT COUNT(*) FROM Feedbacks AS F
								   WHERE F.CustomerId=@CustomerId)

	BEGIN TRAN
	INSERT INTO Feedbacks (CustomerId, ProductId, Rate, Description)
	VALUES (@CustomerId, @ProductId, @Rate, @Description)

	IF (@CustomerFeedbackCount >= @maxCustomerFeedbackCount)
		BEGIN
		RAISERROR('You are limited to only 3 feedbacks per product!', 16, 1)
		 ROLLBACK
	    END
	ELSE
		COMMIT

END

