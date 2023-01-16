/*Uso de la base de datos de la panadería*/
USE HOMEBAKERY;
/*Segun el apartado "Aspectos a incluir" se requiere de:
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

/*Segun el apartado "Aspectos a incluir" se requiere de:
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
CALL Ins_Nueva_Presentacion("Paquete de 200 gr", "200", "gramos")

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
CALL Ins_Nuevo_Proveedor("Comestibles Ahuad Hnos", "Supermercado", "03814237975", "España 1838", "San Miguel de Tucumán", "Tucumán", "Argentina"); 
