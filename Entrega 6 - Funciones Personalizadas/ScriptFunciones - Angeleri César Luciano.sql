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
FROM Total_Peso_Recetas; -- Debido a un error en la inserción de datos, las recetas de "Pan Hamburguesa" y "Pan arabe", tiene la cantidad por paquete.alter 
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