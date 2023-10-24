-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gamertx
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gamertx
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gamertx` DEFAULT CHARACTER SET utf8 ;
USE `gamertx` ;

-- -----------------------------------------------------
-- Table `gamertx`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`usuarios` (
  `email` VARCHAR(150) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `contraseña` VARCHAR(200) NOT NULL,
  `apellido` VARCHAR(50) NULL,
  `username` VARCHAR(30) NULL,
  `edad` TINYINT UNSIGNED NULL,
  `fecha_nacimiento` DATE NULL,
  `imagen_perfil` VARCHAR(300) NULL DEFAULT 'https://thumbs.dreamstime.com/z/s%C3%ADmbolo-masculino-del-perfil-de-la-persona-usuario-vector-icono-avatar-en-pictograma-plano-glyph-color-c%C3%ADrculo-118184766.jpg?w=768',
  `is_admin` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`direcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`direcciones` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `barrio` VARCHAR(50) NOT NULL,
  `calle` VARCHAR(50) NOT NULL,
  `ciudad` VARCHAR(35) NOT NULL,
  `departamento` ENUM("Amazonas", "Antioquia", "Arauca", "Atlántico", "Bolívar", "Boyacá", "Caldas", "Caquetá", "Casanare", "Cauca", "Cesar", "Chocó", "Córdoba", "Cundinamarca", "Guainía", "Guaviare", "Huila", "La Guajira", "Magdalena", "Meta", "Nariño", "Norte de Santander", "Putumayo", "Quindío", "Risaralda", "San Andrés, Providencia y Santa Catalina", "Santander", "Sucre", "Tolima", "Valle del Cauca", "Vaupés", "Vichada") NOT NULL,
  `codigo_postal` VARCHAR(10) NULL,
  PRIMARY KEY (`id_direccion`),
  UNIQUE INDEX `id_UNIQUE` (`id_direccion` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`categorias` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` ENUM("Laptop", "Monitor", "Desktop_PC", "Complementos", "Partes_PC") NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `orden` TINYINT NOT NULL,
  `numero_productos` SMALLINT NOT NULL,
  `url` VARCHAR(255) NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE INDEX `id_UNIQUE` (`id_categoria` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`ofertas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`ofertas` (
  `id_oferta` INT NOT NULL,
  `tipo` ENUM("Envio Gratis", "Descuento", "2x1") NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_cierre` DATETIME NOT NULL,
  `dias_activo` TINYINT NOT NULL,
  `valor_descuento` CHAR(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_oferta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`modelos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`modelos` (
  `id_modelo` INT NOT NULL AUTO_INCREMENT,
  `numero_referencia` VARCHAR(30) NOT NULL,
  `version` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_modelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`marcas` (
  `id_marca` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo` SET("Computadores", "Perifericos", "Componenetes", "Asistencia") NOT NULL,
  PRIMARY KEY (`id_marca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `id_categoria` INT NOT NULL,
  `id_modelo` INT NOT NULL,
  `id_marca` INT NOT NULL,
  `id_oferta` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `stock` SMALLINT(100) NOT NULL DEFAULT 0,
  `descripcion` VARCHAR(355) NOT NULL,
  `precio` INT NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `valoracion` INT NULL DEFAULT 0,
  `estado` VARCHAR(45) NULL,
  PRIMARY KEY (`id_producto`, `id_categoria`, `id_modelo`, `id_marca`),
  INDEX `fk_Productos_categorias1_idx` (`id_categoria` ASC) VISIBLE,
  INDEX `fk_Productos_ofertas1_idx` (`id_oferta` ASC) VISIBLE,
  INDEX `fk_Productos_modelos1_idx` (`id_modelo` ASC) VISIBLE,
  INDEX `fk_Productos_Marcas1_idx` (`id_marca` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_categorias1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `gamertx`.`categorias` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_ofertas1`
    FOREIGN KEY (`id_oferta`)
    REFERENCES `gamertx`.`ofertas` (`id_oferta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_modelos1`
    FOREIGN KEY (`id_modelo`)
    REFERENCES `gamertx`.`modelos` (`id_modelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Marcas1`
    FOREIGN KEY (`id_marca`)
    REFERENCES `gamertx`.`marcas` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`comentarios` (
  `id_comentario` INT NOT NULL,
  `titulo` VARCHAR(35) NOT NULL,
  `texto` VARCHAR(400) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `calificacion` TINYINT NOT NULL DEFAULT 0,
  `usuarios_email` VARCHAR(150) NOT NULL,
  `id_producto` INT NOT NULL,
  `likes` SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_comentario`),
  INDEX `fk_comentarios_usuarios1_idx` (`usuarios_email` ASC) VISIBLE,
  INDEX `fk_Comentarios_Productos1_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_comentarios_usuarios1`
    FOREIGN KEY (`usuarios_email`)
    REFERENCES `gamertx`.`usuarios` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentarios_Productos1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `gamertx`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`imagenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`imagenes` (
  `id_imagen` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `url` VARCHAR(300) NOT NULL,
  `texto_alternativo` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_imagen`, `id_producto`),
  INDEX `fk_imagenes_Productos1_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_imagenes_Productos1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `gamertx`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`post` (
  `id_post` INT NOT NULL AUTO_INCREMENT,
  `email_usuario` VARCHAR(150) NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `contenido` TEXT NOT NULL,
  `fecha_publicacion` DATE NOT NULL,
  `likes` TINYINT(100) NULL DEFAULT 0,
  PRIMARY KEY (`id_post`),
  INDEX `fk_Post_Usuarios1_idx` (`email_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Post_Usuarios1`
    FOREIGN KEY (`email_usuario`)
    REFERENCES `gamertx`.`usuarios` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`label` (
  `id_label` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_label`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`metodo_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`metodo_pago` (
  `id_metodo_pago` INT NOT NULL AUTO_INCREMENT,
  `titular` VARCHAR(45) NOT NULL,
  `banco_emisor` VARCHAR(45) NULL,
  `numero_tarjeta` VARCHAR(45) NULL,
  `tipo` ENUM("Bancaria", "Tarjeta", "Paypal") NOT NULL,
  `numero_cuenta` VARCHAR(45) NULL,
  PRIMARY KEY (`id_metodo_pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`residencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`residencias` (
  `email_usuario` VARCHAR(150) NOT NULL,
  `id_direccion` INT NOT NULL,
  PRIMARY KEY (`email_usuario`, `id_direccion`),
  INDEX `fk_usuarios_has_direcciones_direcciones1_idx` (`id_direccion` ASC) VISIBLE,
  INDEX `fk_usuarios_has_direcciones_usuarios_idx` (`email_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_direcciones_usuarios`
    FOREIGN KEY (`email_usuario`)
    REFERENCES `gamertx`.`usuarios` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_direcciones_direcciones1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `gamertx`.`direcciones` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`pago_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`pago_usuario` (
  `id_pago_usuario` INT NOT NULL AUTO_INCREMENT,
  `id_metodo_pago` INT NOT NULL,
  `usuarios_email` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_pago_usuario`, `id_metodo_pago`),
  INDEX `fk_metodo_pago_has_usuarios_usuarios1_idx` (`usuarios_email` ASC) VISIBLE,
  INDEX `fk_Pago_usuario_metodo_pago1_idx` (`id_metodo_pago` ASC) VISIBLE,
  CONSTRAINT `fk_metodo_pago_has_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_email`)
    REFERENCES `gamertx`.`usuarios` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pago_usuario_metodo_pago1`
    FOREIGN KEY (`id_metodo_pago`)
    REFERENCES `gamertx`.`metodo_pago` (`id_metodo_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`tematica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`tematica` (
  `id_post` INT NOT NULL,
  `id_label` INT NOT NULL,
  PRIMARY KEY (`id_post`, `id_label`),
  INDEX `fk_post_has_label_label1_idx` (`id_label` ASC) VISIBLE,
  INDEX `fk_post_has_label_post1_idx` (`id_post` ASC) VISIBLE,
  CONSTRAINT `fk_post_has_label_post1`
    FOREIGN KEY (`id_post`)
    REFERENCES `gamertx`.`post` (`id_post`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_has_label_label1`
    FOREIGN KEY (`id_label`)
    REFERENCES `gamertx`.`label` (`id_label`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`pedidos` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `email_usuario` VARCHAR(150) NOT NULL,
  `fecha_compra` DATETIME NOT NULL,
  `fecha_entrega` DATETIME NOT NULL,
  `total` DOUBLE NOT NULL,
  `estado` ENUM("En preparacion""Enviado", "Entregado") NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_Pedidos_usuarios1_idx` (`email_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_usuarios1`
    FOREIGN KEY (`email_usuario`)
    REFERENCES `gamertx`.`usuarios` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`carrito_compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`carrito_compras` (
  `id_carrito` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `email_usuario` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_carrito`, `id_producto`, `email_usuario`),
  INDEX `fk_usuarios_has_Productos_Productos1_idx` (`id_producto` ASC) VISIBLE,
  INDEX `fk_usuarios_has_Productos_usuarios1_idx` (`email_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_Productos_usuarios1`
    FOREIGN KEY (`email_usuario`)
    REFERENCES `gamertx`.`usuarios` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_Productos_Productos1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `gamertx`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`detalles_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`detalles_pedido` (
  `id_detalle_pedido` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `id_pedido` INT NOT NULL,
  PRIMARY KEY (`id_detalle_pedido`, `id_producto`, `id_pedido`),
  INDEX `fk_Productos_has_Pedidos_Pedidos1_idx` (`id_pedido` ASC) VISIBLE,
  INDEX `fk_Productos_has_Pedidos_Productos1_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_has_Pedidos_Productos1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `gamertx`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_has_Pedidos_Pedidos1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `gamertx`.`pedidos` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`caracteristicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`caracteristicas` (
  `id_caracteristica` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`id_caracteristica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamertx`.`productos_has_caracteristicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamertx`.`productos_has_caracteristicas` (
  `id_producto` INT NOT NULL,
  `id_caracteristica` INT NOT NULL,
  PRIMARY KEY (`id_producto`, `id_caracteristica`),
  INDEX `fk_Productos_has_Caracteristicas_Caracteristicas1_idx` (`id_caracteristica` ASC) VISIBLE,
  INDEX `fk_Productos_has_Caracteristicas_Productos1_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_has_Caracteristicas_Productos1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `gamertx`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_has_Caracteristicas_Caracteristicas1`
    FOREIGN KEY (`id_caracteristica`)
    REFERENCES `gamertx`.`caracteristicas` (`id_caracteristica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
