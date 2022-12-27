SELECT * FROM homebakery.presentacion_material;
SELECT 
	PRESENTACION.Nombre_Presentacion AS Nombre,
    MATERIAL.Nombre_Material AS Material
FROM PRESENTACION_MATERIAL
LEFT JOIN PRESENTACION
ON PRESENTACION_MATERIAL.ID_Presentacion = Presentacion.ID_Presentacion
LEFT JOIN MATERIAL
ON PRESENTACION_MATERIAL.ID_Material = MATERIAL.ID_Material;