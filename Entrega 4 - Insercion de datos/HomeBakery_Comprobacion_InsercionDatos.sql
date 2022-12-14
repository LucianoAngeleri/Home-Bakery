SELECT * FROM HOMEBAKERY.RECETA_MATERIAL;
SELECT 
	RECETA.Nombre_Receta AS Nombre,
    MATERIAL.Nombre_Material AS Material,
    RECETA_MATERIAL.Categoria_Proceso AS Etapa,
    RECETA_MATERIAL.Cantidad_Material AS Cantidad,
    RECETA_MATERIAL.Unidad_Medida AS Unidad
FROM RECETA_MATERIAL
LEFT JOIN RECETA
ON RECETA_MATERIAL.ID_Receta = RECETA.ID_Receta
LEFT JOIN MATERIAL
ON RECETA_MATERIAL.ID_Material = MATERIAL.ID_Material
WHERE RECETA.Nombre_Receta = 'Pan Integral con Semillas';