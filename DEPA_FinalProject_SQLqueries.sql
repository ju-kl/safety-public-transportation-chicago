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

#### Get the record count and view the data for each table

# Crime table
SELECT COUNT(*) FROM crime;
SELECT * FROM crime
LIMIT 10;

# Bus Stops table
SELECT COUNT(*) FROM BusStops;
SELECT * FROM BusStops
LIMIT 10;

# Train stops table
SELECT COUNT(*) FROM TrainStops;
SELECT * FROM TrainStops
LIMIT 10;

# Grid table
SELECT COUNT(*) FROM grid;
SELECT * FROM grid
LIMIT 10;

# Holiday table
SELECT COUNT(*) FROM hday;
SELECT * FROM hday
LIMIT 10;

# Weather table
SELECT COUNT(*) FROM weather;
SELECT * FROM weather
LIMIT 10;

## Check the datatypes from a certain column
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TrainStops';


########### Querying the data ##########

# Find the number of crimes ocurring by Location type
SELECT locationDescription, COUNT(*) AS numberOfCrimes
FROM crime
GROUP BY locationDescription
ORDER BY COUNT(*) DESC;

# Find the total number of crimes occuring per year
SELECT year, COUNT(*) AS numberOfCrimes
FROM crime
GROUP BY year;

# Find the top 5 types of crime
SELECT primaryType, COUNT(*) AS numberOfCrimes
FROM crime
GROUP BY primaryType
ORDER BY COUNT(*) DESC
LIMIT 5;

# Average number of crimes per day
SELECT COUNT(*) / (DATEDIFF(MAX(date), MIN(date))) AS avgCrime
from crime;
# Average of 14.85 crimes per day

# Top 5 Holidays with the most crime occurences in 2019
SELECT Holiday, DATE(Date) as Date, COUNT(*) as numberOfCrimes
FROM hday
INNER JOIN crime USING (Date)
WHERE YEAR(Date) = 2019
GROUP BY Holiday, Date
ORDER BY COUNT(*) DESC
LIMIT 5;
# Most number of crimes occured on Memorial day, which was 20

# Bus stops with the most crime occurences
SELECT routesStpg AS route, publicNam AS stopName, COUNT(*) AS numberOfCrimes
FROM BusStops
INNER JOIN crime USING (gridId)
WHERE locationDescription = "CTA BUS STOP"
GROUP BY stopID
ORDER BY COUNT(*) DESC
LIMIT 5;

# Grids with the most bus stops
SELECT gridId, COUNT(*) AS numOfBusStops
FROM grid
INNER JOIN BusStops USING (gridId)
GROUP BY gridId
ORDER BY COUNT(*) DESC
LIMIT 5;




############################################
SET SQL_SAFE_UPDATES = 0;

SET FOREIGN_KEY_CHECKS=0; -- to disable them
SET FOREIGN_KEY_CHECKS=1; -- to re-enable them