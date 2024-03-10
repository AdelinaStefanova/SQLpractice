SELECT productname, categoryname, description
FROM Production.Products AS PO
INNER JOIN Production.Categories AS PC
ON PO.categoryid = PC.categoryid;


SELECT productname, categoryname, description
FROM Production.Products AS PO, Production.Categories AS PC
WHERE PO.categoryid = PC.categoryid;

SELECT c.custid, c.contactname, o.orderid, o.orderdate
FROM Sales.Customers AS C 
LEFT OUTER JOIN Sales.Orders AS O
	ON c.custid = o.custid;

SELECT c.custid, c.contactname, o.orderid, o.orderdate
FROM Sales.Customers AS C LEFT OUTER JOIN Sales.Orders AS O
	ON c.custid = o.custid
WHERE o.orderid IS NULL;

SELECT c.companyname, o.orderdate
FROM Sales.Customers AS C JOIN Sales.Orders AS O
ON C.custid = O.custid;


SELECT C.companyname, O.orderdate
FROM Sales.Customers AS C JOIN Sales.Orders AS O
ON C.custid = O.custid;

SELECT [companyname], [orderdate]
FROM [Sales].[Customers] AS C JOIN [Sales].[Orders] AS O
ON C.custid = O.custid;

SELECT DISTINCT e.city, e.country
FROM [Sales].[Customers] AS C JOIN [HR].[Employees] AS E
ON C.city = E.city AND C.country = E.country;

SELECT e.city, e.country
FROM [Sales].[Customers] AS C JOIN [HR].[Employees] AS E
ON C.city = E.city AND C.country = E.country;

SELECT c.custid, c.companyname, o.orderid, o.orderdate,
od.productid, od.qty
FROM Sales.Customers AS c
JOIN Sales.Orders AS o
ON c.custid = o.custid
JOIN Sales.OrderDetails od
On o.orderid = od.orderid
JOIN Production.Products AS pp
ON pp.productid = od.productid;


SELECT c.custid, c.companyname, o.orderid, o.orderdate, od.productid, od.qty
FROM Sales.Customers AS c
JOIN Sales.Orders AS o
ON c.custid = o.custid
JOIN Sales.OrderDetails AS od
ON o.orderid = od.orderid
JOIN Production.Products AS pp
ON pp.productid = od.productid;

SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o
ON c.custid = o. custid;

SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o
ON c.custid = o. custid
WHERE o.custid IS NULL;

SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
RIGHT OUTER JOIN Sales.Orders AS o
ON c.custid = o. custid;

SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers AS c
FULL JOIN Sales.Orders AS o
ON c.custid = o. custid;

SELECT e1.firstname, e2.lastname
FROM HR.Employees AS e1 CROSS JOIN HR.Employees AS e2;


SELECT e.empid, e.lastname AS empname, e.title, e.mgrid, e.lastname AS mgrname
FROM HR.Employees AS e JOIN HR.Employees AS m
ON e.mgrid = m.empid


SELECT e.empid, e.lastname AS empname, e.title, e.mgrid, e.lastname AS mgrname
FROM HR.Employees AS e JOIN HR.Employees AS m
ON e.mgrid = m.empid


SELECT e.empid, e.lastname AS empname, e.title, e.mgrid, e.lastname AS mgrname
FROM HR.Employees AS e JOIN HR.Employees AS m
ON e.mgrid = m.empid



SELECT TOP (5) shipcity, shipregion
FROM Sales.Orders;



SELECT TOP (5) PERCENT shipcity, shipregion
FROM Sales.Orders;


SELECT TOP (10) WITH TIES shipcity, shipregion
FROM Sales.Orders
ORDER BY shipcity;


SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
ORDER BY orderdate, orderid DESC
OFFSET 0 ROWS FETCH FIRST 50 ROWS ONLY;


SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
ORDER BY orderdate, orderid DESC
OFFSET 50 ROWS FETCH NEXT 50 ROWS ONLY;


DECLARE @offval INT
SET @offval = 50
DECLARE @fetchval INT
SET @fetchval = 100
SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
ORDER BY orderdate, orderid DESC
OFFSET @offval ROWS FETCH NEXT @fetchval ROWS ONLY;


SELECT custid,city, region, country
FROM Sales.Customers
WHERE region IS NOT NULL;

SELECT COUNT (region)
FROM Sales.Customers;

SELECT region
FROM Sales.Customers
ORDER BY region DESC

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region <> N'WA';

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region = N'WA';


SELECT custid, country, region, city
FROM Sales.Customers
WHERE region <> N'WA' OR region IS NULL;


SELECT custid, country, region, city
FROM Sales.Customers
WHERE region IS NULL;

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region != NULL;

SELECT custid, country, region, city
FROM Sales.Customers 
WHERE region like 'NULL';

SELECT AVG(unitprice) AS avg_price,
MIN(qty)AS min_qty,
MAX(discount) AS max_discount
FROM Sales.OrderDetails;

SELECT empid, YEAR(orderdate) AS orderyear,
COUNT(custid) AS all_custs,
COUNT(DISTINCT custid) AS unique_custs
FROM Sales.Orders
GROUP BY empid, YEAR(orderdate);


--this will fail:
SELECT orderid, productid, AVG(unitprice) AS avg_price,
MIN(qty)AS min_qty,
MAX(discount) AS max_discount
FROM Sales.OrderDetails;


SELECT MIN (companyname) AS first_customer, MAX(companyname) AS last_customer
FROM Sales.Customers

--this will fail:
SELECT MIN (companyname) AS first_customer, MAX(companyname) AS last_customer, AVG(companyname) AS avg_customer
FROM Sales.Customers



SELECT MIN (orderdate) AS first_customer, MAX(orderdate) AS last_customer
FROM Sales.Orders

--this will fail:
SELECT MIN (orderdate) AS first_customer, MAX(orderdate) AS last_customer,AVG(orderdate) AS avg_orderdate
FROM Sales.Orders


SELECT MIN (discount) AS min_discount, MAX(discount) AS max_discoun,AVG(discount) AS avg_discount
FROM Sales.OrderDetails


SELECT shippeddate
FROM Sales.Orders
ORDER BY shippeddate;

SELECT
MIN (shippeddate) AS earliest,
MAX (shippeddate) AS latest,
COUNT (shippeddate) AS [count_shippeddate],
COUNT (*) AS COUNT_all
FROM Sales.Orders;

SELECT empid, COUNT(*) AS cnt
FROM Sales.Orders
GROUP BY empid;

/*SELECT empid, COUNT(*) AS cnt
FROM Sales.Orders, Sales.OrderDetails
GROUP BY empid, orderdate

----SELECT custid, COUNT(*) AS cnt
FROM Sales.Customers, Sales.OrderDetails
GROUP BY orderid*/


SELECT productid, MAX(qty) AS largest_order
FROM Sales.OrderDetails
GROUP BY productid;


SELECT custid, COUNT(*) AS count_orders
FROM Sales.Orders
GROUP BY custid
HAVING COUNT(*) > 10;

SELECT c.custid, COUNT(*) AS cnt, c.companyname
FROM Sales.Customers AS c 
JOIN Sales.Orders AS o ON c.custid = o.custid
GROUP BY c.custid, c.companyname
HAVING COUNT(*) > 1;

SELECT p.productid, COUNT(*) AS cnt
FROM Production.Products AS p JOIN Sales.OrderDetails AS od 
ON p.productid = od.productid
GROUP BY p.productid
HAVING COUNT(*) >= 10;

SELECT empid, COUNT(*) AS cnt
FROM Sales.Orders
GROUP BY empid
ORDER BY cnt DESC;


select COUNT(region)
FROM Sales.Customers;

SELECT region
FROM Sales.Customers
ORDER BY region DESC


select custid, country, region, city
from Sales.Customers
where region <> N'WA'

select custid, country, region, city
from Sales.Customers
where region = N'WA'

select custid, country, region, city
from Sales.Customers
where region <> N'WA' OR region IS NULL 






