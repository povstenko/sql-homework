--1
USE SalesOrders;

;WITH REDUCEPRICE
AS
	(
		SELECT PRODUCTNUMBER, PRODUCTNAME, PRODUCTDESCRIPTION, RETAILPRICE-(RETAILPRICE*2/10) AS PRICE, QUANTITYONHAND, CATEGORYID
		FROM PRODUCTS
		WHERE PRODUCTNAME LIKE '%bike%'
		AND RETAILPRICE > 1500
		AND QUANTITYONHAND < 10
	)
SELECT * FROM REDUCEPRICE;





--2
CREATE DATABASE ParisToulouse;
USE ParisToulouse;

CREATE TABLE Cities
(
	CitySrc NVARCHAR(255) NOT NULL,
	CityDest NVARCHAR(255) NOT NULL,
	Distance INT NOT NULL
)

INSERT INTO Cities(CitySrc, CityDest, Distance)
VALUES
('Paris', 'Nantes', 385),
('Paris', 'Clermont Ferrand', 420),
('Paris', 'Lyon', 470),
('Clermont Ferrand', 'Toulouse', 375),
('Clermont Ferrand', 'Montpellier', 335),
('Lyon', 'Montpellier', 305),
('Lyon', 'Marseille', 320),
('Montpellier', 'Toulouse', 240),
('Marseille', 'Nice', 205)

SELECT * FROM Cities;

DROP FUNCTION RoadList;

GO
CREATE FUNCTION RoadList(@road NVARCHAR(255), @city NVARCHAR(255))
RETURNS NVARCHAR(255) 
AS BEGIN
	RETURN @road + ', ' + @city
END
GO

WITH ParisTrip AS
(
	SELECT Road = dbo.RoadList(CitySrc, CityDest), CitySrc, CityDest, Distance, TotalDist = Distance
	FROM Cities
	WHERE CitySrc = 'Paris'
	UNION ALL
	SELECT dbo.RoadList(pt.Road, c.CityDest), c.CitySrc, c.CityDest, c.Distance, pt.TotalDist + c.Distance
	FROM Cities c
	INNER JOIN ParisTrip pt
	ON pt.CityDest = c.CitySrc
)
SELECT Road, TotalDist
FROM ParisTrip 
WHERE Road LIKE 'Paris%Toulouse';




--3
USE AdventureWorks2012;

GO
IF OBJECT_ID('GetLastWeekOrders') IS NOT NULL
DROP FUNCTION GetLastWeekOrders;

GO
CREATE FUNCTION GetLastWeekOrders (@datefrom DATE)
RETURNS TABLE
AS
RETURN (
	SELECT sod.SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, UnitPrice, LineTotal, OrderDate, CustomerID, TerritoryID
	FROM Sales.SalesOrderDetail AS sod
	INNER JOIN Sales.SalesOrderHeader AS soh
	ON sod.SalesOrderID = soh.SalesOrderID
	WHERE OrderDate >= DATEADD(WEEk, -1,@datefrom)
)
GO

SELECT * FROM GetLastWeekOrders(GETDATE()) ORDER BY OrderDate
SELECT * FROM GetLastWeekOrders('2014-06-30') ORDER BY OrderDate





--4
USE AdventureWorks2012;

IF OBJECT_ID('Birthday') IS NOT NULL
DROP PROCEDURE Birthday;


GO
CREATE PROCEDURE Birthday
AS
	SELECT * FROM HumanResources.Employee e
	--LEFT JOIN Sales.vIndividualCustomer c
	--ON e.BusinessEntityID = c.BusinessEntityID
	WHERE DAY(BirthDate) = DAY(GETDATE())
	AND MONTH(BirthDate) = MONTH(GETDATE())
GO

EXEC Birthday