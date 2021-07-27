-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Drogaria_avenida
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Drogaria_avenida
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Drogaria_avenida` DEFAULT CHARACTER SET utf8 ;
USE `Drogaria_avenida` ;

-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`tipo_produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`tipo_produto` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`tipo_produto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_produto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`fabricante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`fabricante` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`fabricante` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fabricante` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`Produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`Produtos` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`Produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `designacao` VARCHAR(20) NOT NULL,
  `composicao` VARCHAR(30) NOT NULL,
  `id_fabricante` INT NOT NULL,
  `preco` DECIMAL(8,2) NOT NULL,
  `Produto` VARCHAR(45) NOT NULL,
  `id_tipo_produto` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_drogaria_1_idx` (`id_tipo_produto` ASC) ,
  INDEX `fk_drogaria_2_idx` (`id_fabricante` ASC) ,
  CONSTRAINT `fk_drogaria_1`
    FOREIGN KEY (`id_tipo_produto`)
    REFERENCES `Drogaria_avenida`.`tipo_produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drogaria_2`
    FOREIGN KEY (`id_fabricante`)
    REFERENCES `Drogaria_avenida`.`fabricante` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`cliente` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `localidade` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `numero_contribuinte` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`compra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`compra` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_compras_1_idx` (`id_cliente` ASC) ,
  CONSTRAINT `fk_compras_1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `Drogaria_avenida`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`medico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`medico` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`medico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) NOT NULL,
  `CRM` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`recorrencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`recorrencia` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`recorrencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `recorrencia` VARCHAR(45) NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`receita_medica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`receita_medica` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`receita_medica` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `intituicao` VARCHAR(25) NOT NULL,
  `data` DATE NOT NULL,
  `id_tipo_recorrencia` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_receita_1_idx` (`id_tipo_recorrencia` ASC) ,
  CONSTRAINT `fk_receita_1`
    FOREIGN KEY (`id_tipo_recorrencia`)
    REFERENCES `Drogaria_avenida`.`recorrencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`conexao_produtos_compras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`conexao_produtos_compras` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`conexao_produtos_compras` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_compras` INT NOT NULL,
  `id_produtos` INT NOT NULL,
  `quantidade_produtos` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conexao_drogaria_1_idx` (`id_produtos` ASC),
  INDEX `fk_conexao_drogaria_2_idx` (`id_compras` ASC),
  CONSTRAINT `fk_conexao_produtos_1`
    FOREIGN KEY (`id_produtos`)
    REFERENCES `Drogaria_avenida`.`Produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conexao_produtos_2`
    FOREIGN KEY (`id_compras`)
    REFERENCES `Drogaria_avenida`.`compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Drogaria_avenida`.`conexao_receita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Drogaria_avenida`.`conexao_receita` ;

CREATE TABLE IF NOT EXISTS `Drogaria_avenida`.`conexao_receita` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_compra_produtos` INT NOT NULL,
  `id_medico` INT NOT NULL,
  `id_receita` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_conexao_receita_1_idx` (`id_medico` ASC) ,
  INDEX `fk_conexao_receita_2_idx` (`id_receita` ASC) ,
  INDEX `fk_conexao_receita_3_idx` (`id_compra_produtos` ASC) ,
  CONSTRAINT `fk_conexao_receita_1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `Drogaria_avenida`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conexao_receita_2`
    FOREIGN KEY (`id_receita`)
    REFERENCES `Drogaria_avenida`.`receita_medica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conexao_receita_3`
    FOREIGN KEY (`id_compra_produtos`)
    REFERENCES `Drogaria_avenida`.`conexao_produtos_compras` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
