-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema supermarket
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `supermarket` ;

-- -----------------------------------------------------
-- Schema supermarket
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `supermarket` DEFAULT CHARACTER SET utf8 ;
USE `supermarket` ;

-- -----------------------------------------------------
-- Table `supermarket`.`suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermarket`.`suppliers` ;

CREATE TABLE IF NOT EXISTS `supermarket`.`suppliers` (
  `supplierCode` VARCHAR(45) NOT NULL,
  `supplierName` VARCHAR(45) NOT NULL,
  `supplierPhone` VARCHAR(45) NULL,
  PRIMARY KEY (`supplierCode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermarket`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermarket`.`products` ;

CREATE TABLE IF NOT EXISTS `supermarket`.`products` (
  `productCode` VARCHAR(45) NOT NULL,
  `supplierCode` VARCHAR(45) NOT NULL,
  `productName` VARCHAR(45) NOT NULL,
  `productType` VARCHAR(45) NOT NULL,
  `quantityStocked` INT NULL,
  `productPrice` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`productCode`, `supplierCode`),
  INDEX `fk_products_suppliers1_idx` (`supplierCode` ASC) VISIBLE,
  CONSTRAINT `fk_products_suppliers1`
    FOREIGN KEY (`supplierCode`)
    REFERENCES `supermarket`.`suppliers` (`supplierCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermarket`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermarket`.`customers` ;

CREATE TABLE IF NOT EXISTS `supermarket`.`customers` (
  `customerCode` INT NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customerCode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermarket`.`purchases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermarket`.`purchases` ;

CREATE TABLE IF NOT EXISTS `supermarket`.`purchases` (
  `purchaseID` INT NOT NULL AUTO_INCREMENT,
  `customerCode` INT NOT NULL,
  `purchaseDate` DATE NOT NULL,
  `purchaseType` VARCHAR(45) NULL,
  PRIMARY KEY (`purchaseID`, `customerCode`),
  INDEX `fk_purchases_customers1_idx` (`customerCode` ASC) VISIBLE,
  CONSTRAINT `fk_purchases_customers1`
    FOREIGN KEY (`customerCode`)
    REFERENCES `supermarket`.`customers` (`customerCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermarket`.`purchaseInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermarket`.`purchaseInfo` ;

CREATE TABLE IF NOT EXISTS `supermarket`.`purchaseInfo` (
  `purchaseID` INT NOT NULL,
  `productCode` VARCHAR(45) NOT NULL,
  `quantityPurchased` INT NOT NULL,
  `priceEach` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`purchaseID`, `productCode`),
  INDEX `fk_purchases_has_products_products1_idx` (`productCode` ASC) VISIBLE,
  INDEX `fk_purchases_has_products_purchases_idx` (`purchaseID` ASC) VISIBLE,
  CONSTRAINT `fk_purchases_has_products_purchases`
    FOREIGN KEY (`purchaseID`)
    REFERENCES `supermarket`.`purchases` (`purchaseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchases_has_products_products1`
    FOREIGN KEY (`productCode`)
    REFERENCES `supermarket`.`products` (`productCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `supermarket` ;

-- -----------------------------------------------------
-- Placeholder table for view `supermarket`.`vw_productPopularity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermarket`.`vw_productPopularity` (`productCode` INT, `count(*)` INT);

-- -----------------------------------------------------
-- procedure sp_newProduct
-- -----------------------------------------------------

USE `supermarket`;
DROP procedure IF EXISTS `supermarket`.`sp_newProduct`;

DELIMITER $$
USE `supermarket`$$
-- inserts a new product for a pre-exsiting supplier of the supermarket
CREATE PROCEDURE sp_newProduct
	(IN
		productCode VARCHAR(45),
        supplierCode VARCHAR(45),
        productName VARCHAR(45),
        productType VARCHAR(45),
        quantityStocked INT,
        productPrice DECIMAL(10,2)
	)
BEGIN
	INSERT INTO `products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`)
	VALUES (productCode, supplierCode, productName, productType, quantityStocked, productPrice);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_newSupplier
-- -----------------------------------------------------

USE `supermarket`;
DROP procedure IF EXISTS `supermarket`.`sp_newSupplier`;

DELIMITER $$
USE `supermarket`$$
CREATE PROCEDURE sp_newSupplier
	(IN
        supplierCode VARCHAR(45),
        supplierName VARCHAR(45),
        supplierPhone VARCHAR(45)
	)
BEGIN
	INSERT INTO `suppliers` (`supplierCode`, `supplierName`, `supplierPhone`)
	VALUES (supplierCode, supplierName, supplierPhone);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `supermarket`.`vw_productPopularity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supermarket`.`vw_productPopularity`;
DROP VIEW IF EXISTS `supermarket`.`vw_productPopularity` ;
USE `supermarket`;
CREATE  OR REPLACE VIEW vw_productPopularity AS
-- returns product codes and how many times they've been purchased 
SELECT 
	productCode,
    count(*)
FROM purchaseInfo
GROUP BY productCode;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `supermarket`.`suppliers`
-- -----------------------------------------------------
START TRANSACTION;
USE `supermarket`;
INSERT INTO `supermarket`.`suppliers` (`supplierCode`, `supplierName`, `supplierPhone`) VALUES ('OR_42983', 'Smith\'s Veggie-Fruit Farms', '971-222-3333');
INSERT INTO `supermarket`.`suppliers` (`supplierCode`, `supplierName`, `supplierPhone`) VALUES ('OR_28315', 'Hagrid Granary Inc.', '503-123-4567');
INSERT INTO `supermarket`.`suppliers` (`supplierCode`, `supplierName`, `supplierPhone`) VALUES ('WA_76900', 'Whitney Meat & Dairy Co.', '360-420-9999');

COMMIT;


-- -----------------------------------------------------
-- Data for table `supermarket`.`products`
-- -----------------------------------------------------
START TRANSACTION;
USE `supermarket`;
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('F_2390', 'OR_42983', 'banana', 'fruit', 64, 0.99);
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('G_5161', 'OR_28315', 'yellow corn', 'grain', 18, 1.37);
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('V_8273', 'OR_42983', 'romaine lettuce', 'vegetable', 30, 2.00);
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('V_0932', 'OR_42983', 'red bell pepper', 'vegetable', 35, 1.50);
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('D_7725', 'WA_76900', 'milk', 'dairy', 24, 2.22);
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('M_0248', 'WA_76900', 'chicken breast', 'meat', 10, 4.25);
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('F_6904', 'OR_42983', 'strawberries', 'fruit', 16, 5.00);
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('M_5738', 'WA_76900', 'beef patty', 'meat', 20, 3.99);
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('D_2302', 'WA_76900', 'plain yogurt', 'dairy', 30, 2.99);
INSERT INTO `supermarket`.`products` (`productCode`, `supplierCode`, `productName`, `productType`, `quantityStocked`, `productPrice`) VALUES ('G_3879', 'OR_28315', 'oats', 'grain', 5, 2.50);

COMMIT;


-- -----------------------------------------------------
-- Data for table `supermarket`.`customers`
-- -----------------------------------------------------
START TRANSACTION;
USE `supermarket`;
INSERT INTO `supermarket`.`customers` (`customerCode`, `lastName`, `firstName`) VALUES (29735, 'Jenkins', 'Leroy');
INSERT INTO `supermarket`.`customers` (`customerCode`, `lastName`, `firstName`) VALUES (67283, 'Man', 'Muscle');
INSERT INTO `supermarket`.`customers` (`customerCode`, `lastName`, `firstName`) VALUES (30221, 'Mama', 'Joe');

COMMIT;


-- -----------------------------------------------------
-- Data for table `supermarket`.`purchases`
-- -----------------------------------------------------
START TRANSACTION;
USE `supermarket`;
INSERT INTO `supermarket`.`purchases` (`purchaseID`, `customerCode`, `purchaseDate`, `purchaseType`) VALUES (1, 30221, '2020-06-18', 'credit');
INSERT INTO `supermarket`.`purchases` (`purchaseID`, `customerCode`, `purchaseDate`, `purchaseType`) VALUES (2, 29735, '2020-06-18', 'cash');
INSERT INTO `supermarket`.`purchases` (`purchaseID`, `customerCode`, `purchaseDate`, `purchaseType`) VALUES (3, 29735, '2020-06-19', 'cash');
INSERT INTO `supermarket`.`purchases` (`purchaseID`, `customerCode`, `purchaseDate`, `purchaseType`) VALUES (4, 29735, '2020-06-22', 'debit');
INSERT INTO `supermarket`.`purchases` (`purchaseID`, `customerCode`, `purchaseDate`, `purchaseType`) VALUES (5, 30221, '2020-06-22', 'gift card');
INSERT INTO `supermarket`.`purchases` (`purchaseID`, `customerCode`, `purchaseDate`, `purchaseType`) VALUES (6, 30221, '2020-06-22', 'cash');
INSERT INTO `supermarket`.`purchases` (`purchaseID`, `customerCode`, `purchaseDate`, `purchaseType`) VALUES (7, 67283, '2020-06-22', 'credit');
INSERT INTO `supermarket`.`purchases` (`purchaseID`, `customerCode`, `purchaseDate`, `purchaseType`) VALUES (8, 29735, '2020-06-23', 'credit');
INSERT INTO `supermarket`.`purchases` (`purchaseID`, `customerCode`, `purchaseDate`, `purchaseType`) VALUES (9, 67283, '2020-06-23', 'debit');

COMMIT;


-- -----------------------------------------------------
-- Data for table `supermarket`.`purchaseInfo`
-- -----------------------------------------------------
START TRANSACTION;
USE `supermarket`;
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (1, 'F_6904', 3, 5.00);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (1, 'F_2390', 5, 0.99);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (2, 'G_3879', 2, 2.50);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (3, 'D_7725', 4, 2.22);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (3, 'G_5161', 9, 1.37);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (3, 'F_6904', 2, 5.00);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (4, 'F_2390', 3, 0.99);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (5, 'G_3879', 1, 2.50);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (6, 'M_0248', 7, 4.25);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (6, 'M_5738', 3, 3.99);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (7, 'D_2302', 3, 2.99);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (7, 'D_7725', 3, 2.22);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (7, 'G_3879', 1, 2.50);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (7, 'F_2390', 5, 0.99);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (8, 'G_5161', 4, 1.37);
INSERT INTO `supermarket`.`purchaseInfo` (`purchaseID`, `productCode`, `quantityPurchased`, `priceEach`) VALUES (9, 'D_2302', 1, 2.99);

COMMIT;

