/*Inserción de los datos en la base de datos*/
/*Seleccionamos la base de datos creada*/
USE HOMEBAKERY;
/*Tabla Direccion*/
INSERT INTO DIRECCION (Calle,Ciudad,Provincia,Pais)
VALUES
('España 2448','San Miguel de Tucumán','Tucuman','Argentina'),
('Libertad 81','San Isidro de Lules','Tucuman','Argentina'),
('Diagonal Raúl Lechesi','Tafí Viejo','Tucumán','Argentina'),
('Av. Juan Domingo Perón 1900','Yerba Buena','Tucumán','Argentina'),
('Av. Brígido Terán 700','San Miguel de Tucumán','Tucumán','Argentina'),
('Batalla de Chacabuco 1122','San Miguel de Tucumán','Tucumán','Argentina'),
('Carlos Pellegrini 465','San Miguel de Tucumán','Tucumán','Argentina'),
('Av. Ejército del Norte 502','San Miguel de Tucumán','Tucumán','Argentina'),
('AV. Coronel Suarez 275','San Miguel de Tucumán','Tucumán','Argentina'),
('Av. Francisco de Aguirre 260','San Miguel de Tucumán','Tucumán','Argentina'),
('Jujuy 1426','San Miguel de Tucumán','Tucumán','Argentina'),
('Córdoba 646','San Miguel de Tucumán','Tucumán','Argentina'),
('Junín 202','San Miguel de Tucumán','Tucumán','Argentina'),
('Av. Manuel Belgrano 1560','San Miguel de Tucumán','Tucumán','Argentina');
/*Tabla Proveedor*/
/*Primero se modifica el tipo de dato en "Telefono_Proveedor" a VARCHAR(20), ya que nos arroja un error al insertar el número de teléfono como INT*/
ALTER TABLE PROVEEDOR MODIFY COLUMN Telefono_Proveedor VARCHAR(20);
/*Inserción de datos*/
INSERT INTO PROVEEDOR (Nombre_Proveedor,Categoria_Proveedor,Telefono_Proveedor,ID_Direccion) 
VALUES 
('Gomez Pardo - Sucursal Tafí Viejo','Supermercado',03814610300,3),
('Gomez Pardo - Sucursal Yerba Buena','Supermercado',03814383000,4),
('Gomez Pardo - Sucursal Brigido Terán','Supermercado',03814200558,5),
('Gomez Pardo - Sucursal Chacabuco','Supermercado',03814245525,6),
('Harituc - Sucursal Pellegrini','Distribuidor',03814230564,7),
('Harituc - Sucursal Ejército','Distribuidor',03812605849,8),
('Harituc - Sucursal Coronel Suárez','Distribuidor',03814300821,9),
('Harituc - Sucursal Francisco de Aguirre','Distribuidor',03814270565,10),
('Harituc - Sucursal Jujuy','Distribuidor',03814297992,11),
('Semillería Altieri - Sucursal Cordoba','Semillería',03814305826,12),
('Semillería Altieri - Sucursal Junín','Semillería',03814211258,13),
('Polituc','Distribuidor de Envases',03814321894,14);
/*Tabla Presentacion*/
/*Por algun motivo, al querer hacer la siguiente inserción arroja un error 1364 en el campo "ID_Presentacion", siendo que anteriormente
se creo el como AUTO_INCREMENT, procedemos a hacer un ALTER TABLE, a fin de aplicar correctamente el AUTO_INCREMENT */
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE PRESENTACION CHANGE COLUMN ID_Presentacion 
	ID_Presentacion INT NOT NULL AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;
/*Inserción de datos*/
TRUNCATE TABLE PRESENTACION;
INSERT INTO PRESENTACION (Nombre_Presentacion,Cantidad_Presentacion,Unidad_Medida)
VALUES
('Paquete de 25 kg',25,'kilogramos'),
('Paquete  de 1 kg',1,'kilogramos'),
('Paquete de 500 gr',500,'gramos'),
('Paquete de 100 gr',100,'gramos'),
('Paquete de 50 gr',50,'gramos'),
('Paquete de Bolsas',100,'unidades'),
('Paquete de Precintos',500,'unidades'),
('Paquete de pan x 800 gr',1,'unidades'),
('Paquete de 4 un.',4,'unidades'),
('Paquete de 3 un.',3,'unidades'),
('Paquete de 8 un.',8,'unidades'),
('Paquete 1 un.',1,'unidades'),
('Paquete de 2 kg',2,'kilogramos'),
('Paquete de 2,5 kg',2.5,'kilogramos'),
('Paquete de 300 gr	',300,'gramos'),
('Paquete de 400 gr',400,'gramos'),
('Bandeja de 12 un.',12,'unidades'),
('Envase de 2 litros',2,'litros'),
('Envase de 5 litros',5,'litros'),
('Envase de 1 litro',1,'litros');
/*Tabla Empleado*/
/*Primero se modifica el tipo de dato en "Telefono_Empleado" a VARCHAR(20), ya que nos arroja un error al insertar el número de teléfono como INT*/
ALTER TABLE EMPLEADO MODIFY COLUMN Telefono_Empleado VARCHAR(20);
INSERT INTO EMPLEADO (Nombre_Empleado,Telefono_Empleado,Sector_Empleado,ID_Direccion) 
VALUES
('Lisle Turpin', 03816611336, 'Producción', 1),
('Lauren Odger',03819773892, 'Ventas', 2);
/*Tabla Recetas*/
/*Se modifica la tabla Receta, se quitan los campos Categoria_Proceso, Cantidad_Material, Unidad_Medida e ID_Material para asignarlos a la tabla 
RECETA_MATERIAL*/
ALTER TABLE RECETA DROP FOREIGN KEY receta_ibfk_1; -- Se elimina la relacion de FK para luego eliminar las columnas
ALTER TABLE RECETA
	DROP COLUMN Categoria_Proceso,
    DROP COLUMN Cantidad_Material,
    DROP COLUMN Unidad_Medida,
    DROP COLUMN ID_Material;
/*Inserción de datos*/
INSERT INTO RECETA (Nombre_Receta) 
VALUES
('Pan Integral con Semillas'),
('Pan de Molde'),
('Pan Lactal'),
('Pan Hamburguesa'),
('Pan Arabe'),
('Pan Hamburguesa Lactal'),
('Prepizza'),
('Prepizza Integral'),
('Baguette'),
('Pan de Sandwich'),
('Pan Hojaldrado');
/*Tabla RECETA_MATERIAL*/
/*Se añaden las columnas Categoria_Proceso,Cantidad_Material, Unidad_Medida*/
ALTER TABLE RECETA_MATERIAL 
ADD COLUMN( 
	Categoria_Proceso VARCHAR(50) NOT NULL,
	Cantidad_Material FLOAT NOT NULL,
    Unidad_Medida VARCHAR(20) NOT NULL
);
 /*Tabla MATERIAL*/   
 /*se añade el campo Marca_Material y se elimina el campo Costo_Material, ID_Presentacion e ID_Proveedor (con sus respectivas FK)*/
ALTER TABLE MATERIAL ADD COLUMN Marca_Material VARCHAR(40);
ALTER TABLE MATERIAL DROP COLUMN Costo_Material;
ALTER TABLE MATERIAL DROP FOREIGN KEY material_ibfk_1; -- Se elimina la relacion de FK para luego eliminar las columnas
ALTER TABLE MATERIAL DROP FOREIGN KEY material_ibfk_2; -- Se elimina la relacion de FK para luego eliminar las columnas
ALTER TABLE MATERIAL 
	DROP COLUMN ID_Presentacion,
    DROP COLUMN ID_Proveedor;
/*Inserción de datos*/
INSERT INTO MATERIAL (Nombre_Material,Marca_Material,Categoria_Material) VALUES
('Harina 000','	Cañuelas','	Ingrediente'),
('Harina 0000','Cañuelas','	Ingrediente'),
('Harina Integral','Pureza','Ingrediente'), 
('Sal',NULL,'Ingrediente'),
('Azucar','Ledesma','Ingrediente'),
('Levadura',NULL,'Ingrediente'),
('Manteca','Primer Premio','Ingrediente'),
('Grasa',NULL,'Ingrediente'),
('Huevo',NULL,'Ingrediente'),
('Leche','Serenisima','Ingrediente'),
('Mix de Semillas',NULL,'Ingrediente'),
('Agua',NULL,'Ingrediente'),
('Aceite','Cocinero','Ingrediente'),
('Pure de Papa',NULL,'Ingrediente'),
('Polenta',NULL,'Ingrediente'),
('Avena',NULL,'Ingrediente'),
('Chocolate','Alpino','Ingrediente'),
('Cacao',NULL,'Ingrediente'),
('Bolsa PP 40x25',NULL,'Insumo'),
('Precinto',NULL,'Insumo');
/*Tabla RECETA_MATERIAL*/
/*Hacemos AUTO_INCREMENTAL el campo ID_Receta_Material*/
ALTER TABLE RECETA_MATERIAL CHANGE COLUMN ID_Receta_Material
	ID_Receta_Material INT NOT NULL AUTO_INCREMENT;
INSERT INTO RECETA_MATERIAL (ID_Receta, ID_Material, Categoria_Proceso, Cantidad_Material, Unidad_Medida) VALUES -- Revisar "Pan Arabe" y "Pan hamburguesa". Insertar valores individuales
(1,1,'Prefermento',94,'gramos'),
(1,12,'Prefermento',94,'gramos'),
(1,6,'Prefermento',2,'gramos'),
(1,1,'Bloque',219,'gramos'),
(1,3,'Bloque',94,'gramos'),
(1,4,'Bloque',8,'gramos'),
(1,5,'Bloque',41,'gramos'),
(1,7,'Bloque',41,'gramos'),
(1,11,'Activacion de Semillas',47,'gramos'),
(1,12,'Activacion de Semillas',47,'gramos'),
(1,5,'Terminación',10,'gramos'),
(1,10,'Terminación',5,'gramos'),
(1,11,'Terminación',30,'gramos'),
(1,19,'Empaque',1,'unidad'),
(1,20,'Empaque',1,'unidad'),
(2,1,'Prefermento',137,'gramos'),
(2,12,'Prefermento',137,'gramos'),
(2,6,'Prefermento',1,'gramos'),
(2,1,'Bloque',320,'gramos'),
(2,4,'Bloque',9,'gramos'),
(2,13,'Bloque',23,'gramos'),
(2,12,'Bloque',147,'gramos'),
(2,19,'Empaque',1,'unidad'),
(2,20,'Empaque',1,'unidad'),
(3,1,'Prefermento',147,'gramos'),
(3,10,'Prefermento',127,'gramos'),
(3,6,'Prefermento',5,'gramos'),
(3,1,'Tang zhong',39,'gramos'),
(3,12,'Tang zhong',196,'gramos'),
(3,1,'Bloque',303,'gramos'),
(3,4,'Bloque',10,'gramos'),
(3,5,'Bloque',49,'gramos'),
(3,7,'Bloque',49,'gramos'),
(3,5,'Terminación',10,'gramos'),
(3,10,'Terminación',5,'gramos'),
(3,19,'Empaque',1,'unidad'),
(3,20,'Empaque',1,'unidad'),
(4,1,'Prefermento',106,'gramos'),
(4,10,'Prefermento',101,'gramos'),
(4,6,'Prefermento',5,'gramos'),
(4,1,'Bloque',160,'gramos'),
(4,14,'Bloque',80,'gramos'),
(4,5,'Bloque',16,'gramos'),
(4,4,'Bloque',5,'gramos'),
(4,7,'Bloque',27,'gramos'),
(4,5,'Terminación',10,'gramos'),
(4,10,'Terminación',10,'gramos'),
(4,15,'Terminación',10,'gramos'),
(4,19,'Empaque',1,'unidad'),
(4,20,'Empaque',1,'unidad'),
(5,1,'Prefermento',84,'gramos'),
(5,12,'Prefermento',84,'gramos'),
(5,6,'Prefermento',1,'gramos'),
(5,1,'Bloque',197,'gramos'),
(5,4,'Bloque',6,'gramos'),
(5,13,'Bloque',8,'gramos'),
(5,12,'Bloque',99,'gramos'),
(5,19,'Empaque',1,'unidad'),
(5,20,'Empaque',1,'unidad');
/*Tabla Presentacion_Material*/
ALTER TABLE PRESENTACION_MATERIAL CHANGE COLUMN ID_Presentacion_Material
	ID_Presentacion_Material INT NOT NULL AUTO_INCREMENT;
INSERT INTO PRESENTACION_MATERIAL (ID_Presentacion, ID_Material) VALUES
(1,1),
(1,2),
(2,1),
(2,2),
(2,3),
(2,4),
(13,5),
(3,6),
(5,6),
(14,7),
(4,7),
(3,7),
(2,8),
(17,9),
(20,10),
(4,11),
(18,12),
(19,13),
(2,14),
(2,15),
(16,16),
(3,17),
(15,18),
(6,19),
(7,20);
/*Tabla Proveedor_Material*/
ALTER TABLE PROVEEDOR_MATERIAL CHANGE COLUMN ID_Proveedor_Material
	ID_Proveedor_Material INT NOT NULL AUTO_INCREMENT;
INSERT INTO PROVEEDOR_MATERIAL (ID_Material,ID_Proveedor) VALUES
(1,2),
(2,2),
(3,2),
(4,2),
(5,2),
(6,2),
(7,2),
(8,2),
(9,2),
(10,2),
(11,2),
(12,2),
(13,2),
(14,2),
(15,2),
(16,2),
(17,6),
(18,6),
(19,12),
(20,12);
/*Tabla Producto*/
INSERT INTO PRODUCTO (Nombre_Producto,ID_Receta,ID_Presentacion,Precio_Producto) VALUES 
('Pan Integral con Semillas',1,8,450),
('Pan de Molde',2,8,350),
('Pan Lactal',3,8,350),
('Pan Hamburguesa',4,9,300),
('Pan Arabe',5,9,250),
('Pan Hamburguesa Lactal',6,9,300),
('Prepizza',7,10,400),
('Prepizza Integral',8,10,450),
('Baguette',9,12,300),
('Pan de Sandwich',10,9,200),
('Pan Hojaldrado',11,11,400);