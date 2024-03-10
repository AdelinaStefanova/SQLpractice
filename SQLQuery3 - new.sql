 
CREATE TABLE dbo.Data
(
    OrderID   INT IDENTITY(1,1),
    OrderDate DATETIME2
);
 
INSERT dbo.Data(OrderDate) VALUES
 ('20110630 23:59:59.9999999'),
 ('20110730 15:32:00.0000000'),
 ('20110730 23:59:59.9999999'),
 ('20110731 00:00:00.0000000'),
 ('20110731 23:59:59.9999999'),
 ('20110801 00:00:00.0000000');

 SELECT Orderid, OrderDate
 FROM dbo.Data
 WHERE OrderDate BETWEEN '20110701' AND '20110731';

  SELECT Orderid, OrderDate
 FROM dbo.Data
 WHERE OrderDate >= '20110701' AND OrderDate < '20110801';

 SELECT OrderID, OrderDate
 FROM dbo.Data
 WHERE CONVERT(SMALLDATETIME, OrderDate)
 BETWEEN '20110701' AND '20110731';

  SELECT OrderID, OrderDate, CONVERT(SMALLDATETIME, OrderDate) AS c
 FROM dbo.Data
 WHERE CONVERT(SMALLDATETIME, OrderDate)
 BETWEEN '20110701' AND '20110731';

 SELECT COUNT(*) AS numorderlines, SUM(qty*unitprice) AS totalsales
FROM Sales.OrderDetails;

SELECT TOP(5) productid, productname, unitprice,
RANK() OVER(ORDER BY unitprice DESC) AS rankbyprice
FROM Production.Products
ORDER BY rankbyprice;

SELECT CAST(SYSDATETIME() AS DATE) AS [current_date];




SELECT DB_NAME() AS [Current Database];

SELECT COUNT (*) AS numorders, SUM(unitprice) AS totalsales
FROM Sales.OrderDetails

SELECT productid, productname, unitprice,
RANK() OVER(ORDER BY unitprice DESC) AS rankbyprice
FROM Production.Products
ORDER BY rankbyprice;


SELECT productid, productname, unitprice,
DENSE_RANK() OVER(ORDER BY unitprice DESC) AS rankbyprice
FROM Production.Products
ORDER BY rankbyprice;


SELECT productid, productname, unitprice,
NTILE(5) OVER(ORDER BY unitprice DESC) AS rankbyprice
FROM Production.Products
ORDER BY rankbyprice;

SELECT productid, unitprice,
IIF(unitprice > 50, 'high','low') AS pricepoint
FROM Production.Products
ORDER BY unitprice


SELECT CHOOSE (3, 'Beverages', 'Condiments', 'Confections') AS choose_result;



DECLARE @Name nvarchar(50) = 'XY14822';
DECLARE @DiscountinuedDate datetime = '12/4/2012';

SELECT ISDATE(@Name) AS NameISDATE,
ISDATE(@DiscountinuedDate) AS DiscontinuedDateISDATE;
GO


DECLARE @Name nvarchar(50) = 'XY14822';
DECLARE @DiscountinuedDate datetime = '12/4/2012';
DECLARE @DaysToManufacture int = 100;

SELECT ISNUMERIC(@Name) AS NameISNUMERIC,
ISNUMERIC(@DiscountinuedDate) AS DiscontinuedDateISNUMERIC,
ISNUMERIC(@DaysToManufacture) AS DaysToManufactureISNUMERIC;
GO

SELECT productid, unitprice,
CASE 
WHEN unitprice > 50 THEN 'higt'
WHEN unitprice < 50 THEN 'low'
ELSE 'Who knows'
END
AS 'pricepoint'
FROM Production.Products

IF OBJECT_ID('HR.Employees') IS NULL
BEGIN
PRINT 'The specified object does not exist';
END
ELSE
BEGIN
 PRINT 'The specified object exist';
 END


 SELECT custid, city, ISNULL(region, 'N/A') AS region, country
FROM Sales.Customers
ORDER BY region;

SELECT custid, country, region, city,
country + ',' + COALESCE(region, ' ') + ', ' + city aslocation
FROM Sales.Customers
ORDER BY region;

SELECT custid, country, region, city,
country + ', ' + COALESCE(region + ', ', '') + city aslocation
FROM Sales.Customers
ORDER BY region

CREATE TABLE dbo.employee_goals(emp_id INT , goal int , actual int);
GO

INSERT INTO dbo.employee_goals
VALUES(1,100,110), (2,90,90) , (3,100,90) , (4,100,80);

SELECT emp_id, goal, actual
FROM dbo.employee_goals;


SELECT  emp_id, NULLIF(actual, goal) AS actual_if_different
FROM dbo.employee_goals;
GO;
GO

CREATE VIEW HR.getFullNames
AS
SELECT empid, firstname + N' ' + lastname as fullname
FROM HR.Employees;
GO

SELECT empid, fullname
FROM HR.getFullNames
WHERE empid=3
GO

CREATE VIEW Sales.fullOrderDetails
AS
SELECT o.orderid, o.orderdate, od.productid, od.unitprice, od.qty
FROM Sales.Orders AS o
JOIN Sales.OrderDetails AS od
ON o.orderid=od.orderid
GO

SELECT orderid, orderdate, productid, unitprice, qty
FROM Sales.fullOrderDetails
ORDER BY qty
GO

CREATE VIEW Sales.employeeSalesByYear
AS
SELECT empid, YEAR(orderdate) AS orderyear,
COUNT(custid) AS all_custs,
COUNT(DISTINCT custid) AS unique_custs
FROM Sales.Orders
GROUP BY empid, YEAR(orderdate)
GO

SELECT empid, orderyear, all_custs, unique_custs
FROM Sales.employeeSalesByYear
WHERE orderyear=2006



SELECT empid, orderyear, all_custs, unique_custs
FROM Sales.employeeSalesByYear
WHERE empid=1

SELECT orderid, orderdate, custid
FROM Sales.Orders
WHERE custid IN (
SELECT custid
FROM Sales.Customers
WHERE city = 'London')

ORDER BY orderdate DESC

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O1
WHERE orderid =
(SELECT MAX(O2.orderid)
FROM Sales.Orders AS O2
WHERE O2.custid = O1.custid)
ORDER BY custid

GO


DECLARE @maxid AS INT = (
	SELECT MAX(orderid)
	FROM Sales.Orders
);

SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderid = @maxid;
GO

DECLARE @maxid AS INT = (
	SELECT MAX(orderid)
	FROM Sales.Orders
);

SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderid = (
SELECT MAX(O.Orderid)
FROM Sales.Orders AS O
);
GO

SELECT orderid
FROM Sales.Orders
WHERE empid = (

SELECT E.empid
FROM HR.Employees AS E
WHERE E.lastname LIKE N'B%'
);




SELECT orderid
FROM Sales.Orders
WHERE empid = (

SELECT E.empid
FROM HR.Employees AS E
WHERE E.lastname LIKE N'D%'
);



SELECT orderid
FROM Sales.Orders
WHERE empid = (

SELECT TOP 1 E.empid
FROM HR.Employees AS E
WHERE E.lastname LIKE N'D%'
);



SELECT orderid
FROM Sales.Orders
WHERE empid = (

SELECT E.empid
FROM HR.Employees AS E
WHERE E.lastname LIKE N'A%'
);



SELECT orderid
FROM Sales.Orders
WHERE empid IN (

SELECT E.empid
FROM HR.Employees AS E
WHERE E.lastname LIKE N'D%'
);

SELECT O.orderid
FROM HR.Employees AS E
JOIN Sales.Orders AS O
ON E.empid = O.empid
WHERE E.lastname LIKE  N'D%';



SELECT custid,orderid, orderdate,empid
FROM Sales.Orders
WHERE custid IN(
SELECT C.custid
FROM Sales.Customers AS C
WHERE C.country = N'UK'
)
AND empid IN(
SELECT E.empid
FROM HR.Employees AS E
WHERE E.country = N'UK'
)



SELECT o.custid,o.orderid, o.orderdate,o.empid
FROM Sales.Orders AS o
JOIN Sales.Customers AS c
ON o.custid = c.custid
JOIN HR.Employees AS e
ON o.empid = e.empid
WHERE c.country = N'UK' AND e.country = N'UK'



SELECT custid,companyname
FROM Sales.Customers
WHERE custid NOT IN (
SELECT O.custid
FROM Sales.Orders AS O
)
ORDER BY  custid



SELECT custid,companyname
FROM Sales.Customers
WHERE custid  IN (
SELECT O.custid
FROM Sales.Orders AS O
)
ORDER BY  custid
GO


CREATE VIEW totalSumPerOrders AS
SELECT O.orderid, O.custid, SUM(OD.unitprice*OD.qty) AS total
FROM Sales.Orders AS O
JOIN Sales.OrderDetails AS OD
ON O.orderid=OD.orderid
GROUP BY O.orderid, O.custid
GO
SELECT orderid, custid, total,
CAST(100*total/(
SELECT SUM(TS2.total)
FROM totalSumPerOrders AS TS2
WHERE TS2.custid=TS1.custid
)
AS NUMERIC(5,2)) AS pct
FROM totalSumPerOrders AS TS1
ORDER BY custid, orderid;

GO

SELECT  custid, companyname
FROM Sales.Customers AS C
WHERE  country = N'Spain'
AND EXISTS(
SELECT * FROM Sales.Orders AS O
WHERE O.custid=C.custid
);
GO
SELECT custid,companyname
FROM Sales.Customers AS C
WHERE country = N'Spain'
AND NOT EXISTS(
SELECT * FROM Sales.Orders AS O
WHERE O.custid= C.custid
);


go
SELECT orderid,orderdate, empid, custid,
(
SELECT MAX(O2.orderid)
FROM Sales.Orders AS O2
WHERE O2.orderid<O1.orderid
) AS prevorderid
FROM Sales.Orders AS O1
ORDER BY prevorderid;
GO
SELECT orderid, orderdate, empid, custid,
(
SELECT MAX(O2.orderid)
FROM Sales.Orders AS O2
WHERE O2.orderid<O1.orderid
AND O2.custid = O1.custid
)AS prevorderid
FROM Sales.Orders AS O1
ORDER BY prevorderid;

GO

CREATE VIEW Sales.qtyPerYear
AS SELECT YEAR(O.orderdate) AS orderyear, SUM(OD.qty) AS qty
FROM Sales.Orders AS O
JOIN Sales.OrderDetails AS OD ON OD.orderid = O.orderid
GROUP BY YEAR(orderdate);
GO
SELECT orderyear, qty, (SELECT SUM(Q2.qty)
                        FROM Sales.qtyPerYear AS Q2
						WHERE Q2.orderyear<=Q1.orderyear)
						AS aggregateqty
FROM Sales.qtyPerYear AS Q1
ORDER BY orderyear




