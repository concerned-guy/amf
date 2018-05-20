USE amf
GO




-- 1st Example
-- When Customer Ordered Food From Menu
INSERT INTO Orders (FoodID, TableID, CustomerID, EmployeeID)
VALUES
	(1 -- Classic Burrito
	,1 -- Two-seated table on the 1st floor
	,1 -- Mr. Brown, a frequent customer of the restaurant
	,3 -- Henry the Waiter
	)
GO

-- View Result
SELECT OrderID, TableID, FoodName, CustomerName, CustomerAddress, EmployeeName, EmployeeRole
FROM Orders
INNER JOIN Foods ON Orders.FoodID = Foods.FoodID
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GO







-- 2nd Example
-- When Customer Order Food From a Place Far Away
INSERT INTO Deliveries (FoodID, DeliveryAddress, DeliveryDate, CustomerID, EmployeeID)
VALUES
	(3              -- Grilled Fish Tacos
	,'Times Square' -- Delivery Address
	,'2018-4-26'    -- Deliver now
	,2              -- A guy who identifies himself as John Smith, and often orders foods shipped to Times Square
	,4              -- Linus the Shipper
	)
GO

-- View Result
SELECT DeliveryID, DeliveryAddress, DeliveryDate, FoodName, CustomerName, CustomerAddress, EmployeeName, EmployeeRole
FROM Deliveries
INNER JOIN Foods ON Deliveries.FoodID = Foods.FoodID
INNER JOIN Customers ON Deliveries.CustomerID = Customers.CustomerID
INNER JOIN Employees ON Deliveries.EmployeeID = Employees.EmployeeID
GO







-- 3rd Example
-- When a Customer Order Food To Be Taken Away
INSERT INTO Takeaways (FoodID, CustomerID, EmployeeID)
VALUES
	(5 -- Street-Style Mini Tacos
	,3 -- Kim, who lives at the Mexican Border, now on her holiday in New York
	,3 -- Henry the Waiter, again
	)
GO

-- View Result
SELECT TakeawayID, FoodName, CustomerName, CustomerAddress, EmployeeName, EmployeeRole
FROM Takeaways
INNER JOIN Foods ON Takeaways.FoodID = Foods.FoodID
INNER JOIN Customers ON Takeaways.CustomerID = Customers.CustomerID
INNER JOIN Employees ON Takeaways.EmployeeID = Employees.EmployeeID
GO