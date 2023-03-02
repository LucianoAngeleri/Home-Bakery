/*Creación de la base de datos para la panadería Home Bakery*/
CREATE DATABASE HOMEBAKERY;
/*Seleccionamos la base de datos creada*/
USE HOMEBAKERY;
/*Creación de las tablas*/
#Tabla de dimension "Direccion"
CREATE TABLE DIRECCION (
	ID_Direccion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Calle VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
	Provincia VARCHAR(50) NOT NULL,
    Pais VARCHAR(30) NOT NULL
);
#Tabla de dimensión "Cliente" 
CREATE TABLE CLIENTE (
	ID_Cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Cliente VARCHAR(50) NOT NULL,
    Categoria_Cliente VARCHAR(50) NOT NULL,
	Edad INT,
    Telefono_Cliente VARCHAR(20),
    ID_Direccion INT,
    FOREIGN KEY (ID_Direccion)
    REFERENCES DIRECCION(ID_Direccion)
);
#Tabla de dimensión "Proveedor"
CREATE TABLE PROVEEDOR (
	ID_Proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Proveedor VARCHAR(50) NOT NULL,
    Categoria_Proveedor VARCHAR(50) NOT NULL,
	Telefono_Proveedor VARCHAR(20),
    ID_Direccion INT,
    FOREIGN KEY (ID_Direccion)
    REFERENCES DIRECCION(ID_Direccion)
);
#Tabla de dimensión "Empleado"
CREATE TABLE EMPLEADO (
	ID_Empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Empleado VARCHAR(50) NOT NULL,
	Sector_Empleado VARCHAR(50) NOT NULL,
    Telefono_Empleado VARCHAR(20),
	ID_Direccion INT,
    FOREIGN KEY (ID_Direccion)
    REFERENCES DIRECCION(ID_Direccion)
);
#Tabla de dimensión "Presentacion"
CREATE TABLE PRESENTACION (
	ID_Presentacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Presentacion VARCHAR(50) NOT NULL,
    Cantidad_Presentacion FLOAT NOT NULL,
    Unidad_Medida VARCHAR(20)
);
#Tabla de dimensión "Material"
CREATE TABLE MATERIAL (
	ID_Material INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Material VARCHAR(50) NOT NULL,
    Categoria_Material VARCHAR(50) NOT NULL,
    Marca_Material VARCHAR(40) NULL DEFAULT NULL
);
#Tabla de enlace "Presentacion_Material"
CREATE TABLE PRESENTACION_MATERIAL (
	ID_Presentacion_Material INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ID_Presentacion INT NOT NULL,
    ID_Material INT NOT NULL,
    FOREIGN KEY (ID_Presentacion)
    REFERENCES PRESENTACION(ID_Presentacion),
	FOREIGN KEY (ID_Material)
    REFERENCES MATERIAL(ID_Material)
);
#Tabla de enlace "Proveedor_Material"
CREATE TABLE PROVEEDOR_MATERIAL (
	ID_Proveedor_Material INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_Proveedor INT NOT NULL,
    ID_Material INT NOT NULL,
    FOREIGN KEY (ID_Proveedor)
    REFERENCES PROVEEDOR(ID_Proveedor),
    FOREIGN KEY (ID_Material)
    REFERENCES MATERIAL(ID_Material)
);
#Tabla de dimensión "Receta"
CREATE TABLE RECETA (
	ID_Receta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Receta VARCHAR(50) NOT NULL
);
#Tabla de enlace "Receta_Material"
CREATE TABLE RECETA_MATERIAL (
	ID_Receta_Material INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_Receta INT NOT NULL,
	ID_Material INT NOT NULL,
    Categoria_Proceso VARCHAR(50) NOT NULL,
    Cantidad_Material FLOAT NOT NULL,
    Unidad_Medida VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Receta)
    REFERENCES RECETA(ID_Receta),
    FOREIGN KEY (ID_Material)
    REFERENCES MATERIAL(ID_Material)
);
#Tabla de dimensión "Producto"
CREATE TABLE PRODUCTO (
	ID_Producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Producto VARCHAR(50) NOT NULL,
    Precio_Producto FLOAT NOT NULL,
    ID_Presentacion INT NOT NULL,
    ID_Receta INT NOT NULL,
    FOREIGN KEY (ID_Presentacion)
    REFERENCES PRESENTACION(ID_Presentacion),
    FOREIGN KEY (ID_Receta)
    REFERENCES RECETA(ID_Receta)
);
#Tabla de hecho "Pedido"
CREATE TABLE PEDIDO (
	ID_Pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha_Pedido DATETIME NOT NULL,
    Estado_Pedido VARCHAR(50),
    ID_Cliente INT NOT NULL,
    FOREIGN KEY (ID_Cliente)
    REFERENCES CLIENTE(ID_Cliente)
);
#Tabla de enlace "Pedido_Producto"
CREATE TABLE PEDIDO_PRODUCTO (
	ID_Pedido_Producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT NOT NULL,
	ID_Producto INT NOT NULL, 
    Cantidad_Producto INT NOT NULL,
    FOREIGN KEY (ID_Pedido)
    REFERENCES PEDIDO(ID_Pedido),
    FOREIGN KEY (ID_Producto)
    REFERENCES PRODUCTO(ID_Producto)
);
#Tabla de hecho "Compra"
CREATE TABLE COMPRA (
	ID_Compra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha_Compra DATETIME NOT NULL,
	Medio_Pago VARCHAR(30),
    Valor_Compra FLOAT NOT NULL,
    Categoria_Compra VARCHAR(50),
    ID_Proveedor INT NOT NULL,
    ID_Empleado INT NOT NULL,
	FOREIGN KEY (ID_Proveedor)
    REFERENCES PROVEEDOR(ID_Proveedor),
    FOREIGN KEY (ID_Empleado)
    REFERENCES EMPLEADO(ID_Empleado)
);
#Tabla de enlace "Compra_Material"
CREATE TABLE COMPRA_MATERIAL (
	ID_Compra_Material INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_Compra INT NOT NULL,
    ID_Material INT NOT NULL,
    Cantidad_Material INT NOT NULL,
    FOREIGN KEY (ID_Compra)
    REFERENCES COMPRA(ID_Compra),
	FOREIGN KEY (ID_Material)
    REFERENCES MATERIAL(ID_Material)
);
#Tabla de hecho "Venta"
CREATE TABLE VENTA (
	ID_Venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha_Venta DATETIME NOT NULL,
	Medio_Pago VARCHAR(30),
    Valor_Venta FLOAT NOT NULL,
    ID_Pedido INT NOT NULL,
    ID_Empleado INT NOT NULL,
    FOREIGN KEY (ID_Pedido)
    REFERENCES PEDIDO(ID_Pedido),
    FOREIGN KEY (ID_Empleado)
    REFERENCES EMPLEADO(ID_Empleado)
);