-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema r_UofO
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `r_UofO` ;

-- -----------------------------------------------------
-- Schema r_UofO
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `r_UofO` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema r_uofo
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `r_uofo` ;

-- -----------------------------------------------------
-- Schema r_uofo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `r_uofo` ;
USE `r_UofO` ;

-- -----------------------------------------------------
-- Table `r_UofO`.`authorInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `r_UofO`.`authorInfo` ;

CREATE TABLE IF NOT EXISTS `r_UofO`.`authorInfo` (
  `author` VARCHAR(20) NOT NULL,
  `author_flair_text` VARCHAR(45) NULL DEFAULT NULL,
  `author_flair_text_color` VARCHAR(45) NULL DEFAULT NULL,
  `author_flair_background_color` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`author`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `r_UofO`.`posting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `r_UofO`.`posting` ;

CREATE TABLE IF NOT EXISTS `r_UofO`.`posting` (
  `id` VARCHAR(45) NOT NULL COMMENT 'pulled from the JSON data object \"id\"',
  `title` VARCHAR(300) NOT NULL,
  `author` VARCHAR(60) NOT NULL,
  `created_utc` INT NULL DEFAULT NULL,
  `score` INT NULL DEFAULT NULL,
  `articleLink` VARCHAR(225) NULL DEFAULT NULL,
  `num_crossposts` INT NULL DEFAULT NULL,
  `num_comments` INT NULL DEFAULT NULL,
  `selftext` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `author`),
  INDEX `fk_posting_authorInfo1_idx` (`author` ASC) VISIBLE,
  CONSTRAINT `fk_posting_authorInfo1`
    FOREIGN KEY (`author`)
    REFERENCES `r_UofO`.`authorInfo` (`author`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `r_UofO`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `r_UofO`.`comments` ;

CREATE TABLE IF NOT EXISTS `r_UofO`.`comments` (
  `commentID` INT NOT NULL,
  `author` VARCHAR(20) NOT NULL,
  `id` VARCHAR(45) NOT NULL,
  `content` VARCHAR(10000) NULL DEFAULT NULL,
  `url` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`commentID`, `author`, `id`),
  INDEX `fk_comments_authorInfo1_idx` (`author` ASC) VISIBLE,
  INDEX `fk_comments_posting1_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_authorInfo1`
    FOREIGN KEY (`author`)
    REFERENCES `r_UofO`.`authorInfo` (`author`),
  CONSTRAINT `fk_comments_posting1`
    FOREIGN KEY (`id`)
    REFERENCES `r_UofO`.`posting` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `r_uofo` ;
USE `r_UofO` ;

-- -----------------------------------------------------
-- procedure sp_insertPostData
-- -----------------------------------------------------

USE `r_UofO`;
DROP procedure IF EXISTS `r_UofO`.`sp_insertPostData`;

DELIMITER $$
USE `r_UofO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertPostData`(IN 
		id VARCHAR(45),
		title VARCHAR(300),
		author VARCHAR(20),
        created_utc INT,
        score INT,
        articleLink VARCHAR(225),
        num_crossposts INT,
        num_comments INT,
        selftext MEDIUMTEXT
	)
BEGIN
INSERT INTO `posting` (`id`, `title`, `author`, `created_utc`, `score`, `articleLink`, `num_crossposts`, `num_comments`, `selftext`)
VALUES (id, title, author, created_utc, score, articleLink, num_crossposts, num_comments, selftext);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_insertUser
-- -----------------------------------------------------

USE `r_UofO`;
DROP procedure IF EXISTS `r_UofO`.`sp_insertUser`;

DELIMITER $$
USE `r_UofO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertUser`(IN 
		username VARCHAR(20),
        flair_text VARCHAR(45),
        flair_text_color VARCHAR(45),
        flair_background_color VARCHAR(45)
	)
BEGIN
INSERT INTO `authorInfo` (`author`, `author_flair_text`, `author_flair_text_color`, `author_flair_background_color`) 
VALUES (username, flair_text, flair_text_color, flair_background_color);
END$$

DELIMITER ;
USE `r_uofo` ;

-- -----------------------------------------------------
-- Placeholder table for view `r_uofo`.`vw_getbigscores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `r_uofo`.`vw_getbigscores` (`author` INT, `title` INT, `score` INT, `posting date` INT);

-- -----------------------------------------------------
-- View `r_uofo`.`vw_getbigscores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `r_uofo`.`vw_getbigscores`;
DROP VIEW IF EXISTS `r_uofo`.`vw_getbigscores` ;
USE `r_uofo`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `r_uofo`.`vw_getbigscores` AS select `a`.`author` AS `author`,`p`.`title` AS `title`,`p`.`score` AS `score`,concat(from_unixtime(`p`.`created_utc`)) AS `posting date` from (`r_uofo`.`posting` `p` join `r_uofo`.`authorinfo` `a` on((`p`.`author` = `a`.`author`))) where (`p`.`score` >= (select avg(`r_uofo`.`posting`.`score`) from `r_uofo`.`posting`));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
