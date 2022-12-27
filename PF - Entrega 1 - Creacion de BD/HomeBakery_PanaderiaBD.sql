/*Creación de la base de datos para la panadería Home Bakery*/
CREATE DATABASE HOMEBAKERY;
/*Seleccionamos la base de datos creada*/
USE HOMEBAKERY;
/*Creación de las tablas*/
#Tabla "Direccion"
CREATE TABLE DIRECCION (
	ID_Direccion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Calle VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
	Provincia VARCHAR(50) NOT NULL,
    Pais VARCHAR(30) NOT NULL
);
#Tabla "Cliente"
CREATE TABLE CLIENTE (
	ID_Cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Cliente VARCHAR(50) NOT NULL,
    Categoria_Cliente VARCHAR(50) NOT NULL,
	Edad INT,
    Telefono_Cliente INT,
    ID_Direccion INT,
    FOREIGN KEY (ID_Direccion)
    REFERENCES DIRECCION(ID_Direccion)
);
#Tabla "Proveedor"
CREATE TABLE PROVEEDOR (
	ID_Proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Proveedor VARCHAR(50) NOT NULL,
    Categoria_Proveedor VARCHAR(50) NOT NULL,
	Telefono_Proveedor INT, /*Modificar a BIGINT o a VARCHAR*/
    ID_Direccion INT,
    FOREIGN KEY (ID_Direccion)
    REFERENCES DIRECCION(ID_Direccion)
);
#Tabla "Empleado"
CREATE TABLE EMPLEADO (
	ID_Empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Empleado VARCHAR(50) NOT NULL,
	Sector_Empleado VARCHAR(50) NOT NULL,
    Telefono_Empleado INT,
	ID_Direccion INT,
    FOREIGN KEY (ID_Direccion)
    REFERENCES DIRECCION(ID_Direccion)
);
#Tabla "Presentacion"
CREATE TABLE PRESENTACION (
	ID_Presentacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Presentacion VARCHAR(50) NOT NULL,
    Cantidad_Presentacion FLOAT NOT NULL,
    Unidad_Medida VARCHAR(20)
);
#Tabla "Material"
CREATE TABLE MATERIAL (
	ID_Material INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Material VARCHAR(50) NOT NULL,
    Costo_Material FLOAT NOT NULL, /*Eliminar Costo_Material y añadir Marca_Material*/
    Categoria_Material VARCHAR(50) NOT NULL,
    ID_Presentacion INT NOT NULL,
	ID_Proveedor INT NOT NULL,
    FOREIGN KEY (ID_Presentacion)
    REFERENCES PRESENTACION(ID_Presentacion), -- Elimnar esta relacion porque en la tabla PRESENTACION_MATERIAL ya estará presente
    FOREIGN KEY (ID_Proveedor)
    REFERENCES PROVEEDOR(ID_Proveedor) -- Elimnar esta relacion porque en la tabla PROVEEDOR_MATERIAL ya estará presente
);
#Tabla "Receta"
CREATE TABLE RECETA (
	ID_Receta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Receta VARCHAR(50) NOT NULL,
    Cantidad_Material FLOAT NOT NULL, -- Se elimina la columna y pasa a la tabla RECETA_MATERIAL
    Unidad_Medida VARCHAR(20) NOT NULL, -- Se elimina la columna y pasa a la tabla RECETA_MATERIAL
    Categoria_Proceso VARCHAR(50) NOT NULL, -- Se elimina la columna y pasa a la tabla RECETA_MATERIAL
    ID_Material INT NOT NULL, -- Se elimina la columna y pasa a la tabla RECETA_MATERIAL
	FOREIGN KEY (ID_Material)  -- Se elimina la relación para poder eliminar las columnas anteriores
    REFERENCES MATERIAL(ID_Material)
);
#Tabla "Producto"
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
#Tabla "Pedido"
CREATE TABLE PEDIDO (
	ID_Pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha_Pedido DATETIME NOT NULL,
    Cantidad_Producto INT NOT NULL,
    Estado_Pedido VARCHAR(50),
    ID_Producto INT NOT NULL,
    ID_Cliente INT NOT NULL,
    FOREIGN KEY (ID_Producto)
    REFERENCES PRODUCTO(ID_Producto),
    FOREIGN KEY (ID_Cliente)
    REFERENCES CLIENTE(ID_Cliente)
);
#Tabla "Compra"
CREATE TABLE COMPRA (
	ID_Compra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha_Compra DATETIME NOT NULL,
	Medio_Pago VARCHAR(30),
    Valor_Compra FLOAT NOT NULL,
    Categoria_Compra VARCHAR(50),
    ID_Proveedor INT NOT NULL,
    ID_Material INT NOT NULL,
    ID_Empleado INT NOT NULL,
	FOREIGN KEY (ID_Proveedor)
    REFERENCES PROVEEDOR(ID_Proveedor),
    FOREIGN KEY (ID_Material)
    REFERENCES MATERIAL(ID_Material),
    FOREIGN KEY (ID_Empleado)
    REFERENCES EMPLEADO(ID_Empleado)
);
#Tabla "Venta"
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
/*Creación de tablas de enlace*/
#Tabla "Pedido_Producto"
CREATE TABLE PEDIDO_PRODUCTO (
	ID_Pedido_Producto INT NOT NULL PRIMARY KEY,
    ID_Pedido INT NOT NULL,
	ID_Producto INT NOT NULL,
    FOREIGN KEY (ID_Pedido)
    REFERENCES PEDIDO(ID_Pedido),
    FOREIGN KEY (ID_Producto)
    REFERENCES PRODUCTO(ID_Producto)
);
#Tabla "Presentacion_Material"
CREATE TABLE PRESENTACION_MATERIAL (
	ID_Presentacion_Material INT NOT NULL PRIMARY KEY,
	ID_Presentacion INT NOT NULL,
    ID_Material INT NOT NULL,
    FOREIGN KEY (ID_Presentacion)
    REFERENCES PRESENTACION(ID_Presentacion),
	FOREIGN KEY (ID_Material)
    REFERENCES MATERIAL(ID_Material)
);
#Tabla "Compra_Material"
CREATE TABLE COMPRA_MATERIAL (
	ID_Compra_Material INT NOT NULL PRIMARY KEY,
    ID_Compra INT NOT NULL,
    ID_Material INT NOT NULL,
    FOREIGN KEY (ID_Compra)
    REFERENCES COMPRA(ID_Compra),
	FOREIGN KEY (ID_Material)
    REFERENCES MATERIAL(ID_Material)
);
#Tabla "Proveedor_Material"
CREATE TABLE PROVEEDOR_MATERIAL (
	ID_Proveedor_Material INT NOT NULL PRIMARY KEY,
    ID_Proveedor INT NOT NULL,
    ID_Material INT NOT NULL,
    FOREIGN KEY (ID_Proveedor)
    REFERENCES PROVEEDOR(ID_Proveedor),
    FOREIGN KEY (ID_Material)
    REFERENCES MATERIAL(ID_Material)
);
#Tabla "Receta_Material"
CREATE TABLE RECETA_MATERIAL (
	ID_Receta_Material INT NOT NULL PRIMARY KEY, -- Hacer AUTO_INCREMENTAL
    ID_Receta INT NOT NULL,
	ID_Material INT NOT NULL,
    FOREIGN KEY (ID_Receta)
    REFERENCES RECETA(ID_Receta),
    FOREIGN KEY (ID_Material)
    REFERENCES MATERIAL(ID_Material)
);

