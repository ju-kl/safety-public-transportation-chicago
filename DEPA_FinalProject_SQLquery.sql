/***********************************************
** GROUP 6 FINAL PROJECT
** DATA ENGINEERING PLATFORMS (MSCA 31012)

** File: DEPA_FinalProject_SQLquery.sql
** Desc: Verifying and querying our data from CloudSQL
** Auth: Jainam Mehta, Julian Kleindiek, Lola Johnston, Peter Eusebio
** Date: 04 Dec 2019
** ALL RIGHTS RESERVED | DO NOT DISTRIBUTE
************************************************/

# Select the mydb database, where our data is located
USE `mydb`;

# Show the list of tables
SHOW TABLES;

########### Verify that all data has been populated correctly ##########

SELECT COUNT(*) FROM crime;
SELECT * FROM crime
LIMIT 10;

SELECT COUNT(*) FROM BusStops;
SELECT * FROM BusStops
LIMIT 10;

SELECT COUNT(*) FROM TrainStops;
SELECT * FROM TrainStops
LIMIT 10;


SELECT COUNT(*) FROM grid;
SELECT * FROM grid
LIMIT 10;

SELECT COUNT(*) FROM hday;
SELECT * FROM hday
LIMIT 10;

SELECT COUNT(*) FROM weather;
SELECT * FROM weather
LIMIT 10;

## Checking the datatype of a certain column
SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_NAME = 'BusStops' AND 
     COLUMN_NAME = 'systemStop';

########### Querying the data ##########




############################################
SET SQL_SAFE_UPDATES = 0;

SET FOREIGN_KEY_CHECKS=0; -- to disable them
SET FOREIGN_KEY_CHECKS=1; -- to re-enable them