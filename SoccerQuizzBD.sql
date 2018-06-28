-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SoccerQuizzBD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SoccerQuizzBD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SoccerQuizzBD` DEFAULT CHARACTER SET utf8 ;
USE `SoccerQuizzBD` ;

-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Resposta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Resposta` (
  `idResposta` INT NOT NULL AUTO_INCREMENT,
  `resposta` VARCHAR(45) NOT NULL,
  `idPergunta` INT NOT NULL,
  PRIMARY KEY (`idResposta`),
  INDEX `fk_Resposta_Pergunta1_idx` (`idPergunta` ASC),
  CONSTRAINT `fk_Resposta_Pergunta1`
    FOREIGN KEY (`idPergunta`)
    REFERENCES `SoccerQuizzBD`.`Pergunta` (`idPergunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Jogador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Jogador` (
  `username` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `pontuacaoIndividual` INT NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Moderador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Moderador` (
  `nivel1` TINYINT(1) NOT NULL,
  `nivel2` TINYINT(1) NOT NULL,
  `nivel3` TINYINT(1) NOT NULL,
  `jogador` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`jogador`),
  CONSTRAINT `fk_Moderador_Jogador1`
    FOREIGN KEY (`jogador`)
    REFERENCES `SoccerQuizzBD`.`Jogador` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Tema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Tema` (
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT(1000) NULL,
  `moderador` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`nome`),
  INDEX `fk_Tema_Moderador1_idx` (`moderador` ASC),
  CONSTRAINT `fk_Tema_Moderador1`
    FOREIGN KEY (`moderador`)
    REFERENCES `SoccerQuizzBD`.`Moderador` (`jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Pergunta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Pergunta` (
  `idPergunta` INT NOT NULL AUTO_INCREMENT,
  `descricao` TEXT(1000) NOT NULL,
  `imagem` BLOB NULL,
  `gabarito` INT NOT NULL,
  `tema` VARCHAR(100) NOT NULL,
  `moderador` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idPergunta`),
  INDEX `fk_Pergunta_Resposta1_idx` (`gabarito` ASC),
  INDEX `fk_Pergunta_Tema1_idx` (`tema` ASC),
  INDEX `fk_Pergunta_Moderador1_idx` (`moderador` ASC),
  CONSTRAINT `fk_Pergunta_Resposta1`
    FOREIGN KEY (`gabarito`)
    REFERENCES `SoccerQuizzBD`.`Resposta` (`idResposta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pergunta_Tema1`
    FOREIGN KEY (`tema`)
    REFERENCES `SoccerQuizzBD`.`Tema` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pergunta_Moderador1`
    FOREIGN KEY (`moderador`)
    REFERENCES `SoccerQuizzBD`.`Moderador` (`jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Perfil` (
  `nome` VARCHAR(100) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `foto` BLOB NULL,
  `pais` VARCHAR(30) NOT NULL,
  `jogador` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`email`, `jogador`),
  CONSTRAINT `fk_Perfil_Jogador`
    FOREIGN KEY (`jogador`)
    REFERENCES `SoccerQuizzBD`.`Jogador` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Jogo` (
  `idJogo` INT NOT NULL AUTO_INCREMENT,
  `jogador1` VARCHAR(50) NOT NULL,
  `jogador2` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idJogo`),
  INDEX `fk_Jogo_Jogador1_idx` (`jogador1` ASC),
  INDEX `fk_Jogo_Jogador2_idx` (`jogador2` ASC),
  CONSTRAINT `fk_Jogo_Jogador1`
    FOREIGN KEY (`jogador1`)
    REFERENCES `SoccerQuizzBD`.`Jogador` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_Jogador2`
    FOREIGN KEY (`jogador2`)
    REFERENCES `SoccerQuizzBD`.`Jogador` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Competicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Competicao` (
  `nome` VARCHAR(100) NOT NULL,
  `dataInicio` DATE NOT NULL,
  `dataFim` DATE NOT NULL,
  PRIMARY KEY (`nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Equipe` (
  `nome` VARCHAR(100) NOT NULL,
  `moderador` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`nome`),
  INDEX `fk_Equipe_Moderador1_idx` (`moderador` ASC),
  CONSTRAINT `fk_Equipe_Moderador1`
    FOREIGN KEY (`moderador`)
    REFERENCES `SoccerQuizzBD`.`Moderador` (`jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Participacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Participacao` (
  `idParticipacao` INT NOT NULL AUTO_INCREMENT,
  `pontuacao` INT NOT NULL,
  `jogador` VARCHAR(50) NOT NULL,
  `competicao` VARCHAR(100) NOT NULL,
  `equipe` VARCHAR(100) NOT NULL,
  INDEX `fk_Participacao_Jogador1_idx` (`jogador` ASC),
  INDEX `fk_Participacao_Competicao1_idx` (`competicao` ASC),
  INDEX `fk_Participacao_Equipe1_idx` (`equipe` ASC),
  PRIMARY KEY (`idParticipacao`),
  CONSTRAINT `fk_Participacao_Jogador1`
    FOREIGN KEY (`jogador`)
    REFERENCES `SoccerQuizzBD`.`Jogador` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participacao_Competicao1`
    FOREIGN KEY (`competicao`)
    REFERENCES `SoccerQuizzBD`.`Competicao` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participacao_Equipe1`
    FOREIGN KEY (`equipe`)
    REFERENCES `SoccerQuizzBD`.`Equipe` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`JogoEvento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`JogoEvento` (
  `idJogo` INT NOT NULL,
  `competicao` VARCHAR(100) NOT NULL,
  `participante1` INT NOT NULL,
  `participante2` INT NOT NULL,
  PRIMARY KEY (`idJogo`),
  INDEX `fk_JogoEvento_Competicao1_idx` (`competicao` ASC),
  INDEX `fk_JogoEvento_Participacao1_idx` (`participante1` ASC),
  INDEX `fk_JogoEvento_Participacao2_idx` (`participante2` ASC),
  CONSTRAINT `fk_JogoEvento_Jogo1`
    FOREIGN KEY (`idJogo`)
    REFERENCES `SoccerQuizzBD`.`Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JogoEvento_Competicao1`
    FOREIGN KEY (`competicao`)
    REFERENCES `SoccerQuizzBD`.`Competicao` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JogoEvento_Participacao1`
    FOREIGN KEY (`participante1`)
    REFERENCES `SoccerQuizzBD`.`Participacao` (`idParticipacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JogoEvento_Participacao2`
    FOREIGN KEY (`participante2`)
    REFERENCES `SoccerQuizzBD`.`Participacao` (`idParticipacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`Perguntas_no_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`Perguntas_no_Jogo` (
  `idPergunta` INT NOT NULL,
  `idJogo` INT NOT NULL,
  PRIMARY KEY (`idPergunta`, `idJogo`),
  INDEX `fk_Pergunta_has_Jogo_Jogo1_idx` (`idJogo` ASC),
  INDEX `fk_Pergunta_has_Jogo_Pergunta1_idx` (`idPergunta` ASC),
  CONSTRAINT `fk_Pergunta_has_Jogo_Pergunta1`
    FOREIGN KEY (`idPergunta`)
    REFERENCES `SoccerQuizzBD`.`Pergunta` (`idPergunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pergunta_has_Jogo_Jogo1`
    FOREIGN KEY (`idJogo`)
    REFERENCES `SoccerQuizzBD`.`Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoccerQuizzBD`.`PontuacaoCompeticao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoccerQuizzBD`.`PontuacaoCompeticao` (
  `equipe` VARCHAR(100) NOT NULL,
  `competicao` VARCHAR(100) NOT NULL,
  `pontuacao` INT NOT NULL,
  PRIMARY KEY (`equipe`, `competicao`),
  INDEX `fk_Equipe_has_Competicao_Competicao1_idx` (`competicao` ASC),
  INDEX `fk_Equipe_has_Competicao_Equipe1_idx` (`equipe` ASC),
  CONSTRAINT `fk_Equipe_has_Competicao_Equipe1`
    FOREIGN KEY (`equipe`)
    REFERENCES `SoccerQuizzBD`.`Equipe` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_has_Competicao_Competicao1`
    FOREIGN KEY (`competicao`)
    REFERENCES `SoccerQuizzBD`.`Competicao` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
