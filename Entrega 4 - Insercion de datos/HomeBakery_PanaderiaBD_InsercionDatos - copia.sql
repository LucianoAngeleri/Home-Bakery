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