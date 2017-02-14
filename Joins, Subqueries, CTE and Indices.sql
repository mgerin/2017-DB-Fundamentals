-- Problem 1.	Employee Address

SELECT TOP(5) e.EmployeeID, e.JobTitle, E.AddressID, a.AddressText FROM Employees AS e
JOIN Addresses AS a ON a.AddressID=e.AddressID
ORDER BY e.AddressID;

-- Problem 2.	Addresses with Towns

SELECT TOP(50) e.FirstName, e.LastName, t.[Name] AS 'Town', a.AddressText FROM Employees AS e
INNER JOIN Addresses AS a ON e.AddressID=a.AddressID
INNER JOIN Towns AS t ON a.TownID=t.TownID
ORDER BY e.FirstName, e.LastName;

-- Problem 3.	Sales Employee

SELECT e.EmployeeID, e.FirstName, e.LastName, d.[Name] AS 'DepartmentName' FROM Employees AS e
INNER JOIN Departments AS d ON e.DepartmentID=d.DepartmentID
WHERE d.[Name]='Sales';

-- Problem 4.	Employee Departments

SELECT TOP(5) E.EmployeeID, E.FirstName, E.Salary, D.[Name] AS DepartmentName
  FROM Employees AS E
  INNER JOIN Departments AS D
  ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > 15000
ORDER BY E.DepartmentID ASC;

-- Problem 5.	Employees Without Project

 SELECT TOP(3) E.EmployeeID, E.FirstName 
    FROM Employees AS E
    LEFT JOIN EmployeesProjects AS EP
      ON E.EmployeeID = EP.EmployeeID
   WHERE EP.EmployeeID IS NULL
ORDER BY E.EmployeeID;

-- Problem 6.	Employees Hired After

SELECT e.FirstName, e.LastName, e.HireDate, d.[Name] AS 'DeptName' FROM Employees AS e
LEFT OUTER JOIN Departments AS d ON e.DepartmentID=d.DepartmentID
WHERE e.HireDate > '1999-01-01' AND d.[Name] IN ('Sales', 'Finance')
ORDER BY e.HireDate;

-- Problem 7.	Employees with Project

SELECT TOP(5) E.EmployeeID, E.FirstName, P.Name
    FROM Employees AS E
   INNER JOIN EmployeesProjects AS EP
      ON E.EmployeeID = EP.EmployeeID
   INNER JOIN Projects AS P
      ON EP.ProjectID = P.ProjectID
   WHERE P.StartDate > '2002-08-13'
     AND P.EndDate IS NULL
ORDER BY E.EmployeeID ASC;

-- Problem 8.	Employee 24

SELECT e.EmployeeID, e.FirstName, p.Name
  FROM Employees AS e
 INNER JOIN [EmployeesProjects] AS ep
    ON e.EmployeeID = ep.EmployeeID
  LEFT JOIN [Projects] AS p
    ON ep.ProjectID = p.ProjectID
   AND p.StartDate < '2005-01-01'
WHERE e.EmployeeID = 24;

-- Problem 9.	Employee Manager

 SELECT e.[EmployeeID], e.[FirstName], e.[ManagerID], m.[FirstName] AS 'ManagerName'
    FROM [Employees] AS e
   INNER JOIN [Employees] AS m
      ON e.ManagerID = m.EmployeeID
   WHERE e.ManagerID IN (3, 7)
ORDER BY [EmployeeID] ASC;

-- Problem 10.	Employee Summary

SELECT TOP 50 e.EmployeeID, e.FirstName + ' ' + e.LastName AS 'EmployeeName', m.FirstName + ' ' + m.LastName AS ManagerName, d.Name AS DepartmentName FROM Employees AS e
LEFT OUTER JOIN Employees AS m ON m.EmployeeID=e.ManagerID
LEFT OUTER JOIN Departments AS d ON d.DepartmentID=e.DepartmentID
ORDER BY e.EmployeeID ASC;

-- Problem 11.	Min Average Salary

SELECT MIN(a.AverageSalary) AS MinAverageSalary
  FROM 
  (
    SELECT e.DepartmentID, 
      AVG(e.Salary) AS AverageSalary
    FROM Employees AS e
	   GROUP BY e.DepartmentID
  ) AS a;
