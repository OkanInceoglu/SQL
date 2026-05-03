USE car_rentals;

SELECT *
FROM clients
WHERE cl_first_name LIKE '[ИВД]%';

SELECT *
FROM cars
WHERE year_model BETWEEN '2008' AND '2011';

SELECT *
FROM cars
WHERE brand LIKE 'bmw' AND (model LIKE 'E81' OR model LIKE 'E88');

SELECT * 
FROM clients
WHERE country NOT LIKE 'България';

SELECT *
FROM cars INNER JOIN cars_specification
ON cars.id=cars_specification.car_id
WHERE price <=100 AND cars_specification.color=N'син';

SELECT em_first_name,em_last_name,position_name
FROM employees INNER JOIN positions
ON employees.position_id=positions.id;

CREATE VIEW viewcarrepairs AS
SELECT *
FROM cars_specification INNER JOIN car_repairs
ON cars_specification.license_pl_number=car_repairs.license_pl_number;

SELECT *
FROM locations

CREATE VIEW viewrent AS
SELECT *
FROM rent INNER JOIN locations
ON rent.location_id=locations.id
WHERE locations.location LIKE N'Бургас';

DROP VIEW viewrent;

CREATE VIEW vw_rent_locations AS
SELECT *
FROM rent r
JOIN locations l ON r.location_id = l.id
WHERE l.location IN (N'Бъргас', N'Варна', N'Ямбол');

SELECT *
FROM cars JOIN cars_specification
ON cars.id=cars_specification.car_id
WHERE cars_specification.price BETWEEN 50 AND 100;


SELECT *
FROM cars_specification cs
JOIN rent r ON cs.license_pl_number = r.car_number
JOIN clients cl ON r.client_id = cl.id;

SELECT cl.cl_first_name, cl.cl_last_name,r.car_number,e.em_first_name,e.em_last_name
FROM clients cl JOIN rent r
ON cl.id=r.client_id 
JOIN employees e ON r.employee_id=e.id;

SELECT car_number ,COUNT(*) AS BrojOtdavaniq
FROM rent
GROUP BY car_number;

SELECT *
FROM employees
WHERE em_first_name LIKE 'Я__';

SELECT *
FROM cars JOIN cars_specification ON
cars.id=cars_specification.car_id
WHERE cars_specification.km BETWEEN 50000.00 AND 100000.00;

SELECT position_name,COUNT(*) AS BojSlujiteli
FROM positions
GROUP BY position_name;

SELECT *
FROM cars
WHERE brand NOT IN ('Nissan','Mazda','Toyota');

SELECT *
FROM cars JOIN cars_specification ON
cars.id= cars_specification.car_id
JOIN rent ON cars_specification.license_pl_number=rent.car_number
WHERE rent.ending_date='2016-01-25';

SELECT *
FROM rent;

DECLARE @minCAR decimal (8,2);

SELECT @minCAR=min(price)
FROM cars_specification;

SELECT @minCAR AS minCarPrice;

IF EXISTS (
    SELECT 1
    FROM cars_specification
    WHERE price = 100
)
    PRINT N'Има автомобил с цена 100';
ELSE
    PRINT N'Няма автомобил с цена 100';

    SELECT 
    license_pl_number,
    km,
    CASE 
        WHEN km < 50000 THEN 'Very Good'
        WHEN km BETWEEN 50000 AND 100000 THEN 'Good'
        ELSE 'Bad'
    END AS condition_status
FROM cars_specification;

