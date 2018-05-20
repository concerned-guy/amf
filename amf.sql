-- Group 9:
--   Dao Anh Duy
--   Vu Xuan Huy
--   Dang Nhat Minh
--   Vuong Bao Son

SET NOCOUNT ON
GO

USE master
GO

IF EXISTS (SELECT * FROM sysdatabases WHERE NAME='amf')
DROP DATABASE amf
GO
CREATE DATABASE amf
GO
USE amf
GO

SET QUOTED_IDENTIFIER ON
SET DATEFORMAT dmy -- Date format is Day-Month-Year not Year-Month-Day by default!
GO

-- Create table section:
CREATE TABLE Employees (
	EmployeeID INT NOT NULL IDENTITY,
	EmployeeName varchar(100) NOT NULL,
	EmployeeGender bit,    -- 1 for male, 0 for female
	EmployeeBirthDate DATE, 
	EmployeeAddress varchar(100),
	EmployeePhone varchar(100),
	EmployeeRole varchar(100) NOT NULL,
	EmployeeSalary DECIMAL(10,3) NOT NULL
	CONSTRAINT "PK_Employees"	PRIMARY KEY  CLUSTERED (EmployeeID)
	--@TODO: create EmployeeWorkHour with the data type ("from %d to %d", start,finish) ?
) 
GO

CREATE TABLE Storage (
	ProductID INT  NOT NULL IDENTITY,
	ProductName varchar(100) NOT NULL,
	ProductQuantity INT,
	ProductDate DATE
	CONSTRAINT "PK_Storage"	PRIMARY KEY  CLUSTERED (ProductID)
)

CREATE TABLE Suppliers (
	SupplierID INT  NOT NULL IDENTITY,
	SupplierName varchar(100) NOT NULL,
	SupplierAddress varchar(100),
	SupplierPhone varchar(100),
	ProductID INT
	CONSTRAINT "PK_Suppliers"	PRIMARY KEY  CLUSTERED (SupplierID)
)
GO

CREATE TABLE Orders (
	OrderID INT NOT NULL IDENTITY,
	FoodID INT NOT NULL,
	TableID INT,
	CustomerID INT,
	EmployeeID INT
	CONSTRAINT "PK_Orders"	PRIMARY KEY  CLUSTERED (OrderID)
)
GO

CREATE TABLE Deliveries (
	DeliveryID INT  NOT NULL IDENTITY,
	FoodID INT NOT NULL,
	DeliveryAddress varchar(100),
	DeliveryDate DATE,
	CustomerID INT,
	EmployeeID INT
	CONSTRAINT "PK_Deliveries"	PRIMARY KEY  CLUSTERED (DeliveryID)
)
GO

CREATE TABLE Takeaways (
	TakeawayID INT NOT NULL IDENTITY,
	FoodID INT NOT NULL,
	CustomerID INT,
	EmployeeID INT
	CONSTRAINT "PK_TakeawayID" PRIMARY KEY  CLUSTERED (TakeawayID)
)
GO

CREATE TABLE Foods (
	FoodID INT  NOT NULL IDENTITY,  
	FoodName varchar(200) NOT NULL,
	FoodCategories varchar(200) NOT NULL,
	FoodPrice DECIMAL(10,3) NOT NULL
	CONSTRAINT "PK_Foods"	PRIMARY KEY  CLUSTERED (FoodID)
)
GO

CREATE TABLE Tables (
	TableID INT NOT NULL IDENTITY,
	Seats INT,
	FloorNumber INT
	CONSTRAINT "PK_Tables"	PRIMARY KEY  CLUSTERED (TableID)
)
GO

CREATE TABLE Customers (
	CustomerID INT NOT NULL IDENTITY,
	CustomerName nvarchar(100) NOT NULL,
	CustomerGender bit,	-- 1 for male, 0 for female
	CustomerBirthDate DATE,
	CustomerAddress varchar(100),
	CustomerPhone varchar(100)
	--CONSTRAINT "CK_Birthdate" CHECK (CustomerBirthDate < getdate())
	CONSTRAINT "PK_Customers"	PRIMARY KEY  CLUSTERED (CustomerID)
)
GO

-- ADD FOREIGN KEYS SECTION:

ALTER TABLE Suppliers
ADD CONSTRAINT "FK_Suppliers_Storage" FOREIGN KEY (ProductID) REFERENCES Storage (ProductID)
GO

ALTER TABLE Orders
ADD CONSTRAINT "FK_Orders_Foods" FOREIGN KEY (FoodID) REFERENCES Foods (FoodID)
GO

ALTER TABLE Orders
ADD CONSTRAINT "FK_Orders_Tables" FOREIGN KEY (TableID) REFERENCES Tables (TableID)
GO

ALTER TABLE Orders
  ADD CONSTRAINT "FK_Orders_Customers"	FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
GO

ALTER TABLE Orders
  ADD CONSTRAINT "FK_Orders_Employees"	FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
GO

ALTER TABLE Deliveries
ADD CONSTRAINT "FK_Deliveries_Foods" FOREIGN KEY (FoodID) REFERENCES Foods (FoodID)
GO

ALTER TABLE Deliveries
ADD CONSTRAINT "FK_Deliveries_Customers" FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
GO

ALTER TABLE Deliveries
ADD CONSTRAINT "FK_Deliveries_Employees" FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
GO

ALTER TABLE Takeaways
ADD CONSTRAINT "FK_Takeaways_Foods" FOREIGN KEY (FoodID) REFERENCES Foods (FoodID)
GO

ALTER TABLE Takeaways
ADD CONSTRAINT "FK_Takeaways_Customers" FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
GO

ALTER TABLE Takeaways
ADD CONSTRAINT "FK_Takeaways_Employees" FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
GO

---- Insert values section:

INSERT INTO Employees (EmployeeName, EmployeeGender, EmployeeBirthDate,	EmployeeAddress, EmployeePhone, EmployeeRole, EmployeeSalary)
VALUES  
	('Snoopy', 1, '1-1-1991', '100 East 35th Street', '555-1234', 'Chef', '1000.0'),
	('Schroeder', 1, '2-2-1992', 'Massachusetts', '555-9876', 'Manager', '1000.0'),
	('Henry', 1, '3-3-1993', 'Somewhere in Michigan', '555-1111', 'Waiter', '1000.0'),
	('Charlie', 1, '4-4-1994', 'Manhattan', '555-5556', 'Shipper', '500.0')
GO

INSERT INTO Storage (ProductName, ProductQuantity, ProductDate)
VALUES
	('Tomato', 100, '1-1-2018'),
	('Chicken', 100, '5-1-2018'),
	('Bread', 100, '5-1-2018')
GO

INSERT INTO Suppliers (SupplierName, SupplierAddress, SupplierPhone, ProductID)
VALUES
	('Steep Farm', 'East Coast', '555-0101', 1),
	('Fresh Garden', 'California', '555-0909', 1)
GO

INSERT INTO Foods (FoodName, FoodCategories, FoodPrice)
VALUES
	('Classic Burrito', 'Burritos', 10.79),
	('Grilled California Burrito', 'Burritos', 11.99),
	('Grilled Fish Tacos', 'Tacos', 10.49),
	('Shrimp Tacos', 'Tacos', 11.49),
	('Street-Style Mini Tacos', 'Tacos', 10.49)
GO

INSERT INTO Tables (Seats, FloorNumber)
VALUES
	(2, 1),
	(2, 1),
	(4, 1),
	(4, 1),
	(4, 1),
	(4, 2),
	(4, 2),
	(6, 2)
GO

INSERT INTO Customers (CustomerName, CustomerGender, CustomerAddress, CustomerPhone)
VALUES
	('Mr. Brown',    1, 'Brooklyn',       '555-0009'),
	('John Smith',   1, 'Times Square',   '555-9999'),
	('Kim Possible', 0, 'Mexican Border', '555-5555')
GO
