--Problem 1.	Create Database

CREATE DATABASE Minions

--Problem 2.	Create Tables

CREATE TABLE Minions 
(
	Id INT NOT NULL PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	Age INT
);

CREATE TABLE Towns
(
	Id INT NOT NULL PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL 
);

--Problem 3.	Alter Minions Table

ALTER TABLE Minions
	ADD TownId INT NOT NULL;

ALTER TABLE Minions
ADD CONSTRAINT FK_Minions_TownId FOREIGN KEY (TownId) REFERENCES Towns (Id);

--Problem 4.	Insert Records in Both Tables

INSERT INTO Towns VALUES (1, 'Sofia'), (2, 'Plovdiv'), (3, 'Varna');

INSERT INTO Minions VALUES (1, 'Kevin', 22, 1), (2, 'Bob', 15, 3), (3, 'Steward', NULL, 2);

--Problem 5.	Truncate Table Minions

TRUNCATE TABLE Minions;

--Problem 6.	Drop All Tables

DROP TABLE Minions, Towns;

--Problem 7.	Create Table People

CREATE TABLE People
(
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX),
	Height FLOAT(2),
	Weight FLOAT(2),
	Gender CHAR(1) NOT NULL CHECK (Gender = 'm' OR Gender = 'f'),
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(max)
);

INSERT INTO People(Name, Picture, Height, Weight, Gender, Birthdate, Biography) VALUES ('MARIN', NULL, 1.90, 90.00, 'm', '1989-04-25', 'BIOGRAPHY'),
('VESI', NULL, 1.55, 61.25, 'f', '1995-04-25', 'BIOGRAPHY of VESI'), ('Stamat', NULL, 1.95, 101.25, 'm', '1990-03-15', 'BIOGRAPHY of Stamat'),
('Lyubo', NULL, 1.82, 85.25, 'm', '1992-06-04', 'BIOGRAPHY of Lyubo'), ('Katya', NULL, 1.65, 65.25, 'f', '1994-04-25', 'BIOGRAPHY of KATYA');

--Problem 8.	Create Table Users

CREATE TABLE Users
(
Id INT PRIMARY KEY IDENTITY,
Username VARCHAR(30) UNIQUE NOT NULL,
Password VARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(MAX) NULL,
LastLoginTime DATETIME,
IsDeleted BIT
);

INSERT INTO Users VALUES ('mgerin', '2131321432423', NULL, '2016-10-02', 'false'),
('ghfhgh', '213132143242hhj', NULL, '2016-10-02', 'false'),
('jjhjjjuuii', '2131321432423', NULL, '2016-10-02', 'true'),
('hhhghj', '21314455', NULL, '2016-10-02', 'false'),
('DFSPDFSFDSFSFDSFSDS', '2131321432423', NULL, '2016-10-02', 'false');

--Problem 9.	Change Primary Key

ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC07B9EC8188;

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username);

--Problem 10.	Add Check Constraint

ALTER TABLE Users
ADD CONSTRAINT CK_Users_Password CHECK (LEN(Password) >= 5);

--Problem 11.	Set Default Value of a Field

ALTER TABLE Users
ADD CONSTRAINT DF_Users DEFAULT GETDATE() FOR LastLoginTime;

--Problem 12.	Set Unique Field

ALTER TABLE Users
DROP CONSTRAINT PK_Users;

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id);

ALTER TABLE Users
ADD CONSTRAINT CK_Users_Name CHECK (LEN(Username) >= 3);

--Problem 13.	Movies Database

CREATE DATABASE Movies;

USE Movies
GO

CREATE TABLE Directors 
(
	Id INT NOT NULL PRIMARY KEY, 
	DirectorName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX) NULL
);
 
CREATE TABLE Genres 
(
	Id INT NOT NULL PRIMARY KEY,
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX) NULL
);

CREATE TABLE Categories 
(
	Id INT NOT NULL PRIMARY KEY,
	CategoryName NVARCHAR(200) NOT NULL,
	Notes NVARCHAR(MAX) NULL
);

CREATE TABLE Movies 
(
	Id INT NOT NULL PRIMARY KEY,
	Title NVARCHAR(200) NOT NULL,
	DirectorId INT NOT NULL,
	CopyrightYear INT NOT NULL,
	Length INT NULL,
	GenreId INT NOT NULL,
	CategoryId INT NOT NULL,
	Rating INT NULL,
	Notes NVARCHAR(MAX) NULL
);

INSERT INTO Directors
VALUES (1, 'SHARO', 'NOTES'),
(2, 'LUCKY', 'NOTES 2'),
(3, 'STRAHIL', NULL),
(4, 'JOHNY', 'NOTES 4'),
(5, 'LORENZO', 'NOTES 5');

INSERT INTO Genres
VALUES (1, 'ACTION', 'NOTES'),
(2, 'COMEDY', 'HAHAHA'),
(3, 'ROMANTIC', NULL),
(4, 'THRILLER', NULL),
(5, 'DRAMA', 'NOTES 5');

INSERT INTO Categories
VALUES (1, 'A', 'FOR ALL PEOPLE'),
(2, 'B', 'HAHAHA'),
(3, 'C', NULL),
(4, 'D', NULL),
(5, 'E', 'NOTES 5');

INSERT INTO Movies
VALUES (1, 'FILM ONE', 2, 2016, 120, 1, 3, NULL, 'NOTES'),
(2, 'FILM TWO', 1, 2010, 88, 2, 2, 6, 'NOTES'),
(3, 'FILM THREE', 3, 2016, 120, 1, 4, 10, 'NOTES'),
(4, 'FILM FOUR', 4, 2014, 120, 5, 1, NULL, 'NOTES'),
(5, 'FILM FIVE', 2, 2013, 100, 4, 5, 6, 'NOTES');

--Problem 14.	Car Rental Database

CREATE DATABASE CarRental;

USE CarRental
GO

CREATE TABLE Categories
(
Id INT NOT NULL PRIMARY KEY,
Category NVARCHAR(50) NOT NULL UNIQUE,
DailyRate FLOAT(1) NOT NULL,
WeeklyRate FLOAT(1) NOT NULL,
MonthlyRate FLOAT(1) NOT NULL,
WeekendRate FLOAT(1) NOT NULL
)

CREATE TABLE Cars
(
Id INT NOT NULL PRIMARY KEY,
PlateNumber NVARCHAR(15) NOT NULL,
Make NVARCHAR(30) NOT NULL,
Model NVARCHAR(30) NOT NULL,
CarYear INT NOT NULL,
CategoryId INT,
Doors INT,
Picture VARBINARY(max),
Condition NVARCHAR(50),
Available BIT
)

CREATE TABLE Employees
(
Id INT NOT NULL PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Title NVARCHAR(50),
Notes NVARCHAR(max)
)

CREATE TABLE Customers
(
Id INT NOT NULL PRIMARY KEY,
DriverLicenceNumber NVARCHAR(20) NOT NULL,
FullName NVARCHAR(150) NOT NULL,
Address NVARCHAR(150) NOT NULL,
City NVARCHAR(50) NOT NULL,
ZIPCode NVARCHAR(10),
Notes NVARCHAR(max)
)

CREATE TABLE RentalOrders
(
Id INT NOT NULL PRIMARY KEY,
EmployeeId INT NOT NULL,
CustomerId INT NOT NULL,
CarId INT NOT NULL,
CarCondition NVARCHAR(50),
TankLevel INT NOT NULL,
KilometrageStart FLOAT(1) NOT NULL,
KilometrageEnd FLOAT(1) NOT NULL,
TotalKilometrage FLOAT(1) NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
TotalDays INT NOT NULL,
RateApplied FLOAT(1) NOT NULL,
TaxRate FLOAT(1) NOT NULL,
OrderStatus NVARCHAR(30) NOT NULL,
Notes NVARCHAR(max)
)

INSERT INTO Categories VALUES(1, 'Category 1', 13.55, 60, 220.5, 35),
(2, 'Category 2', 20.55, 70, 250.5, 50),
(3, 'Category 3', 25.55, 80, 320.5, 65);

INSERT INTO Cars VALUES (1, 'CA4223XP', 'BMW', '320d', 2001, 1, 4, NULL, 'GOOD', 'TRUE'),
(2, 'CB2223XP', 'OPEL', 'VECTRA', 2005, 2, 5, NULL, 'GOOD', 'TRUE'),
(3, 'PA4265AP', 'VW', 'PASSAT', 2010, 3, 4, NULL, 'PERFECT', 'TRUE');

INSERT INTO Employees VALUES (1, 'IVAN', 'IVANOV', 'JOHNY', 'NOTES'),
(2, 'STAMAT', 'PETROV', 'SP', 'NOTES SP'),
(3, 'KOSTADIN', 'IVANOV', 'KOKI', NULL);

INSERT INTO Customers VALUES (1, '34234234SFSD', 'BOBI B', 'RICCARDO VACCARINI', 'SOFIA', '1404', 'Notes'),
(2, '34SSDASAS234234SFSD', 'MANO', 'ANGEL KANCHEV', 'SOFIA', '1404', 'Notes'),
(3, '34234234SDADASDFSD', 'GESHEV', 'GOCE DELCHEV', 'SOFIA', '1000', NULL);

INSERT INTO RentalOrders VALUES (1, 2, 1, 3, 'GOOD', 23, 140440, 140640, 200,
 '2016-09-08', '2016-09-08', 1, 13.55, 20, 'CONFIRMED', 'Notes'),
 (2, 2, 1, 3, 'GOOD', 23, 140440, 140640, 200,
 '2016-09-08', '2016-09-08', 1, 13.55, 20, 'CONFIRMED', 'Notes'),
 (3, 2, 1, 3, 'GOOD', 23, 140440, 140640, 200,
 '2016-09-08', '2016-09-08', 1, 13.55, 20, 'CONFIRMED', 'Notes');

--Problem 15.	Hotel Database

CREATE DATABASE Hotel;
 
 USE Hotel
 GO

 CREATE TABLE Employees
 (
 Id INT NOT NULL PRIMARY KEY,
 FirstName NVARCHAR(50) NOT NULL,
 LastName NVARCHAR(50) NOT NULL,
 Title NVARCHAR(50) NOT NULL,
 Notes NVARCHAR(max)
 );

 CREATE TABLE Customers
 (
 AccountNumber NVARCHAR(50) NOT NULL PRIMARY KEY,
 FirstName NVARCHAR(50) NOT NULL,
 LastName NVARCHAR(50) NOT NULL, 
 PhoneNumber NVARCHAR(15) NOT NULL, 
 EmergencyName NVARCHAR(50) NOT NULL, 
 EmergencyNumber NVARCHAR(15) NOT NULL, 
 Notes NVARCHAR(max)
 );

 CREATE TABLE RoomStatus
 (
 RoomStatus NVARCHAR(50) NOT NULL PRIMARY KEY, 
 Notes NVARCHAR(max)
 );

 CREATE TABLE RoomTypes
 (
 RoomType NVARCHAR(50) NOT NULL PRIMARY KEY, 
 Notes NVARCHAR(max)
 );

 CREATE TABLE BedTypes
 (
 BedType NVARCHAR(30) NOT NULL PRIMARY KEY, 
 Notes NVARCHAR(max)
 );

 CREATE TABLE Rooms
 (
 RoomNumber INT NOT NULL PRIMARY KEY, 
 RoomType NVARCHAR(50) NOT NULL,
 BedType NVARCHAR(30) NOT NULL, 
 Rate FLOAT(2) NOT NULL, 
 RoomStatus NVARCHAR(50) NOT NULL, 
 Notes NVARCHAR(max)
 );

 CREATE TABLE Payments
 (
 Id INT NOT NULL PRIMARY KEY, 
 EmployeeId INT NOT NULL, 
 PaymentDate DATE NOT NULL, 
 AccountNumber NVARCHAR(50) NOT NULL, 
 FirstDateOccupied DATE NOT NULL, 
 LastDateOccupied DATE NOT NULL, 
 TotalDays INT NOT NULL, 
 AmountCharged FLOAT (2) NOT NULL, 
 TaxRate FLOAT (2) NOT NULL, 
 TaxAmount FLOAT (2) NOT NULL, 
 PaymentTotal FLOAT (2) NOT NULL, 
 Notes NVARCHAR(max)
 );

 CREATE TABLE Occupancies
 (
 Id INT NOT NULL PRIMARY KEY, 
 EmployeeId INT NOT NULL, 
 DateOccupied DATE NOT NULL, 
 AccountNumber NVARCHAR(50) NOT NULL, 
 RoomNumber INT NOT NULL, 
 RateApplied FLOAT (2) NOT NULL, 
 PhoneCharge FLOAT (2), 
 Notes NVARCHAR(max)
 );

 INSERT INTO Employees VALUES (1, 'JOHN', 'JOHNY', 'J', NULL),
 (2, 'ADAM', 'SMITH', 'AS', NULL),
 (3, 'LILY', 'LUCK', 'LL', NULL);

 INSERT INTO Customers VALUES ('KKDAA2332342342423432', 'IVAN', 'IVANOV', '32194994', 'II', '21', NULL),
 ('LKLL334', 'STAMAT', 'PETROV', '+232194994', 'SP', '22', NULL),
 ('KKDAA23323423', 'ZOYA', 'HRISTOVA', '+113222194994', 'ZH', '23', NULL);

 INSERT INTO RoomStatus VALUES ('FREE', NULL),
 ('OCCUPIED', NULL),
 ('RESERVED', NULL);

 INSERT INTO RoomTypes VALUES ('SINGLE', NULL),
 ('DOUBLE', NULL),
 ('SUIT', NULL);

 INSERT INTO BedTypes VALUES ('SINGLE', NULL),
 ('DOUBLE', NULL),
 ('PREMIUM', NULL);

 INSERT INTO Rooms VALUES (301, 'DOUBLE', 'PREMIUM', 50.33, 'FREE', NULL),
 (302, 'DOUBLE', 'DOUBLE', 40.50, 'OCCUPIED', NULL),
 (303, 'SINGLE', 'SINGLE', 30.33, 'FREE', NULL);

 INSERT INTO Payments VALUES (1, 2, '2016-10-06', 'ADADASDA', '2016-10-01', '2016-10-06', 6, 300, 0.2, 60, 360, NULL),
 (2, 1, '2016-10-06', 'ADADASDA', '2016-10-01', '2016-10-06', 6, 300, 0.2, 60, 360, NULL),
 (3, 3, '2016-10-06', 'ADADASDA', '2016-10-01', '2016-10-06', 6, 300, 0.2, 60, 360, NULL);

 INSERT INTO Occupancies VALUES (1, 1, '2016-10-06', 'ADADASDA', 205, 0.2, 0.00, NULL),
 (2, 2, '2016-10-06', 'ADADASDA', 205, 0.2, 0.00, NULL),
 (3, 3, '2016-10-06', 'ADADASDA', 205, 0.2, 0.00, NULL);

--Problem 16.	Create SoftUni Database

CREATE DATABASE SoftUni;

USE SoftUni
GO

CREATE TABLE Towns
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Addresses
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
AddressText NVARCHAR(150) NOT NULL,
TownId INT
);

CREATE TABLE Departments
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
Name NVARCHAR(100) NOT NULL
);

CREATE TABLE Employees
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
FirstName NVARCHAR(50) NOT NULL,
MiddleName NVARCHAR(50),
LastName NVARCHAR(50) NOT NULL,
JobTitle NVARCHAR(50) NOT NULL,
DepartmentId INT NOT NULL,
HireDate DATE NOT NULL,
Salary DECIMAL NOT NULL,
AddressId INT NULL
);

ALTER TABLE Addresses
ADD CONSTRAINT FK_Addresses_TownId FOREIGN KEY (TownId)
REFERENCES Towns (Id);

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_DepartmentId FOREIGN KEY (DepartmentId)
REFERENCES Departments (Id);

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_AddressId FOREIGN KEY (AddressId)
REFERENCES Addresses (Id);

--Problem 17.	Backup Database

--Problem 18.	Basic Insert

INSERT INTO Towns
VALUES ('Sofia'),('Plovdiv'),('Varna'),('Burgas');

INSERT INTO Departments
VALUES ('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance');

INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle,DepartmentId, HireDate, Salary)
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

--Problem 19.	Basic Select All Fields

SELECT * FROM Towns;

SELECT * FROM Departments;

SELECT * FROM Employees;

--Problem 20.	Basic Select All Fields and Order Them

SELECT * FROM Towns
ORDER BY Name;

SELECT * FROM Departments
ORDER BY Name;

SELECT * FROM Employees
ORDER BY Salary DESC;

--Problem 21.	Basic Select Some Fields

SELECT Name FROM Towns
ORDER BY Name;

SELECT Name FROM Departments
ORDER BY Name;

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC;

--Problem 22.	Increase Employees Salary

UPDATE Employees
SET Salary = Salary + Salary * 0.1;

SELECT Salary FROM Employees;

--Problem 23.	Decrease Tax Rate

USE Hotel
GO

UPDATE Payments
SET TaxRate = TaxRate - TaxRate * 0.03;

SELECT TaxRate FROM Payments;

--Problem 24.	Delete All Records

DELETE FROM Occupancies;