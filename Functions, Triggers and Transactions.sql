USE SoftUni
GO

-- Problem 1.	Employees with Salary Above 35000
GO
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT FirstName, LastName FROM Employees
	WHERE Salary > 35000
END

EXEC dbo.usp_GetEmployeesSalaryAbove35000
	
-- Problem 2.	Employees with Salary Above Number
GO
CREATE PROC usp_GetEmployeesSalaryAboveNumber(@Number MONEY)
AS
BEGIN
	SELECT FirstName, LastName FROM Employees
	WHERE Salary >= @Number
END

EXEC dbo.usp_GetEmployeesSalaryAboveNumber '35000'

-- Problem 3.	Town Names Starting With

GO
CREATE PROC usp_GetTownsStartingWith(@pattern VARCHAR(10))
AS
BEGIN
	SELECT [Name] FROM Towns
	WHERE SUBSTRING(Name, 1, LEN(@pattern)) = @pattern
END

EXEC dbo.usp_GetTownsStartingWith 'B'

DROP PROC dbo.usp_GetTownsStartingWith

-- Problem 4.	Employees from Town

GO
CREATE PROC usp_GetEmployeesFromTown(@townName VARCHAR(50))
AS
BEGIN
	SELECT e.FirstName, e.LastName FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID=t.TownID
	WHERE t.Name = @townName
END

EXEC dbo.usp_GetEmployeesFromTown 'Sofia'

-- Problem 5.	Salary Level Function
GO
CREATE FUNCTION ufn_GetSalaryLevel(@salary MONEY)
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @salaryLevel VARCHAR(10)

	IF (@salary < 30000)
		SET @salaryLevel= 'Low'
	ELSE IF (@salary >= 30000 AND @salary <= 50000)
		SET @salaryLevel = 'Average'
	ELSE 
		SET @salaryLevel = 'High'
	RETURN @salaryLevel
END;

SELECT e.FirstName, E.LastName, dbo.ufn_GetSalaryLevel(e.Salary) AS SalaryLevel FROM Employees AS e;

-- Problem 6.	Employees by Salary Level
GO

CREATE PROC usp_EmployeesBySalaryLevel(@salaryLevel VARCHAR(10))
AS
BEGIN
	SELECT FirstName, LastName FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @salaryLevel
END


EXEC dbo.usp_EmployeesBySalaryLevel 'High'

-- Problem 7.	Define Function
GO

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @length INT = LEN(@word)
	DECLARE @index INT = 1

	WHILE(@index <= @length)
	BEGIN
		DECLARE @char CHAR(1) = SUBSTRING(@word, @index, 1)
		IF (CHARINDEX(@char, @setOfLetters) <= 0)
		BEGIN
			RETURN 0
		END
		SET @index += 1
	END

	RETURN 1
END

SELECT dbo.ufn_IsWordComprised ('oistmiahf', 'Sofia')
 
GO
-- Problem 8.	* Delete Employees and Departments

ALTER TABLE Departments
ALTER COLUMN ManagerId INT NULL

SELECT E.EmployeeID FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE D.Name IN ('Production', 'Production Control')

DELETE FROM EmployeesProjects
WHERE EmployeeID IN (
					SELECT E.EmployeeID FROM Employees AS E
					INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
					WHERE D.Name IN ('Production', 'Production Control')
					)

UPDATE Employees
SET ManagerID = NULL
WHERE ManagerID IN (
				   SELECT E.EmployeeID FROM Employees AS E
				   INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
				   WHERE D.Name IN ('Production', 'Production Control')
				   )
				   
UPDATE Departments
SET ManagerID = NULL
WHERE ManagerID IN (
					SELECT E.EmployeeID FROM Employees AS E
					INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
					WHERE D.Name IN ('Production', 'Production Control')
					)
					
DELETE FROM Employees
WHERE EmployeeID IN (
					SELECT E.EmployeeID FROM Employees AS E
					INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
					WHERE D.Name IN ('Production', 'Production Control')
					)

DELETE FROM Departments
WHERE Name IN ('Production', 'Production Control')


-- Problem 9.	Employees with Three Projects

CREATE PROC usp_AssignProject(@EmployeeID INT, @ProjectID INT)
AS
BEGIN
DECLARE @maxEmployeeProjectsCount INT = 3
DECLARE @employeeProjectsCount INT
SET @employeeProjectsCount = (SELECT COUNT(*) FROM EmployeesProjects AS ep
							   WHERE ep.EmployeeID=@EmployeeID)
	BEGIN TRAN
	INSERT INTO EmployeesProjects(EmployeeID, ProjectID)
	VALUES (@EmployeeID, @ProjectID)

	IF (@employeeProjectsCount >= @maxEmployeeProjectsCount)
	   BEGIN
	     RAISERROR('The employee has too many projects!', 16, 1)
		 ROLLBACK
	   END
	ELSE
		COMMIT
END;

DROP PROC udp_AssignProject;

-- Problem 10.	Find Full Name
GO
USE Bank
GO

-- Problem 11.	People with Balance Higher Than

CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@sum MONEY)
AS
BEGIN
	SELECT ah.FirstName, ah.LastName FROM AccountHolders AS ah
	LEFT OUTER JOIN Accounts AS ac ON ah.Id = ac.AccountHolderId
	GROUP BY FirstName, LastName
	HAVING SUM(ac.Balance) >= @sum
END

EXEC dbo.usp_GetHoldersWithBalanceHigherThan 7000

-- Problem 12.	Future Value Function

-- Problem 13.	Calculating Interest

-- Problem 14.	Deposit Money

-- Problem 15.	Withdraw Money

CREATE PROC usp_WithdrawMoney
	@account INT,
	@moneyAmount MONEY

AS
BEGIN
	BEGIN TRAN

	UPDATE Accounts SET Balance = Balance - @moneyAmount
	WHERE Id = @account
	IF @@ROWCOUNT <> 1
		BEGIN
		 ROLLBACK;
		 RAISERROR('Invalid account!', 16, 1)
		 RETURN
		END

	COMMIT
END;

-- Problem 16.	Money Transfer

-- Problem 17.	Create Table Logs

-- Problem 18.	Create Table Emails

-- Problem 19.	*Scalar Function: Cash in User Games Odd Rows

-- Problem 20.	Trigger

-- Problem 21.	*Massive Shopping

-- Problem 22.	Number of Users for Email Provider

-- Problem 23.	All User in Games

-- Problem 24.	Users in Games with Their Items

-- Problem 25.	* User in Games with Their Statistics

-- Problem 26.	All Items with Greater than Average Statistics

-- Problem 27.	Display All Items with Information about Forbidden Game Type

-- Problem 28.	Buy Items for User in Game

-- Problem 29.	Peaks and Mountains

-- Problem 30.	Peaks with Their Mountain, Country and Continent

-- Problem 31.	Rivers by Country

-- Problem 32.	Count of Countries by Currency

-- Problem 33.	Population and Area by Continent

-- Problem 34.	Monasteries by Country

-- Problem 35.	Monasteries by Continents and Countries