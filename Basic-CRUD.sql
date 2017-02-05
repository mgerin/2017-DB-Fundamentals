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

-- 