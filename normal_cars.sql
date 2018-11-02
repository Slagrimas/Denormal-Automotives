
--Create a new postgres user named normal_user.
--Create a new database named normal_cars owned by normal_user.
DROP DATABASE IF EXISTS normal_cars;
DROP USER IF EXISTS normal_user;
CREATE USER normal_user;
CREATE DATABASE normal_cars;

--Create a query to generate the tables needed to accomplish your normalized schema
CREATE TABLE make_table (
    make_id SERIAL PRIMARY KEY,
    make_code VARCHAR(25) NOT NULL,
    make_title VARCHAR(25) NOT NULL
    --Bigger window for varchar
);

--Create queries to insert all of the data that was in the car_models table, into the new normalized tables
INSERT INTO make_table (make_code, make_title) 
SELECT DISTINCT make_code, make_title
FROM car_models;

--Create a query to generate the tables needed to accomplish your normalized schema
CREATE TABLE model_table (
    model_id SERIAL PRIMARY KEY,
    model_code VARCHAR(50) NOT NULL,
    model_title VARCHAR(50) NOT NULL,
    make_id INTEGER NOT NULL
);

--Create queries to insert all of the data that was in the car_models table, into the new normalized tables
INSERT INTO model_table (model_code, model_title, make_id) 
SELECT DISTINCT car_models.model_code, car_models.model_title, make_table.make_id
FROM make_table
  INNER JOIN car_models 
    ON car_models.make_code = make_table.make_code
    AND car_models.make_title = make_table.make_title;

--year table here

--Create a query to generate the tables needed to accomplish your normalized schema
--just model no year
CREATE TABLE model_year (
    model_year_id SERIAL PRIMARY KEY,
    model_id INTEGER NOT NULL,
    year INTEGER NOT NULL
);

--Create queries to insert all of the data that was in the car_models table, into the new normalized tables
INSERT INTO model_year (model_id, year)
SELECT DISTINCT model_table.model_id, car_models.year
FROM model_table 
INNER JOIN car_models
ON car_models.model_code = model_table.model_code
AND car_models.model_title = model_table.model_title;

--Create a query to get a list of all make_title values in the car_models table. Without any duplicate rows, this should have 71 results
SELECT make_title
FROM make_table;

-- Create a query to list all model_title values where the make_code is 'VOLKS' Without any duplicate rows, this should have 27 results.
SELECT model_title
FROM model_table
INNER JOIN make_table USING (make_id)
WHERE make_code = 'VOLKS';

--Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM'. Without any duplicate rows, this should have 136 rows.
--incorrect--
SELECT DISTINCT make_code, model_code, model_title, year
FROM make_table
INNER JOIN model_table USING (make_id)
INNER JOIN model_year USING (model_id)
WHERE make_code = 'LAM';
--incorrect--

