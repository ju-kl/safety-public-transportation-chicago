-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`grid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grid` (
  `gridId` INT NOT NULL,
  `minlat` FLOAT NULL,
  `maxlat` FLOAT NULL,
  `minlong` FLOAT NULL,
  `maxlong` FLOAT NULL,
  PRIMARY KEY (`gridId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BusStops`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BusStops`;
CREATE TABLE IF NOT EXISTS `mydb`.`BusStops` (
  `stopID` INT NOT NULL,
  `Long` FLOAT NULL,
  `systemStop` FLOAT NULL,
  `street` VARCHAR(45) NULL,
  `crossSt` VARCHAR(45) NULL,
  `dir` VARCHAR(45) NULL,
  `pos` VARCHAR(45) NULL,
  `routesStpg` VARCHAR(45) NULL,
  `owlRoutes` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  `publicNam` VARCHAR(60) NULL,
  `latitude` FLOAT NULL,
  `longitude` FLOAT NULL,
  `gridId` INT NULL,
  PRIMARY KEY (`stopID`),
  INDEX `Grid_ID_idx` (`gridId` ASC),
  CONSTRAINT `busgrid`
    FOREIGN KEY (`gridId`)
    REFERENCES `mydb`.`grid` (`gridId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TrainStops`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TrainStops`;
CREATE TABLE IF NOT EXISTS `mydb`.`TrainStops` (
  `stopID` INT NOT NULL,
  `directionID` VARCHAR(45) NULL,
  `stopName` VARCHAR(45) NULL,
  `stationName` VARCHAR(45) NULL,
  `stationDescriptiveName` VARCHAR(100) NULL,
  `mapID` VARCHAR(45) NULL,
  `ada` VARCHAR(45) NULL,
  `red` VARCHAR(45) NULL,
  `blue` VARCHAR(45) NULL,
  `g` VARCHAR(45) NULL,
  `brn` VARCHAR(45) NULL,
  `p` VARCHAR(45) NULL,
  `pExp` VARCHAR(45) NULL,
  `y` VARCHAR(45) NULL,
  `pnk` VARCHAR(45) NULL,
  `o` VARCHAR(45) NULL,
  `latitude` FLOAT NULL,
  `longitude` FLOAT NULL,
  `gridId` INT NULL,
  PRIMARY KEY (`stopID`),
  INDEX `Grid_ID_idx` (`gridId` ASC),
  CONSTRAINT `traingrid`
    FOREIGN KEY (`gridId`)
    REFERENCES `mydb`.`grid` (`gridId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hday` (
  `Date` DATETIME NOT NULL,
  `Holiday` VARCHAR(45) NULL,
  PRIMARY KEY (`Date`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`weather`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`weather` (
  `Date` DATETIME NOT NULL,
  `Elevation` FLOAT NULL,
  `Latitude` FLOAT NULL,
  `Longitude` FLOAT NULL,
  `Prcp` FLOAT NULL,
  `Station` VARCHAR(45) NULL,
  `Tmax` FLOAT NULL,
  `Tavg` FLOAT NULL,
  `Tmin` FLOAT NULL,
  `Tobs` FLOAT NULL,
  `Tsun` FLOAT NULL,
  PRIMARY KEY (`Date`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`crime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`crime`;
CREATE TABLE IF NOT EXISTS `mydb`.`crime` (
  `crimeID` INT NOT NULL DEFAULT '0',
  `caseNumber` VARCHAR(45) NOT NULL,
  `datetime` DATETIME NULL,
  `block` VARCHAR(45) NULL,
  `iucr` VARCHAR(45) NULL,
  `primaryType` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `locationDescription` VARCHAR(45) NULL,
  `arrest` VARCHAR(45) NULL,
  `domestic` VARCHAR(45) NULL,
  `beat` VARCHAR(45) NULL,
  `district` VARCHAR(45) NULL,
  `ward` VARCHAR(45) NULL,
  `communityArea` VARCHAR(45) NULL,
  `fbiCode` VARCHAR(45) NULL,
  `xCoordinate` VARCHAR(45) NULL,
  `yCoordinate` VARCHAR(45) NULL,
  `year` VARCHAR(45) NULL,
  `updatedOn` VARCHAR(45) NULL,
  `latitude` FLOAT NULL,
  `longitude` FLOAT NULL,
  `date` DATETIME NULL,
  `time` VARCHAR(20) NULL,
  `gridId` INT NULL,
  PRIMARY KEY (`CrimeID`),
  INDEX `Grid_ID_idx` (`gridId` ASC),
  INDEX `date_idx` (`date` ASC),
  CONSTRAINT `crimegrid`
    FOREIGN KEY (`gridId`)
    REFERENCES `mydb`.`grid` (`gridId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `holidate`
    FOREIGN KEY (`date`)
    REFERENCES `mydb`.`hday` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `weatherdate`
    FOREIGN KEY (`date`)
    REFERENCES `mydb`.`weather` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
