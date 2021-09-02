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
-- Table `assign03`.`sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assign03`.`sellers` ;

CREATE TABLE IF NOT EXISTS `assign03`.`sellers` (
  `sellerID` INT NOT NULL,
  `sellerName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sellerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assign03`.`items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assign03`.`items` ;

CREATE TABLE IF NOT EXISTS `assign03`.`items` (
  `itemID` INT NOT NULL,
  `openPrice` DECIMAL(9,2) NOT NULL,
  `reservePrice` DECIMAL(9,2) NOT NULL,
  `info` VARCHAR(45) NOT NULL,
  `endTime` DATETIME NOT NULL,
  `sellers_sellerID` INT NOT NULL,
  PRIMARY KEY (`itemID`),
  INDEX `fk_items_sellers1_idx` (`sellers_sellerID` ASC) VISIBLE,
  CONSTRAINT `fk_items_sellers1`
    FOREIGN KEY (`sellers_sellerID`)
    REFERENCES `assign03`.`sellers` (`sellerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assign03`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assign03`.`customers` ;

CREATE TABLE IF NOT EXISTS `assign03`.`customers` (
  `customerID` INT NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assign03`.`bids`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assign03`.`bids` ;

CREATE TABLE IF NOT EXISTS `assign03`.`bids` (
  `bidID` INT NOT NULL,
  `customers_customerID` INT NOT NULL,
  `items_itemID` INT NOT NULL,
  `bidPrice` DECIMAL(9,2) NOT NULL,
  `winningBid` VARCHAR(3) NULL COMMENT 'winningBid is for the keyword ‘yes,’ and would only appear on the row with the customer who wins that item/bid.',
  PRIMARY KEY (`bidID`),
  INDEX `fk_bids_customers1_idx` (`customers_customerID` ASC) VISIBLE,
  INDEX `fk_bids_items1_idx` (`items_itemID` ASC) VISIBLE,
  CONSTRAINT `fk_bids_customers1`
    FOREIGN KEY (`customers_customerID`)
    REFERENCES `assign03`.`customers` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bids_items1`
    FOREIGN KEY (`items_itemID`)
    REFERENCES `assign03`.`items` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
