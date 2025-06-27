CREATE TABLE IF NOT EXISTS `Dim_Usuario` (
  `ID_Usuario_CS` INT NOT NULL AUTO_INCREMENT,
  `ID_Usuario_CN` INT NULL,
  `Nombre_Completo` VARCHAR(300) NULL,
  `Nickname` VARCHAR(16) NULL,
  `Correo` VARCHAR(150) NULL UNIQUE,
  `Fecha_Nacimiento` DATE NULL,
  `Password_Hash` VARCHAR(255) NOT NULL,
  `Fecha_Insercion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Modificacion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Usuario_CS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Dim_Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Categoria` (
  `ID_Categoria_CS` INT NOT NULL,
  `ID_Categoria_CN` INT NULL,
  `Nombre_Categoria` VARCHAR(100) NULL,
  `Fecha_Insercion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Modificacion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Categoria_CS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Dim_Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Curso` (
  `ID_Curso_CS` INT NOT NULL,
  `ID_Curso_CN` INT NULL,
  `Nombre_Curso` VARCHAR(100) NULL,
  `Duracion_Horas` INT NULL,
  `Nivel_Curso` VARCHAR(50) NULL,
  `ID_Categoria_CS` INT NULL,
  `Fecha_Insercion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Modificacion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Curso_CS`),
  INDEX `fk_Dim_Curso_Dim_Categoria_idx` (`ID_Categoria_CS` ASC),
  CONSTRAINT `fk_Dim_Curso_Dim_Categoria`
    FOREIGN KEY (`ID_Categoria_CS`)
    REFERENCES `Dim_Categoria` (`ID_Categoria_CS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Dim_Instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Instructor` (
  `ID_Instructor_CS` INT NOT NULL,
  `ID_Instructor_CN` INT NULL,
  `Nombre_Completo_Instructor` VARCHAR(300) NULL,
  `Especialidad` VARCHAR(100) NULL,
  `Biografia` TEXT NULL,
  `URL_Imagen` TEXT NULL,
  `Fecha_Insercion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Modificacion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Instructor_CS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Dim_Temario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Temario` (
  `ID_Temario_CS` INT NOT NULL,
  `ID_Temario_CN` INT NULL,
  `ID_Curso_CN_Referencia` INT NULL,
  `Titulo_Temario` VARCHAR(100) NULL,
  `Descripcion_Temario` TEXT NULL,
  `Fecha_Insercion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Modificacion_Fila` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Temario_CS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Dim_Fecha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dim_Fecha` (
  `ID_Fecha_CS` INT NOT NULL,
  `Fecha_Completa` DATE NOT NULL,
  `Anio` INT NOT NULL,
  `Mes` INT NOT NULL,
  `Trimestre` INT NOT NULL,
  `Nombre_Mes` VARCHAR(20) NOT NULL,
  `Semana_Anio` INT NOT NULL,
  `Dia_Anio` INT NOT NULL,
  `Dia_Semana_Numero` INT NOT NULL,
  `Nombre_Dia_Semana` VARCHAR(20) NOT NULL,
  `Es_Fin_De_Semana` TINYINT NOT NULL,
  PRIMARY KEY (`ID_Fecha_CS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Hecho_Registros_Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hecho_Registros_Usuario` (
  `ID_Registro_CS` BIGINT NOT NULL AUTO_INCREMENT,
  `ID_Usuario_CS` INT NULL,
  `ID_Fecha_Registro_CS` INT NULL,
  `Cantidad_Registros` INT NULL DEFAULT 1,
  PRIMARY KEY (`ID_Registro_CS`),
  INDEX `fk_Hecho_Registros_Usuario_Dim_Usuario_idx` (`ID_Usuario_CS` ASC),
  INDEX `fk_Hecho_Registros_Usuario_Dim_Fecha_idx` (`ID_Fecha_Registro_CS` ASC),
  CONSTRAINT `fk_Hecho_Registros_Usuario_Dim_Usuario`
    FOREIGN KEY (`ID_Usuario_CS`)
    REFERENCES `Dim_Usuario` (`ID_Usuario_CS`),
  CONSTRAINT `fk_Hecho_Registros_Usuario_Dim_Fecha`
    FOREIGN KEY (`ID_Fecha_Registro_CS`)
    REFERENCES `Dim_Fecha` (`ID_Fecha_CS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Hecho_Inscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hecho_Inscripciones` (
  `ID_Inscripcion_CS` BIGINT NOT NULL AUTO_INCREMENT,
  `ID_Inscripcion_CN` INT NULL,
  `ID_Usuario_CS` INT NULL,
  `ID_Curso_CS` INT NULL,
  `ID_Fecha_Inscripcion_CS` INT NULL,
  `Estado_Inscripcion` VARCHAR(50) NULL,
  `Cantidad_Inscripciones` INT NULL DEFAULT 1,
  PRIMARY KEY (`ID_Inscripcion_CS`),
  INDEX `fk_Hecho_Inscripciones_Dim_Usuario_idx` (`ID_Usuario_CS` ASC),
  INDEX `fk_Hecho_Inscripciones_Dim_Curso_idx` (`ID_Curso_CS` ASC),
  INDEX `fk_Hecho_Inscripciones_Dim_Fecha_idx` (`ID_Fecha_Inscripcion_CS` ASC),
  CONSTRAINT `fk_Hecho_Inscripciones_Dim_Usuario`
    FOREIGN KEY (`ID_Usuario_CS`)
    REFERENCES `Dim_Usuario` (`ID_Usuario_CS`),
  CONSTRAINT `fk_Hecho_Inscripciones_Dim_Curso`
    FOREIGN KEY (`ID_Curso_CS`)
    REFERENCES `Dim_Curso` (`ID_Curso_CS`),
  CONSTRAINT `fk_Hecho_Inscripciones_Dim_Fecha`
    FOREIGN KEY (`ID_Fecha_Inscripcion_CS`)
    REFERENCES `Dim_Fecha` (`ID_Fecha_CS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Hecho_Logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hecho_Logins` (
  `ID_Login_CS` BIGINT NOT NULL AUTO_INCREMENT,
  `ID_Usuario_CS` INT NOT NULL,
  `ID_Fecha_Login_CS` INT NOT NULL,
  `Cantidad_Logins` INT NULL DEFAULT 1,
  PRIMARY KEY (`ID_Login_CS`),
  INDEX `fk_Hecho_Logins_Dim_Usuario_idx` (`ID_Usuario_CS` ASC),
  INDEX `fk_Hecho_Logins_Dim_Fecha_idx` (`ID_Fecha_Login_CS` ASC),
  CONSTRAINT `fk_Hecho_Logins_Dim_Usuario`
    FOREIGN KEY (`ID_Usuario_CS`)
    REFERENCES `Dim_Usuario` (`ID_Usuario_CS`),
  CONSTRAINT `fk_Hecho_Logins_Dim_Fecha`
    FOREIGN KEY (`ID_Fecha_Login_CS`)
    REFERENCES `Dim_Fecha` (`ID_Fecha_CS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Puente_Curso_Instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Puente_Curso_Instructor` (
  `ID_Curso_CS` INT NOT NULL,
  `ID_Instructor_CS` INT NOT NULL,
  PRIMARY KEY (`ID_Curso_CS`, `ID_Instructor_CS`),
  INDEX `fk_Puente_Curso_Instructor_Dim_Instructor_idx` (`ID_Instructor_CS` ASC),
  CONSTRAINT `fk_Puente_Curso_Instructor_Dim_Curso`
    FOREIGN KEY (`ID_Curso_CS`)
    REFERENCES `Dim_Curso` (`ID_Curso_CS`),
  CONSTRAINT `fk_Puente_Curso_Instructor_Dim_Instructor`
    FOREIGN KEY (`ID_Instructor_CS`)
    REFERENCES `Dim_Instructor` (`ID_Instructor_CS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `Puente_Temario_Instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Puente_Temario_Instructor` (
  `ID_Temario_CS` INT NOT NULL,
  `ID_Instructor_CS` INT NOT NULL,
  PRIMARY KEY (`ID_Temario_CS`, `ID_Instructor_CS`),
  INDEX `fk_Puente_Temario_Instructor_Dim_Instructor_idx` (`ID_Instructor_CS` ASC),
  CONSTRAINT `fk_Puente_Temario_Instructor_Dim_Temario`
    FOREIGN KEY (`ID_Temario_CS`)
    REFERENCES `Dim_Temario` (`ID_Temario_CS`),
  CONSTRAINT `fk_Puente_Temario_Instructor_Dim_Instructor`
    FOREIGN KEY (`ID_Instructor_CS`)
    REFERENCES `Dim_Instructor` (`ID_Instructor_CS`))
ENGINE = InnoDB;