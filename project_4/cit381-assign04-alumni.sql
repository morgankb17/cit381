-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema alumni_website
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema alumni_website
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `alumni_website` DEFAULT CHARACTER SET utf8 ;
USE `alumni_website` ;

-- -----------------------------------------------------
-- Table `alumni_website`.`registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`registration` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`registration` (
  `registrationID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`registrationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`members` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`members` (
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`events` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`events` (
  `eventID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`eventID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`authors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`authors` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`authors` (
  `authorID` INT NOT NULL AUTO_INCREMENT,
  `lastName` VARCHAR(45) NOT NULL,
  `firstName` VARCHAR(45) NULL,
  `authorType` VARCHAR(45) NULL,
  PRIMARY KEY (`authorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`article_entry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`article_entry` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`article_entry` (
  `articleID` INT NOT NULL AUTO_INCREMENT,
  `articleAbstract` VARCHAR(255) NULL,
  `articleTitle` VARCHAR(100) NOT NULL,
  `articleText` VARCHAR(1000) NULL,
  `authorID` INT NOT NULL,
  PRIMARY KEY (`articleID`),
  INDEX `fk_article_entry_authors_idx` (`authorID` ASC) VISIBLE,
  CONSTRAINT `fk_article_entry_authors`
    FOREIGN KEY (`authorID`)
    REFERENCES `alumni_website`.`authors` (`authorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`contact` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`contact` (
  `submissionID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`submissionID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`member_information`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`member_information` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`member_information` (
  `memberID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`memberID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`comments` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`comments` (
  `commentID` INT NOT NULL AUTO_INCREMENT,
  `articleID` INT NOT NULL,
  `lastName` VARCHAR(45) NULL,
  `firstName` VARCHAR(45) NULL,
  `commentText` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`commentID`),
  INDEX `fk_comments_article_entry1_idx` (`articleID` ASC) VISIBLE,
  CONSTRAINT `fk_comments_article_entry1`
    FOREIGN KEY (`articleID`)
    REFERENCES `alumni_website`.`article_entry` (`articleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`major_highlights`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`major_highlights` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`major_highlights` (
  `highlightsID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`highlightsID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`success_stories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`success_stories` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`success_stories` (
  `storiesID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`storiesID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`stats_numbers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`stats_numbers` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`stats_numbers` (
  `stats_numbersID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`stats_numbersID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`home`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`home` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`home` (
  `landing_pageID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`landing_pageID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alumni_website`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alumni_website`.`courses` ;

CREATE TABLE IF NOT EXISTS `alumni_website`.`courses` (
  `coursesID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`coursesID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
