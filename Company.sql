CREATE DATABASE Company;

USE Company;

CREATE TABLE Dostavchici(
ID int identity primary key,
Company_Name varchar(100) not null,
Company_Description varchar (100) not null,
Companu_Adress varchar(100) not null,
Company_Phone char(12) not null);

CREATE TABLE Products(
ID int identity primary key,
Product_Name varchar(50) not null,
Product_Description varchar(50) not null,
Product_Brand varchar(50) not null);

CREATE TABLE Slijiteli(
ID int identity primary key not null,
First_Name varchar(50) not null,
Last_Name varchar(50) not null);

CREATE TABLE Dostavki(
Company_ID int not null,
Products_ID int not null,
Data_dostavka DATE not null,
Cena_dostavka decimal(10,2) not null,
Broi int not null,
Priel_Dostavka int not null,

Primary key(Company_ID,Products_ID,Data_dostavka),

foreign key(Company_ID) references Dostavchici(ID),

foreign key(Products_ID) references Products(ID),

foreign key(Priel_Dostavka) references Slijiteli(ID));

INSERT INTO Products(Product_Name,Product_Description,Product_Brand)
VALUES ('Мура','вафла','Нестле'),
('Троя','вафла','Победа'),
('Морени','вафла','Нестле'),
('Ная','вафла','Победа'),
('Своге-чист','шоколад','Своге'),
('Своге-лешници','шоколад','Своге'),
('Милка-чист','шоколад','Милка'),
('Милка-биск','бисквити','Милка'),
('Анелия','бисквити','Победа');

INSERT INTO Dostavchici(Company_Name,Company_Description,Companu_Adress,Company_Phone)
VALUES ('Победа-1','сладки и солени изделия','Бургас','0887-123-876'),
('Даная-3','сладки и солени изделия','София','0886-345-343'),
('Славея-2','сладки и солени изделия','Варна','0885-234-345');

INSERT INTO Slijiteli(First_Name,Last_Name)
VALUES ('Ивелин','Иванов'),
('Радо','Димов'),
('Силвия','Радева');

INSERT INTO Dostavki(Company_ID,Products_ID,Data_dostavka,Cena_dostavka,Broi,Priel_Dostavka)
VALUES (1,4,'2017-5-1',0.60,10,2);

INSERT INTO Dostavki(Company_ID,Products_ID,Data_dostavka,Cena_dostavka,Broi,Priel_Dostavka)
VALUES (1,2,'2017-5-1',0.25,15,2),
(1,9,'2017-5-1',1.20,10,2),
(2,1,'2017-5-3',0.30,20,3),
(2,8,'2017-5-3',1.25,16,3),
(3,5,'2017-5-8',1.12,20,1),
(3,6,'2017-5-8',1.20,13,1);

SELECT d.Company_Name ,SUM(ds.Products_ID) as BrojDostavki
FROM Dostavchici d LEFT JOIN Dostavki ds ON d.ID=ds.Company_ID
GROUP BY d.Company_Name;

SELECT p.Product_Name ,AVG(d.Cena_dostavka) as sredna_cena
FROM Products p LEFT JOIN Dostavki d ON p.ID=d.Products_ID
GROUP BY p.Product_Name;

SELECT *
FROM Products
WHERE Product_Brand LIKE 'Милка';

UPDATE Dostavki
SET Cena_dostavka=Cena_dostavka-0.05;

SELECT *
FROM Products p JOIN Dostavki d ON p.ID=d.Products_ID
WHERE p.id IN(2,4,6);

SELECT *
FROM Dostavchici
WHERE Companu_Adress IN ('Бургас','Варна');

UPDATE Dostavki
SET Broi = 1
WHERE Products_ID=4;

CREATE PROCEDURE GetDostavki
@ProductDescription varchar(100),
@ProductBrand varchar(50)
AS
BEGIN

SELECT *
FROM Products p
JOIN Dostavki d
ON p.ID = d.Products_ID
WHERE p.Product_Description = @ProductDescription
AND p.Product_Brand = @ProductBrand;

END;

EXEC GetDostavki 'Laptop', 'Dell';

CREATE PROCEDURE InsertDostavchici
@CompanyName varchar(100),
@CompanyAddress varchar(100),
@CompanyPhone varchar(20),
@City varchar(50)
AS
BEGIN

INSERT INTO Dostavchici
(Company_Name,Company_Description,Companu_Adress,Company_Phone)

VALUES
(@CompanyName, @CompanyAddress, @CompanyPhone, @City);

END;

EXEC InsertDostavchici
'Tech Ltd',
'Burgas Center',
'0899999999',
'Burgas';