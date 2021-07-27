-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fabrica_picoles
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fabrica_picoles
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fabrica_picoles` DEFAULT CHARACTER SET utf8 ;
USE `fabrica_picoles` ;

-- -----------------------------------------------------
-- Table `fabrica_picoles`.`sabor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`sabor` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`embalagens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`embalagens` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `produto_producao` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`tipo_picole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`tipo_picole` (
  `id` INT NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`Picoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`Picoles` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `id_sabor` INT NOT NULL,
  `id_tipo_embalagem` INT NOT NULL,
  `preco` DECIMAL(8,2) NOT NULL,
  `id_tipo_picole` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_picole_1_idx` (`id_sabor` ASC) VISIBLE,
  INDEX `fk_picoles_2_idx` (`id_tipo_embalagem` ASC) VISIBLE,
  INDEX `fk_picoles_3_idx` (`id_tipo_picole` ASC) VISIBLE,
  CONSTRAINT `fk_picole_1`
    FOREIGN KEY (`id_sabor`)
    REFERENCES `fabrica_picoles`.`sabor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_picoles_2`
    FOREIGN KEY (`id_tipo_embalagem`)
    REFERENCES `fabrica_picoles`.`embalagens` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_picoles_3`
    FOREIGN KEY (`id_tipo_picole`)
    REFERENCES `fabrica_picoles`.`tipo_picole` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`aditivos_nutritivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`aditivos_nutritivos` (
  `id` INT NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  `formula_quimica` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`aditivos_conservantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`aditivos_conservantes` (
  `id` INT NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  `descricao` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`revendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`revendedor` (
  `id` INT NOT NULL,
  `cnpj` VARCHAR(45) NOT NULL,
  `razao_social` VARCHAR(45) NOT NULL,
  `contato` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`nota_fiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`nota_fiscal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_serie` VARCHAR(20) NOT NULL,
  `id_revendendor` INT NOT NULL,
  `data` DATE NOT NULL,
  `Valor_final` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nota_fiscal_1_idx` (`id_revendendor` ASC) VISIBLE,
  CONSTRAINT `fk_nota_fiscal_1`
    FOREIGN KEY (`id_revendendor`)
    REFERENCES `fabrica_picoles`.`revendedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`lotes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`lotes` (
  `id` INT NOT NULL,
  `id_tipo_picole` INT NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lote_1_idx` (`id_tipo_picole` ASC) VISIBLE,
  CONSTRAINT `fk_lote_1`
    FOREIGN KEY (`id_tipo_picole`)
    REFERENCES `fabrica_picoles`.`tipo_picole` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`conexao_conser_pico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`conexao_conser_pico` (
  `id` INT NOT NULL,
  `id_picole` INT NOT NULL,
  `id_conservantes` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conexao_cons_1_idx` (`id_conservantes` ASC) VISIBLE,
  INDEX `fk_conexao_cons_2_idx` (`id_picole` ASC) VISIBLE,
  CONSTRAINT `fk_conexao_cons_1`
    FOREIGN KEY (`id_conservantes`)
    REFERENCES `fabrica_picoles`.`aditivos_conservantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conexao_cons_2`
    FOREIGN KEY (`id_picole`)
    REFERENCES `fabrica_picoles`.`Picoles` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`conexao_nutri_pico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`conexao_nutri_pico` (
  `id` INT NOT NULL,
  `id_picole` INT NOT NULL,
  `id_nutritivos` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conexao_nutri_1_idx` (`id_picole` ASC) VISIBLE,
  INDEX `fk_conexao_nutri_1_idx1` (`id_nutritivos` ASC) VISIBLE,
  CONSTRAINT `fk_conexao_nutri_1`
    FOREIGN KEY (`id_picole`)
    REFERENCES `fabrica_picoles`.`Picoles` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conexao_nutri_1`
    FOREIGN KEY (`id_nutritivos`)
    REFERENCES `fabrica_picoles`.`aditivos_nutritivos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`ingredientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`ingredientes` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`conexao_ingredientes_picole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`conexao_ingredientes_picole` (
  `id` INT NOT NULL,
  `id_picole` INT NOT NULL,
  `id_ingredientes` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conexao_ingr_1_idx` (`id_picole` ASC) VISIBLE,
  INDEX `fk_conexao_ingr_2_idx` (`id_ingredientes` ASC) VISIBLE,
  CONSTRAINT `fk_conexao_ingr_1`
    FOREIGN KEY (`id_picole`)
    REFERENCES `fabrica_picoles`.`Picoles` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conexao_ingr_2`
    FOREIGN KEY (`id_ingredientes`)
    REFERENCES `fabrica_picoles`.`ingredientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fabrica_picoles`.`conexap_lotes_nota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fabrica_picoles`.`conexap_lotes_nota` (
  `id` INT NOT NULL,
  `id_lotes` INT NOT NULL,
  `id_nota_fiscal` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conexa_lote_1_idx` (`id_lotes` ASC) VISIBLE,
  INDEX `fk_conexao_lote_2_idx` (`id_nota_fiscal` ASC) VISIBLE,
  CONSTRAINT `fk_conexa_lote_1`
    FOREIGN KEY (`id_lotes`)
    REFERENCES `fabrica_picoles`.`lotes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conexao_lote_2`
    FOREIGN KEY (`id_nota_fiscal`)
    REFERENCES `fabrica_picoles`.`nota_fiscal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
