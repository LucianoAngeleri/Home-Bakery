/*Creación de triggers para la base de datos*/
/*Seleccionamos la base de datos creada*/
USE HOMEBAKERY;
/*Creamos la tabla de auditoria de las tablas COMPRA y VENTA*/
CREATE TABLE LOG_COMPRA (
	ID_Log_Compra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ID_Compra INT NOT NULL,
    Usuario_Registro VARCHAR(50) NOT NULL,
    Fecha_Registro DATE NOT NULL,
    Hora_Registro TIME NOT NULL
);
CREATE TABLE LOG_VENTA (
	ID_Log_Venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ID_Venta INT NOT NULL,
    Usuario_Registro VARCHAR(50) NOT NULL,
    Fecha_Registro DATE NOT NULL,
    Hora_Registro TIME NOT NULL
);
/*Creación del trigger para la inserción de nuevos datos sobre la tabla de auditoría "LOG_COMPRA"*/
DELIMITER $$
CREATE TRIGGER `tr_log_insert_COMPRA` 
AFTER INSERT ON `COMPRA`
FOR EACH ROW
BEGIN
	INSERT INTO `LOG_COMPRA`(
		ID_Compra,
		Usuario_Registro, 
		Fecha_Registro, 
		Hora_Registro)
    VALUES(
		NEW.ID_Compra, 
		USER(), 
		CURRENT_DATE(), 
		CURRENT_TIME());
END$$
DELIMITER ;
/*Creación del trigger para la inserción de nuevos datos sobre la tabla de auditoría "LOG_VENTA"*/
DELIMITER $$
CREATE TRIGGER `tr_log_insert_VENTA` 
AFTER INSERT ON `VENTA`
FOR EACH ROW
BEGIN
	INSERT INTO `LOG_COMPRA`(
		ID_Venta,
		Usuario_Registro,
		Fecha_Registro,
		Hora_Registro)
    VALUES (
		NEW.ID_Venta, 
		USER(), 
		CURRENT_DATE(), 
		CURRENT_TIME());
END$$
DELIMITER ;
/*A fin de tener un respaldo de las tablas VENTA y COMPRA crearemos triggers que nos ayuden a ir almacenando los datos antes de ser borrados*/
/*Creamos la tabla de backup de las tablas COMPRA y VENTA*/
CREATE TABLE BACKUP_COMPRA (
	ID_BK_Compra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ID_Compra INT NOT NULL,
    Usuario_Registro VARCHAR(50) NOT NULL,
    Fecha_Registro DATE NOT NULL,
    Hora_Registro TIME NOT NULL,
	Fecha_Compra DATETIME, 
	Medio_Pago VARCHAR(30), 
	Valor_Compra FLOAT, 
	Categoria_Compra VARCHAR(50) ,
	ID_Proveedor INT,
	ID_Empleado INT
);
CREATE TABLE BACKUP_VENTA (
	ID_BK_Venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ID_Venta INT NOT NULL,
    Usuario_Registro VARCHAR(50) NOT NULL,
    Fecha_Registro DATE NOT NULL,
    Hora_Registro TIME NOT NULL,
	Fecha_Venta DATETIME, 
	Medio_Pago VARCHAR(30),
	Valor_Venta FLOAT,
	ID_Pedido INT,
	ID_Empleado INT
);
/*Creación del trigger para hacer el backup en la tabla "BACKUP_COMPRA" antes de la eliminacion sobre la tabla "COMPRA"*/
DELIMITER $$
CREATE TRIGGER `tr_backup_COMPRA`
BEFORE DELETE ON COMPRA
FOR EACH ROW
BEGIN
    INSERT INTO BACKUP_COMPRA (
		ID_Compra,
        Usuario_Registro,
		Fecha_Registro,
		Hora_Registro,
		Fecha_Compra,
		Medio_Pago,
		Valor_Compra,
		Categoria_Compra,
		ID_Proveedor,
		ID_Empleado)
	VALUES (
		OLD.ID_Compra, 
		USER(), 
		CURRENT_DATE(), 
		CURRENT_TIME(), 
		OLD.Fecha_Compra, 
		OLD.Medio_Pago, 
		OLD.Valor_Compra, 
		OLD.Categoria_Compra, 
		OLD.ID_Proveedor, 
		OLD.ID_Empleado);
END$$
DELIMITER ;
/*Creación del trigger para hacer el backup en la tabla "BACKUP_VENTA" antes de la eliminacion sobre la tabla "VENTA"*/
DELIMITER $$
CREATE TRIGGER `tr_backup_VENTA`
BEFORE DELETE ON VENTA
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP_VENTA (
		ID_Venta,
        Usuario_Registro,
        Fecha_Registro,
        Hora_Registro,
        Fecha_Venta,
        Medio_Pago,
        Valor_Venta,
        ID_Pedido,
        ID_Empleado)
    VALUES (
		OLD.ID_Venta,
        USER(),
        CURRENT_DATE(),
        CURRENT_TIME(),
        OLD.Fecha_Venta,
        OLD.Medio_Pago,
        OLD.Valor_Venta,
        OLD.ID_Pedido,
        OLD.ID_Empleado);
END$$
DELIMITER ;