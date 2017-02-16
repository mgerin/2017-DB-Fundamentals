-- Problem 1.	Employees with Salary Above 35000

-- Problem 2.	Employees with Salary Above Number

-- Problem 3.	Town Names Starting With

-- Problem 4.	Employees from Town

-- Problem 5.	Salary Level Function

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

-- Problem 7.	Define Function

-- Problem 8.	* Delete Employees and Departments

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

DROP PROC udp_AssignProject;S

-- Problem 10.	Find Full Name

USE Bank
GO

-- Problem 11.	People with Balance Higher Than

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