-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema assign03
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema assign03
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `assign03` DEFAULT CHARACTER SET utf8 ;
USE `assign03` ;

-- -----------------------------------------------------
-- Table `assign03`.`regions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assign03`.`regions` ;

CREATE TABLE IF NOT EXISTS `assign03`.`regions` (
  `regionID` INT NOT NULL,
  `regionName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`regionID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assign03`.`stores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assign03`.`stores` ;

CREATE TABLE IF NOT EXISTS `assign03`.`stores` (
  `storeCode` INT NOT NULL,
  `storeName` VARCHAR(45) NOT NULL,
  `regions_regionID` INT NOT NULL,
  PRIMARY KEY (`storeCode`),
  INDEX `fk_stores_regions_idx` (`regions_regionID` ASC) VISIBLE,
  CONSTRAINT `fk_stores_regions`
    FOREIGN KEY (`regions_regionID`)
    REFERENCES `assign03`.`regions` (`regionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assign03`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assign03`.`employees` ;

CREATE TABLE IF NOT EXISTS `assign03`.`employees` (
  `employeeNumber` INT NOT NULL AUTO_INCREMENT,
  `lastName` VARCHAR(45) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `hireDate` DATETIME NOT NULL,
  `releaseDate` DATETIME NULL,
  `managerNumber` INT NULL,
  PRIMARY KEY (`employeeNumber`),
  INDEX `fk_employees_employees1_idx` (`managerNumber` ASC) VISIBLE,
  CONSTRAINT `fk_employees_employees1`
    FOREIGN KEY (`managerNumber`)
    REFERENCES `assign03`.`employees` (`employeeNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assign03`.`assignment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assign03`.`assignment` ;

CREATE TABLE IF NOT EXISTS `assign03`.`assignment` (
  `employees_employeeNumber` INT NOT NULL,
  `stores_storeCode` INT NOT NULL,
  PRIMARY KEY (`stores_storeCode`, `employees_employeeNumber`),
  INDEX `fk_employees_has_stores_stores1_idx` (`stores_storeCode` ASC) VISIBLE,
  INDEX `fk_employees_has_stores_employees1_idx` (`employees_employeeNumber` ASC) VISIBLE,
  CONSTRAINT `fk_employees_has_stores_employees1`
    FOREIGN KEY (`employees_employeeNumber`)
    REFERENCES `assign03`.`employees` (`employeeNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_has_stores_stores1`
    FOREIGN KEY (`stores_storeCode`)
    REFERENCES `assign03`.`stores` (`storeCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
