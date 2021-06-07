USE AdventureWorks2019

-- exercise 1

SELECT p.Name AS ProductName,
	   NonDiscountSales = (OrderQty * UnitPrice),
	   Discounts = ((OrderQty * UnitPrice) * UnitPriceDiscount)
FROM Production.Product AS p
INNER JOIN Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
ORDER BY ProductName DESC;

-- exercise 2

SELECT DISTINCT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle;

-- without DISTINCT

SELECT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle;

-- exercise 3

SELECT JobTitle, SUM(VacationHours) AS TotalVacationHours
FROM HumanResources.Employee
WHERE Gender = 'M'
GROUP BY JobTitle


-- exercise 4

SELECT Ord.SalesOrderID, Ord.OrderDate,
	(
		SELECT MAX(OrdDet.UnitPrice)
		FROM Sales.SalesOrderDetail AS OrdDet
		WHERE Ord.SalesOrderID = OrdDet.SalesOrderID
	) AS MaxUnitPrice
FROM Sales.SalesOrderHeader AS Ord;

-- exercise 5

DECLARE @mytbl2 TABLE
( 
	c1 VARCHAR(50) 
);
INSERT @mytbl2 VALUES ('Discount is 10-15% off'), ('Discount is .10-.15 off');

SELECT *
FROM @mytbl2 m
WHERE m.c1 like '%!%%' ESCAPE '!'

-- exercise 6

SELECT SalesOrderID, UnitPrice
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID, UnitPrice
HAVING COUNT(SalesOrderID) = 1

-- exercise 7 ---- 

SELECT Production.ProductSubcategory.ProductSubcategoryID AS ProductID, COUNT(Sales.SalesOrderHeader.rowguid) AS OrderQty
FROM Person.Address
JOIN Sales.SalesOrderHeader ON Sales.SalesOrderHeader.ShipToAddressID = Person.Address.AddressID 
JOIN Production.ProductSubcategory ON Production.ProductSubcategory.rowguid = Person.Address.rowguid
WHERE City = 'London' AND Production.ProductSubcategory.Name = 'Cranksets' 
GROUP BY Production.ProductSubcategory.ProductSubcategoryID, Sales.SalesOrderHeader.rowguid

-- exercise 8

SELECT CONCAT(pp.FirstName,' ', pp.LastName) AS EmployeeName,
	   JobTitle,
	   BirthDate,
	   DATENAME(DW,GETDATE()) AS  WeekDayofBirth,
	   CASE
			WHEN  YEAR(GETDATE()) < 1960 THEN 'The Oldest'
			WHEN  YEAR(GETDATE()) < 1970 THEN '60s'
			WHEN  YEAR(GETDATE()) < 1980 THEN '70s'
			WHEN  YEAR(GETDATE()) < 1990 THEN '80s'
			ELSE 'The Newborns'
	   END AS AgeGroup
FROM Person.Person AS pp 
JOIN HumanResources.Employee he ON he.BusinessEntityID = pp.BusinessEntityID
ORDER BY AgeGroup , WeekDayofBirth




