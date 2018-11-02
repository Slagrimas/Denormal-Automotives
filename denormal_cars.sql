CREATE USER denormal_user;
CREATE DATABASE denormal_cars WITH OWNER = denormal_user;

--The SELECT DISTINCT statement is used to return only distinct (different) values.
--(70)
SELECT DISTINCT  make_title FROM car_models;

SELECT DISTINCT model_code
FROM car_models
WHERE make_code = 'VOLKS';

SELECT make_code, model_code, model_title, year
FROM car_models
WHERE make_code = 'LAM';

SELECT DISTINCT *
FROM car_models
WHERE year BETWEEN 2010 and 2015