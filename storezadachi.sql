USE Store;

SELECT *
FROM Product
WHERE ProductInStock<100;

SELECT *
FROM Product
WHERE ProductID LIKE 2 OR ProductID LIKE 3;

SELECT ProductInStock,COUNT(*) AS BrojProdukti
FROM Product
GROUP BY ProductInStock
HAVING ProductInStock>1;

SELECT *
From Product
WHERE ProductName LIKE 'Х%';

SELECT AVG(ProductPrice) AS avg_price
FROM Product
WHERE ProductCategoryID = 1;

SELECT *
FROM SaleProduct;

SELECT *
FROM Employee e JOIN  Sale s ON
e.EmployeeID=s.SEmployeeID
WHERE s.SDate='2026-04-01';

UPDATE Product
SET ProductPrice = ProductPrice * 0.8
WHERE ProductName LIKE '%Хляб%';

SELECT p.ProductName, p.ProductInStock,p.ProductPrice,sp.Quantity,s.SDate
FROM Product p JOIN SaleProduct sp ON
p.ProductID=sp.SProductID
JOIN Sale s ON
sp.SaleID=s.SaleID;

SELECT Quantity,COUNT(*) AS ProdadeniProdukti
FROM SaleProduct sp JOIN Product p ON
sp.SProductID=p.ProductID
WHERE p.ProductName LIKE 'Хляб'
GROUP BY Quantity;

SELECT *
FROM Product
WHERE ProductPrice BETWEEN 1 AND 3;

DECLARE @MinStock int;

SELECT @MinStock=min(ProductInStock)
FROM Product;

SELECT @MinStock AS MINStock;

IF EXISTS(
SELECT 1
FROM Product
WHERE ProductInStock = 55)
PRINT 'NALICHEN' ;
ELSE 
PRINT 'NE E NALICHNA';