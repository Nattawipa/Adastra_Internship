USE AdventureWorks2019

-- exercise 1

WITH Sales_CTE (SalesPersonID, NumberOfOrders) 
AS 
( 
	SELECT SalesPersonID, COUNT(*) 
	FROM Sales.SalesOrderHeader 
	WHERE SalesPersonID IS NOT NULL 
	GROUP BY SalesPersonID 
) 
SELECT AVG(NumberOfOrders) AS AverageSalesPerPerson
FROM Sales_CTE;

-- exercise 2

SELECT YEAR(OrderDate) AS Year, 
	   SalesPersonID,
	   COUNT(SalesOrderID) AS SalesPersonTotalOrders
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY YEAR(OrderDate), SalesPersonID

-- exercise 3

CREATE TABLE #table1
(
	OrderDate DATE,
	SalesOrderID INT
)

CREATE TABLE #table2
(
	OrderDate DATE,
	SalesPersonID INT,
	SalesOrderID INT
)