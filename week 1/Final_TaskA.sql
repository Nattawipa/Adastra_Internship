USE AdventureWorks2019
GO

-- 1. How many salespersons has bonus less than 5,000.00 Sales.SalesPerson?

SELECT SUM(BusinessEntityID) AS Total_Salespersons 
FROM Sales.SalesPerson
WHERE Bonus < 5000.00

-- 2. How many salespersons in the list of TerritoryID equals to 4?

SELECT SUM(BusinessEntityID) AS Total_Salespersons 
FROM Sales.SalesPerson
WHERE TerritoryID = 4

-- 3. How many salespersons records that have been modified on 2011-05-24?

SELECT SUM(BusinessEntityID) AS Total_Salespersons 
FROM Sales.SalesPerson
WHERE ModifiedDate = '2011-05-24'

-- 4. On product table (Production.Product), create an analytic query against it by color with the following statistics functions 
-- Sum, Count, Average, Minimum, Maximum and Standard Deviation. Also, filter the non-color products out of this list.
-- Note: Find the aggregation from StandardCost column.

SELECT SUM(StandardCost) AS Sum_StandardCost, 
	   Count(StandardCost) AS Count_StandardCost, 
	   AVG(StandardCost) AS Avg_StandardCost, 
	   MIN(StandardCost) AS Min_StandardCost, 
	   MAX(StandardCost) AS Max_StandardCost,
	   STDEV (StandardCost) AS Std_StandardCost
FROM Production.Product

---- 4.1. How can we find the product color with the average that less than or equal to 500?

SELECT Color
FROM Production.Product
GROUP BY Color, StandardCost
HAVING AVG(StandardCost) <= 500

-- 5. Create a SQL script that list the employee in the following order of columns: JobTitle, FirstName and LastName.
-- Join Hint: HumanResources.Employee and Person.Person

SELECT JobTitle, FirstName, LastName
FROM HumanResources.Employee
JOIN Person.Person ON HumanResources.Employee.BusinessEntityID = Person.Person.BusinessEntityID

-- 6. 2 tables contain the information of vendors (Purchasing.Vendor) and vendor’s product (Purchasing.ProductVendor)
---- 6.1. How many rows that vendor contains no products?

SELECT BusinessEntityID FROM Purchasing.Vendor
UNION 
SELECT BusinessEntityID FROM Purchasing.ProductVendor
ORDER BY BusinessEntityID


SELECT COUNT(Purchasing.Vendor.BusinessEntityID) AS Total_Vendor
FROM Purchasing.Vendor
JOIN Purchasing.ProductVendor ON Purchasing.ProductVendor.BusinessEntityID = Purchasing.Vendor.BusinessEntityID
WHERE Purchasing.ProductVendor.ProductID IS NULL

---- 6.2. What methodology to achieve that?
-- Answer: I used 2 methods, firstly I check vendor rows it has 104 rows and then I made a union check between 2 table 
-- because Purchasing.ProductVendor it contains only the vendor that have a product based on ProductID, 
-- and it is show that number of rows is 104 that the same means that all vendor contains a product.
-- To re-check by second method, I check by normal query sum from BusinessEntityID join between 2 tables 
-- and search from a condition that if ProductID is null means no product as a result is zero.

-- 7. Create a SQL script that lookup for the customer in ‘Germany’ who did not use credit card.
-- Hint: Sales.Customer, Sales.SalesTerritory and Sales.PersonCreditCard

SELECT COUNT(Sales.PersonCreditCard.CreditCardID) AS No_CreditCard
FROM Sales.Customer
JOIN Sales.SalesTerritory ON Sales.Customer.TerritoryID = Sales.SalesTerritory.TerritoryID
JOIN Sales.PersonCreditCard ON Sales.PersonCreditCard.ModifiedDate = Sales.SalesTerritory.ModifiedDate
WHERE Sales.SalesTerritory.Name = 'Germany' AND Sales.PersonCreditCard.CreditCardID IS NULL

-- 8. Create a SQL script that find the maximum or UnitPrice of each SalesOrderID and OrderDate
-- Hint: Sales.SalesOrderHeader and Sales.SalesOrderDetail

SELECT Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderHeader.OrderDate, MAX(Sales.SalesOrderDetail.UnitPrice) AS Max_UnitPrice
FROM Sales.SalesOrderHeader 
JOIN Sales.SalesOrderDetail ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID 
GROUP BY Sales.SalesOrderHeader.SalesOrderID, Sales.SalesOrderHeader.OrderDate

-- 9. Sales and Commission analysis:
-- AdventureWork Limited need to analyze the sales and commission of the salesperson as the following criteria:
-- Output Column: 
-- Subcategory, Salesperson name (First name and Last name with space in between), 
-- NetSales (Must be calculated by UnitPrice x OrderQty) with the deducted tax of 3%, 
-- SalesCommission (Use NetSales with the following condition: 
-- (1) If the subcategory contains Bikes, the commission is 15% 
-- (2) If the subcategory is ‘Locks’ then no commission and 
-- (3) Other subcategory must be 10%

/*
SELECT Production.ProductSubcategory.Name AS Subcategory,
	   CONCAT(Person.Person.FirstName,' ',Person.Person.LastName) AS SalesPerson_Name, 
	   (sod.UnitPrice * sod.OrderQty) AS Net,
	   (3 * (sod.UnitPrice * sod.OrderQty)) / 100 AS Tax,
	   ((sod.UnitPrice * sod.OrderQty) - ((3 * (sod.UnitPrice * sod.OrderQty)) / 100)) AS NetSales,
	   CASE 
			WHEN Production.ProductSubcategory.Name LIKE '%Bikes%' THEN '15%'
			WHEN Production.ProductSubcategory.Name LIKE 'Locks' THEN '0%'
			ELSE '10%'
	   END AS SalesCommission_Percent,
	   CASE 
			WHEN Production.ProductSubcategory.Name LIKE '%Bikes%' THEN (15 * (sod.UnitPrice * sod.OrderQty)) / 100
			WHEN Production.ProductSubcategory.Name LIKE 'Locks' THEN (0 * (sod.UnitPrice * sod.OrderQty)) / 100
			ELSE (10 * (sod.UnitPrice * sod.OrderQty)) / 100
	   END AS SalesCommission
FROM Sales.SalesPerson 
JOIN Person.Person ON Person.Person.BusinessEntityID = Sales.SalesPerson.BusinessEntityID
JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.TerritoryID = Sales.SalesPerson.TerritoryID 
JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
JOIN Production.Product ON Production.Product.ProductID = sod.ProductID 
JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
ORDER BY Subcategory ASC, SalesCommission DESC
*/

---- 9.1. Create a SQL script from the condition above and must sort by Subcategory in ascending and SalesCommission from largest to least amount

SELECT Production.ProductSubcategory.Name AS Subcategory,
	   CONCAT(Person.Person.FirstName,' ',Person.Person.LastName) AS SalesPerson_Name, 
	   ((sod.UnitPrice * sod.OrderQty) - ((3 * (sod.UnitPrice * sod.OrderQty)) / 100)) AS NetSales,
	   CASE 
			WHEN Production.ProductSubcategory.Name LIKE '%Bikes%' THEN (15 * (sod.UnitPrice * sod.OrderQty)) / 100
			WHEN Production.ProductSubcategory.Name LIKE 'Locks' THEN (0 * (sod.UnitPrice * sod.OrderQty)) / 100
			ELSE (10 * (sod.UnitPrice * sod.OrderQty)) / 100
	   END AS SalesCommission
FROM Sales.SalesPerson 
JOIN Person.Person ON Person.Person.BusinessEntityID = Sales.SalesPerson.BusinessEntityID
JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.TerritoryID = Sales.SalesPerson.TerritoryID 
JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
JOIN Production.Product ON Production.Product.ProductID = sod.ProductID 
JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
ORDER BY Subcategory ASC, SalesCommission DESC

---- 9.2. Create a summary from above with CTE or Derived table by sum only sales commission of each salesperson with the TotalCommission 
---- greater than 25,000 and sort by TotalCommission in descending

;WITH cte 
AS
(
	SELECT Production.ProductSubcategory.Name AS Subcategory,
		   CONCAT(Person.Person.FirstName,' ',Person.Person.LastName) AS SalesPerson_Name, 
	       ((sod.UnitPrice * sod.OrderQty) - ((3 * (sod.UnitPrice * sod.OrderQty)) / 100)) AS NetSales,
		   CASE 
				WHEN Production.ProductSubcategory.Name LIKE '%Bikes%' THEN (15 * (sod.UnitPrice * sod.OrderQty)) / 100
				WHEN Production.ProductSubcategory.Name LIKE 'Locks' THEN (0 * (sod.UnitPrice * sod.OrderQty)) / 100
				ELSE (10 * (sod.UnitPrice * sod.OrderQty)) / 100
			END AS SalesCommission
	FROM Sales.SalesPerson 
	JOIN Person.Person ON Person.Person.BusinessEntityID = Sales.SalesPerson.BusinessEntityID
	JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.TerritoryID = Sales.SalesPerson.TerritoryID 
	JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
	JOIN Production.Product ON Production.Product.ProductID = sod.ProductID 
	JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
),
cte2 
AS
(
	SELECT SalesPerson_Name, Sum(SalesCommission) AS TotalCommission 
	FROM cte
	GROUP BY SalesPerson_Name
)

SELECT * FROM cte2
WHERE TotalCommission > 25000
ORDER BY TotalCommission DESC





