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