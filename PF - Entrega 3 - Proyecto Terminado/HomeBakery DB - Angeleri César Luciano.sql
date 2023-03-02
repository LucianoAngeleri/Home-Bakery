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
/*Inserción de los datos en la base de datos*/
/*Seleccionamos la base de datos creada*/
USE HOMEBAKERY;
/*Tabla de dimensión Direccion*/
INSERT INTO DIRECCION (Calle,Ciudad,Provincia,Pais) VALUES
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
('Av. Manuel Belgrano 1560','San Miguel de Tucumán','Tucumán','Argentina'),
('3 Esker Hill', 'Coté-Lai', 'Chaco', 'Argentina'),
('2 Pawling Avenue', 'Villa Ángela', 'Chaco', 'Argentina'),
('37 Buena Vista Point', 'Río Ceballos', 'Córdoba', 'Argentina'),
('59992 Scoville Drive', 'Capitán Bermúdez', 'Santa Fe', 'Argentina'),
('8 Graceland Plaza', 'Caleta Olivia', 'Santa Cruz', 'Argentina'),
('09 Bartillon Hill', 'Bella Vista', 'Tucumán', 'Argentina'),
('519 Fulton Circle', 'Candelaria', 'Misiones', 'Argentina'),
('28404 Hansons Pass', 'Belén de Escobar', 'Buenos Aires', 'Argentina'),
('31 Cardinal Alley', 'Chilecito', 'La Rioja', 'Argentina'),
('01700 Eliot Crossing', 'Chilecito', 'La Rioja', 'Argentina'),
('5 Southridge Hill', 'Chimbas', 'San Juan', 'Argentina'),
('118 Clove Road', 'Cipolletti', 'Río Negro', 'Argentina'),
('4599 Mcguire Court', 'Avellaneda', 'Buenos Aires', 'Argentina'),
('62 Spaight Parkway', 'Colonia Wanda', 'Misiones', 'Argentina'),
('814 Shoshone Court', 'Comandante Luis Piedra Buena', 'Santa Cruz', 'Argentina'),
('954 Bluejay Alley', 'Coronel Belisle', 'Río Negro', 'Argentina'),
('84120 Dovetail Plaza', 'Ezeiza', 'Buenos Aires', 'Argentina'),
('9 Bartelt Point', 'Corralito', 'Córdoba', 'Argentina'),
('05358 Donald Way', 'Corzuela', 'Chaco', 'Argentina'),
('7 American Ash Circle', 'Costa Sacate', 'Córdoba', 'Argentina'),
('12649 Tennessee Parkway', 'Villa Nueva', 'Córdoba', 'Argentina'),
('33154 Morrow Park', 'Cruz Alta', 'Tucumán', 'Argentina'),
('30 Village Avenue', 'Puerto Iguazú', 'Misiones', 'Argentina'),
('8 Straubel Plaza', 'Curuzú Cuatiá', 'Corrientes', 'Argentina'),
('4 Marcy Circle', 'Daireaux', 'Buenos Aires', 'Argentina'),
('0 American Way', 'Darwin', 'Río Negro', 'Argentina'),
('293 Vermont Drive', 'Deán Funes', 'Córdoba', 'Argentina'),
('4451 Anthes Court', 'Diamante', 'Entre Ríos', 'Argentina'),
('81 Cascade Hill', 'Buena Esperanza', 'San Luis', 'Argentina'),
('6 Monument Hill', 'El Colorado', 'Formosa', 'Argentina'),
('19 Hudson Road', 'El Quebrachal', 'Salta', 'Argentina'),
('16 Fulton Court', 'Brea Pozo', 'Santiago del Estero', 'Argentina'),
('03 Ridgeview Center', 'Villa Constitución', 'Santa Fe', 'Argentina'),
('7810 Pierstorff Hill', 'Aguilares', 'Tucumán', 'Argentina'),
('17 Mockingbird Hill', 'Villa María', 'Córdoba', 'Argentina'),
('501 Lien Hill', 'El Quebrachal', 'Salta', 'Argentina'),
('444 Iowa Point', 'Colegiales', 'Buenos Aires', 'Argentina'),
('1 Clove Street', 'Embarcación', 'Salta', 'Argentina'),
('623 Warner Place', 'Firmat', 'Buenos Aires', 'Argentina'),
('8 Hovde Parkway', 'Firmat', 'Buenos Aires', 'Argentina'),
('949 Schmedeman Court', 'Cipolletti', 'Río Negro', 'Argentina'),
('8317 Laurel Pass', 'Villa Nueva', 'Córdoba', 'Argentina'),
('641961 Donald Way', 'Firmat', 'Buenos Aires', 'Argentina'),
('29785 Del Mar Parkway', 'Garupá', 'Misiones', 'Argentina'),
('3 Monica Court', 'General Belgrano', 'Buenos Aires', 'Argentina'),
('6555 Manufacturers Way', 'Puerto Iguazú', 'Misiones', 'Argentina'),
('9325 Ronald Regan Drive', 'San Carlos de Bariloche', 'Río Negro', 'Argentina'),
('8110 Kingsford Circle', 'Cañuelas', 'Buenos Aires', 'Argentina'),
('12 International Plaza', 'General Levalle', 'Buenos Aires', 'Argentina'),
('551 Dakota Pass', 'Tafí del Valle', 'Tucumán', 'Argentina'),
('4688 Glacier Hill Street', 'General Roca', 'Río Negro', 'Argentina'),
('2358 Lerdahl Lane', 'Gobernador Costa', 'Chubut', 'Argentina'),
('519 Bay Trail', 'Clodomira', 'Santiago del Estero', 'Argentina'),
('7571 Park Meadow Terrace', 'Gobernador Costa', 'Chubut', 'Argentina'),
('21 International Plaza', 'Guatimozín', 'Córdoba', 'Argentina'),
('36 Clyde Gallagher Junction', 'Guatimozín', 'Córdoba', 'Argentina'),
('763 Ridgeview Alley', 'Hualfín', 'Catamarca', 'Argentina'),
('9682 Forest Street', 'Hualfín', 'Catamarca', 'Argentina'),
('81580 Comanche Terrace', 'Hualfín', 'Catamarca', 'Argentina'),
('317 Aberg Lane', 'Huanchillas', 'Córdoba', 'Argentina'),
('13242 Moulton Terrace', 'Clodomira', 'Santiago del Estero', 'Argentina'),
('74 Lillian Park', 'Isla Verde', 'Córdoba', 'Argentina'),
('0 Lawn Way', 'Ituzaingó', 'Buenos Aires', 'Argentina'),
('07 Anderson Point', 'Jardín América', 'Misiones', 'Argentina'),
('3 Lerdahl Terrace', 'La Francia', 'Córdoba', 'Argentina'),
('0 Debra Alley', 'La Francia', 'Córdoba', 'Argentina'),
('27 Kennedy Pass', 'Villa La Angostura', 'Neuquén', 'Argentina'),
('66113 5th Parkway', 'La Puerta de San José', 'Catamarca', 'Argentina'),
('7094 Magdeline Center', 'La Punta', 'San Luis', 'Argentina'),
('75 Claremont Circle', 'Laborde', 'Córdoba', 'Argentina'),
('20 Graedel Way', 'Laboulaye', 'Córdoba', 'Argentina'),
('621 Raven Terrace', 'Las Garcitas', 'Chaco', 'Argentina'),
('11 Lerdahl Point', 'Las Heras', 'Mendoza', 'Argentina'),
('980 Trailsway Point', 'Las Lajas', 'Neuquén', 'Argentina'),
('6474 Trailsway Drive', 'Leones', 'Córdoba', 'Argentina'),
('99 Cascade Center', 'Lincoln', 'Buenos Aires', 'Argentina'),
('33430 6th Drive', 'Londres', 'Catamarca', 'Argentina'),
('12 American Place', 'Necochea', 'Buenos Aires', 'Argentina'),
('878 Carberry Parkway', 'Machagai', 'Chaco', 'Argentina'),
('74 Weeping Birch Terrace', 'Mainque', 'Río Negro', 'Argentina'),
('054 Debra Pass', 'Quilmes', 'Buenos Aires', 'Argentina'),
('7 Katie Lane', 'Gualeguaychú', 'Entre Ríos', 'Argentina'),
('35242 School Plaza', 'Maipú', 'Buenos Aires', 'Argentina'),
('74561 Kedzie Center', 'Marcos Juárez', 'Córdoba', 'Argentina'),
('939 North Street', 'Mercedes', 'Buenos Aires', 'Argentina'),
('43 Onsgard Place', 'Molinos', 'Salta', 'Argentina'),
('6 Dwight Street', 'Morrison', 'Córdoba', 'Argentina'),
('6 Meadow Ridge Court', 'Villa María', 'Córdoba', 'Argentina'),
('068 Onsgard Street', 'La Falda', 'Córdoba', 'Argentina'),
('965 Towne Road', 'Naschel', 'San Luis', 'Argentina'),
('34307 Darwin Pass', 'Neuquén', 'Neuquén', 'Argentina'),
('054 Towne Pass', 'Pico Truncado', 'Santa Cruz', 'Argentina'),
('09 Express Court', 'Puerta de Corral Quemado', 'Catamarca', 'Argentina'),
('93 Marcy Park', 'Puerto Deseado', 'Santa Cruz', 'Argentina'),
('41726 Golf Course Drive', 'Puerto Esperanza', 'Misiones', 'Argentina'),
('1 David Avenue', 'Puerto Esperanza', 'Misiones', 'Argentina'),
('48 Sugar Pass', 'Quilino', 'Córdoba', 'Argentina'),
('503 Green Ridge Alley', 'Quitilipi', 'Chaco', 'Argentina'),
('2 Starling Center', 'Rawson', 'Chubut', 'Argentina'),
('16859 Upham Center', 'Rawson', 'Chubut', 'Argentina'),
('4551 Hanson Court', 'Rinconada', 'Jujuy', 'Argentina'),
('66 Gina Park', 'Río Colorado', 'Río Negro', 'Argentina'),
('03981 Bashford Center', 'Río Cuarto', 'Córdoba', 'Argentina'),
('49 Morrow Drive', 'Río Pico', 'Chubut', 'Argentina'),
('40517 Northview Circle', 'Rufino', 'Santa Fe', 'Argentina'),
('33 Karstens Terrace', 'Lanús', 'Buenos Aires', 'Argentina'),
('75719 Artisan Avenue', 'Samuhú', 'Chaco', 'Argentina'),
('5632 Pearson Park', 'Alejandro Roca', 'Córdoba', 'Argentina'),
('21 Vidon Lane', 'Villa General Belgrano', 'Córdoba', 'Argentina'),
('3 Northport Pass', 'Villaguay', 'Entre Ríos', 'Argentina'),
('29956 Corben Junction', 'San Agustín de Valle Fértil', 'San Juan', 'Argentina'),
('67 Lakewood Plaza', 'Villa Nueva', 'Córdoba', 'Argentina'),
('6265 Shopko Pass', 'San Antonio', 'Río Negro', 'Argentina'),
('277 Mosinee Park', 'San Carlos de Bariloche', 'Río Negro', 'Argentina'),
('08 Karstens Street', 'San Jorge', 'Santa Fe', 'Argentina'),
('62212 Rusk Pass', 'San Martín', 'Buenos Aires', 'Argentina'),
('29661 Judy Court', 'San Pedro', 'Buenos Aires', 'Argentina'),
('9272 Sutteridge Junction', 'Santa Catalina - Dique Lujan', 'Buenos Aires', 'Argentina'),
('197 Hauk Park', 'Aranguren', 'Entre Ríos', 'Argentina'),
('225 Lakewood Plaza', 'Bandera', 'Santiago del Estero', 'Argentina'),
('9211 Crownhardt Circle', 'Santo Tomé', 'Santa Fe', 'Argentina'),
('9 Sullivan Way', 'Sunchales', 'Santa Fe', 'Argentina'),
('455 Iowa Circle', 'Buena Esperanza', 'San Luis', 'Argentina'),
('5805 Butterfield Lane', 'Tartagal', 'Salta', 'Argentina'),
('39 Bartillon Hill', 'Tinogasta', 'Catamarca', 'Argentina'),
('352 Dexter Parkway', 'Tostado', 'Santa Fe', 'Argentina'),
('4 East Street', 'Bella Vista', 'Tucumán', 'Argentina'),
('12824 Graceland Crossing', 'Villa La Angostura', 'Neuquén', 'Argentina'),
('3 Ruskin Terrace', 'Tostado', 'Santa Fe', 'Argentina'),
('4 Sage Avenue', 'Lanús', 'Buenos Aires', 'Argentina'),
('2499 Arapahoe Plaza', 'Totoras', 'Santa Fe', 'Argentina'),
('9 Bluestem Way', 'Colegiales', 'Buenos Aires', 'Argentina'),
('72 Texas Park', 'Trelew', 'Chubut', 'Argentina'),
('8916 Arapahoe Plaza', 'Villa Ojo de Agua', 'Santiago del Estero', 'Argentina'),
('8081 Schurz Place', 'Trelew', 'Chubut', 'Argentina'),
('93642 Loomis Hill', 'Tres Arroyos', 'Buenos Aires', 'Argentina'),
('98 Stoughton Trail', 'Tres Arroyos', 'Buenos Aires', 'Argentina'),
('726 Manufacturers Street', 'Tres Isletas', 'Chaco', 'Argentina'),
('87 Rutledge Drive', 'Viedma', 'Río Negro', 'Argentina'),
('716 Holmberg Drive', 'Tres Isletas', 'Chaco', 'Argentina'),
('12 Fuller Parkway', 'Capayán', 'Catamarca', 'Argentina'),
('976 Chive Point', 'Ulapes', 'La Rioja', 'Argentina'),
('8883 Ryan Trail', 'Charata', 'Chaco', 'Argentina'),
('3 Twin Pines Way', 'Venado Tuerto', 'Santa Fe', 'Argentina'),
('43558 Pennsylvania Street', 'Berón de Astrada', 'Corrientes', 'Argentina'),
('64 Rutledge Street', 'Necochea', 'Buenos AIres', 'Argentina'),
('51986 Bashford Point', 'Venado Tuerto', 'Santa Fe', 'Argentina'),
('77132 Rowland Junction', 'Vera', 'Santa Fe', 'Argentina'),
('42 Bunting Avenue', 'Victoria', 'Entre Ríos', 'Argentina'),
('098 Algoma Lane', 'Arroyo Seco', 'Santa Fe', 'Argentina'),
('21207 Glacier Hill Circle', 'Río Ceballos', 'Córdoba', 'Argentina'),
('243 Hagan Trail', 'Victoria', 'Entre Ríos', 'Argentina'),
('504 Algoma Drive', 'Jesús María', 'Córdoba', 'Argentina'),
('1825 Burrows Center', 'Arauco', 'Córdoba', 'Argentina'),
('2 Loeprich Junction', 'Victoria', 'Entre Ríos', 'Argentina'),
('9310 Armistice Parkway', 'Jesús María', 'Córdoba', 'Argentina'),
('9080 Oriole Road', 'Vicuña Mackenna', 'Córdoba', 'Argentina'),
('32 Glendale Street', 'Villa Lugano', 'Buenos Aires', 'Argentina');
/*Tabla Proveedor*/
INSERT INTO PROVEEDOR (Nombre_Proveedor,Categoria_Proveedor,Telefono_Proveedor,ID_Direccion) VALUES 
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
/*Tabla de dimensión Presentacion*/
INSERT INTO PRESENTACION (Nombre_Presentacion,Cantidad_Presentacion,Unidad_Medida) VALUES
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
('Envase de 1 litro',1,'litros'),
('Paquete de 200 gr',200,'gramos');
/*Tabla de dinmensión Empleado*/
INSERT INTO EMPLEADO (Nombre_Empleado,Telefono_Empleado,Sector_Empleado,ID_Direccion) VALUES
('Lisle Turpin', 03816611336, 'Producción', 1),
('Lauren Odger',03819773892, 'Ventas', 2);
/*Tabla de dimensión Cliente*/
INSERT INTO CLIENTE (ID_Cliente, Nombre_Cliente, Categoria_Cliente, Edad, Telefono_Cliente, ID_Direccion) VALUES 
(1,'Kakalina Caret','Restaurante',49,'4213709208',15),(2,'Koralle Noye','Cliente tienda fisica',NULL,NULL,NULL),(3,'Clerkclaude Willatt','Cliente tienda fisica',63,'8742267826',17),(4,'Ursola Berzins','Distribuidor mayorista',NULL,NULL,18),(5,'Meris Eddy','Cliente tienda fisica',25,'9841919528',19),(6,'Huey Ellams','Grande cadena',NULL,NULL,118),(7,'Mair Cuniam','Grande cadena',70,'2832991586',20),(8,'Lorettalorna Abbado','Cliente en linea',32,'6886746893',NULL),(9,'Raffaello Davids','Distribuidor mayorista',21,'2555078641',21),(10,'Dallas Dearsley','Distribuidor mayorista',NULL,NULL,22),(11,'Conny Todari','Cliente en linea',NULL,NULL,23),(12,'Gay Lydster','Cliente tienda fisica',38,'8839039564',24),(13,'Charleen Klehn','Cliente en linea',NULL,NULL,25),(14,'Moina Doogood','Restaurante',NULL,NULL,NULL),(15,'Elenore Artist','Cliente tienda fisica',NULL,NULL,26),(16,'Tudor Yoslowitz','Cliente en linea',NULL,NULL,27),(17,'Lothario Algie','Cliente tienda fisica',NULL,NULL,28),(18,'Allie Olsen','Restaurante',NULL,NULL,29),(19,'Kermy Lantuff','Restaurante',20,'8447508440',30),(20,'Sinclare Mathon','Grande cadena',NULL,NULL,31),(21,'Carver Fowles','Cliente tienda fisica',NULL,NULL,32),(22,'Skipton Dudderidge','Cliente tienda fisica',41,'9931654286',34),(23,'Jordan Cheyenne','Cliente en linea',39,'2616295435',NULL),(24,'Jaimie Ekell','Restaurante',38,'4933486916',35),(25,'Jenda Walbridge','Restaurante',38,'1435888711',64),(26,'Debbi Alfonzo','Cliente tienda fisica',NULL,NULL,36),(27,'Morgan Mardling','Distribuidor mayorista',63,'2793732461',67),(28,'Judon Bolver','Restaurante',69,'3621513479',37),(29,'Ulrike Dulieu','Grande cadena',26,'8499041606',40),(30,'Marilin Conring','Grande cadena',61,'8634478543',109),(31,'Xymenes Melburg','Cliente en linea',31,'5434705941',41),(32,'Teriann Adam','Distribuidor mayorista',53,'2337393148',42),(33,'Sybilla Lord','Cliente en linea',NULL,NULL,43),(34,'Shaylynn Radage','Cliente tienda fisica',38,'8646571693',44),(35,'Town Schubuser','Distribuidor mayorista',NULL,NULL,45),(36,'Alis Rosendahl','Cliente tienda fisica',NULL,NULL,46),(37,'Honey Lanktree','Cliente tienda fisica',69,'8966780331',47),(38,'Elfreda Liddell','Cliente en linea',53,'8989298543',48),(39,'Morgun Fleg','Cliente tienda fisica',NULL,NULL,49),(40,'Warner Legon','Cliente tienda fisica',36,'5121540218',50),(41,'Morly Vedikhov','Cliente en linea',29,'4843968221',51),(42,'Clevie Waplington','Distribuidor mayorista',61,'1973041939',16),(43,'Jerald Trassler','Restaurante',61,'6236923776',52),(44,'Carmelita Rangall','Restaurante',35,'5974466297',53),(45,'Caz Sieve','Distribuidor mayorista',60,'6231340912',54),(46,'Morganica Paula','Grande cadena',44,'4779235394',55),(47,'Lelia Hubbert','Cliente tienda fisica',39,'1294386465',57),(48,'Bentley Peat','Cliente en linea',NULL,NULL,59),(49,'Norrie Benfield','Cliente tienda fisica',NULL,NULL,NULL),(50,'Ed Pilmore','Cliente tienda fisica',22,'2054895177',60),(51,'Trueman Brauninger','Distribuidor mayorista',56,'5173543903',62),(52,'Hanna Baxter','Cliente tienda fisica',54,'4311756271',58),(53,'Koral Matley','Restaurante',33,'3199618331',63),(54,'Quinn Bannister','Cliente tienda fisica',40,'3856408595',65),(55,'Nataniel Van Driel','Grande cadena',26,'2953644860',66),(56,'Torrey Caldes','Cliente tienda fisica',NULL,NULL,68),(57,'Ania Bowler','Cliente en linea',44,'5311653376',71),(58,'Danyette Siddle','Restaurante',18,'1697774437',72),(59,'Cullan Briatt','Cliente tienda fisica',37,'1505487490',73),(60,'Melisenda Keyworth','Restaurante',43,'5859198854',74),(61,'Frank Reyna','Distribuidor mayorista',60,'5168278543',76),(62,'Shaylyn Mildner','Restaurante',59,'9646975309',77),(63,'Franklin Stannering','Distribuidor mayorista',21,'1982160101',78),(64,'Nikolas Brunsen','Cliente en linea',NULL,NULL,79),(65,'Sondra Clynmans','Cliente tienda fisica',33,'6709466495',80),(66,'Marie-jeanne Barti','Cliente en linea',20,'1182401544',NULL),(67,'Kitti Wisbey','Cliente en linea',29,'9629332261',81),(68,'Marsiella Colls','Cliente en linea',50,'8761564035',113),(69,'Deloris Scoble','Distribuidor mayorista',52,'3794421313',NULL),(70,'Boone Withinshaw','Cliente en linea',18,'1022888855',82),(71,'Nannette Trevithick','Restaurante',40,'5945459278',83),(72,'Loralie Sueter','Distribuidor mayorista',42,'4359755963',84),(73,'Herminia Iacovazzi','Cliente en linea',18,'7086644108',85),(74,'Crosby Pooley','Cliente tienda fisica',NULL,NULL,86),(75,'Brent Wynrehame','Cliente tienda fisica',30,'2597009333',87),(76,'Ellswerth Fenich','Distribuidor mayorista',67,'4498120158',88),(77,'Man Zoanetti','Cliente tienda fisica',38,'5798289174',89),(78,'Rhonda Hutchison','Cliente en linea',51,'3984654421',90),(79,'Artus Ubsdell','Restaurante',37,'1631737422',91),(80,'Brandice Marner','Restaurante',NULL,NULL,92),(81,'Dari Crix','Cliente tienda fisica',39,'4879622634',105),(82,'Barbara-anne Kobieriecki','Distribuidor mayorista',NULL,NULL,93),(83,'Ofelia Abramcik','Cliente tienda fisica',NULL,NULL,NULL),(84,'Reinaldo Griswood','Restaurante',60,'2519900202',94),(85,'Ibby Euesden','Distribuidor mayorista',28,'5076888616',NULL),(86,'Van Abrahim','Cliente en linea',57,'1811760233',96),(87,'Gustaf Vergo','Grande cadena',51,'8468929481',97),(88,'Emmery Treamayne','Grande cadena',54,'8505513059',98),(89,'Brit Waylen','Grande cadena',32,'7439295503',99),(90,'Pryce Anderbrugge','Cliente tienda fisica',33,'8311686488',100),(91,'Karil Marven','Restaurante',49,'4647854713',101),(92,'Francisco Shird','Restaurante',NULL,NULL,102),(93,'Dewain Felton','Cliente tienda fisica',38,'8445670800',103),(94,'Romola Rennebeck','Restaurante',34,'4131728773',104),(95,'Etty Abatelli','Cliente en linea',33,'8088236865',106),(96,'Cairistiona Rojel','Distribuidor mayorista',44,'8892162780',108),(97,'Belvia Brashier','Cliente tienda fisica',NULL,NULL,110),(98,'Phillida Clemanceau','Cliente en linea',NULL,NULL,111),(99,'Innis Pedracci','Cliente en linea',NULL,NULL,NULL),(100,'Beverlie Clampe','Cliente en linea',70,'2929677742',112),(101,'Kacey Kennon','Cliente en linea',NULL,NULL,114),(102,'Langston Romanetti','Cliente tienda fisica',46,'8294530234',115),(103,'Stormy Treske','Cliente tienda fisica',34,'8817583607',116),(104,'Sissy Cobbe','Cliente tienda fisica',69,'2956395137',117),(105,'Greer Bushell','Cliente tienda fisica',43,'8122175469',119),(106,'Raimund Lighten','Cliente tienda fisica',54,'9944347200',121),(107,'Vick Swarbrick','Cliente en linea',28,'2985438040',122),(108,'Inness Tinn','Cliente tienda fisica',58,'2114851303',123),(109,'Kilian Birckmann','Distribuidor mayorista',55,'1685361267',124),(110,'August Loadman','Cliente en linea',68,'6592358839',126),(111,'Margy Camell','Distribuidor mayorista',65,'2605609653',70),(112,'Miller Marder','Grande cadena',38,'9818989102',127),(113,'Sheffield Mahy','Restaurante',25,'8174472297',128),(114,'Dosi Malacrida','Cliente en linea',53,'2199084653',129),(115,'Gayleen Keyson','Cliente tienda fisica',49,'8234547833',130),(116,'Gamaliel Kettlewell','Cliente tienda fisica',37,'8187498067',131),(117,'Krysta Abramzon','Cliente tienda fisica',63,'7191901972',132),(118,'Dwain Houlahan','Distribuidor mayorista',29,'2052226576',107),(119,'Arvie Crosier','Restaurante',43,'6896161937',75),(120,'Laurie Bapty','Cliente en linea',NULL,NULL,133),(121,'Erna Stolz','Cliente en linea',59,'5867407679',134),(122,'Giulia Blowing','Restaurante',19,'6396190979',135),(123,'Chere Crummey','Restaurante',37,'1446785668',136),(124,'Elnora Eliasson','Cliente tienda fisica',NULL,NULL,137),(125,'Maighdiln McGrouther','Cliente en linea',41,'1622793866',139),(126,'Gusta Farnfield','Restaurante',30,'9422366881',140),(127,'Trixy Opdenort','Cliente en linea',38,'8952704446',141),(128,'Gabie Tolliday','Distribuidor mayorista',64,'1071484023',142),(129,'Christy Franck','Distribuidor mayorista',24,'9775752472',143),(130,'Leslie Birtwell','Distribuidor mayorista',44,'2892236166',145),(131,'Reuven Burdus','Cliente tienda fisica',70,'9404919707',146),(132,'Ozzy Spittall','Cliente tienda fisica',47,'6999792071',NULL),(133,'Bertina Kerley','Cliente tienda fisica',18,'9718331848',147),(134,'Tabbie Pilkington','Cliente tienda fisica',NULL,NULL,149),(135,'See Frowing','Grande cadena',58,'6031483100',151),(136,'Corbin Gorvette','Grande cadena',42,'6376348261',95),(137,'Faina Leving','Distribuidor mayorista',21,'9236884878',152),(138,'Gaspard Haygreen','Restaurante',NULL,NULL,NULL),(139,'Giorgia Zoren','Distribuidor mayorista',70,'2542950498',154),(140,'Ferguson Jansema','Restaurante',26,'5272628260',155),(141,'Lucine Laxton','Restaurante',21,'9217936236',156),(142,'Sauncho Weatherby','Cliente en linea',49,'6688124869',157),(143,'Nobe Scollard','Grande cadena',61,'1737842038',158),(144,'Kimberley Binion','Restaurante',22,'7988616306',159),(145,'Darda Moriarty','Grande cadena',62,'5171513372',NULL),(146,'Heloise Greyes','Cliente tienda fisica',37,'6631487788',160),(147,'Alaric Clem','Cliente tienda fisica',24,'5573065265',161),(148,'Davy Witherop','Restaurante',NULL,NULL,162),(149,'Mallorie Portsmouth','Cliente en linea',54,'4714900557',163),(150,'Lazaro Lucius','Distribuidor mayorista',NULL,NULL,164),(151,'Pen Longshaw','Grande cadena',NULL,NULL,165),(152,'Binni Vedenyapin','Cliente tienda fisica',59,'1085678004',69),(153,'Rochell Spawton','Distribuidor mayorista',58,'5367593869',166),(154,'Angelita Trever','Cliente en linea',19,'1651420312',167),(155,'Gwendolyn Antrim','Cliente tienda fisica',58,'5935637507',168),(156,'Leanora Feldberg','Cliente en linea',NULL,NULL,169),(157,'Correna Drayson','Cliente en linea',60,'7075158716',170),(158,'Adrianna Jaggs','Grande cadena',69,'8214692646',172);
/*Tabla de dimensión Receta*/
INSERT INTO RECETA (Nombre_Receta) VALUES
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
/*Tabla de dimensión Material*/
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
/*Tabla de enlace Receta_Material*/
INSERT INTO RECETA_MATERIAL (ID_Receta, ID_Material, Categoria_Proceso, Cantidad_Material, Unidad_Medida) VALUES
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
(4,1,'Prefermento',27,'gramos'),
(4,10,'Prefermento',25,'gramos'),
(4,6,'Prefermento',1,'gramos'),
(4,1,'Bloque',40,'gramos'),
(4,14,'Bloque',20,'gramos'),
(4,5,'Bloque',4,'gramos'),
(4,4,'Bloque',1,'gramos'),
(4,7,'Bloque',7,'gramos'),
(4,5,'Terminación',0.1,'gramos'),
(4,10,'Terminación',0.1,'gramos'),
(4,15,'Terminación',0.1,'gramos'),
(4,19,'Empaque',0.25,'unidad'),
(4,20,'Empaque',0.25,'unidad'),
(5,1,'Prefermento',21,'gramos'),
(5,12,'Prefermento',21,'gramos'),
(5,6,'Prefermento',1,'gramos'),
(5,1,'Bloque',49,'gramos'),
(5,4,'Bloque',1,'gramos'),
(5,13,'Bloque',2,'gramos'),
(5,12,'Bloque',25,'gramos'),
(5,19,'Empaque',0.25,'unidad'),
(5,20,'Empaque',0.25,'unidad');
/*Tabla de enlace Presentacion_Material*/
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
/*Tabla de enlace Proveedor_Material*/
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
/*Tabla de dimensión Producto*/
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
#Tabla de hecho "Pedido"
INSERT INTO PEDIDO (ID_Pedido, Fecha_Pedido, Estado_Pedido, ID_Cliente) VALUES (1,'2020-07-26 00:00:00','Entregado',38),(2,'2020-07-27 00:00:00','Entregado',38),(3,'2020-07-30 00:00:00','Entregado',38),(4,'2020-08-01 00:00:00','Entregado',38),(5,'2020-08-06 00:00:00','Entregado',38),(6,'2020-08-08 00:00:00','Entregado',38),(7,'2020-08-11 00:00:00','Entregado',38),(8,'2020-08-15 00:00:00','Entregado',38),(9,'2020-08-16 00:00:00','Entregado',38),(10,'2020-08-22 00:00:00','Entregado',38),(11,'2020-08-27 00:00:00','Entregado',38),(12,'2020-09-11 00:00:00','Entregado',38),(13,'2020-09-18 00:00:00','Entregado',38),(14,'2020-09-20 00:00:00','Entregado',38),(15,'2020-09-26 00:00:00','Entregado',38),(16,'2020-10-01 00:00:00','Entregado',12),(17,'2020-10-02 00:00:00','Entregado',6),(18,'2020-10-03 00:00:00','Entregado',24),(19,'2020-10-04 00:00:00','Entregado',2),(20,'2020-10-05 00:00:00','Entregado',8),(21,'2020-10-06 00:00:00','Entregado',17),(22,'2020-10-07 00:00:00','Entregado',113),(23,'2020-10-08 00:00:00','Entregado',33),(24,'2020-10-10 00:00:00','Entregado',38),(25,'2020-11-24 00:00:00','Entregado',70),(26,'2020-11-24 00:00:00','Entregado',80),(27,'2020-11-24 00:00:00','Entregado',13),(28,'2020-11-24 00:00:00','Entregado',126),(29,'2020-11-24 00:00:00','Entregado',87),(30,'2020-11-24 00:00:00','Entregado',1),(31,'2020-11-24 00:00:00','Entregado',14),(32,'2020-11-24 00:00:00','Entregado',41),(33,'2020-11-24 00:00:00','Entregado',64),(34,'2020-11-24 00:00:00','Entregado',143),(35,'2020-11-24 00:00:00','Entregado',113),(36,'2020-11-24 00:00:00','Entregado',16),(37,'2020-12-01 00:00:00','Entregado',48),(38,'2020-12-01 00:00:00','Entregado',157),(39,'2020-12-01 00:00:00','Entregado',114),(40,'2020-12-01 00:00:00','Entregado',88),(41,'2020-12-01 00:00:00','Entregado',92),(42,'2020-12-01 00:00:00','Entregado',87),(43,'2020-12-01 00:00:00','Entregado',25),(44,'2020-12-01 00:00:00','Entregado',23),(45,'2020-12-01 00:00:00','Entregado',117),(46,'2020-12-01 00:00:00','Entregado',30),(47,'2020-12-01 00:00:00','Entregado',27),(48,'2020-12-01 00:00:00','Entregado',84),(49,'2020-12-01 00:00:00','Entregado',142),(50,'2020-12-01 00:00:00','Entregado',20),(51,'2020-12-01 00:00:00','Entregado',56),(52,'2020-12-08 00:00:00','Entregado',58),(53,'2020-12-08 00:00:00','Entregado',88),(54,'2020-12-08 00:00:00','Entregado',23),(55,'2020-12-08 00:00:00','Entregado',19),(56,'2020-12-08 00:00:00','Entregado',30),(57,'2020-12-08 00:00:00','Entregado',14),(58,'2020-12-08 00:00:00','Entregado',16),(59,'2020-12-08 00:00:00','Entregado',29),(60,'2020-12-12 00:00:00','Entregado',140),(61,'2020-12-15 00:00:00','Entregado',42),(62,'2020-12-15 00:00:00','Entregado',114),(63,'2020-12-16 00:00:00','Entregado',75),(64,'2020-12-16 00:00:00','Entregado',10),(65,'2020-12-16 00:00:00','Entregado',140),(66,'2020-12-16 00:00:00','Entregado',34),(67,'2020-12-17 00:00:00','Entregado',19),(68,'2020-12-17 00:00:00','Entregado',30),(69,'2020-12-17 00:00:00','Entregado',39),(70,'2020-12-17 00:00:00','Entregado',78),(71,'2020-12-17 00:00:00','Entregado',142),(72,'2020-12-23 00:00:00','Entregado',158),(73,'2020-12-23 00:00:00','Entregado',10),(74,'2020-12-26 00:00:00','Entregado',88),(75,'2020-12-28 00:00:00','Entregado',58),(76,'2020-12-28 00:00:00','Entregado',30),(77,'2020-12-28 00:00:00','Entregado',16),(78,'2020-12-29 00:00:00','Entregado',10),(79,'2020-12-29 00:00:00','Entregado',87),(80,'2020-12-29 00:00:00','Entregado',1),(81,'2020-12-29 00:00:00','Entregado',39),(82,'2020-12-30 00:00:00','Entregado',110),(83,'2020-12-30 00:00:00','Entregado',129),(84,'2021-01-03 00:00:00','Entregado',10),(85,'2021-01-03 00:00:00','Entregado',27),(86,'2021-01-03 00:00:00','Entregado',142),(87,'2021-01-05 00:00:00','Entregado',75),(88,'2021-01-05 00:00:00','Entregado',52),(89,'2021-01-05 00:00:00','Entregado',32),(90,'2021-01-07 00:00:00','Entregado',130),(91,'2021-01-08 00:00:00','Entregado',110),(92,'2021-01-08 00:00:00','Entregado',34),(93,'2021-01-11 00:00:00','Entregado',142),(94,'2021-01-12 00:00:00','Entregado',100),(95,'2021-01-12 00:00:00','Entregado',70),(96,'2021-01-12 00:00:00','Entregado',21),(97,'2021-01-12 00:00:00','Entregado',10),(98,'2021-01-12 00:00:00','Entregado',88),(99,'2021-01-12 00:00:00','Entregado',95),(100,'2021-01-12 00:00:00','Entregado',87),(101,'2021-01-12 00:00:00','Entregado',146),(102,'2021-01-12 00:00:00','Entregado',28),(103,'2021-01-12 00:00:00','Entregado',19),(104,'2021-01-12 00:00:00','Entregado',150),(105,'2021-01-12 00:00:00','Entregado',30),(106,'2021-01-12 00:00:00','Entregado',14),(107,'2021-01-12 00:00:00','Entregado',90),(108,'2021-01-12 00:00:00','Entregado',107),(109,'2021-01-14 00:00:00','Entregado',87),(110,'2021-01-15 00:00:00','Entregado',140),(111,'2021-01-15 00:00:00','Entregado',90),(112,'2021-01-16 00:00:00','Entregado',154),(113,'2021-01-17 00:00:00','Entregado',10),(114,'2021-01-17 00:00:00','Entregado',30),(115,'2021-01-18 00:00:00','Entregado',142),(116,'2021-01-18 00:00:00','Entregado',32),(117,'2021-01-20 00:00:00','Entregado',21),(118,'2021-01-20 00:00:00','Entregado',90),(119,'2021-01-26 00:00:00','Entregado',110),(120,'2021-01-26 00:00:00','Entregado',100),(121,'2021-01-26 00:00:00','Entregado',88),(122,'2021-01-26 00:00:00','Entregado',137),(123,'2021-01-26 00:00:00','Entregado',116),(124,'2021-01-26 00:00:00','Entregado',87),(125,'2021-01-26 00:00:00','Entregado',150),(126,'2021-01-26 00:00:00','Entregado',66),(127,'2021-01-26 00:00:00','Entregado',34),(128,'2021-01-30 00:00:00','Entregado',158),(129,'2021-01-30 00:00:00','Entregado',10),(130,'2021-01-30 00:00:00','Entregado',114),(131,'2021-01-30 00:00:00','Entregado',140),(132,'2021-01-30 00:00:00','Entregado',19),(133,'2021-01-30 00:00:00','Entregado',156),(134,'2021-01-30 00:00:00','Entregado',68),(135,'2021-01-31 00:00:00','Entregado',69),(136,'2021-01-31 00:00:00','Entregado',143),(137,'2021-02-01 00:00:00','Entregado',50),(138,'2021-02-01 00:00:00','Entregado',126),(139,'2021-02-01 00:00:00','Entregado',90),(140,'2021-02-01 00:00:00','Entregado',65),(141,'2021-02-01 00:00:00','Entregado',107),(142,'2021-02-02 00:00:00','Entregado',158),(143,'2021-02-02 00:00:00','Entregado',139),(144,'2021-02-02 00:00:00','Entregado',78),(145,'2021-02-03 00:00:00','Entregado',55),(146,'2021-02-04 00:00:00','Entregado',158),(147,'2021-02-04 00:00:00','Entregado',86),(148,'2021-02-05 00:00:00','Entregado',10),(149,'2021-02-05 00:00:00','Entregado',151),(150,'2021-02-05 00:00:00','Entregado',142),(151,'2021-02-08 00:00:00','Entregado',45),(152,'2021-02-08 00:00:00','Entregado',10),(153,'2021-02-08 00:00:00','Entregado',15),(154,'2021-02-08 00:00:00','Entregado',52),(155,'2021-02-08 00:00:00','Entregado',19),(156,'2021-02-08 00:00:00','Entregado',53),(157,'2021-02-08 00:00:00','Entregado',5),(158,'2021-02-08 00:00:00','Entregado',14),(159,'2021-02-08 00:00:00','Entregado',143),(160,'2021-02-09 00:00:00','Entregado',81),(161,'2021-02-09 00:00:00','Entregado',88),(162,'2021-02-09 00:00:00','Entregado',9),(163,'2021-02-11 00:00:00','Entregado',83),(164,'2021-02-11 00:00:00','Entregado',106),(165,'2021-02-12 00:00:00','Entregado',42),(166,'2021-02-11 00:00:00','Entregado',61),(167,'2021-02-11 00:00:00','Entregado',85),(168,'2021-02-11 00:00:00','Entregado',91),(169,'2021-02-11 00:00:00','Entregado',120),(170,'2021-02-16 00:00:00','Entregado',85),(171,'2021-02-16 00:00:00','Entregado',19),(172,'2021-02-16 00:00:00','Entregado',143),(173,'2021-02-16 00:00:00','Entregado',35),(174,'2021-02-17 00:00:00','Entregado',22),(175,'2021-02-18 00:00:00','Entregado',18),(176,'2021-02-18 00:00:00','Entregado',114),(177,'2021-02-18 00:00:00','Entregado',86),(178,'2021-02-19 00:00:00','Entregado',69),(179,'2021-02-19 00:00:00','Entregado',88),(180,'2021-02-19 00:00:00','Entregado',27),(181,'2021-02-19 00:00:00','Entregado',22),(182,'2021-02-21 00:00:00','Entregado',78),(183,'2021-02-21 00:00:00','Entregado',104),(184,'2021-02-22 00:00:00','Entregado',45),(185,'2021-02-22 00:00:00','Entregado',140),(186,'2021-02-22 00:00:00','Entregado',14),(187,'2021-02-22 00:00:00','Entregado',22),(188,'2021-02-24 00:00:00','Entregado',45),(189,'2021-02-24 00:00:00','Entregado',72),(190,'2021-02-24 00:00:00','Entregado',22),(191,'2021-02-24 00:00:00','Entregado',103),(192,'2021-02-24 00:00:00','Entregado',35),(193,'2021-02-25 00:00:00','Entregado',89),(194,'2021-02-25 00:00:00','Entregado',126),(195,'2021-02-26 00:00:00','Entregado',134),(196,'2021-02-27 00:00:00','Entregado',27),(197,'2021-02-27 00:00:00','Entregado',22),(198,'2021-02-28 00:00:00','Entregado',99),(199,'2021-02-28 00:00:00','Entregado',143),(200,'2021-03-01 00:00:00','Entregado',45),(201,'2021-03-01 00:00:00','Entregado',69),(202,'2021-03-01 00:00:00','Entregado',78),(203,'2021-03-01 00:00:00','Entregado',142),(204,'2021-03-01 00:00:00','Entregado',35),(205,'2021-03-03 00:00:00','Entregado',19),(206,'2021-03-03 00:00:00','Entregado',62),(207,'2021-03-04 00:00:00','Entregado',155),(208,'2021-03-04 00:00:00','Entregado',150),(209,'2021-03-04 00:00:00','Entregado',22),(210,'2021-03-07 00:00:00','Entregado',140),(211,'2021-03-07 00:00:00','Entregado',98),(212,'2021-03-16 00:00:00','Entregado',89),(213,'2021-03-16 00:00:00','Entregado',114),(214,'2021-03-16 00:00:00','Entregado',88),(215,'2021-03-16 00:00:00','Entregado',128),(216,'2021-03-16 00:00:00','Entregado',155),(217,'2021-03-16 00:00:00','Entregado',19),(218,'2021-03-16 00:00:00','Entregado',120),(219,'2021-03-16 00:00:00','Entregado',72),(220,'2021-03-16 00:00:00','Entregado',125),(221,'2021-03-25 00:00:00','Entregado',154),(222,'2021-03-25 00:00:00','Entregado',70),(223,'2021-03-25 00:00:00','Entregado',45),(224,'2021-03-25 00:00:00','Entregado',59),(225,'2021-03-25 00:00:00','Entregado',128),(226,'2021-03-25 00:00:00','Entregado',19),(227,'2021-03-25 00:00:00','Entregado',27),(228,'2021-03-25 00:00:00','Entregado',39),(229,'2021-03-25 00:00:00','Entregado',142),(230,'2021-03-25 00:00:00','Entregado',134),(231,'2021-03-26 00:00:00','Entregado',72),(232,'2021-03-30 00:00:00','Entregado',59),(233,'2021-03-30 00:00:00','Entregado',121),(234,'2021-03-30 00:00:00','Entregado',140),(235,'2021-03-30 00:00:00','Entregado',142),(236,'2021-04-03 00:00:00','Entregado',10),(237,'2021-04-03 00:00:00','Entregado',26),(238,'2021-04-04 00:00:00','Entregado',88),(239,'2021-04-04 00:00:00','Entregado',60),(240,'2021-04-10 00:00:00','Entregado',10),(241,'2021-04-11 00:00:00','Entregado',154),(242,'2021-04-11 00:00:00','Entregado',103),(243,'2021-04-12 00:00:00','Entregado',45),(244,'2021-04-12 00:00:00','Entregado',74),(245,'2021-04-12 00:00:00','Entregado',114),(246,'2021-04-12 00:00:00','Entregado',121),(247,'2021-04-12 00:00:00','Entregado',128),(248,'2021-04-12 00:00:00','Entregado',111),(249,'2021-04-12 00:00:00','Entregado',39),(250,'2021-04-12 00:00:00','Entregado',142),(251,'2021-04-14 00:00:00','Entregado',10),(252,'2021-04-15 00:00:00','Entregado',144),(253,'2021-04-15 00:00:00','Entregado',141),(254,'2021-04-15 00:00:00','Entregado',14),(255,'2021-04-15 00:00:00','Entregado',143),(256,'2021-04-15 00:00:00','Entregado',78),(257,'2021-04-22 00:00:00','Entregado',154),(258,'2021-04-22 00:00:00','Entregado',10),(259,'2021-04-22 00:00:00','Entregado',114),(260,'2021-04-22 00:00:00','Entregado',88),(261,'2021-04-22 00:00:00','Entregado',140),(262,'2021-04-22 00:00:00','Entregado',78),(263,'2021-04-22 00:00:00','Entregado',103),(264,'2021-04-24 00:00:00','Entregado',111),(265,'2021-04-25 00:00:00','Entregado',110),(266,'2021-04-26 00:00:00','Entregado',110),(267,'2021-04-26 00:00:00','Entregado',121),(268,'2021-04-26 00:00:00','Entregado',128),(269,'2021-04-26 00:00:00','Entregado',47),(270,'2021-04-26 00:00:00','Entregado',39),(271,'2021-04-26 00:00:00','Entregado',35),(272,'2021-04-27 00:00:00','Entregado',45),(273,'2021-04-27 00:00:00','Entregado',142),(274,'2021-04-28 00:00:00','Entregado',12),(275,'2021-04-28 00:00:00','Entregado',27),(276,'2021-04-28 00:00:00','Entregado',142),(277,'2021-04-29 00:00:00','Entregado',114),(278,'2021-05-01 00:00:00','Entregado',82),(279,'2021-05-01 00:00:00','Entregado',10),(280,'2021-05-01 00:00:00','Entregado',19),(281,'2021-05-03 00:00:00','Entregado',70),(282,'2021-05-03 00:00:00','Entregado',43),(283,'2021-05-04 00:00:00','Entregado',142),(284,'2021-05-05 00:00:00','Entregado',118),(285,'2021-05-06 00:00:00','Entregado',10),(286,'2021-05-08 00:00:00','Entregado',119),(287,'2021-05-08 00:00:00','Entregado',69),(288,'2021-05-08 00:00:00','Entregado',60),(289,'2021-05-09 00:00:00','Entregado',118),(290,'2021-05-09 00:00:00','Entregado',111),(291,'2021-05-10 00:00:00','Entregado',140),(292,'2021-05-13 00:00:00','Entregado',97),(293,'2021-05-13 00:00:00','Entregado',10),(294,'2021-05-14 00:00:00','Entregado',57),(295,'2021-05-14 00:00:00','Entregado',79),(296,'2021-05-14 00:00:00','Entregado',59),(297,'2021-05-14 00:00:00','Entregado',128),(298,'2021-05-14 00:00:00','Entregado',47),(299,'2021-05-20 00:00:00','Entregado',37),(300,'2021-05-21 00:00:00','Entregado',10),(301,'2021-05-22 00:00:00','Entregado',10),(302,'2021-05-23 00:00:00','Entregado',158),(303,'2021-05-23 00:00:00','Entregado',111),(304,'2021-05-28 00:00:00','Entregado',45),(305,'2021-05-28 00:00:00','Entregado',123),(306,'2021-05-28 00:00:00','Entregado',10),(307,'2021-05-28 00:00:00','Entregado',19),(308,'2021-05-28 00:00:00','Entregado',111),(309,'2021-05-28 00:00:00','Entregado',143),(310,'2021-05-31 00:00:00','Entregado',34),(311,'2021-06-02 00:00:00','Entregado',37),(312,'2021-06-03 00:00:00','Entregado',119),(313,'2021-06-03 00:00:00','Entregado',10),(314,'2021-06-03 00:00:00','Entregado',63),(315,'2021-06-03 00:00:00','Entregado',78),(316,'2021-06-04 00:00:00','Entregado',110),(317,'2021-06-04 00:00:00','Entregado',140),(318,'2021-06-04 00:00:00','Entregado',98),(319,'2021-06-06 00:00:00','Entregado',44),(320,'2021-06-06 00:00:00','Entregado',14),(321,'2021-06-06 00:00:00','Entregado',27),(322,'2021-06-06 00:00:00','Entregado',142),(323,'2021-06-08 00:00:00','Entregado',78),(324,'2021-06-08 00:00:00','Entregado',127),(325,'2021-06-10 00:00:00','Entregado',45),(326,'2021-06-10 00:00:00','Entregado',10),(327,'2021-06-10 00:00:00','Entregado',87),(328,'2021-06-10 00:00:00','Entregado',37),(329,'2021-06-12 00:00:00','Entregado',93),(330,'2021-06-13 00:00:00','Entregado',22),(331,'2021-06-14 00:00:00','Entregado',10),(332,'2021-06-14 00:00:00','Entregado',81),(333,'2021-06-14 00:00:00','Entregado',122),(334,'2021-06-14 00:00:00','Entregado',37),(335,'2021-06-17 00:00:00','Entregado',119),(336,'2021-06-17 00:00:00','Entregado',69),(337,'2021-06-17 00:00:00','Entregado',87),(338,'2021-06-17 00:00:00','Entregado',35),(339,'2021-06-20 00:00:00','Entregado',10),(340,'2021-06-23 00:00:00','Entregado',111),(341,'2021-06-25 00:00:00','Entregado',10),(342,'2021-06-25 00:00:00','Entregado',77),(343,'2021-06-25 00:00:00','Entregado',98),(344,'2021-06-30 00:00:00','Entregado',10),(345,'2021-06-30 00:00:00','Entregado',63),(346,'2021-06-30 00:00:00','Entregado',39),(347,'2021-06-30 00:00:00','Entregado',98),(348,'2021-07-02 00:00:00','Entregado',158),(349,'2021-07-02 00:00:00','Entregado',10),(350,'2021-07-02 00:00:00','Entregado',98),(351,'2021-07-07 00:00:00','Entregado',10),(352,'2021-07-07 00:00:00','Entregado',98),(353,'2021-07-12 00:00:00','Entregado',105),(354,'2021-07-12 00:00:00','Entregado',132),(355,'2021-07-13 00:00:00','Entregado',10),(356,'2021-07-13 00:00:00','Entregado',114),(357,'2021-07-13 00:00:00','Entregado',76),(358,'2021-07-13 00:00:00','Entregado',108),(359,'2021-07-13 00:00:00','Entregado',98),(360,'2021-07-14 00:00:00','Entregado',71),(361,'2021-07-14 00:00:00','Entregado',98),(362,'2021-07-15 00:00:00','Entregado',35),(363,'2021-07-16 00:00:00','Entregado',110),(364,'2021-07-16 00:00:00','Entregado',93),(365,'2021-07-17 00:00:00','Entregado',128),(366,'2021-07-20 00:00:00','Entregado',136),(367,'2021-07-21 00:00:00','Entregado',10),(368,'2021-07-21 00:00:00','Entregado',140),(369,'2021-07-21 00:00:00','Entregado',111),(370,'2021-07-21 00:00:00','Entregado',142),(371,'2021-07-22 00:00:00','Entregado',109),(372,'2021-07-22 00:00:00','Entregado',98),(373,'2021-07-26 00:00:00','Entregado',10),(374,'2021-07-26 00:00:00','Entregado',138),(375,'2021-07-27 00:00:00','Entregado',69),(376,'2021-07-27 00:00:00','Entregado',138),(377,'2021-07-28 00:00:00','Entregado',142),(378,'2021-07-29 00:00:00','Entregado',10),(379,'2021-08-02 00:00:00','Entregado',111),(380,'2021-08-04 00:00:00','Entregado',10),(381,'2021-08-06 00:00:00','Entregado',128),(382,'2021-08-08 00:00:00','Entregado',10),(383,'2021-08-09 00:00:00','Entregado',111),(384,'2021-08-14 00:00:00','Entregado',10),(385,'2021-08-18 00:00:00','Entregado',10),(386,'2021-08-25 00:00:00','Entregado',111),(387,'2021-08-26 00:00:00','Entregado',10),(388,'2021-09-01 00:00:00','Entregado',10),(389,'2021-09-03 00:00:00','Entregado',15),(390,'2021-09-03 00:00:00','Entregado',122),(391,'2021-09-06 00:00:00','Entregado',142),(392,'2021-09-10 00:00:00','Entregado',10),(393,'2021-09-11 00:00:00','Entregado',15),(394,'2021-09-17 00:00:00','Entregado',10),(395,'2021-09-21 00:00:00','Entregado',15),(396,'2021-09-22 00:00:00','Entregado',111),(397,'2021-09-23 00:00:00','Entregado',10),(398,'2021-09-28 00:00:00','Entregado',111),(399,'2021-09-29 00:00:00','Entregado',10),(400,'2021-09-29 00:00:00','Entregado',15),(401,'2021-10-09 00:00:00','Entregado',10),(402,'2021-10-13 00:00:00','Entregado',69),(403,'2021-10-13 00:00:00','Entregado',43),(404,'2021-10-14 00:00:00','Entregado',10),(405,'2021-10-14 00:00:00','Entregado',43),(406,'2021-10-14 00:00:00','Entregado',35),(407,'2021-10-18 00:00:00','Entregado',111),(408,'2021-10-19 00:00:00','Entregado',63),(409,'2021-10-19 00:00:00','Entregado',73),(410,'2021-10-20 00:00:00','Entregado',140),(411,'2021-10-21 00:00:00','Entregado',96),(412,'2021-10-21 00:00:00','Entregado',10),(413,'2021-10-21 00:00:00','Entregado',15),(414,'2021-10-30 00:00:00','Entregado',63),(415,'2021-10-30 00:00:00','Entregado',1),(416,'2021-11-05 00:00:00','Entregado',147),(417,'2021-11-06 00:00:00','Entregado',147),(418,'2021-11-06 00:00:00','Entregado',10),(419,'2021-11-06 00:00:00','Entregado',15),(420,'2021-11-20 00:00:00','Entregado',10),(421,'2021-11-29 00:00:00','Entregado',15),(422,'2021-11-29 00:00:00','Entregado',63),(423,'2021-12-01 00:00:00','Entregado',10),(424,'2021-12-02 00:00:00','Entregado',111),(425,'2021-12-22 00:00:00','Entregado',88),(426,'2021-12-22 00:00:00','Entregado',117),(427,'2021-12-24 00:00:00','Entregado',69),(428,'2021-12-27 00:00:00','Entregado',10),(429,'2021-12-27 00:00:00','Entregado',145),(430,'2021-12-27 00:00:00','Entregado',15),(431,'2021-12-27 00:00:00','Entregado',73),(432,'2021-12-28 00:00:00','Entregado',111),(433,'2021-12-30 00:00:00','Entregado',10),(434,'2022-01-06 00:00:00','Entregado',10),(435,'2022-01-10 00:00:00','Entregado',126),(436,'2022-01-10 00:00:00','Entregado',4),(437,'2022-01-18 00:00:00','Entregado',129),(438,'2022-01-10 00:00:00','Entregado',10),(439,'2022-01-10 00:00:00','Entregado',63),(440,'2022-01-10 00:00:00','Entregado',67),(441,'2022-01-10 00:00:00','Entregado',102),(442,'2022-01-19 00:00:00','Entregado',131),(443,'2022-01-24 00:00:00','Entregado',70),(444,'2022-01-25 00:00:00','Entregado',10),(445,'2022-01-25 00:00:00','Entregado',101),(446,'2022-01-25 00:00:00','Entregado',142),(447,'2022-01-26 00:00:00','Entregado',155),(448,'2022-01-27 00:00:00','Entregado',15),(449,'2022-01-27 00:00:00','Entregado',88),(450,'2022-01-28 00:00:00','Entregado',87),(451,'2022-01-29 00:00:00','Entregado',94),(452,'2022-01-30 00:00:00','Entregado',152),(453,'2022-01-31 00:00:00','Entregado',11),(454,'2022-01-31 00:00:00','Entregado',10),(455,'2022-01-31 00:00:00','Entregado',92),(456,'2022-01-31 00:00:00','Entregado',101),(457,'2022-01-31 00:00:00','Entregado',112),(458,'2022-01-31 00:00:00','Entregado',51),(459,'2022-02-01 00:00:00','Entregado',100),(460,'2022-02-01 00:00:00','Entregado',14),(461,'2022-02-03 00:00:00','Entregado',92),(462,'2022-02-17 00:00:00','Entregado',15),(463,'2022-02-21 00:00:00','Entregado',153),(464,'2022-02-21 00:00:00','Entregado',142),(465,'2022-02-21 00:00:00','Entregado',22),(466,'2022-03-04 00:00:00','Entregado',15),(467,'2022-03-08 00:00:00','Entregado',10),(468,'2022-03-10 00:00:00','Entregado',126),(469,'2022-03-08 00:00:00','Entregado',111),(470,'2022-03-23 00:00:00','Entregado',10),(471,'2022-03-24 00:00:00','Entregado',15),(472,'2022-03-25 00:00:00','Entregado',111),(473,'2022-05-31 00:00:00','Entregado',10),(474,'2022-05-31 00:00:00','Entregado',111),(475,'2022-06-01 00:00:00','Entregado',111),(476,'2022-06-18 00:00:00','Entregado',111),(477,'2022-06-22 00:00:00','Entregado',115),(478,'2022-06-22 00:00:00','Entregado',7),(479,'2022-06-23 00:00:00','Entregado',10),(480,'2022-06-24 00:00:00','Entregado',27),(481,'2022-06-25 00:00:00','Entregado',100),(482,'2022-06-26 00:00:00','Entregado',100);
#Tabla de enlace "Pedido_Producto"
INSERT INTO PEDIDO_PRODUCTO (ID_Pedido_Producto, ID_Pedido, ID_Producto, Cantidad_Producto) VALUES (1,1,4,12),(2,2,4,2),(3,3,5,1),(4,3,4,2),(5,4,4,9),(6,5,5,1),(7,6,5,3),(8,6,7,1),(9,7,7,1),(10,8,4,9),(11,9,5,1),(12,9,4,4),(13,10,5,6),(14,10,4,3),(15,11,5,5),(16,12,5,3),(17,12,4,5),(18,13,9,3),(19,13,7,2),(20,14,5,1),(21,14,7,1),(22,15,4,3),(23,16,5,2),(24,17,5,2),(25,18,4,2),(26,19,4,1),(27,20,4,1),(28,21,5,1),(29,22,4,2),(30,23,5,2),(31,24,5,2),(32,24,7,2),(33,25,1,2),(34,25,3,1),(35,26,1,1),(36,27,1,1),(37,28,1,1),(38,29,1,1),(39,30,1,1),(40,31,3,1),(41,32,3,1),(42,33,1,1),(43,34,1,1),(44,35,1,1),(45,36,1,1),(46,37,10,1),(47,37,1,1),(48,37,3,1),(49,38,1,1),(50,39,1,1),(51,39,3,1),(52,40,1,4),(53,41,1,1),(54,42,1,1),(55,43,1,1),(56,44,1,1),(57,45,1,2),(58,46,1,1),(59,47,1,1),(60,48,10,1),(61,48,1,1),(62,49,1,1),(63,50,3,1),(64,51,1,1),(65,52,1,1),(66,53,1,2),(67,54,1,1),(68,55,3,1),(69,56,1,2),(70,57,3,1),(71,58,1,1),(72,59,1,1),(73,60,3,1),(74,61,5,1),(75,61,1,1),(76,61,3,1),(77,62,1,1),(78,62,3,1),(79,63,1,1),(80,64,1,1),(81,65,1,1),(82,66,1,1),(83,67,1,1),(84,67,3,1),(85,68,1,2),(86,69,1,1),(87,70,1,1),(88,71,1,2),(89,72,1,2),(90,73,1,1),(91,74,1,2),(92,75,1,1),(93,76,1,4),(94,77,3,1),(95,78,1,1),(96,79,1,1),(97,80,1,2),(98,81,1,1),(99,82,1,1),(100,83,1,1),(101,84,1,1),(102,85,1,1),(103,86,1,1),(104,87,1,1),(105,88,1,1),(106,89,1,1),(107,90,3,2),(108,91,1,3),(109,92,1,1),(110,93,1,1),(111,94,1,2),(112,95,1,1),(113,96,1,1),(114,97,1,1),(115,98,1,2),(116,99,1,1),(117,100,1,1),(118,101,1,1),(119,102,1,1),(120,102,3,1),(121,103,1,2),(122,104,1,1),(123,105,1,4),(124,106,1,1),(125,107,1,1),(126,108,1,1),(127,109,3,1),(128,110,1,1),(129,111,1,1),(130,112,1,1),(131,113,1,3),(132,114,1,3),(133,115,1,2),(134,116,1,1),(135,117,1,2),(136,118,1,1),(137,119,1,3),(138,120,1,1),(139,120,3,1),(140,121,1,2),(141,122,1,1),(142,123,1,1),(143,124,1,1),(144,124,3,1),(145,125,1,1),(146,126,1,3),(147,127,1,1),(148,128,1,3),(149,129,1,1),(150,130,1,1),(151,130,3,1),(152,131,1,1),(153,132,1,2),(154,133,1,1),(155,134,1,1),(156,135,1,1),(157,136,1,1),(158,137,1,1),(159,138,1,1),(160,139,1,1),(161,140,1,1),(162,141,1,1),(163,142,1,1),(164,143,1,1),(165,144,1,2),(166,145,1,1),(167,146,1,3),(168,147,3,1),(169,148,1,1),(170,149,1,1),(171,150,1,1),(172,151,1,1),(173,152,1,2),(174,153,1,1),(175,154,1,1),(176,155,1,2),(177,156,1,1),(178,157,1,1),(179,158,1,1),(180,159,1,1),(181,160,1,1),(182,161,1,3),(183,162,1,1),(184,163,1,1),(185,164,1,1),(186,165,5,5),(187,165,1,1),(188,166,1,1),(189,167,1,2),(190,168,5,2),(191,169,1,1),(192,170,5,1),(193,170,1,1),(194,171,1,1),(195,172,1,1),(196,173,1,1),(197,174,1,1),(198,175,1,1),(199,176,1,1),(200,176,3,1),(201,177,3,1),(202,178,1,1),(203,179,1,2),(204,180,1,2),(205,181,1,2),(206,182,1,1),(207,183,1,1),(208,184,1,1),(209,185,1,1),(210,186,1,1),(211,187,1,1),(212,188,1,1),(213,189,1,1),(214,190,1,1),(215,191,1,2),(216,192,1,2),(217,193,1,1),(218,194,1,1),(219,195,1,1),(220,196,1,2),(221,197,1,2),(222,198,1,1),(223,199,1,1),(224,200,1,1),(225,201,1,1),(226,201,3,1),(227,202,1,1),(228,203,1,1),(229,204,1,1),(230,205,1,1),(231,206,1,1),(232,207,1,1),(233,208,1,1),(234,209,1,1),(235,210,1,1),(236,211,3,1),(237,212,1,1),(238,213,1,1),(239,213,3,1),(240,214,1,2),(241,215,1,1),(242,216,1,1),(243,217,1,1),(244,218,1,2),(245,219,1,1),(246,220,1,1),(247,221,1,1),(248,222,1,1),(249,223,1,1),(250,224,1,1),(251,225,1,2),(252,226,1,1),(253,227,1,2),(254,228,1,1),(255,229,1,1),(256,230,1,1),(257,231,1,1),(258,232,1,1),(259,233,1,1),(260,234,1,1),(261,235,1,2),(262,236,1,1),(263,237,1,1),(264,238,1,2),(265,239,1,3),(266,240,1,1),(267,241,1,1),(268,242,1,2),(269,243,1,1),(270,244,1,2),(271,245,1,1),(272,245,3,1),(273,246,1,2),(274,247,1,2),(275,248,1,1),(276,249,1,1),(277,250,1,1),(278,251,1,1),(279,252,1,1),(280,253,1,1),(281,254,1,1),(282,255,1,1),(283,256,1,1),(284,257,1,2),(285,258,1,1),(286,259,1,1),(287,259,3,1),(288,260,1,2),(289,261,1,1),(290,262,1,1),(291,263,1,2),(292,264,1,1),(293,265,1,2),(294,266,1,1),(295,267,1,1),(296,268,1,1),(297,269,1,1),(298,270,1,1),(299,271,1,1),(300,272,1,1),(301,273,1,1),(302,274,1,1),(303,275,1,3),(304,276,1,1),(305,277,1,1),(306,277,3,1),(307,278,6,1),(308,279,1,1),(309,280,1,1),(310,281,1,1),(311,282,1,3),(312,283,1,1),(313,284,1,1),(314,284,3,1),(315,285,1,1),(316,286,6,8),(317,287,1,1),(318,287,3,1),(319,288,1,1),(320,289,3,2),(321,290,1,1),(322,291,1,1),(323,292,1,2),(324,293,1,1),(325,294,6,4),(326,295,6,1),(327,296,1,1),(328,297,1,1),(329,298,1,1),(330,299,3,1),(331,300,1,1),(332,301,8,1),(333,302,1,1),(334,303,1,1),(335,304,1,1),(336,305,1,1),(337,306,1,1),(338,307,1,1),(339,308,1,2),(340,309,1,2),(341,310,1,2),(342,311,3,1),(343,312,1,1),(344,313,1,2),(345,314,1,1),(346,315,1,1),(347,316,1,1),(348,317,1,1),(349,318,1,1),(350,319,1,1),(351,320,1,1),(352,321,1,1),(353,322,1,2),(354,323,1,1),(355,324,1,2),(356,325,1,2),(357,326,1,1),(358,327,1,1),(359,328,3,1),(360,329,1,1),(361,330,1,1),(362,331,1,1),(363,332,1,2),(364,333,1,2),(365,334,3,1),(366,335,1,1),(367,336,1,1),(368,337,1,1),(369,338,1,1),(370,339,1,1),(371,340,1,1),(372,341,1,1),(373,342,1,2),(374,343,1,2),(375,344,1,1),(376,345,1,1),(377,346,1,1),(378,347,1,1),(379,348,1,5),(380,349,1,1),(381,350,1,2),(382,351,1,1),(383,352,1,2),(384,353,1,1),(385,354,1,2),(386,355,1,1),(387,356,1,2),(388,357,1,1),(389,358,6,1),(390,358,1,1),(391,359,1,1),(392,360,1,1),(393,361,6,1),(394,362,1,1),(395,363,1,1),(396,364,1,1),(397,365,5,1),(398,365,1,1),(399,366,6,6),(400,367,1,1),(401,368,1,1),(402,369,1,1),(403,370,1,1),(404,371,1,1),(405,372,1,1),(406,373,1,1),(407,374,1,3),(408,375,1,1),(409,376,1,1),(410,377,1,2),(411,378,1,1),(412,379,1,1),(413,380,1,1),(414,381,5,3),(415,382,1,1),(416,383,1,2),(417,384,1,1),(418,385,1,1),(419,386,1,1),(420,387,1,1),(421,388,1,1),(422,389,1,1),(423,389,7,1),(424,390,1,3),(425,391,1,1),(426,392,1,1),(427,393,1,1),(428,393,7,1),(429,394,1,1),(430,395,1,1),(431,396,1,1),(432,397,1,2),(433,398,1,2),(434,399,1,1),(435,400,1,1),(436,401,1,1),(437,402,1,1),(438,403,1,1),(439,404,1,1),(440,405,1,1),(441,406,1,1),(442,407,1,2),(443,408,1,1),(444,409,1,1),(445,410,1,1),(446,411,2,2),(447,412,1,1),(448,413,1,1),(449,414,5,1),(450,415,5,10),(451,416,1,1),(452,417,3,1),(453,418,1,1),(454,419,2,1),(455,419,1,1),(456,420,1,1),(457,421,6,1),(458,421,1,1),(459,422,1,1),(460,423,1,1),(461,424,1,1),(462,425,1,2),(463,425,3,1),(464,426,1,1),(465,427,1,1),(466,428,1,1),(467,429,5,1),(468,430,1,1),(469,431,1,1),(470,432,1,1),(471,433,1,1),(472,434,1,1),(473,435,1,1),(474,436,1,1),(475,437,1,1),(476,438,1,1),(477,439,1,1),(478,440,1,1),(479,441,1,1),(480,442,1,1),(481,443,1,1),(482,444,1,1),(483,445,1,1),(484,446,1,1),(485,447,1,2),(486,448,1,1),(487,449,1,1),(488,450,1,1),(489,450,3,1),(490,451,1,1),(491,452,1,1),(492,453,2,1),(493,454,1,1),(494,455,2,1),(495,456,1,1),(496,457,1,1),(497,458,1,1),(498,459,2,1),(499,459,1,1),(500,460,2,1),(501,461,1,1),(502,462,1,1),(503,463,1,1),(504,464,1,1),(505,465,1,1),(506,466,2,1),(507,467,1,2),(508,468,2,1),(509,469,1,1),(510,470,1,1),(511,471,1,1),(512,472,1,1),(513,473,11,1),(514,473,1,1),(515,474,1,1),(516,475,1,1),(517,476,1,1),(518,477,1,2),(519,478,1,1),(520,479,11,1),(521,479,1,1),(522,480,1,2),(523,481,1,1),(524,482,2,1);
#Tabla de hecho "Compra"
INSERT INTO COMPRA (ID_Compra, Fecha_Compra, Medio_Pago, Valor_Compra, Categoria_Compra, ID_Proveedor, ID_Empleado) VALUES (1,'2022-06-09 00:00:00','Tarjeta de crédito/débito',2857.08,'Ingredientes',12,1),(2,'2022-05-02 00:00:00','Tarjeta de crédito/débito',2830.02,'Materiales de empaque',9,2),(3,'2022-11-26 00:00:00','Efectivo',2569.49,'Utensilios',9,2),(4,'2022-07-05 00:00:00','Tarjeta de crédito/débito',5986.39,'Utensilios',10,2),(5,'2022-08-03 00:00:00','Efectivo',2348.77,'Ingredientes',7,1),(6,'2022-07-12 00:00:00','Tarjeta de crédito/débito',6003.68,'Materiales de empaque',4,1),(7,'2022-10-29 00:00:00','Transferencia bancaria',7897.61,'Materiales de empaque',4,2),(8,'2022-08-19 00:00:00','Efectivo',9897.48,'Utensilios',8,2),(9,'2022-10-29 00:00:00','Tarjeta de crédito/débito',220.84,'Insumos',10,1),(10,'2022-12-17 00:00:00','Tarjeta de crédito/débito',5133.89,'Insumos',4,2),(11,'2022-08-25 00:00:00','Efectivo',4858.4,'Utensilios',10,1),(12,'2022-11-12 00:00:00','Transferencia bancaria',6069.73,'Insumos',9,1),(13,'2022-11-30 00:00:00','Transferencia bancaria',4954.98,'Utensilios',8,2),(14,'2023-02-06 00:00:00','Tarjeta de crédito/débito',6855.8,'Materiales de empaque',1,2),(15,'2022-06-03 00:00:00','Transferencia bancaria',6865.03,'Utensilios',1,2),(16,'2023-02-18 00:00:00','Tarjeta de crédito/débito',6514.79,'Insumos',2,2),(17,'2022-03-28 00:00:00','Efectivo',7440.78,'Ingredientes',6,2),(18,'2022-08-18 00:00:00','Transferencia bancaria',4556.74,'Utensilios',11,2),(19,'2022-10-29 00:00:00','Efectivo',2979.68,'Ingredientes',5,1),(20,'2022-11-09 00:00:00','Tarjeta de crédito/débito',3819.65,'Utensilios',8,1),(21,'2022-07-20 00:00:00','Transferencia bancaria',1585.64,'Utensilios',5,2),(22,'2022-09-13 00:00:00','Tarjeta de crédito/débito',4899.34,'Utensilios',12,2),(23,'2022-05-31 00:00:00','Transferencia bancaria',4813.9,'Insumos',6,2),(24,'2022-11-04 00:00:00','Tarjeta de crédito/débito',5654.6,'Utensilios',1,1),(25,'2022-10-02 00:00:00','Transferencia bancaria',9002.22,'Utensilios',5,2),(26,'2022-03-23 00:00:00','Transferencia bancaria',445.02,'Insumos',4,1),(27,'2022-08-23 00:00:00','Tarjeta de crédito/débito',4701.8,'Insumos',5,1),(28,'2022-07-07 00:00:00','Efectivo',6829.37,'Utensilios',10,1),(29,'2022-12-21 00:00:00','Transferencia bancaria',7491.54,'Ingredientes',5,2),(30,'2022-10-04 00:00:00','Tarjeta de crédito/débito',6185.27,'Utensilios',6,2),(31,'2022-05-19 00:00:00','Efectivo',3466.22,'Ingredientes',10,2),(32,'2022-03-05 00:00:00','Efectivo',9554.2,'Materiales de empaque',3,2),(33,'2023-02-06 00:00:00','Tarjeta de crédito/débito',1654.08,'Insumos',3,2),(34,'2022-10-18 00:00:00','Tarjeta de crédito/débito',5856.55,'Utensilios',1,1),(35,'2022-12-19 00:00:00','Transferencia bancaria',1339.47,'Utensilios',3,2),(36,'2022-08-27 00:00:00','Tarjeta de crédito/débito',878.71,'Insumos',2,1),(37,'2022-06-27 00:00:00','Tarjeta de crédito/débito',3741.39,'Ingredientes',1,2),(38,'2023-02-09 00:00:00','Efectivo',1138.11,'Utensilios',2,1),(39,'2022-06-06 00:00:00','Transferencia bancaria',3316.43,'Ingredientes',5,1),(40,'2023-02-07 00:00:00','Tarjeta de crédito/débito',3813.94,'Ingredientes',10,1),(41,'2022-11-06 00:00:00','Transferencia bancaria',2349.4,'Utensilios',4,1),(42,'2022-09-25 00:00:00','Efectivo',631.67,'Utensilios',8,2),(43,'2023-01-02 00:00:00','Tarjeta de crédito/débito',1008.5,'Insumos',12,1),(44,'2022-12-02 00:00:00','Efectivo',9391.62,'Insumos',5,2),(45,'2022-07-07 00:00:00','Efectivo',1743.6,'Utensilios',7,1),(46,'2022-09-12 00:00:00','Tarjeta de crédito/débito',1204.21,'Utensilios',6,2),(47,'2022-12-16 00:00:00','Tarjeta de crédito/débito',5600.24,'Insumos',6,1),(48,'2023-02-25 00:00:00','Efectivo',1227.1,'Ingredientes',10,2),(49,'2022-06-29 00:00:00','Efectivo',3586.63,'Materiales de empaque',5,2),(50,'2022-02-27 00:00:00','Transferencia bancaria',6698,'Utensilios',8,2);
#Tabla de enlace "Compra_Material"
INSERT INTO COMPRA_MATERIAL (ID_Compra_Material, ID_Compra, ID_Material, Cantidad_Material) VALUES (1,49,2,13),(2,39,15,19),(3,14,12,3),(4,16,16,3),(5,27,20,3),(6,1,13,15),(7,46,7,14),(8,41,6,10),(9,8,20,3),(10,31,16,14),(11,50,4,17),(12,11,17,8),(13,2,9,16),(14,3,8,11),(15,44,5,9),(16,45,8,8),(17,28,11,14),(18,37,4,15),(19,35,19,12),(20,36,3,16),(21,13,13,18),(22,32,2,19),(23,22,8,17),(24,7,6,10),(25,34,1,14),(26,33,15,18),(27,18,3,16),(28,6,7,7),(29,4,7,9),(30,38,8,14),(31,12,20,20),(32,10,15,6),(33,29,5,12),(34,15,12,15),(35,23,15,2),(36,9,3,16),(37,19,19,12),(38,26,19,7),(39,5,17,11),(40,40,7,19),(41,42,14,10),(42,30,8,17),(43,43,20,15),(44,17,14,16),(45,25,8,2),(46,21,12,18),(47,24,14,2),(48,20,3,1),(49,47,3,6),(50,48,7,10),(51,37,7,13),(52,50,14,6),(53,26,7,15),(54,9,20,15),(55,46,4,15),(56,14,1,4),(57,44,20,20),(58,27,15,18),(59,41,6,7),(60,31,8,8),(61,28,9,14),(62,49,15,18),(63,1,2,9),(64,39,19,3),(65,12,18,17),(66,2,4,14),(67,15,7,16),(68,40,4,15),(69,5,9,4),(70,20,4,3),(71,30,12,12),(72,29,18,7),(73,10,8,8),(74,24,19,7),(75,17,3,5),(76,6,20,17),(77,45,3,18),(78,36,7,4),(79,7,8,5),(80,4,9,4);
#Tabla de hecho "Venta"
INSERT INTO venta (ID_Venta, Fecha_Venta, Medio_Pago, Valor_Venta, ID_Pedido, ID_Empleado) VALUES (1,'2020-07-26 00:00:00','Tarjeta de crédito/débito',3600,1,2),(2,'2020-07-27 00:00:00','Efectivo',600,2,2),(3,'2020-07-30 00:00:00','Tarjeta de crédito/débito',250,3,2),(4,'2020-08-01 00:00:00','Tarjeta de crédito/débito',2700,4,2),(5,'2020-08-06 00:00:00','Efectivo',250,5,2),(6,'2020-08-08 00:00:00','Transferencia bancaria',750,6,2),(7,'2020-08-11 00:00:00','Tarjeta de crédito/débito',400,7,2),(8,'2020-08-15 00:00:00','Transferencia bancaria',2700,8,2),(9,'2020-08-16 00:00:00','Tarjeta de crédito/débito',250,9,2),(10,'2020-08-22 00:00:00','Transferencia bancaria',1500,10,2),(11,'2020-08-27 00:00:00','Transferencia bancaria',1250,11,2),(12,'2020-09-11 00:00:00','Transferencia bancaria',750,12,2),(13,'2020-09-18 00:00:00','Tarjeta de crédito/débito',900,13,2),(14,'2020-09-20 00:00:00','Efectivo',250,14,2),(15,'2020-09-26 00:00:00','Efectivo',900,15,2),(16,'2020-10-01 00:00:00','Transferencia bancaria',500,16,2),(17,'2020-10-02 00:00:00','Efectivo',500,17,2),(18,'2020-10-03 00:00:00','Transferencia bancaria',600,18,2),(19,'2020-10-04 00:00:00','Tarjeta de crédito/débito',300,19,2),(20,'2020-10-05 00:00:00','Tarjeta de crédito/débito',300,20,2),(21,'2020-10-06 00:00:00','Tarjeta de crédito/débito',250,21,2),(22,'2020-10-07 00:00:00','Transferencia bancaria',600,22,2),(23,'2020-10-08 00:00:00','Efectivo',500,23,2),(24,'2020-10-10 00:00:00','Tarjeta de crédito/débito',500,24,2),(25,'2020-11-24 00:00:00','Transferencia bancaria',900,25,2),(26,'2020-11-24 00:00:00','Efectivo',450,26,2),(27,'2020-11-24 00:00:00','Tarjeta de crédito/débito',450,27,2),(28,'2020-11-24 00:00:00','Tarjeta de crédito/débito',450,28,2),(29,'2020-11-24 00:00:00','Tarjeta de crédito/débito',450,29,2),(30,'2020-11-24 00:00:00','Efectivo',450,30,2),(31,'2020-11-24 00:00:00','Tarjeta de crédito/débito',350,31,2),(32,'2020-11-24 00:00:00','Transferencia bancaria',350,32,2),(33,'2020-11-24 00:00:00','Tarjeta de crédito/débito',450,33,2),(34,'2020-11-24 00:00:00','Tarjeta de crédito/débito',450,34,2),(35,'2020-11-24 00:00:00','Tarjeta de crédito/débito',450,35,2),(36,'2020-11-24 00:00:00','Transferencia bancaria',450,36,2),(37,'2020-12-01 00:00:00','Efectivo',200,37,2),(38,'2020-12-01 00:00:00','Tarjeta de crédito/débito',450,38,2),(39,'2020-12-01 00:00:00','Efectivo',450,39,2),(40,'2020-12-01 00:00:00','Transferencia bancaria',1800,40,2),(41,'2020-12-01 00:00:00','Tarjeta de crédito/débito',450,41,2),(42,'2020-12-01 00:00:00','Transferencia bancaria',450,42,2),(43,'2020-12-01 00:00:00','Transferencia bancaria',450,43,2),(44,'2020-12-01 00:00:00','Transferencia bancaria',450,44,2),(45,'2020-12-01 00:00:00','Efectivo',900,45,2),(46,'2020-12-01 00:00:00','Tarjeta de crédito/débito',450,46,2),(47,'2020-12-01 00:00:00','Transferencia bancaria',450,47,2),(48,'2020-12-01 00:00:00','Efectivo',200,48,2),(49,'2020-12-01 00:00:00','Transferencia bancaria',450,49,2),(50,'2020-12-01 00:00:00','Transferencia bancaria',350,50,2),(51,'2020-12-01 00:00:00','Efectivo',450,51,2),(52,'2020-12-08 00:00:00','Transferencia bancaria',450,52,2),(53,'2020-12-08 00:00:00','Efectivo',900,53,2),(54,'2020-12-08 00:00:00','Transferencia bancaria',450,54,2),(55,'2020-12-08 00:00:00','Tarjeta de crédito/débito',350,55,2),(56,'2020-12-08 00:00:00','Tarjeta de crédito/débito',900,56,2),(57,'2020-12-08 00:00:00','Efectivo',350,57,2),(58,'2020-12-08 00:00:00','Efectivo',450,58,2),(59,'2020-12-08 00:00:00','Transferencia bancaria',450,59,2),(60,'2020-12-12 00:00:00','Tarjeta de crédito/débito',350,60,2),(61,'2020-12-15 00:00:00','Transferencia bancaria',250,61,2),(62,'2020-12-15 00:00:00','Efectivo',450,62,2),(63,'2020-12-16 00:00:00','Efectivo',450,63,2),(64,'2020-12-16 00:00:00','Transferencia bancaria',450,64,2),(65,'2020-12-16 00:00:00','Efectivo',450,65,2),(66,'2020-12-16 00:00:00','Transferencia bancaria',450,66,2),(67,'2020-12-17 00:00:00','Tarjeta de crédito/débito',450,67,2),(68,'2020-12-17 00:00:00','Tarjeta de crédito/débito',900,68,2),(69,'2020-12-17 00:00:00','Tarjeta de crédito/débito',450,69,2),(70,'2020-12-17 00:00:00','Transferencia bancaria',450,70,2),(71,'2020-12-17 00:00:00','Transferencia bancaria',900,71,2),(72,'2020-12-23 00:00:00','Efectivo',900,72,2),(73,'2020-12-23 00:00:00','Efectivo',450,73,2),(74,'2020-12-26 00:00:00','Tarjeta de crédito/débito',900,74,2),(75,'2020-12-28 00:00:00','Efectivo',450,75,2),(76,'2020-12-28 00:00:00','Transferencia bancaria',1800,76,2),(77,'2020-12-28 00:00:00','Efectivo',350,77,2),(78,'2020-12-29 00:00:00','Transferencia bancaria',450,78,2),(79,'2020-12-29 00:00:00','Tarjeta de crédito/débito',450,79,2),(80,'2020-12-29 00:00:00','Transferencia bancaria',900,80,2),(81,'2020-12-29 00:00:00','Transferencia bancaria',450,81,2),(82,'2020-12-30 00:00:00','Transferencia bancaria',450,82,2),(83,'2020-12-30 00:00:00','Tarjeta de crédito/débito',450,83,2),(84,'2021-01-03 00:00:00','Transferencia bancaria',450,84,2),(85,'2021-01-03 00:00:00','Efectivo',450,85,2),(86,'2021-01-03 00:00:00','Efectivo',450,86,2),(87,'2021-01-05 00:00:00','Transferencia bancaria',450,87,2),(88,'2021-01-05 00:00:00','Efectivo',450,88,2),(89,'2021-01-05 00:00:00','Tarjeta de crédito/débito',450,89,2),(90,'2021-01-07 00:00:00','Efectivo',700,90,2),(91,'2021-01-08 00:00:00','Efectivo',1350,91,2),(92,'2021-01-08 00:00:00','Tarjeta de crédito/débito',450,92,2),(93,'2021-01-11 00:00:00','Efectivo',450,93,2),(94,'2021-01-12 00:00:00','Tarjeta de crédito/débito',900,94,2),(95,'2021-01-12 00:00:00','Efectivo',450,95,2),(96,'2021-01-12 00:00:00','Transferencia bancaria',450,96,2),(97,'2021-01-12 00:00:00','Transferencia bancaria',450,97,2),(98,'2021-01-12 00:00:00','Tarjeta de crédito/débito',900,98,2),(99,'2021-01-12 00:00:00','Transferencia bancaria',450,99,2),(100,'2021-01-12 00:00:00','Tarjeta de crédito/débito',450,100,2),(101,'2021-01-12 00:00:00','Tarjeta de crédito/débito',450,101,2),(102,'2021-01-12 00:00:00','Efectivo',450,102,2),(103,'2021-01-12 00:00:00','Efectivo',900,103,2),(104,'2021-01-12 00:00:00','Efectivo',450,104,2),(105,'2021-01-12 00:00:00','Efectivo',1800,105,2),(106,'2021-01-12 00:00:00','Tarjeta de crédito/débito',450,106,2),(107,'2021-01-12 00:00:00','Transferencia bancaria',450,107,2),(108,'2021-01-12 00:00:00','Tarjeta de crédito/débito',450,108,2),(109,'2021-01-14 00:00:00','Transferencia bancaria',350,109,2),(110,'2021-01-15 00:00:00','Efectivo',450,110,2),(111,'2021-01-15 00:00:00','Tarjeta de crédito/débito',450,111,2),(112,'2021-01-16 00:00:00','Efectivo',450,112,2),(113,'2021-01-17 00:00:00','Tarjeta de crédito/débito',1350,113,2),(114,'2021-01-17 00:00:00','Transferencia bancaria',1350,114,2),(115,'2021-01-18 00:00:00','Transferencia bancaria',900,115,2),(116,'2021-01-18 00:00:00','Efectivo',450,116,2),(117,'2021-01-20 00:00:00','Transferencia bancaria',900,117,2),(118,'2021-01-20 00:00:00','Tarjeta de crédito/débito',450,118,2),(119,'2021-01-26 00:00:00','Transferencia bancaria',1350,119,2),(120,'2021-01-26 00:00:00','Tarjeta de crédito/débito',450,120,2),(121,'2021-01-26 00:00:00','Transferencia bancaria',900,121,2),(122,'2021-01-26 00:00:00','Tarjeta de crédito/débito',450,122,2),(123,'2021-01-26 00:00:00','Efectivo',450,123,2),(124,'2021-01-26 00:00:00','Transferencia bancaria',450,124,2),(125,'2021-01-26 00:00:00','Efectivo',450,125,2),(126,'2021-01-26 00:00:00','Transferencia bancaria',1350,126,2),(127,'2021-01-26 00:00:00','Tarjeta de crédito/débito',450,127,2),(128,'2021-01-30 00:00:00','Transferencia bancaria',1350,128,2),(129,'2021-01-30 00:00:00','Tarjeta de crédito/débito',450,129,2),(130,'2021-01-30 00:00:00','Tarjeta de crédito/débito',450,130,2),(131,'2021-01-30 00:00:00','Efectivo',450,131,2),(132,'2021-01-30 00:00:00','Transferencia bancaria',900,132,2),(133,'2021-01-30 00:00:00','Efectivo',450,133,2),(134,'2021-01-30 00:00:00','Transferencia bancaria',450,134,2),(135,'2021-01-31 00:00:00','Efectivo',450,135,2),(136,'2021-01-31 00:00:00','Transferencia bancaria',450,136,2),(137,'2021-02-01 00:00:00','Transferencia bancaria',450,137,2),(138,'2021-02-01 00:00:00','Tarjeta de crédito/débito',450,138,2),(139,'2021-02-01 00:00:00','Tarjeta de crédito/débito',450,139,2),(140,'2021-02-01 00:00:00','Tarjeta de crédito/débito',450,140,2),(141,'2021-02-01 00:00:00','Transferencia bancaria',450,141,2),(142,'2021-02-02 00:00:00','Efectivo',450,142,2),(143,'2021-02-02 00:00:00','Transferencia bancaria',450,143,2),(144,'2021-02-02 00:00:00','Efectivo',900,144,2),(145,'2021-02-03 00:00:00','Efectivo',450,145,2),(146,'2021-02-04 00:00:00','Transferencia bancaria',1350,146,2),(147,'2021-02-04 00:00:00','Efectivo',350,147,2),(148,'2021-02-05 00:00:00','Efectivo',450,148,2),(149,'2021-02-05 00:00:00','Transferencia bancaria',450,149,2),(150,'2021-02-05 00:00:00','Tarjeta de crédito/débito',450,150,2),(151,'2021-02-08 00:00:00','Transferencia bancaria',450,151,2),(152,'2021-02-08 00:00:00','Efectivo',900,152,2),(153,'2021-02-08 00:00:00','Transferencia bancaria',450,153,2),(154,'2021-02-08 00:00:00','Tarjeta de crédito/débito',450,154,2),(155,'2021-02-08 00:00:00','Efectivo',900,155,2),(156,'2021-02-08 00:00:00','Tarjeta de crédito/débito',450,156,2),(157,'2021-02-08 00:00:00','Transferencia bancaria',450,157,2),(158,'2021-02-08 00:00:00','Efectivo',450,158,2),(159,'2021-02-08 00:00:00','Efectivo',450,159,2),(160,'2021-02-09 00:00:00','Efectivo',450,160,2),(161,'2021-02-09 00:00:00','Transferencia bancaria',1350,161,2),(162,'2021-02-09 00:00:00','Transferencia bancaria',450,162,2),(163,'2021-02-11 00:00:00','Transferencia bancaria',450,163,2),(164,'2021-02-11 00:00:00','Transferencia bancaria',450,164,2),(165,'2021-02-12 00:00:00','Transferencia bancaria',1250,165,2),(166,'2021-02-11 00:00:00','Efectivo',450,166,2),(167,'2021-02-11 00:00:00','Efectivo',900,167,2),(168,'2021-02-11 00:00:00','Transferencia bancaria',500,168,2),(169,'2021-02-11 00:00:00','Transferencia bancaria',450,169,2),(170,'2021-02-16 00:00:00','Tarjeta de crédito/débito',250,170,2),(171,'2021-02-16 00:00:00','Tarjeta de crédito/débito',450,171,2),(172,'2021-02-16 00:00:00','Transferencia bancaria',450,172,2),(173,'2021-02-16 00:00:00','Efectivo',450,173,2),(174,'2021-02-17 00:00:00','Efectivo',450,174,2),(175,'2021-02-18 00:00:00','Transferencia bancaria',450,175,2),(176,'2021-02-18 00:00:00','Efectivo',450,176,2),(177,'2021-02-18 00:00:00','Efectivo',350,177,2),(178,'2021-02-19 00:00:00','Transferencia bancaria',450,178,2),(179,'2021-02-19 00:00:00','Transferencia bancaria',900,179,2),(180,'2021-02-19 00:00:00','Tarjeta de crédito/débito',900,180,2),(181,'2021-02-19 00:00:00','Tarjeta de crédito/débito',900,181,2),(182,'2021-02-21 00:00:00','Tarjeta de crédito/débito',450,182,2),(183,'2021-02-21 00:00:00','Transferencia bancaria',450,183,2),(184,'2021-02-22 00:00:00','Tarjeta de crédito/débito',450,184,2),(185,'2021-02-22 00:00:00','Transferencia bancaria',450,185,2),(186,'2021-02-22 00:00:00','Transferencia bancaria',450,186,2),(187,'2021-02-22 00:00:00','Tarjeta de crédito/débito',450,187,2),(188,'2021-02-24 00:00:00','Tarjeta de crédito/débito',450,188,2),(189,'2021-02-24 00:00:00','Transferencia bancaria',450,189,2),(190,'2021-02-24 00:00:00','Efectivo',450,190,2),(191,'2021-02-24 00:00:00','Efectivo',900,191,2),(192,'2021-02-24 00:00:00','Efectivo',900,192,2),(193,'2021-02-25 00:00:00','Tarjeta de crédito/débito',450,193,2),(194,'2021-02-25 00:00:00','Tarjeta de crédito/débito',450,194,2),(195,'2021-02-26 00:00:00','Tarjeta de crédito/débito',450,195,2),(196,'2021-02-27 00:00:00','Tarjeta de crédito/débito',900,196,2),(197,'2021-02-27 00:00:00','Efectivo',900,197,2),(198,'2021-02-28 00:00:00','Tarjeta de crédito/débito',450,198,2),(199,'2021-02-28 00:00:00','Tarjeta de crédito/débito',450,199,2),(200,'2021-03-01 00:00:00','Efectivo',450,200,2),(201,'2021-03-01 00:00:00','Transferencia bancaria',450,201,2),(202,'2021-03-01 00:00:00','Transferencia bancaria',450,202,2),(203,'2021-03-01 00:00:00','Tarjeta de crédito/débito',450,203,2),(204,'2021-03-01 00:00:00','Tarjeta de crédito/débito',450,204,2),(205,'2021-03-03 00:00:00','Tarjeta de crédito/débito',450,205,2),(206,'2021-03-03 00:00:00','Tarjeta de crédito/débito',450,206,2),(207,'2021-03-04 00:00:00','Transferencia bancaria',450,207,2),(208,'2021-03-04 00:00:00','Transferencia bancaria',450,208,2),(209,'2021-03-04 00:00:00','Tarjeta de crédito/débito',450,209,2),(210,'2021-03-07 00:00:00','Efectivo',450,210,2),(211,'2021-03-07 00:00:00','Transferencia bancaria',350,211,2),(212,'2021-03-16 00:00:00','Efectivo',450,212,2),(213,'2021-03-16 00:00:00','Efectivo',450,213,2),(214,'2021-03-16 00:00:00','Transferencia bancaria',900,214,2),(215,'2021-03-16 00:00:00','Transferencia bancaria',450,215,2),(216,'2021-03-16 00:00:00','Transferencia bancaria',450,216,2),(217,'2021-03-16 00:00:00','Efectivo',450,217,2),(218,'2021-03-16 00:00:00','Transferencia bancaria',900,218,2),(219,'2021-03-16 00:00:00','Efectivo',450,219,2),(220,'2021-03-16 00:00:00','Transferencia bancaria',450,220,2),(221,'2021-03-25 00:00:00','Tarjeta de crédito/débito',450,221,2),(222,'2021-03-25 00:00:00','Transferencia bancaria',450,222,2),(223,'2021-03-25 00:00:00','Transferencia bancaria',450,223,2),(224,'2021-03-25 00:00:00','Efectivo',450,224,2),(225,'2021-03-25 00:00:00','Tarjeta de crédito/débito',900,225,2),(226,'2021-03-25 00:00:00','Efectivo',450,226,2),(227,'2021-03-25 00:00:00','Tarjeta de crédito/débito',900,227,2),(228,'2021-03-25 00:00:00','Transferencia bancaria',450,228,2),(229,'2021-03-25 00:00:00','Transferencia bancaria',450,229,2),(230,'2021-03-25 00:00:00','Efectivo',450,230,2),(231,'2021-03-26 00:00:00','Transferencia bancaria',450,231,2),(232,'2021-03-30 00:00:00','Transferencia bancaria',450,232,2),(233,'2021-03-30 00:00:00','Tarjeta de crédito/débito',450,233,2),(234,'2021-03-30 00:00:00','Transferencia bancaria',450,234,2),(235,'2021-03-30 00:00:00','Efectivo',900,235,2),(236,'2021-04-03 00:00:00','Efectivo',450,236,2),(237,'2021-04-03 00:00:00','Transferencia bancaria',450,237,2),(238,'2021-04-04 00:00:00','Tarjeta de crédito/débito',900,238,2),(239,'2021-04-04 00:00:00','Tarjeta de crédito/débito',1350,239,2),(240,'2021-04-10 00:00:00','Transferencia bancaria',450,240,2),(241,'2021-04-11 00:00:00','Tarjeta de crédito/débito',450,241,2),(242,'2021-04-11 00:00:00','Tarjeta de crédito/débito',900,242,2),(243,'2021-04-12 00:00:00','Efectivo',450,243,2),(244,'2021-04-12 00:00:00','Tarjeta de crédito/débito',900,244,2),(245,'2021-04-12 00:00:00','Efectivo',450,245,2),(246,'2021-04-12 00:00:00','Efectivo',900,246,2),(247,'2021-04-12 00:00:00','Tarjeta de crédito/débito',900,247,2),(248,'2021-04-12 00:00:00','Transferencia bancaria',450,248,2),(249,'2021-04-12 00:00:00','Efectivo',450,249,2),(250,'2021-04-12 00:00:00','Transferencia bancaria',450,250,2),(251,'2021-04-14 00:00:00','Transferencia bancaria',450,251,2),(252,'2021-04-15 00:00:00','Transferencia bancaria',450,252,2),(253,'2021-04-15 00:00:00','Efectivo',450,253,2),(254,'2021-04-15 00:00:00','Efectivo',450,254,2),(255,'2021-04-15 00:00:00','Efectivo',450,255,2),(256,'2021-04-15 00:00:00','Efectivo',450,256,2),(257,'2021-04-22 00:00:00','Tarjeta de crédito/débito',900,257,2),(258,'2021-04-22 00:00:00','Tarjeta de crédito/débito',450,258,2),(259,'2021-04-22 00:00:00','Transferencia bancaria',450,259,2),(260,'2021-04-22 00:00:00','Transferencia bancaria',900,260,2),(261,'2021-04-22 00:00:00','Transferencia bancaria',450,261,2),(262,'2021-04-22 00:00:00','Transferencia bancaria',450,262,2),(263,'2021-04-22 00:00:00','Transferencia bancaria',900,263,2),(264,'2021-04-24 00:00:00','Tarjeta de crédito/débito',450,264,2),(265,'2021-04-25 00:00:00','Transferencia bancaria',900,265,2),(266,'2021-04-26 00:00:00','Efectivo',450,266,2),(267,'2021-04-26 00:00:00','Tarjeta de crédito/débito',450,267,2),(268,'2021-04-26 00:00:00','Transferencia bancaria',450,268,2),(269,'2021-04-26 00:00:00','Transferencia bancaria',450,269,2),(270,'2021-04-26 00:00:00','Transferencia bancaria',450,270,2),(271,'2021-04-26 00:00:00','Efectivo',450,271,2),(272,'2021-04-27 00:00:00','Efectivo',450,272,2),(273,'2021-04-27 00:00:00','Transferencia bancaria',450,273,2),(274,'2021-04-28 00:00:00','Efectivo',450,274,2),(275,'2021-04-28 00:00:00','Transferencia bancaria',1350,275,2),(276,'2021-04-28 00:00:00','Efectivo',450,276,2),(277,'2021-04-29 00:00:00','Tarjeta de crédito/débito',450,277,2),(278,'2021-05-01 00:00:00','Transferencia bancaria',300,278,2),(279,'2021-05-01 00:00:00','Tarjeta de crédito/débito',450,279,2),(280,'2021-05-01 00:00:00','Tarjeta de crédito/débito',450,280,2),(281,'2021-05-03 00:00:00','Tarjeta de crédito/débito',450,281,2),(282,'2021-05-03 00:00:00','Efectivo',1350,282,2),(283,'2021-05-04 00:00:00','Efectivo',450,283,2),(284,'2021-05-05 00:00:00','Transferencia bancaria',450,284,2),(285,'2021-05-06 00:00:00','Transferencia bancaria',450,285,2),(286,'2021-05-08 00:00:00','Tarjeta de crédito/débito',2250,286,2),(287,'2021-05-08 00:00:00','Transferencia bancaria',450,287,2),(288,'2021-05-08 00:00:00','Efectivo',450,288,2),(289,'2021-05-09 00:00:00','Efectivo',700,289,2),(290,'2021-05-09 00:00:00','Transferencia bancaria',450,290,2),(291,'2021-05-10 00:00:00','Tarjeta de crédito/débito',450,291,2),(292,'2021-05-13 00:00:00','Tarjeta de crédito/débito',900,292,2),(293,'2021-05-13 00:00:00','Tarjeta de crédito/débito',450,293,2),(294,'2021-05-14 00:00:00','Transferencia bancaria',1110,294,2),(295,'2021-05-14 00:00:00','Transferencia bancaria',300,295,2),(296,'2021-05-14 00:00:00','Tarjeta de crédito/débito',450,296,2),(297,'2021-05-14 00:00:00','Transferencia bancaria',450,297,2),(298,'2021-05-14 00:00:00','Efectivo',450,298,2),(299,'2021-05-20 00:00:00','Transferencia bancaria',350,299,2),(300,'2021-05-21 00:00:00','Transferencia bancaria',450,300,2),(301,'2021-05-22 00:00:00','Efectivo',450,301,2),(302,'2021-05-23 00:00:00','Efectivo',450,302,2),(303,'2021-05-23 00:00:00','Tarjeta de crédito/débito',450,303,2),(304,'2021-05-28 00:00:00','Tarjeta de crédito/débito',450,304,2),(305,'2021-05-28 00:00:00','Efectivo',450,305,2),(306,'2021-05-28 00:00:00','Efectivo',450,306,2),(307,'2021-05-28 00:00:00','Efectivo',450,307,2),(308,'2021-05-28 00:00:00','Efectivo',900,308,2),(309,'2021-05-28 00:00:00','Efectivo',900,309,2),(310,'2021-05-31 00:00:00','Efectivo',900,310,2),(311,'2021-06-02 00:00:00','Efectivo',350,311,2),(312,'2021-06-03 00:00:00','Tarjeta de crédito/débito',450,312,2),(313,'2021-06-03 00:00:00','Tarjeta de crédito/débito',900,313,2),(314,'2021-06-03 00:00:00','Transferencia bancaria',450,314,2),(315,'2021-06-03 00:00:00','Transferencia bancaria',450,315,2),(316,'2021-06-04 00:00:00','Efectivo',450,316,2),(317,'2021-06-04 00:00:00','Transferencia bancaria',450,317,2),(318,'2021-06-04 00:00:00','Transferencia bancaria',450,318,2),(319,'2021-06-06 00:00:00','Transferencia bancaria',450,319,2),(320,'2021-06-06 00:00:00','Tarjeta de crédito/débito',450,320,2),(321,'2021-06-06 00:00:00','Efectivo',450,321,2),(322,'2021-06-06 00:00:00','Tarjeta de crédito/débito',900,322,2),(323,'2021-06-08 00:00:00','Efectivo',450,323,2),(324,'2021-06-08 00:00:00','Efectivo',900,324,2),(325,'2021-06-10 00:00:00','Efectivo',900,325,2),(326,'2021-06-10 00:00:00','Transferencia bancaria',450,326,2),(327,'2021-06-10 00:00:00','Transferencia bancaria',450,327,2),(328,'2021-06-10 00:00:00','Tarjeta de crédito/débito',350,328,2),(329,'2021-06-12 00:00:00','Efectivo',450,329,2),(330,'2021-06-13 00:00:00','Efectivo',450,330,2),(331,'2021-06-14 00:00:00','Transferencia bancaria',450,331,2),(332,'2021-06-14 00:00:00','Efectivo',900,332,2),(333,'2021-06-14 00:00:00','Tarjeta de crédito/débito',900,333,2),(334,'2021-06-14 00:00:00','Transferencia bancaria',350,334,2),(335,'2021-06-17 00:00:00','Tarjeta de crédito/débito',450,335,2),(336,'2021-06-17 00:00:00','Tarjeta de crédito/débito',450,336,2),(337,'2021-06-17 00:00:00','Efectivo',450,337,2),(338,'2021-06-17 00:00:00','Tarjeta de crédito/débito',450,338,2),(339,'2021-06-20 00:00:00','Tarjeta de crédito/débito',450,339,2),(340,'2021-06-23 00:00:00','Tarjeta de crédito/débito',450,340,2),(341,'2021-06-25 00:00:00','Efectivo',450,341,2),(342,'2021-06-25 00:00:00','Transferencia bancaria',900,342,2),(343,'2021-06-25 00:00:00','Efectivo',900,343,2),(344,'2021-06-30 00:00:00','Transferencia bancaria',450,344,2),(345,'2021-06-30 00:00:00','Efectivo',450,345,2),(346,'2021-06-30 00:00:00','Efectivo',450,346,2),(347,'2021-06-30 00:00:00','Tarjeta de crédito/débito',450,347,2),(348,'2021-07-02 00:00:00','Tarjeta de crédito/débito',2250,348,2),(349,'2021-07-02 00:00:00','Tarjeta de crédito/débito',450,349,2),(350,'2021-07-02 00:00:00','Tarjeta de crédito/débito',900,350,2),(351,'2021-07-07 00:00:00','Transferencia bancaria',450,351,2),(352,'2021-07-07 00:00:00','Tarjeta de crédito/débito',900,352,2),(353,'2021-07-12 00:00:00','Tarjeta de crédito/débito',450,353,2),(354,'2021-07-12 00:00:00','Tarjeta de crédito/débito',900,354,2),(355,'2021-07-13 00:00:00','Tarjeta de crédito/débito',450,355,2),(356,'2021-07-13 00:00:00','Efectivo',900,356,2),(357,'2021-07-13 00:00:00','Transferencia bancaria',450,357,2),(358,'2021-07-13 00:00:00','Transferencia bancaria',300,358,2),(359,'2021-07-13 00:00:00','Efectivo',450,359,2),(360,'2021-07-14 00:00:00','Efectivo',450,360,2),(361,'2021-07-14 00:00:00','Efectivo',300,361,2),(362,'2021-07-15 00:00:00','Tarjeta de crédito/débito',450,362,2),(363,'2021-07-16 00:00:00','Efectivo',450,363,2),(364,'2021-07-16 00:00:00','Efectivo',450,364,2),(365,'2021-07-17 00:00:00','Efectivo',250,365,2),(366,'2021-07-20 00:00:00','Transferencia bancaria',1650,366,2),(367,'2021-07-21 00:00:00','Transferencia bancaria',450,367,2),(368,'2021-07-21 00:00:00','Tarjeta de crédito/débito',450,368,2),(369,'2021-07-21 00:00:00','Efectivo',450,369,2),(370,'2021-07-21 00:00:00','Transferencia bancaria',450,370,2),(371,'2021-07-22 00:00:00','Transferencia bancaria',450,371,2),(372,'2021-07-22 00:00:00','Efectivo',450,372,2),(373,'2021-07-26 00:00:00','Transferencia bancaria',450,373,2),(374,'2021-07-26 00:00:00','Tarjeta de crédito/débito',1350,374,2),(375,'2021-07-27 00:00:00','Efectivo',450,375,2),(376,'2021-07-27 00:00:00','Transferencia bancaria',450,376,2),(377,'2021-07-28 00:00:00','Tarjeta de crédito/débito',900,377,2),(378,'2021-07-29 00:00:00','Tarjeta de crédito/débito',450,378,2),(379,'2021-08-02 00:00:00','Transferencia bancaria',450,379,2),(380,'2021-08-04 00:00:00','Tarjeta de crédito/débito',450,380,2),(381,'2021-08-06 00:00:00','Efectivo',625,381,2),(382,'2021-08-08 00:00:00','Efectivo',450,382,2),(383,'2021-08-09 00:00:00','Efectivo',900,383,2),(384,'2021-08-14 00:00:00','Efectivo',450,384,2),(385,'2021-08-18 00:00:00','Transferencia bancaria',450,385,2),(386,'2021-08-25 00:00:00','Efectivo',450,386,2),(387,'2021-08-26 00:00:00','Transferencia bancaria',450,387,2),(388,'2021-09-01 00:00:00','Tarjeta de crédito/débito',450,388,2),(389,'2021-09-03 00:00:00','Transferencia bancaria',450,389,2),(390,'2021-09-03 00:00:00','Transferencia bancaria',1350,390,2),(391,'2021-09-06 00:00:00','Transferencia bancaria',450,391,2),(392,'2021-09-10 00:00:00','Tarjeta de crédito/débito',450,392,2),(393,'2021-09-11 00:00:00','Transferencia bancaria',450,393,2),(394,'2021-09-17 00:00:00','Tarjeta de crédito/débito',450,394,2),(395,'2021-09-21 00:00:00','Transferencia bancaria',450,395,2),(396,'2021-09-22 00:00:00','Transferencia bancaria',450,396,2),(397,'2021-09-23 00:00:00','Tarjeta de crédito/débito',900,397,2),(398,'2021-09-28 00:00:00','Tarjeta de crédito/débito',900,398,2),(399,'2021-09-29 00:00:00','Efectivo',450,399,2),(400,'2021-09-29 00:00:00','Efectivo',450,400,2),(401,'2021-10-09 00:00:00','Tarjeta de crédito/débito',450,401,2),(402,'2021-10-13 00:00:00','Efectivo',450,402,2),(403,'2021-10-13 00:00:00','Tarjeta de crédito/débito',450,403,2),(404,'2021-10-14 00:00:00','Tarjeta de crédito/débito',450,404,2),(405,'2021-10-14 00:00:00','Tarjeta de crédito/débito',450,405,2),(406,'2021-10-14 00:00:00','Tarjeta de crédito/débito',450,406,2),(407,'2021-10-18 00:00:00','Transferencia bancaria',900,407,2),(408,'2021-10-19 00:00:00','Transferencia bancaria',450,408,2),(409,'2021-10-19 00:00:00','Transferencia bancaria',450,409,2),(410,'2021-10-20 00:00:00','Efectivo',450,410,2),(411,'2021-10-21 00:00:00','Tarjeta de crédito/débito',700,411,2),(412,'2021-10-21 00:00:00','Efectivo',450,412,2),(413,'2021-10-21 00:00:00','Efectivo',450,413,2),(414,'2021-10-30 00:00:00','Transferencia bancaria',250,414,2),(415,'2021-10-30 00:00:00','Efectivo',2500,415,2),(416,'2021-11-05 00:00:00','Efectivo',450,416,2),(417,'2021-11-06 00:00:00','Transferencia bancaria',350,417,2),(418,'2021-11-06 00:00:00','Efectivo',450,418,2),(419,'2021-11-06 00:00:00','Efectivo',350,419,2),(420,'2021-11-20 00:00:00','Transferencia bancaria',450,420,2),(421,'2021-11-29 00:00:00','Transferencia bancaria',300,421,2),(422,'2021-11-29 00:00:00','Transferencia bancaria',450,422,2),(423,'2021-12-01 00:00:00','Transferencia bancaria',450,423,2),(424,'2021-12-02 00:00:00','Tarjeta de crédito/débito',450,424,2),(425,'2021-12-22 00:00:00','Transferencia bancaria',900,425,2),(426,'2021-12-22 00:00:00','Tarjeta de crédito/débito',450,426,2),(427,'2021-12-24 00:00:00','Transferencia bancaria',450,427,2),(428,'2021-12-27 00:00:00','Tarjeta de crédito/débito',450,428,2),(429,'2021-12-27 00:00:00','Efectivo',250,429,2),(430,'2021-12-27 00:00:00','Efectivo',450,430,2),(431,'2021-12-27 00:00:00','Tarjeta de crédito/débito',450,431,2),(432,'2021-12-28 00:00:00','Tarjeta de crédito/débito',450,432,2),(433,'2021-12-30 00:00:00','Efectivo',450,433,2),(434,'2022-01-06 00:00:00','Tarjeta de crédito/débito',450,434,2),(435,'2022-01-10 00:00:00','Tarjeta de crédito/débito',450,435,2),(436,'2022-01-10 00:00:00','Efectivo',450,436,2),(437,'2022-01-18 00:00:00','Tarjeta de crédito/débito',450,437,2),(438,'2022-01-10 00:00:00','Efectivo',450,438,2),(439,'2022-01-10 00:00:00','Tarjeta de crédito/débito',450,439,2),(440,'2022-01-10 00:00:00','Transferencia bancaria',450,440,2),(441,'2022-01-10 00:00:00','Transferencia bancaria',450,441,2),(442,'2022-01-19 00:00:00','Tarjeta de crédito/débito',450,442,2),(443,'2022-01-24 00:00:00','Efectivo',450,443,2),(444,'2022-01-25 00:00:00','Efectivo',450,444,2),(445,'2022-01-25 00:00:00','Tarjeta de crédito/débito',450,445,2),(446,'2022-01-25 00:00:00','Transferencia bancaria',450,446,2),(447,'2022-01-26 00:00:00','Tarjeta de crédito/débito',900,447,2),(448,'2022-01-27 00:00:00','Tarjeta de crédito/débito',450,448,2),(449,'2022-01-27 00:00:00','Transferencia bancaria',450,449,2),(450,'2022-01-28 00:00:00','Efectivo',450,450,2),(451,'2022-01-29 00:00:00','Tarjeta de crédito/débito',450,451,2),(452,'2022-01-30 00:00:00','Efectivo',450,452,2),(453,'2022-01-31 00:00:00','Efectivo',350,453,2),(454,'2022-01-31 00:00:00','Transferencia bancaria',450,454,2),(455,'2022-01-31 00:00:00','Tarjeta de crédito/débito',350,455,2),(456,'2022-01-31 00:00:00','Efectivo',450,456,2),(457,'2022-01-31 00:00:00','Tarjeta de crédito/débito',450,457,2),(458,'2022-01-31 00:00:00','Efectivo',450,458,2),(459,'2022-02-01 00:00:00','Efectivo',350,459,2),(460,'2022-02-01 00:00:00','Efectivo',350,460,2),(461,'2022-02-03 00:00:00','Transferencia bancaria',450,461,2),(462,'2022-02-17 00:00:00','Efectivo',450,462,2),(463,'2022-02-21 00:00:00','Efectivo',450,463,2),(464,'2022-02-21 00:00:00','Tarjeta de crédito/débito',450,464,2),(465,'2022-02-21 00:00:00','Efectivo',450,465,2),(466,'2022-03-04 00:00:00','Efectivo',350,466,2),(467,'2022-03-08 00:00:00','Tarjeta de crédito/débito',900,467,2),(468,'2022-03-10 00:00:00','Tarjeta de crédito/débito',350,468,2),(469,'2022-03-08 00:00:00','Tarjeta de crédito/débito',450,469,2),(470,'2022-03-23 00:00:00','Tarjeta de crédito/débito',450,470,2),(471,'2022-03-24 00:00:00','Transferencia bancaria',450,471,2),(472,'2022-03-25 00:00:00','Transferencia bancaria',450,472,2),(473,'2022-05-31 00:00:00','Tarjeta de crédito/débito',400,473,2),(474,'2022-05-31 00:00:00','Tarjeta de crédito/débito',450,474,2),(475,'2022-06-01 00:00:00','Efectivo',450,475,2),(476,'2022-06-18 00:00:00','Efectivo',450,476,2),(477,'2022-06-22 00:00:00','Efectivo',900,477,2),(478,'2022-06-22 00:00:00','Tarjeta de crédito/débito',450,478,2),(479,'2022-06-23 00:00:00','Transferencia bancaria',400,479,2),(480,'2022-06-24 00:00:00','Transferencia bancaria',900,480,2),(481,'2022-06-25 00:00:00','Efectivo',450,481,2),(482,'2022-06-26 00:00:00','Efectivo',350,482,2);
/*Creación de Vistas*/
/*Seleccionamos la base de datos de la panadería*/
USE HOMEBAKERY;
/*Esta vista nos permite obtener todas las recetas disponibles con los correspondientes ingredientes y sus cantidades en cada etapa.*/
/*Creamos la vista Recetas_E_Ingredientes_Disponibles*/
CREATE VIEW Recetas_E_Ingredientes_Disponibles AS
SELECT 
	RECETA.Nombre_Receta AS Nombre, 
	MATERIAL.Nombre_Material AS Material, 
	RECETA_MATERIAL.Categoria_Proceso AS Etapa, 
	RECETA_MATERIAL.Cantidad_Material AS Cantidad, 
	RECETA_MATERIAL.Unidad_Medida AS Unidad
FROM RECETA_MATERIAL 
INNER JOIN RECETA
ON RECETA_MATERIAL.ID_Receta = RECETA.ID_Receta
INNER JOIN MATERIAL
ON RECETA_MATERIAL.ID_Material = MATERIAL.ID_Material;
/*La vista muestra todas las recetas sobre las que se tiene información para su elaboración*/
/*Creamos la vista Recetas_Activas*/
CREATE VIEW Recetas_Activas AS
SELECT DISTINCT
	RECETA.Nombre_Receta AS Nombre,
    RECETA.ID_Receta
FROM RECETA_MATERIAL 
INNER JOIN RECETA
ON RECETA_MATERIAL.ID_Receta = RECETA.ID_Receta
WHERE RECETA_MATERIAL.ID_Receta IS NOT NULL;
/*La vista muestra los ingredientes e insumos para elaborar la receta de "Pan integral con Semillas"*/
/*Creamos la vista Ingredientes_Pan_integral_con_Semillas*/
CREATE VIEW Ingredientes_Pan_integral_con_Semillas AS
SELECT 
	RECETA.Nombre_Receta AS Nombre, 
	MATERIAL.Nombre_Material AS Material, 
	RECETA_MATERIAL.Categoria_Proceso AS Etapa, 
	RECETA_MATERIAL.Cantidad_Material AS Cantidad, 
	RECETA_MATERIAL.Unidad_Medida AS Unidad
FROM RECETA_MATERIAL 
INNER JOIN RECETA
ON RECETA_MATERIAL.ID_Receta = RECETA.ID_Receta
INNER JOIN MATERIAL
ON RECETA_MATERIAL.ID_Material = MATERIAL.ID_Material
WHERE RECETA.Nombre_Receta= "Pan Integral con Semillas";
/*La vista muestra los ingredientes e insumos para elaborar la receta de "Pan Lactal"*/
/*Creamos la vista Ingredientes_Pan_Lactal*/
CREATE VIEW Ingredientes_Pan_Lactal AS
SELECT 
	RECETA.Nombre_Receta AS Nombre, 
	MATERIAL.Nombre_Material AS Material, 
	RECETA_MATERIAL.Categoria_Proceso AS Etapa, 
	RECETA_MATERIAL.Cantidad_Material AS Cantidad, 
	RECETA_MATERIAL.Unidad_Medida AS Unidad
FROM RECETA_MATERIAL 
INNER JOIN RECETA
ON RECETA_MATERIAL.ID_Receta = RECETA.ID_Receta
INNER JOIN MATERIAL
ON RECETA_MATERIAL.ID_Material = MATERIAL.ID_Material
WHERE RECETA.Nombre_Receta= "Pan Lactal";
/*La vista muestra los ingredientes e insumos para elaborar la receta de "Pan de Molde"*/
/*Creamos la vista Ingredientes_Pan_de_Molde*/
CREATE VIEW Ingredientes_Pan_de_Molde AS
SELECT 
	RECETA.Nombre_Receta AS Nombre, 
	MATERIAL.Nombre_Material AS Material, 
	RECETA_MATERIAL.Categoria_Proceso AS Etapa, 
	RECETA_MATERIAL.Cantidad_Material AS Cantidad, 
	RECETA_MATERIAL.Unidad_Medida AS Unidad
FROM RECETA_MATERIAL 
INNER JOIN RECETA
ON RECETA_MATERIAL.ID_Receta = RECETA.ID_Receta
INNER JOIN MATERIAL
ON RECETA_MATERIAL.ID_Material = MATERIAL.ID_Material
WHERE RECETA.Nombre_Receta= "Pan de Molde";
/*La vista muestra los ingredientes e insumos para elaborar la receta de "Pan de Hamburguesa"*/
/*Creamos la vista Ingredientes_Pan_Hamburguesa*/
CREATE VIEW Ingredientes_Pan_Hamburguesa AS
SELECT 
	RECETA.Nombre_Receta AS Nombre, 
	MATERIAL.Nombre_Material AS Material, 
	RECETA_MATERIAL.Categoria_Proceso AS Etapa, 
	RECETA_MATERIAL.Cantidad_Material AS Cantidad, 
	RECETA_MATERIAL.Unidad_Medida AS Unidad
FROM RECETA_MATERIAL 
INNER JOIN RECETA
ON RECETA_MATERIAL.ID_Receta = RECETA.ID_Receta
INNER JOIN MATERIAL
ON RECETA_MATERIAL.ID_Material = MATERIAL.ID_Material
WHERE RECETA.Nombre_Receta= "Pan Hamburguesa";
/*La vista muestra los ingredientes e insumos para elaborar la receta de "Pan Arabe"*/
/*Creamos la vista Ingredientes_Pan_Arabe*/
CREATE VIEW Ingredientes_Pan_Arabe AS
SELECT 
	RECETA.Nombre_Receta AS Nombre, 
	MATERIAL.Nombre_Material AS Material, 
	RECETA_MATERIAL.Categoria_Proceso AS Etapa, 
	RECETA_MATERIAL.Cantidad_Material AS Cantidad, 
	RECETA_MATERIAL.Unidad_Medida AS Unidad
FROM RECETA_MATERIAL 
INNER JOIN RECETA
ON RECETA_MATERIAL.ID_Receta = RECETA.ID_Receta
INNER JOIN MATERIAL
ON RECETA_MATERIAL.ID_Material = MATERIAL.ID_Material
WHERE RECETA.Nombre_Receta= "Pan Arabe";
/*En la panadería se trabaja por tandas de horneado de a 3 panes (para los panes de moldes), creamos vista nos permite obtener
la cantidad de ingredientes para ser horneados en una tanda, para cada receta, es decir para 3 panes. 
Sólo debe afectar a los panes integrales, lactales y de molde.*/
/*Creamos la vista Ingredientes_Por_Tandas_Moldes*/
CREATE VIEW Ingredientes_Por_Tandas_Moldes AS
SELECT 
	RECETA.Nombre_Receta AS Nombre, 
	MATERIAL.Nombre_Material AS Material, 
	RECETA_MATERIAL.Categoria_Proceso AS Etapa, 
	(RECETA_MATERIAL.Cantidad_Material*3) AS Cantidad, 
	RECETA_MATERIAL.Unidad_Medida AS Unidad
FROM RECETA_MATERIAL 
INNER JOIN RECETA
ON RECETA_MATERIAL.ID_Receta = RECETA.ID_Receta
INNER JOIN MATERIAL
ON RECETA_MATERIAL.ID_Material = MATERIAL.ID_Material
WHERE (RECETA.Nombre_Receta) IN ("Pan Integral con Semillas","Pan de Molde","Pan Lactal");
/*Esta vista nos permite obtener la cantidad total de ingredientes agrupados para cada receta, sin importar la etapa del proceso.*/
/*Creamos la vista Total_Ingredientes_Recetas*/
CREATE VIEW Total_Ingredientes_Recetas AS
SELECT
	Nombre, 
	Material, 
	SUM(Cantidad) as Cantidad_Total, 
	Unidad
FROM Recetas_E_Ingredientes_Disponibles
GROUP BY 
	Material, 
    Nombre
ORDER BY 
    Nombre ASC,
	Cantidad_Total DESC;
/*Esta vista nos permite obtener el peso total de cada receta.*/
/*Creamos la vista Total_Peso_Recetas*/
CREATE VIEW Total_Peso_Recetas AS
SELECT 
	Nombre,
	SUM(Cantidad) as Peso_Total, 
    Unidad 
FROM Recetas_E_Ingredientes_Disponibles
WHERE Unidad = 'gramos'
GROUP BY 
    Nombre;
/*Creación de funciones*/
/*Seleccionamos la base de datos creada*/
USE HOMEBAKERY;
/*Necesitamos una función para determinar si el tipo de producto va en formato de paquete o en formato individual segun el peso.*/
/*Creamos la función "Formato_Venta"*/
DELIMITER $$
CREATE FUNCTION Formato_Venta(peso INT)
RETURNS VARCHAR(10) READS SQL DATA
BEGIN
  IF peso >= 500 THEN
    RETURN 'Individual';
  ELSE
    RETURN 'Paquete';
  END IF;
END$$
DELIMITER ;
/*Uso de la funcion "Formato_Venta"*/
SELECT 
	Nombre,
    Peso_Total AS Peso, 
    Formato_Venta(Peso_Total) AS Formato_de_Venta
FROM Total_Peso_Recetas;
/*Necesito una función que ajuste el precio de venta de un producto, según la inflación mensual.*/
/*Creamos la función "Aumentar_Precio_Por_Inflacion"*/
DELIMITER $$
CREATE FUNCTION Aumentar_Precio_Por_Inflacion(precio_original INT, inflacion_mensual FLOAT)
RETURNS FLOAT NO SQL
BEGIN
  DECLARE precio_ajustado FLOAT;
  SET precio_ajustado = precio_original + (precio_original * inflacion_mensual / 100);
  RETURN precio_ajustado;
END$$
DELIMITER ;
/*Uso de la funcion "Aumentar_Precio_Por_Inflacion"*/
SELECT 
	Nombre_Producto, 
	Precio_Producto AS Precio_Original,
    Aumentar_Precio_Por_Inflacion(Precio_Producto,4.9) AS Precio_Ajustado
FROM PRODUCTO;
/*Creación de los Stored Procedures*/
/*Uso de la base de datos de la panadería*/
USE HOMEBAKERY;
/*Segun el apartado "Aspectos a incluir" se requiere de un SP:
1.Debe permitir indicar a través de un parámetro el campo de ordenamiento 
de una tabla y mediante un segundo parámetro, si el orden es descendente o ascendente.
*Adicionalmente se agregó un tercer parámetro para indicar la tabla a la cual queremos aplicar el ordenamiento.*/
DELIMITER $$
CREATE PROCEDURE Ordenar_Tabla (IN tabla VARCHAR(255), IN campo VARCHAR(255), IN orden VARCHAR(4))
BEGIN
  DECLARE consulta VARCHAR(255);
  SET @consulta = CONCAT("SELECT * FROM ", tabla, " ORDER BY ", campo, " ", orden);
  PREPARE ejecutar FROM @consulta;
  EXECUTE ejecutar;
  DEALLOCATE PREPARE ejecutar;
END$$
DELIMITER ;
/*Ejemplo aplicado sobre la tabla "Direccion"*/
CALL Ordenar_Tabla("DIRECCION", "ID_Direccion","DESC");

/*Segun el apartado "Aspectos a incluir" se requiere de un SP que:
1: insertar registros en una tabla de tu proyecto. 
2: eliminar algún registro específico de una tabla de tu proyecto.*/
/*En este caso se creo un SP para insertar datos de nuevas presentaciones de comercializacion de productos o materias primas
(Se puede hacer algo similar par insertar nuevos productos o recetas)*/
DELIMITER $$
CREATE PROCEDURE Ins_Nueva_Presentacion(IN Nombre_Presentacion VARCHAR(50), IN Cantidad_Presentacion FLOAT, IN Unidad_Medida VARCHAR(20))
BEGIN
  INSERT INTO PRESENTACION (Nombre_Presentacion, Cantidad_Presentacion, Unidad_Medida)
  VALUES (Nombre_Presentacion, Cantidad_Presentacion, Unidad_Medida);
END$$
DELIMITER ;
/*Ejemplo insertando una nueva presentacion*/
-- CALL Ins_Nueva_Presentacion(Nombre_Presentacion, Cantidad_Presentacion, Unidad_Medida);
# CALL Ins_Nueva_Presentacion("Fardo de 15 un. x 1 kg", 15, "unidades")

/*Creamos un SP para insertar nuevos proveedores con su respectiva dirección*/
DELIMITER $$
CREATE PROCEDURE Ins_Nuevo_Proveedor
(IN Nombre_Proveedor VARCHAR(50), IN Categoria_Proveedor VARCHAR(50), IN Telefono_Proveedor VARCHAR(20), -- Datos de la tabla "Proveedor"
IN Calle VARCHAR(50), IN Ciudad VARCHAR(50), IN Provincia VARCHAR(50), IN Pais VARCHAR(30)) -- Datos de la tabla "Direccion"
BEGIN
  INSERT INTO DIRECCION (Calle, Ciudad, Provincia, Pais) -- Insertamos primero la direccion en la tabla de "Direccion"
  VALUES (Calle, Ciudad, Provincia, Pais);
  SET @id_direccion = LAST_INSERT_ID(); -- Asignamos a una variable (id_direccion), el valor del id de la ultima inserción
  INSERT INTO PROVEEDOR (Nombre_Proveedor, Categoria_Proveedor, Telefono_Proveedor, ID_Direccion) -- Insertamos luego los datos en la tabla de "Proveedor"
  VALUES (Nombre_Proveedor, Categoria_Proveedor, Telefono_Proveedor, @id_direccion);
END$$
DELIMITER ;
/*Ejemplo insertando un nuevo proveedor*/
-- CALL Ins_Nuevo_Proveedor(Nombre_Proveedor, Categoria_Proveedor, Telefono_Proveedor, Calle, Ciudad, Provincia, Pais)
# CALL Ins_Nuevo_Proveedor("Forrajería Stock", "Semilleria", "03814577895", "Dalmacio Quiles 244", "Lules", "Tucumán", "Argentina");
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

/*Informes*/
/*Todas las vistas que creamos nos sirven para realizar informes útiles para el modelo de negocio, adicionalmente añadimos algunas consultas útiles*/
#Total de Ventas hasta la actualidad
SELECT SUM(Valor_Venta) AS Total_Ventas FROM VENTA;
#Cantidad de Clientes distintos
SELECT DISTINCT COUNT(ID_Cliente) AS Cantidad_Clientes_Distintos FROM CLIENTE;
#Productos mas vendidos
SELECT PRODUCTO.ID_Producto, PRODUCTO.Nombre_Producto, SUM(PEDIDO_PRODUCTO.Cantidad_Producto) AS Cantidad_Vendida
FROM PRODUCTO
INNER JOIN PEDIDO_PRODUCTO ON PRODUCTO.ID_Producto = PEDIDO_PRODUCTO.ID_Producto
INNER JOIN PEDIDO ON PEDIDO_PRODUCTO.ID_Pedido = PEDIDO.ID_Pedido
INNER JOIN VENTA ON PEDIDO.ID_Pedido = VENTA.ID_Pedido
GROUP BY PRODUCTO.ID_Producto
ORDER BY Cantidad_Vendida DESC;
#Total de unidades Vendidas
SELECT SUM(PEDIDO_PRODUCTO.Cantidad_Producto) AS Cantidad_Vendida_Total
FROM PRODUCTO
INNER JOIN PEDIDO_PRODUCTO ON PRODUCTO.ID_Producto = PEDIDO_PRODUCTO.ID_Producto
INNER JOIN PEDIDO ON PEDIDO_PRODUCTO.ID_Pedido = PEDIDO.ID_Pedido
INNER JOIN VENTA ON PEDIDO.ID_Pedido = VENTA.ID_Pedido

