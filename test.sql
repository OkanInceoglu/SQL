CREATE DATABASE Test;

USE Test;

Create table suppliers(
id int identity primary key,
CompanyName varchar(100) not null,
CompanyAdress varchar(200) not null,
CompanyPhone char(12) not null);

CREATE TABLE products (
id int identity primary key,
ProductName varchar(50) not null,
Productprice decimal(10,2) not null,
SupplierID int not null,
Foreign key(SupplierID) references suppliers(id));

Create table employees (
id int identity primary key,
EmpFirstName varchar(50) not null,
EmpLastName varchar(50) not null
);

create table orders(
EmployeeID int not null,
ProductID int not null,
OrderDate DateTime not null,

Primary key(EmployeeID,ProductID,OrderDate),

foreign key (EmployeeID) references employees(id),

foreign key(ProductID) references products(id));

ALTER TABLE employees
ADD EmployeeAdress varchar(100) not null;

INSERT INTO suppliers(CompanyName,CompanyAdress,CompanyPhone)
VALUES ('TechnoLogika','Burgaz','0892360888'),
('ELKabel','Shumen','0889887231'),
('EVN','Plovdiv','0892346763'),
('MediaArt','Burgas','087678990'),
('Happy','Sofia','0892356432');

INSERT INTO products(ProductName,ProductPrice,SupplierID)
VALUES ('WebSite',180.50,1),
('Kabel',8.99,2),
('Tok',3.89,3),
('Laptop',899.20,4),
('File',12.99,5);

INSERT INTO employees(EmpFirstName,EmpLastName,EmployeeAdress)
VALUES ('Okan','Inceoglu','Burgas'),
('Hakan','Mustafov','Burgas'),
('Deniz','Kobak','Burgas'),
('Mustafa','Erol','Burgas'),
('Wegh','Rumi','Istanbul');

ALTER TABLE orders 
ADD quantity int not null;

SELECT * FROM employees;

SELECT * FROM products;

Insert into orders(EmployeeID,ProductID,OrderDate,quantity)
Values (2,1,GETDATE(),1),
(4,2,GETDATE(),5),
(3,3,GETDATE(),12),
(5,4,GETDATE(),2),
(6,4,GETDATE(),3);

Select p.ProductName ,o.quantity as BrojDostavki
FROM Products p JOIN orders o 
ON p.id=o.ProductID
WHERE o.quantity BETWEEN 10 AND 15;

SELECT *
FROM products
WHERE ProductName LIKE 'L%';

SELECT TOP 1 ProductName,MIN(ProductPrice) As MinCena
FROM products
Group By ProductName
Order By MinCena ASC;

UPDATE products
SET Productprice=0.99
WHERE ProductName LIKE 'Tok';

SELECT *
From products;

SELECT s.CompanyName,SUM(p.id) AS BrojPoruchki
FROM suppliers s JOIN products p
ON s.id=p.SupplierID
WHERE s.CompanyName LIKE 'TechnoLogika'
GROUP BY s.CompanyName;

SELECT o.ProductID,o.OrderDate,e.EmpFirstName,e.EmpLastName
FROM orders o INNER JOIN employees e
ON o.EmployeeID=e.id;

SELECT e.EmpFirstName,e.EmpLastName,o.OrderDate,o.quantity,p.ProductName,p.Productprice
FROM employees e JOIN orders o ON e.id=o.EmployeeID JOIN products p ON o.ProductID=p.id;

DELETE FROM orders
WHERE EmployeeID = 2
AND ProductID = 4
AND OrderDate = '2025-05-17 21:30:00';

SELECT *
FROM orders;