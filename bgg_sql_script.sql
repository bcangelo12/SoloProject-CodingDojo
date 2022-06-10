-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bgg_schema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bgg_schema` ;

-- -----------------------------------------------------
-- Schema bgg_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bgg_schema` DEFAULT CHARACTER SET utf8 ;
USE `bgg_schema` ;

-- -----------------------------------------------------
-- Table `bgg_schema`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bgg_schema`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(255) NULL,
  `lastName` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `preferredGenre` VARCHAR(64) NULL,
  `password` VARCHAR(128) NULL,
  `favoriteGames` VARCHAR(255) NULL,
  `otherGenres` VARCHAR(255) NULL,
  `aboutMe` LONGTEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bgg_schema`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bgg_schema`.`messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(255) NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_messages_users_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_messages_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `bgg_schema`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bgg_schema`.`friends`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bgg_schema`.`friends` (
  `users_id` INT NOT NULL,
  `messages_id` INT NOT NULL,
  INDEX `fk_friends_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_friends_messages1_idx` (`messages_id` ASC) VISIBLE,
  CONSTRAINT `fk_friends_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `bgg_schema`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_friends_messages1`
    FOREIGN KEY (`messages_id`)
    REFERENCES `bgg_schema`.`messages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
