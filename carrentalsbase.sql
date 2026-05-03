CREATE DATABASE car_rentals;

USE car_rentals;

CREATE TABLE cars(
    id INT IDENTITY PRIMARY KEY,
    brand NVARCHAR(30) NOT NULL,
    model NVARCHAR(30) NOT NULL,
    year_model NCHAR(4) NOT NULL
);

CREATE TABLE cars_specification(
    license_pl_number NVARCHAR(15) PRIMARY KEY,
    car_id INT NOT NULL,
    km DECIMAL(8,2) NOT NULL,
    color NVARCHAR(20) NOT NULL,
    navigation BIT NOT NULL,
    air_conditioning BIT NOT NULL,
    other NTEXT NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    available BIT NOT NULL,
    
    FOREIGN KEY (car_id) REFERENCES cars(id)
);

CREATE TABLE car_services(
    id INT IDENTITY PRIMARY KEY,
    cs_name NVARCHAR(30) NOT NULL,
    cs_town NVARCHAR(30) NOT NULL,
    cs_address NVARCHAR(30) NOT NULL,
    cs_phone CHAR(12) NOT NULL
);

CREATE TABLE car_repairs(
    license_pl_number NVARCHAR(15),
    cs_id INT,
    starting_date DATE,
    ending_date DATE,
    repair_info NVARCHAR(50) NOT NULL,
    price DECIMAL(8,2) NOT NULL,

    PRIMARY KEY (license_pl_number, cs_id, starting_date, ending_date),
    FOREIGN KEY (cs_id) REFERENCES car_services(id)
);

ALTER TABLE car_repairs
ADD CONSTRAINT fk2 
FOREIGN KEY (license_pl_number)
REFERENCES cars_specification(license_pl_number);

CREATE TABLE positions(
    id INT IDENTITY PRIMARY KEY,
    position_name NVARCHAR(30) NOT NULL,
    salary DECIMAL(6,2) NOT NULL
);

CREATE TABLE employees(
    id INT IDENTITY PRIMARY KEY,
    em_first_name NVARCHAR(20) NOT NULL,
    em_last_name NVARCHAR(20) NOT NULL,
    position_id INT NOT NULL,

    FOREIGN KEY (position_id) REFERENCES positions(id)
);

CREATE TABLE locations(
    id INT IDENTITY PRIMARY KEY,
    location NVARCHAR(50) NOT NULL
);

CREATE TABLE clients_driver_info(
    id INT IDENTITY PRIMARY KEY,
    driving_license NVARCHAR(50) NOT NULL,
    violation NVARCHAR(100) NOT NULL
);

CREATE TABLE clients(
    id INT IDENTITY PRIMARY KEY,
    cl_first_name NVARCHAR(20) NOT NULL,
    cl_last_name NVARCHAR(20) NOT NULL,
    country NVARCHAR(25) NOT NULL,
    town NVARCHAR(25) NOT NULL,
    client_address NVARCHAR(25) NOT NULL,
    gsm_phone NCHAR(12) NOT NULL,

    FOREIGN KEY (id) REFERENCES clients_driver_info(id)
);

CREATE TABLE rent(
    car_number NVARCHAR(15) NOT NULL,
    client_id INT NOT NULL,
    employee_id INT NOT NULL,
    contact_date DATE NOT NULL,
    location_id INT NOT NULL,
    starting_date DATE NOT NULL,
    ending_date DATE NOT NULL,

    PRIMARY KEY (car_number, client_id, employee_id, contact_date),

    FOREIGN KEY (car_number) REFERENCES cars_specification(license_pl_number),
    FOREIGN KEY (client_id) REFERENCES clients(id),
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    FOREIGN KEY (location_id) REFERENCES locations(id)
);

INSERT INTO cars (brand, model, year_model)
VALUES ('vw', 'polo', '2010');

INSERT INTO cars (brand, model, year_model)
VALUES 
('bmw','E81','2010'),
('bmw','E88','2008'),
('bmw','F30','2011'),
('ford','fiesta','2012'),
('nissan','versa','2009'),
('honda','fit','2013'),
('toyota','yaris','2014'),
('ford','focus','2010'),
('toyota','corolla','2011'),
('mazda','6','2009'),
('chevy','impala','2014');

INSERT INTO cars_specification
(license_pl_number, car_id, km, color, navigation, air_conditioning, other, price, available)
VALUES 
('A1414AH',4,50000.00,'бял',0,0,'-',100.00,1),
('A2245KA',1,20000.00,'син',1,1,'-',70.00,1),
('A4515KA',8,60000.00,'син',1,1,'-',150.00,1),
('A4585BA',2,25000.00,'червен',0,0,'-',50.00,1),
('A8780AM',6,28000.00,'бордо',0,1,'-',112.00,1),
('B4574AH',11,12000.00,'бял',0,1,'-',160.00,1),
('B7895AH',5,14000.00,'лилав',0,1,'-',90.00,1),
('C1212CA',10,96000.00,'розов',0,1,'-',100.00,1),
('C3487AD',3,30500.00,'черен',1,1,'-',100.00,1),
('CA1285AA',1,15000.00,'син',0,1,'-',91.00,1),
('CA4478AA',9,120000.00,'бял',0,1,'-',150.00,1),
('H1234',12,15000.00,'черен',1,1,'-',150.00,1),
('P4578BO',7,39000.00,'кафяв',1,1,'-',120.00,1);

INSERT INTO car_services (cs_name, cs_town, cs_address, cs_phone)
VALUES ('Корект','Бургас','ж.к.Славейков','0889123456');

INSERT INTO car_services (cs_name, cs_town, cs_address, cs_phone)
VALUES 
('Фют','Варна','ул.Д.Димитров','0898582486'),
('Фют','София','ж.к.Младост','0878487784'),
('Ауто2','Пловдив','ул.М.Лалов','0875784954'),
('Аутохелп','Бургас','ул.Транспортна','0898457655');

INSERT INTO car_repairs
(license_pl_number, cs_id, starting_date, ending_date, repair_info, price)
VALUES 
('A1414AH',1,'2016-01-12','2016-01-13','смяна масло',20.00),
('A2245KA',2,'2016-01-12','2016-01-15','смяна ремък',100.00),
('A4585BA',3,'2016-01-13','2016-01-13','смяна шарнир',30.00),
('B7895AH',4,'2016-01-15','2016-01-20','смяна накладки',30.00),
('C3487AD',5,'2016-01-15','2016-01-17','смяна крушка',5.00),
('CA1285AA',1,'2016-01-13','2016-01-14','смяна диск',30.00);

INSERT INTO positions (position_name, salary)
VALUES ('шофьор',1200.00);

INSERT INTO positions (position_name, salary)
VALUES 
('администратор',800.00),
('шофьор-администратор',1800.00);

INSERT INTO employees (em_first_name, em_last_name, position_id)
VALUES ('Иван','Михайлов',1);

INSERT INTO employees (em_first_name, em_last_name, position_id)
VALUES 
('Милен','Димитров',3),
('Яна','Стефанова',2),
('Дамян','Иванов',2),
('Силвия','Русева',3);

INSERT INTO locations (location)
VALUES 
('Бургас-Варна'),
('Бургас-Пловдив'),
('Бургас-София'),
('Бургас-Монтана'),
('Бургас-Димитровград'),
('Бургас-Русе'),
('Бургас-Шумен'),
('Бургас-Хасково');

INSERT INTO clients_driver_info (driving_license, violation)
VALUES ('145623','не');

INSERT INTO clients_driver_info (driving_license, violation)
VALUES 
('не','не'),
('не','не'),
('154896','не'),
('215856','да'),
('121212','не');

INSERT INTO clients
(cl_first_name, cl_last_name, country, town, client_address, gsm_phone)
VALUES 
('Радост','Димитрова','България','Варна','ул.Свобода','0885458123'),
('Тихомир','Василев','България','Бургас','ул.Шейново','0885125854'),
('Джордж','Лорънс','Англия','Лондон','Ломбард','0887852485'),
('Кейти','Уонд','Англия','Лондон','Флеет','0885125753'),
('Траян','Димитров','България','Бургас','ж.к.Лазур','0898589899');

ALTER TABLE clients
DROP CONSTRAINT FK__clients__id__49C3F6B7;

ALTER TABLE clients
ADD driver_info_id INT;

ALTER TABLE clients
ADD FOREIGN KEY (driver_info_id)
REFERENCES clients_driver_info(id);

INSERT INTO rent
(car_number, client_id, employee_id, contact_date, location_id, starting_date, ending_date)
VALUES 
('A1414AH',2,2,'2016-01-09',2,'2016-01-10','2016-01-25'),
('A4515KA',2,2,'2016-01-10',5,'2016-01-10','2016-01-15'),
('A8780AM',2,4,'2016-01-15',5,'2016-01-16','2016-01-25'),
('CA1285AA',5,3,'2016-01-12',6,'2016-01-12','2016-01-22'),
('H1234',5,3,'2016-01-16',8,'2016-01-16','2016-01-22'),
('P4578BO',3,5,'2016-01-16',7,'2016-01-17','2016-01-27');

SELECT em_first_name ,em_last_name 
FROM Employees

SELECT em_first_name,em_last_name
FROM Employees
WHERE ID=3;

SELECT position_id, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY position_id;

SELECT position_id, COUNT(*) AS NumberOfEmployees 
FROM Employees
GROUP BY position_id 
HAVING COUNT(*)>1;

SELECT em_first_name, em_last_name 
FROM Employees 
ORDER BY em_first_name

SELECT em_first_name, em_last_name 
FROM Employees 
ORDER BY em_last_name DESC

SELECT *
FROM cars
WHERE year_model='2011';

SELECT *
FROM cars
WHERE year_model <>'2011';

SELECT *
FROM cars
WHERE year_model>'2011';

SELECT *
FROM cars
WHERE year_model<'2011';

SELECT *
FROM cars
WHERE year_model>='2011';

SELECT *
FROM cars
WHERE year_model<='2011';

SELECT *
FROM cars
WHERE year_model BETWEEN '2009' AND '2012';

SELECT *
FROM cars
WHERE brand LIKE 'bmw';

SELECT *
FROM cars
WHERE brand NOT LIKE 'bmw';

SELECT *
FROM cars
WHERE brand IN ('bmw','ford','toyota');

SELECT *
FROM cars
WHERE brand NOT IN ('bmw','ford','toyota');

SELECT id, brand,model,year_model
FROM cars 
WHERE brand='ford' AND model='fiesta';

SELECT id, brand,model,year_model 
FROM cars 
WHERE brand='ford' OR brand='toyota';

SELECT id, brand,model,year_model 
FROM cars
WHERE NOT brand='bmw' ;

SELECT * 
FROM cars 
WHERE brand='ford' AND (model='focus' OR model='fiesta');

SELECT brand, model FROM cars WHERE model LIKE 'f%';

SELECT brand, model FROM cars WHERE model LIKE 'f____';

SELECT brand, model 
FROM cars 
WHERE brand LIKE '[fbt]%';

SELECT brand, model
FROM cars 
WHERE brand LIKE '[a-f]%';

SELECT brand, model FROM cars WHERE brand LIKE '[^fbt]%';

SELECT * FROM cars_specification;

UPDATE cars_specification
SET price='32.08' 
WHERE car_id=4;

SELECT * FROM cars_specification;

UPDATE cars_specification 
SET price = price + price *20/100 
WHERE car_id=5;

SELECT * FROM cars_specification;

UPDATE car_repairs
SET price=60
FROM car_repairs
INNER JOIN car_services ON car_services.id = car_repairs.cs_id
INNER JOIN cars_specification ON 
cars_specification.license_pl_number=car_repairs.license_pl_number
WHERE cs_name LIKE 'Корект' AND cars_specification.license_pl_number LIKE 'A1414AH'

DELETE FROM cars_specification WHERE car_id=11;

SELECT brand, model, year_model, license_pl_number, km, color, navigation
FROM cars, cars_specification 
WHERE cars. ID=cars_specification.car_id

SELECT brand, model, year_model,license_pl_number, km, color, navigation, air_conditioning 
FROM cars C INNER JOIN cars_specification S 
ON C.id=S.car_id

SELECT * 
FROM cars JOIN cars_specification 
ON cars.id=cars_specification.car_id;

SELECT * FROM cars C
LEFT OUTER JOIN cars_specification S 
ON C.id=S.car_id;

SELECT * 
FROM cars C 
RIGHT OUTER JOIN cars_specification S 
ON C.id=S.car_id;

SELECT * 
FROM cars C FULL OUTER JOIN cars_specification S 
ON C.id=S.car_id;

SELECT * FROM cars,cars_specification;

SELECT brand, model, year_model, km,color
FROM cars INNER JOIN cars_specification 
ON cars.ID = cars_specification.car_id 
WHERE cars_specification.license_pl_number = ( 
SELECT car_number 
FROM rent WHERE 
client_id = 3 );

CREATE VIEW v1 AS SELECT * FROM cars WHERE year_model='2011';
DROP VIEW v1;

INSERT INTO employees (em_first_name,em_last_name,position_id)
VALUES ('Радост','Димитрова',1);

SELECT * FROM employees; SELECT * FROM clients;

SELECT em_first_name, em_last_name FROM employees UNION SELECT cl_first_name,cl_last_name FROM clients;

SELECT em_first_name, em_last_name FROM employees INTERSECT SELECT cl_first_name,cl_last_name FROM clients;

SELECT em_first_name, em_last_name FROM employees EXCEPT SELECT cl_first_name,cl_last_name FROM clients;

DECLARE @test varchar(50);
SET @test='Hello, world'; 
SELECT @test;

DECLARE @ClientAddress NVARCHAR(50) 
SET @ClientAddress = 'Centar' 
SELECT cl_first_name, cl_last_name 
FROM clients
WHERE client_address = @ClientAddress ;

DECLARE @NumberOfClients int SELECT @NumberOfClients=(SELECT COUNT(*) FROM clients) SELECT @NumberOfClients AS Customers_Number ;

DECLARE @MaxPrice DECIMAL(5,2) SELECT @MaxPrice= max(price) FROM cars_specification PRINT @MaxPrice 

DECLARE @cl_first_name varchar(30);
DECLARE @cl_last_name varchar(30); 
DECLARE @client_address varchar(30); 
SET @client_address ='Lazur' 
SELECT @cl_first_name = cl_first_name, @cl_last_name = cl_last_name FROM clients
WHERE client_address =@client_address;
PRINT '@cl_first_name =' + @cl_first_name; 
PRINT '@cl_last_name = ' + @cl_last_name;
PRINT '@client_address = ' + @client_address;

DECLARE @StudentsInGroup INT; 
SET @StudentsInGroup = 16;
IF @StudentsInGroup=16 
PRINT 'OK'; 
ELSE 
PRINT 'Check';

DECLARE @StudentsInGroup2 INT; 
SET @StudentsInGroup2 = 16;
IF @StudentsInGroup2=16
PRINT 'OK';

DECLARE @StudentsInGroup3 INT; SET @StudentsInGroup3 = 16; IF @StudentsInGroup3 = 16 PRINT 'OK'; ELSE BEGIN IF @StudentsInGroup3 < 16 PRINT 'Check'; ELSE PRINT 'Error'; END;

DECLARE @i AS INT = 1; WHILE @i <= 10 BEGIN PRINT @i; SET @i = @i + 1; END;

DECLARE @e AS INT = 1; WHILE @e <= 10 BEGIN IF @e = 6 BREAK; PRINT @e; SET @e = @e + 1;END;

IF (SELECT Count(*) FROM cars_specification) >10 BEGIN PRINT 'enough' PRINT ' ' SELECT license_pl_number FROM cars_specification End ELSE PRINT 'not enough'

SELECT * FROM employees;

BEGIN TRAN; INSERT INTO employees (em_first_name, em_last_name,position_id) VALUES ('Иво','Стоянов', 1); INSERT INTO employees (em_first_name, em_last_name,position_id) VALUES ('Димо','Кузманов', 1); ROLLBACK TRAN;

BEGIN TRAN; INSERT INTO employees (em_first_name, em_last_name,position_id) VALUES ('Ивелина','Димова', 1); INSERT INTO employees (em_first_name, em_last_name,position_id) VALUES ('Димитър','Янев', 1); COMMIT TRAN;


SELECT * FROM employees;

BEGIN TRAN Update employees SET em_first_name='Николета' WHERE id=6; SAVE TRAN update_ok; INSERT INTO employees (em_first_name, em_last_name,position_id) VALUES ('Лара','Симова', 1); ROLLBACK TRANSACTION update_ok;