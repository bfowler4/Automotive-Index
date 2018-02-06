-- Initial setup
DROP DATABASE IF EXISTS indexed_cars;

DROP ROLE IF EXISTS indexed_cars_user;

CREATE ROLE indexed_cars_user;

CREATE DATABASE indexed_cars OWNER indexed_cars_user;

\c indexed_cars

\i scripts/car_models.sql

\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql

SELECT COUNT(*) FROM car_models;


-- Initial queries BEFORE indexes
SELECT DISTINCT make_title FROM car_models WHERE make_code = 'LAM'; -- 60.924 ms

SELECT DISTINCT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R'; -- 28.176 ms

SELECT make_code, model_code, model_title, year FROM car_models where make_code = 'LAM'; -- 25.512 ms

SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015; -- 96.737 ms

SELECT * FROM car_models WHERE year = 2010; -- 39.389 ms


-- Add indexes
CREATE INDEX index_make_code_on_car_models ON car_models (make_code);

CREATE INDEX index_model_code_on_car_models ON car_models (model_code);

CREATE INDEX index_year_on_car_models ON car_models (year);

CREATE INDEX index_make_and_model_on_car_models ON car_models (make_code, model_code);


-- Queries AFTER indexes were added
SELECT DISTINCT make_title FROM car_models WHERE make_code = 'LAM'; -- 0.662 ms

SELECT DISTINCT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R'; -- 0.657 ms

SELECT make_code, model_code, model_title, year FROM car_models where make_code = 'LAM'; -- 1.967 ms

SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015; -- 77.486 ms

SELECT * FROM car_models WHERE year = 2010; -- 15.102 ms


\c Alex