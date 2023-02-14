/*Seleccionamos la base de datos de la panadería*/
USE HOMEBAKERY;
SELECT @@AUTOCOMMIT;
SET AUTOCOMMIT = 0;
/*
En la tabla DIRECCION eliminaremos algunos registros iniciando una transacción.
Al final se encuentran los comandos para aceptar(COMMIT) o revertir(ROLLBACK) los cambios.
*/
/*Tabla DIRECCION*/
START TRANSACTION;
SET SQL_SAFE_UPDATES = 0; -- Desactivamos el Safe Updates para que nos deje eliminar los registros.
SET FOREIGN_KEY_CHECKS = 0;-- Desactivamos momentaneamente el chequeo de las FK para poder eliminar los registros.
DELETE FROM DIRECCION
WHERE Provincia = "Córdoba";
SET SQL_SAFE_UPDATES = 1;  -- Activamos el Safe Updates nuevamente.
SET FOREIGN_KEY_CHECKS = 1; -- Activamos nuevamente el chequeo de las FK.

SELECT * FROM DIRECCION
WHERE Provincia = "Córdoba";
#ROLLBACK; -- Revertimos la transaccion, descomentar para revertir la eliminacion de registros.
#COMMIT; -- Aceptamos la transaccion, descomentar para que aceptar la eliminacion de registros.

/*
En la tabla COMPRA, insertaremos ocho nuevos registros iniciando una transacción. 
Agregamos un SAVEPOINT luego de la inserción del registro número 4.
Agregamos otro SAVEPOINT luego del registro número 8.
Agregamos la sentencia de eliminación del savepoint de los primeros 4 registros insertados.
*/
/*Tabla COMPRA*/
START TRANSACTION;
INSERT INTO COMPRA (Fecha_Compra,Medio_Pago,Valor_Compra,Categoria_Compra,ID_Proveedor,ID_Material,ID_Empleado)
VALUES("2023-01-25", "Efectivo", 177.61,"Ingrediente",2,3,1);
INSERT INTO COMPRA (Fecha_Compra,Medio_Pago,Valor_Compra,Categoria_Compra,ID_Proveedor,ID_Material,ID_Empleado)
VALUES("2023-01-25", "Efectivo", 63.10, "Ingrediente",2,6,1);
INSERT INTO COMPRA (Fecha_Compra,Medio_Pago,Valor_Compra,Categoria_Compra,ID_Proveedor,ID_Material,ID_Empleado)
VALUES("2023-01-25", "Efectivo", 2835, "Ingrediente",2,7,1);
INSERT INTO COMPRA (Fecha_Compra,Medio_Pago,Valor_Compra,Categoria_Compra,ID_Proveedor,ID_Material,ID_Empleado)
VALUES("2023-01-25", "Efectivo", 2650, "Ingrediente",6,1,1);
SAVEPOINT Ins_Lote_Compra_1;

INSERT INTO COMPRA (Fecha_Compra,Medio_Pago,Valor_Compra,Categoria_Compra,ID_Proveedor,ID_Material,ID_Empleado)
VALUES("2023-01-25", "Efectivo", 860, "Insumo",12,19,1);
INSERT INTO COMPRA (Fecha_Compra,Medio_Pago,Valor_Compra,Categoria_Compra,ID_Proveedor,ID_Material,ID_Empleado)
VALUES("2023-01-25", "Efectivo", 434.30, "Insumo",12,20,1);
INSERT INTO COMPRA (Fecha_Compra,Medio_Pago,Valor_Compra,Categoria_Compra,ID_Proveedor,ID_Material,ID_Empleado)
VALUES("2023-01-25", "Efectivo", 800, "Ingrediente",2,11,1);
INSERT INTO COMPRA (Fecha_Compra,Medio_Pago,Valor_Compra,Categoria_Compra,ID_Proveedor,ID_Material,ID_Empleado)
VALUES("2023-01-25", "Efectivo", 743, "Ingrediente",2,11,1);
SAVEPOINT Ins_Lote_Compra_2;

SELECT * FROM COMPRA;

#ROLLBACK TO Ins_Lote_Compra_1; -- Vuelve al SAVEPOINT Ins_Lote_Compra_1
#RELEASE SAVEPOINT Ins_Lote_Compra_1; -- Elimina SAVEPOINT Ins_Lote_Compra_1
