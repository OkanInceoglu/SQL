CREATE DATABASE Store;

USE Store;

CREATE TABLE ProductCategory(
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL
);

CREATE TABLE Product(
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(50) NOT NULL,
    ProductCategoryID INT NOT NULL,
    ProductInStock INT NOT NULL,
    ProductPrice DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (ProductCategoryID) 
    REFERENCES ProductCategory(CategoryID)
);

CREATE TABLE Customer(
    CustomerID INT IDENTITY PRIMARY KEY,
    LastName NVARCHAR(30) NOT NULL,
    FirstName NVARCHAR(30) NOT NULL,
    CustomerTown NVARCHAR(50) NOT NULL,
    CustomerAddress NVARCHAR(100) NOT NULL,
    CustomerPhone NVARCHAR(15) NOT NULL
);

CREATE TABLE Employee(
    EmployeeID INT IDENTITY PRIMARY KEY,
    EmLastName NVARCHAR(30) NOT NULL,
    EmFirstName NVARCHAR(30) NOT NULL,
    EmTown NVARCHAR(50) NOT NULL,
    EmAddress NVARCHAR(100) NOT NULL,
    EmPhone NVARCHAR(15) NOT NULL
);

CREATE TABLE Sale(
    SaleID INT IDENTITY PRIMARY KEY,
    SCustomerID INT NOT NULL,
    SEmployeeID INT NOT NULL,
    SDate DATE NOT NULL,

    FOREIGN KEY (SCustomerID) 
    REFERENCES Customer(CustomerID),

    FOREIGN KEY (SEmployeeID) 
    REFERENCES Employee(EmployeeID)
);

CREATE TABLE SaleProduct(
    SaleID INT NOT NULL,
    SProductID INT NOT NULL,
    Quantity INT NOT NULL,

    PRIMARY KEY (SaleID, SProductID),

    FOREIGN KEY (SaleID) 
    REFERENCES Sale(SaleID),

    FOREIGN KEY (SProductID) 
    REFERENCES Product(ProductID)
);

INSERT INTO ProductCategory (CategoryName)
VALUES 
('Храни'),
('Напитки'),
('Техника');

INSERT INTO Product (ProductName, ProductCategoryID, ProductInStock, ProductPrice)
VALUES
('Хляб',1,50,1.20),
('Мляко',1,30,2.50),
('Вода',2,100,1.00),
('Сок',2,40,2.20),
('Телефон',3,10,500.00),
('Лаптоп',3,5,1200.00);

INSERT INTO Customer 
(LastName, FirstName, CustomerTown, CustomerAddress, CustomerPhone)
VALUES
('Иванов','Иван','Бургас','ж.к.Славейков','0888123456'),
('Петров','Петър','Варна','ул.Морска','0888234567'),
('Георгиева','Мария','София','ул.Витоша','0888345678');

INSERT INTO Employee
(EmLastName, EmFirstName, EmTown, EmAddress, EmPhone)
VALUES
('Димитров','Иван','Бургас','ж.к.Изгрев','0888456789'),
('Стоянов','Георги','Пловдив','ул.Капитан Райчо','0888567890');

INSERT INTO Employee
(EmLastName, EmFirstName, EmTown, EmAddress, EmPhone)
VALUES
('Димитров','Иван','Бургас','ж.к.Изгрев','0888456789'),
('Стоянов','Георги','Пловдив','ул.Капитан Райчо','0888567890');

INSERT INTO Sale (SCustomerID, SEmployeeID, SDate)
VALUES
(1,1,'2026-04-01'),
(2,2,'2026-04-02'),
(3,1,'2026-04-03');

INSERT INTO SaleProduct (SaleID, SProductID, Quantity)
VALUES
(1,1,2),
(1,3,5),

(2,2,1),
(2,4,3),

(3,5,1),
(3,6,1);

SELECT * FROM ProductCategory;
SELECT * FROM Product;
SELECT * FROM Customer;
SELECT * FROM Employee;
SELECT * FROM Sale;
SELECT * FROM SaleProduct;

UPDATE Product
SET ProductPrice=1.50
WHERE ProductID=1;

UPDATE Product
SET ProductInStock=1
WHERE ProductName LIKE 'Телефон';

UPDATE Customer
SET FirstName='Окан',
LastName='Ахмедов'
WHERE CustomerPhone ='0888123456'

