-- Problem 1.	Find Names of All Employees by First Name

SELECT e.FirstName, e.LastName 
  FROM Employees AS e
 WHERE e.FirstName LIKE 'SA%';

-- Problem 2.	  Find Names of All employees by Last Name 

SELECT e.FirstName, e.LastName 
  FROM Employees AS e
 WHERE e.LastName LIKE '%ei%';

-- Problem 3.	Find First Names of All Employees

SELECT e.FirstName 
  FROM Employees AS e
  WHERE e.DepartmentID IN (3, 10) AND (DATEPART(year, e.HireDate) BETWEEN 1995 AND 2005);

-- Problem 4.	Find All Employees Except Engineers

SELECT e.FirstName, e.LastName 
  FROM Employees AS e
 WHERE e.JobTitle NOT LIKE '%engineer%';

-- Problem 5.	Find Towns with Name Length

SELECT t.[Name] 
  FROM Towns AS t
 WHERE LEN(t.Name) IN (5, 6)
 ORDER BY t.Name;

-- Problem 6.	 Find Towns Starting With

SELECT * FROM Towns AS t
 WHERE t.Name LIKE '[MKBE]%'
 ORDER BY t.Name;

-- Problem 7.	 Find Towns Not Starting With

SELECT * FROM Towns AS t
 WHERE t.Name LIKE '[^RBD]%'
 ORDER BY t.Name;

-- Problem 8.	Create View Employees Hired After 2000 Year

CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT e.FirstName, e.LastName FROM Employees AS e
 WHERE DATEPART(YEAR,e.HireDate) > 2000;

SELECT * FROM V_EmployeesHiredAfter2000;

-- Problem 9.	Length of Last Name

SELECT e.FirstName, e.LastName FROM Employees AS e
 WHERE LEN(e.LastName) = 5;

-- Problem 10.	Countries Holding ‘A’ 3 or More Times

USE Geography
GO

SELECT c.CountryName, c.IsoCode FROM Countries AS c
 WHERE c.CountryName LIKE '%A%A%A%'
 ORDER BY c.IsoCode;

-- Problem 11.	 Mix of Peak and River Names

SELECT PeakName, RiverName, 
	CONCAT(LOWER(PeakName), LOWER(RIGHT(RiverName, LEN(RiverName) -1))) AS Mix 
	FROM Peaks, Rivers
   WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
   ORDER BY Mix;

-- Problem 12.	Games from 2011 and 2012 year

USE Diablo
GO

  SELECT TOP 50 Name, 
       FORMAT(Start, 'yyyy-MM-dd') AS NewDate
  FROM Games
 WHERE YEAR(Start) IN (2011, 2012)
 ORDER BY Start, Name;

-- Problem 13.	 User Email Providers

SELECT u.Username, RIGHT(u.Email, LEN(u.Email) - CHARINDEX('@', u.Email)) AS 'Email Provider'
  FROM Users AS u
 ORDER BY [Email Provider], u.Username;

-- Problem 14.	 Get Users with IPAdress Like Pattern

SELECT u.Username, u.IpAddress 
  FROM Users AS u
 WHERE u.IpAddress LIKE '___.1%.%.___'
 ORDER BY u.Username;

-- Problem 15.	 Show All Games with Duration and Part of the Day

SELECT g.[Name] AS [Game], 
	   Start = CASE
				WHEN DATEPART(HOUR, g.Start) >= 0 AND DATEPART(HOUR, g.Start) < 12 THEN 'Morning'
				WHEN DATEPART(HOUR, g.Start) >=12 AND DATEPART(HOUR, g.Start) < 18 THEN 'Afternoon'
				ELSE 'Evening'
				END,
	   Duration = CASE
					WHEN g.Duration <= 3 THEN 'Extra Short'
					WHEN g.Duration >= 4 AND g.Duration<=6 THEN 'Short'
					WHEN g.Duration > 6 THEN 'Long'
					ELSE 'Extra Long'
					END
	   FROM Games AS g
	  ORDER BY [Game], Duration, Start;

-- Problem 16.	 Orders Table

CREATE TABLE Orders
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50),
OrderDate DATE 
)

INSERT INTO Orders ([Name], OrderDate) VALUES ('BUTTER', '2016-09-19')

SELECT O.[Name],
	   O.OrderDate,
	   DATEADD(DAY, 3, O.OrderDate) AS 'Pay Due',
	   DATEADD(MONTH, 1, O.OrderDate) AS 'Deliver Due'
FROM Orders AS O