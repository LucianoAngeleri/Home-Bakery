/*Seleccionamos la base de datos del sistema por defecto de MySQL*/
USE mysql;
/*Crear Usuario de lectura de datos*/
CREATE USER LectorHomeBakery@localhost IDENTIFIED BY "HomeBakery2023_Lector";
/*Crear Usuario de edición de datos*/
CREATE USER EditorHomeBakery@localhost IDENTIFIED BY "HomeBakery2023_Editor";
SHOW GRANTS FOR LectorHomeBakery@localhost;
SHOW GRANTS FOR EditorHomeBakery@localhost;
/*
El usuario LectorHomeBakery deberá tener permisos de sólo lectura sobre todas las tablas.
No debe poder eliminar registros
*/
/*Otorgar permisos de sólo lectura a un usuario*/
GRANT SELECT ON HOMEBAKERY.* TO LectorHomeBakery@localhost;
-- El HOMEBAKERY.* sirve para seleccionar todas las tablas de la base de datos HOMEBAKERY
/*
El usuario EditorHomeBakery deberá tener permisos de Lectura, Inserción y Modificación de datos.
No debe poder eliminar registros
*/
GRANT SELECT, INSERT, UPDATE ON HOMEBAKERY.* TO EditorHomeBakery@localhost;

