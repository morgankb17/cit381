CREATE TABLE IF NOT EXISTS `assignment_2`.`person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT COMMENT 'number for the invitee',
  `lastName` VARCHAR(45) NOT NULL COMMENT 'last name of the person invited',
  `firstName` VARCHAR(45) NULL DEFAULT NULL COMMENT 'first name of the person invited',
  PRIMARY KEY (`idPerson`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `assignment_2`.`relationship` (
  `idRelationship` INT NOT NULL AUTO_INCREMENT COMMENT 'number for the invitee; relationship type',
  `relationshipType` VARCHAR(45) NOT NULL COMMENT 'the relationship is either friend or family',
  PRIMARY KEY (`idRelationship`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `assignment_2`.`family` (
  `idPerson` INT NOT NULL COMMENT 'number for the invitee',
  `idRelationship` INT NOT NULL COMMENT 'number for the invitee; relationship type',
  `familyType` VARCHAR(45) NOT NULL COMMENT 'the type of familial relationship',
  PRIMARY KEY (`idPerson`, `idRelationship`),
  INDEX `fk_person_has_relationship_relationship2_idx` (`idRelationship` ASC) VISIBLE,
  INDEX `fk_person_has_relationship_person1_idx` (`idPerson` ASC) VISIBLE,
  CONSTRAINT `fk_person_has_relationship_person1`
    FOREIGN KEY (`idPerson`)
    REFERENCES `assignment_2`.`person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_relationship_relationship2`
    FOREIGN KEY (`idRelationship`)
    REFERENCES `assignment_2`.`relationship` (`idRelationship`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `assignment_2`.`friend` (
  `idPerson` INT NOT NULL COMMENT 'number for the invitee',
  `idRelationship` INT NOT NULL COMMENT 'number for the invitee; relationship type',
  `friendType` VARCHAR(45) NOT NULL COMMENT 'the type of friendship',
  PRIMARY KEY (`idPerson`, `idRelationship`),
  INDEX `fk_person_has_relationship_relationship1_idx` (`idRelationship` ASC) VISIBLE,
  INDEX `fk_person_has_relationship_person_idx` (`idPerson` ASC) VISIBLE,
  CONSTRAINT `fk_person_has_relationship_person`
    FOREIGN KEY (`idPerson`)
    REFERENCES `assignment_2`.`person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_relationship_relationship1`
    FOREIGN KEY (`idRelationship`)
    REFERENCES `assignment_2`.`relationship` (`idRelationship`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

