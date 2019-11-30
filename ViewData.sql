USE `mydb`;
SHOW TABLES;

########## Check that data is populated into different tables

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

############################################
SET SQL_SAFE_UPDATES = 0;

SET FOREIGN_KEY_CHECKS=0; -- to disable them
SET FOREIGN_KEY_CHECKS=1; -- to re-enable them