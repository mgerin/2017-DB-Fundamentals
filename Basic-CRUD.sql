USE SoftUni
GO

-- 2.	Find All Information About Departments

SELECT * FROM Departments

-- 3.	Find all Department Names

SELECT [Name] FROM Departments;

-- 4.	Find Salary of Each Employee

SELECT FirstName, LastName, Salary FROM Employees;

-- 5.	Find Full Name of Each Employee

SELECT FirstName, MiddleName, LastName FROM Employees;

-- 6.	Find Email Address of Each Employee

SELECT FirstName + '.' + LastName + '@softuni.bg' as 'Full Email Address' FROM Employees;

-- 7.	Find All Different Employee’s Salaries

SELECT DISTINCT e.Salary FROM Employees AS e;

-- 8.	Find all Information About Employees

SELECT * FROM Employees AS e
	WHERE e.JobTitle='Sales Representative';

-- 9.	Find Names of All Employees by Salary in Range

SELECT e.FirstName, e.LastName, e.JobTitle 
  FROM Employees AS e
  WHERE e.Salary BETWEEN 20000 AND 30000;

-- 10.  Find Names of All Employees

SELECT e.FirstName + ' ' + e.MiddleName + ' ' + e.LastName AS 'Full Name'
  FROM Employees AS e
  WHERE e.Salary IN (25000, 14000, 12500, 23600);

-- 11.	 Find All Employees Without Manager

SELECT e.FirstName, e.LastName
  FROM Employees AS e
 WHERE e.ManagerID IS NULL;

-- 12. Find All Employees with Salary More Than 50000

  SELECT e.FirstName, e.LastName, e.Salary
    FROM Employees AS e
   WHERE e.Salary > 50000
ORDER BY e.Salary DESC;

-- 13.	 Find 5 Best Paid Employees.

SELECT TOP(5) e.FirstName, e.LastName
  FROM Employees AS e
 ORDER BY e.Salary DESC;

-- 14.	Find All Employees Except Marketing

SELECT e.FirstName, e.LastName
  FROM Employees AS e
 WHERE e.DepartmentID <> 4;

-- 15.	Sort Employees Table

SELECT * FROM Employees AS e
 ORDER BY e.Salary DESC, e.FirstName, e.LastName DESC, e.MiddleName;

-- 16.	 Create View Employees with Salaries

CREATE VIEW V_EmployeesSalaries AS SELECT e.FirstName, e.LastName, e.Salary FROM Employees AS e;

SELECT * FROM V_EmployeesSalaries;

-- 17.	Create View Employees with Job Titles

CREATE VIEW V_EmployeeNameJobTitle AS
SELECT e.FirstName + ' ' + 
	CASE WHEN e.MiddleName IS NULL THEN ''
	ELSE e.MiddleName
	END
	+ ' ' + e.LastName AS 'Full Name', e.JobTitle 
FROM Employees AS e;

SELECT * FROM V_EmployeeNameJobTitle;

-- 18.	 Distinct Job Titles

SELECT DISTINCT e.JobTitle FROM Employees AS e;

-- 19.	Find First 10 Started Projects

SELECT TOP(10) * FROM Projects AS p
 ORDER BY p.StartDate, p.Name;

-- 20.	 Last 7 Hired Employees

SELECT TOP(7) e.FirstName, e.LastName, e.HireDate 
  FROM Employees AS e
 ORDER BY e.HireDate DESC;

-- 21.	Increase Salaries

UPDATE Employees
   SET Salary *= 1.12
 WHERE DepartmentID IN (1, 2, 4, 11);

SELECT e.Salary FROM Employees AS e;

-- 22.	 All Mountain Peaks

USE Geography
GO 

SELECT P.PeakName FROM Peaks AS p
 ORDER BY p.PeakName;

-- 23.	 Biggest Countries by Population

SELECT TOP(30) c.CountryName, c.Population 
  FROM Countries AS c
 WHERE c.ContinentCode = 'EU'
 ORDER BY c.Population DESC, c.CountryName;

--24.	 *Countries and Currency (Euro / Not Euro)

SELECT c.CountryName, c.CountryCode, 
  CASE WHEN c.CurrencyCode='EUR' THEN 'Euro'
  ELSE 'Not Euro'
   END AS 'Currency'
  FROM Countries AS c
 ORDER BY c.CountryName;

-- 25.	 All Diablo Characters

USE Diablo
GO

SELECT CH.Name FROM Characters AS CH
ORDER BY CH.Name;