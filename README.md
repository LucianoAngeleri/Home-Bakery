# Base de datos para Panadería "HomeBakery"
## 1. Descripción de la temática

### Introducción
El desarrollo del presente trabajo nace de la necesidad de organizar la información de un emprendimiento personal, el cual trata de una pequeña panadería que actualmente tiene un bajo nivel de ventas y tecnificación en cuanto a producción.
Para poder escalar el negocio y  mejorar la capacidad de producción y venta actual, es sumamente necesario hacer uso de software que ayude al usuario/empleado de la panadería a realizar un seguimiento e informe de las actividades en todo el proceso de producción y venta de los productos.
Es por ello que planteamos como solución, el uso de una base de datos relacional para poder tener un mejor control de todas las actividades y sectores del emprendimiento, para su posterior uso con un software que permita a un usuario, cargar datos e interactuar con los mismos, para presentarlos de manera eficaz para un mejor entendimiento de la situación del negocio. 
### Objetivos
#### Objetivo General
* Diseñar y crear una base de datos relacional con lenguaje SQL en MySQL Workbench para que una pequeña panadería pueda cargar su información en ella.
#### Objetivos Específicos
* Crear y desarrollar tanto tablas de hechos y de dimensiones como otros objetos sobre el modelo de negocio de la panadería, y que los mismos  permitan el mantenimiento de la base de datos. 
* Debemos poder realizar consultas SQL sobre la base de datos creada para generar informes, a fin de enfocar los esfuerzos de ventas a distintos segmentos de clientes, optimizar los costos de compra de los insumos y de producción y mejorar el servicio de envíos.
### Situación problemática
Actualmente el emprendimiento maneja su información de ventas, compras y clientes mediante hojas de cálculo en Google Spreadsheets, que si bien tiene un modelo relacional desarrollado (aunque a un nivel muy básico), no es apto para trabajar con muchos datos ni está normalizado. El ingreso de datos se hace muy complicado para un usuario sin experiencia en el uso de estas tecnologías, además de que es fácil equivocarse al modificar y eliminar registros, lo que lleva a problemas importantes en cuanto a la seguridad de la información almacenada. Otro punto a tener en cuenta es que para generar informes y visualizaciones, también se hace complicado acceder a la información si el usuario no está familiarizado con Google Spreadsheets.
Buscamos con este trabajo implementar el uso de una base de datos para almacenar y organizar los datos de distintas áreas de una panadería, a fin de poder identificar oportunidades de mejora en todo el proceso de producción y venta con los datos tratados en la misma y facilitar el uso de dicha información por lo usuarios del negocio.
### Modelo de negocio
En líneas generales, la base de datos que realizaremos estará orientada a una pequeña panadería que convierte materias primas en productos finales y luego son vendidos de manera directa al público cliente.
#### Segmentos de clientes
Dado que actualmente la panadería no tiene un lugar físico, principalmente se vende a los siguientes grupos de clientes (público):
* Familiares.
* Compañeros de trabajo.
* Vecinos.
* Amigos.

A futuro, en caso de contar con un lugar físico de venta y producción, los clientes que podemos incluir son:
* Restaurantes y bares.
* Otras panaderías y distribuidoras.
#### Propuesta de valor
La propuesta de valor de la panadería es ofrecer productos de muy buena calidad en cuanto a sus ingredientes y elaboración, poco industrializado y saludable.
#### Canales y Relaciones con clientes
Los canales de venta actuales y de comunicación con los clientes se dan de manera personal, mediante servicios de mensajería telefónica (como Whatsapp y llamadas) y redes sociales.
#### Fuente de ingresos
La fuente de ingresos de la panadería únicamente es mediante la venta directa de sus productos.
#### Actividades clave
Las actividades claves que desarrolla la panadería son:
* La elaboración y producción de sus productos.
* Compra de insumos y materias primas .
* Venta de los productos elaborados.
* Envíos de los productos.
#### Recursos clave
Los recursos físicos que podemos identificar son los equipos de producción (moldes y bandejas, amasadora, horno, utensilios, etc.) y la materia prima e insumos de elaboración. Los recursos humanos son los empleados y el equipo de trabajo de la panadería que realizan las ventas, envíos y elaboran los productos.
#### Asociaciones clave
Si bien actualmente la panadería no tiene ningún socio clave, es importante destacar que existen algunos proveedores de insumos y materias primas importantes para el funcionamiento del negocio.
#### Estructura de costes
Los principales costes que tiene el emprendimiento actualmente son:
* La compra de materia prima e insumos para la elaboración de los productos.
* Uso de energía, gas y máquinas para la producción.
* Uso de vehículos y gastos de combustibles para la entrega de productos.
* Salarios de empleados y equipo de trabajo.
#### asdasdasd

## 2. Diagramas entidad relación
### Diagrama de Entidad - Relación inicial de la base de datos
<image src="PF - Entrega 3 - Proyecto Terminado/Diagramas DER/DER HomeBakery - Inicial.png" alt="Diagrama de Entidad - Relacion inicial">
  
#### Leyenda 
  <image src="PF - Entrega 3 - Proyecto Terminado/Diagramas DER/Leyenda DER HomeBakery - Inicial.png" alt="Leyeda DER Inicial">
    
### Normalización de la base de datos
Debido a que en nuestra base de datos tenemos algunas relaciones “muchos a muchos” (N:M), tendremos que crear una tabla intermedia, o de enlace, entre las tablas que tengan ese tipo de relación, que contendrán los ID’s correspondientes de las dos tablas relacionadas.
    
### Diagrama de Entidad - Relación normalizado de la base de datos
<image src="PF - Entrega 3 - Proyecto Terminado/Diagramas DER/DER HomeBakery - Normalizado.png" alt="Diagrama de Entidad - Relacion Normalizado">
  
#### Leyenda
<image src="PF - Entrega 3 - Proyecto Terminado/Diagramas DER/Leyenda DER HomeBakery - Normalizado.png" alt="Leyenda DER Normalizado">
  
### Diagrama de Entidad - Realcion obtenido en MySQL Workbench
<image src="PF - Entrega 3 - Proyecto Terminado/Diagramas DER/DER HomeBakery - MySQL Workbench.png" alt="Diagrama DER de MySQL Workbench">

## 3. Descripción de Tablas
### Listado de Tablas
* Pedido
* Producto
* Presentacion
* Receta
* Material
* Proveedor
* Direccion
* Empleado
* Venta
* Compra
* Cliente
* Pedido_Producto
* Presentacion_Material
* Compra_Material
* Proveedor_Material
* Receta_Material
  
### Tabla de hecho Pedido

| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Pedido       | INT          | Primary Key   | Código que indica el número de pedido                  |
| Fecha_Pedido    | DATETIME     | -             | Fecha en que se registró el pedido                      |
| ID_Cliente      | INT          | Foreign Key   | Código de cliente que encargó el pedido                 |
| Estado_Pedido   | VARCHAR      | -             | Indica en qué etapa se encuentra el pedido (“Encargado”, “En proceso” o ”Vendido”)|

### Tabla dimensional Producto

| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Producto     | INT          | Primary Key   | Código que indica el producto                          |
| Nombre_Producto | VARCHAR      | -             | Nombre con el que se identifica el producto             |
| ID_Presentacion | INT          | Foreign Key   | Código que corresponde a la presentación en la que está envasado el producto |
| ID_Receta       | INT          | Foreign Key   | Código que corresponde a la receta de la cual proviene el producto |
| Precio_Producto | FLOAT        | -             | Precio de venta del producto                            |

### Tabla dimensional Presentacion

| Nombre de campo    | Tipo de dato | Tipo de Clave | Descripción                                            |
|--------------------|--------------|---------------|--------------------------------------------------------|
| ID_Presentacion    | INT          | Primary Key   | Código de identificación de la presentación o envase    |
| Nombre_Presentacion | VARCHAR      | -             | Nombre descriptivo de la presentación o envase          |
| Cantidad_Presentacion | FLOAT        | -             | Corresponde a la cantidad que contiene o está asociada al envase o presentación |
| Unidad_Medida      | VARCHAR      | -             | Unidad en la que se mide la cantidad del registro       |

### Tabla dimensional Receta

| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Receta       | INT          | Primary Key   | Código que corresponde a la receta para producir un producto terminado |
| Nombre_Receta   | VARCHAR      | -             | Nombre descriptivo de la receta                        |

### Tabla dimensional Material
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
|   ID_Material   | INT          | Primary Key   | código correspondiente al material o materia prima     |
|  Nombre_Material| VARCHAR      | -             | nombre descriptivo del material o materia prima        |
| Categoría_Material | VARCHAR   | -             | indica el tipo o categoría de materia prima o material (“envase”,”utensilios”,”ingrediente”,etc)     |
| Marca_Material   | VARCHAR     | -             | indica el la marca comercial o fabricante de materia prima o material |

### Tabla dimensional Proveedor
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Proveedor    | INT          | Primary Key   | código usado para identificar al proveedor de la materia prima o material |
| Nombre_Proveedor | VARCHAR     | -             | nombre descriptivo del proveedor de materia prima o material |
| Telefono_Proveedor | VARCHAR   | -             | número telefónico correspondiente al proveedor         |
| ID_Direccion    | INT          | Foreign Key   | código asociado a la dirección o “ubicación” del proveedor |
| Categoría_Proveedor | VARCHAR  | -             | indica la categoría de “negocio” del proveedor o si sólo vende determinados productos(“mayorista”,”minorista”,”supermercado”,etc) |

 ### Tabla dimensional Direccion
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Direccion    | INT          | Primary Key   | código asociado a la dirección o “ubicación” del proveedor, cliente, empleado, etc. |
| Calle           | VARCHAR      | -             | nombre de la calle y número de la ubicación asociada   |
| Ciudad          | VARCHAR      | -             | nombre de la ciudad de la ubicación asociada           |
| Provincia       | VARCHAR      | -             | nombre de la provincia de la ubicación asociada        |
| Pais            | VARCHAR      | -             | nombre del país de la ubicación asociada               |

### Tabla dimensional Empleado
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Empleado     | INT          | Primary Key   | código asociado al empleado del establecimiento        |
| Nombre_Empleado | VARCHAR      | -             | nombre completo del empleado                           |
| Telefono_Empleado | VARCHAR    | -             | número telefónico correspondiente al empleado          |
| ID_Direccion    | INT          | Foreign Key   | código asociado a la dirección del empleado del establecimiento |
| Sector_Empleado | VARCHAR      | -             | área o sector en donde trabaja el empleado en cuestión dentro del establecimiento |

### Tabla de hecho Venta
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Venta        | INT          | Primary Key   | código del registro de venta                           |
| Fecha_Venta     | DATETIME     | -             | fecha del registro de la venta                         |
| ID_Pedido       | INT          | Foreign Key   | código que refiere al pedido del cual procede la venta |
| ID_Empleado     | INT          | Foreign Key   | código del empleado que registró la venta              |
| Medio_Pago      | VARCHAR      | -             | medio de pago con el que se registró la venta          |
| Valor_Venta     | FLOAT        | -             | total de la venta realizada                            |
  
### Tabla de hecho Compra
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Compra       | INT          | Primary Key   | código del registro de la compra                       |
| Fecha_Compra    | DATETIME     | -             | fecha del registro de la compra                        |
| ID_Proveedor    | INT          | Foreign Key   | código que refiere al pedido del cual procede la venta |
| Categoria_Compra | VARCHAR     | -             | se refiere al tipo de compra realizado                 |
| ID_Empleado     | INT          | Foreign Key   | código del empleado que registró la compra             |
| Medio_Pago      | VARCHAR      | -             | medio de pago con el que se realizó la compra          |
| Valor_Compra    | FLOAT        | -             | total de la compra realizada                           |

### Tabla dimensional Cliente
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Cliente      | INT          | Primary Key   | código que indica el cliente                           |
| Nombre_Cliente  | VARCHAR      | -             | nombre descriptivo del cliente registrado              |
| Categoria_Cliente | VARCHAR    | -             | indica el tipo o categoría a la que pertenece el cliente (“Restaurante”,”Cliente tienda fisica”,etc.) |
| Edad            | INT          | -             | edad del cliente registrado                            |
| Telefono_Cliente | VARCHAR     | -             | número telefónico correspondiente al cliente           |
| ID_Direccion    | INT          | Foreign Key   | código asociado a la dirección o “ubicación” del cliente |

### Tabla de Enlace Pedido_Producto
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Pedido_Producto | INT       | Primary Key   | código único de la tabla de enlace                     |
| ID_Pedido       | INT          | Foreign Key   | código que indica el número de pedido                  |
| ID_Producto     | INT          | Foreign Key   | código que indica el producto que contiene el pedido   |
| Cantidad_Producto | INT        | -             | cantidad de un producto que registra ese pedido        |

### Tabla de Enlace Presentacion_Material
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Presentacion_Material | INT | Primary Key | código único de la tabla de enlace |
| ID_Presentacion | INT | Foreign Key | código referido al envase o presentación de la materia prima o material |
| ID_Material | INT | Foreign Key | código referido al material o materia prima |

### Tabla de Enlace Compra_Material
| Nombre de campo | Tipo de dato | Tipo de Clave | Descripción                                            |
|-----------------|--------------|---------------|--------------------------------------------------------|
| ID_Compra_Material | INT       | Primary Key   | código único de la tabla de enlace                     |
| ID_Compra       | INT          | Foreign Key   | código del registro de la compra                       |
| ID_Material     | INT          | Foreign Key   | código referido material o materia prima               |
| Cantidad_Material | INT        | -             | se refiere a la cantidad registrada en una determinada compra |

### Tabla de Enlace Proveedor_Material
| Nombre de campo       | Tipo de dato | Tipo de Clave | Descripción                                                     |
|-----------------------|--------------|---------------|-----------------------------------------------------------------|
| ID_Proveedor_Material | INT          | Primary Key   | código único de la tabla de enlace                              |
| ID_Proveedor          | INT          | Foreign Key   | código usado para identificar al proveedor de una materia prima |
| ID_Material           | INT          | Foreign Key   | código referido al material o materia prima                     |
  
### Tabla Enlace Receta_Material
| Nombre de campo     | Tipo de dato | Tipo de Clave | Descripción                                                                              |
|---------------------|--------------|---------------|------------------------------------------------------------------------------------------|
| ID_Receta_Material  | INT          | Primary Key   | código único de la tabla de enlace                                                       |
| ID_Receta           | INT          | Foreign Key   | código que corresponde a la receta                                                       |
| ID_Material         | INT          | Foreign Key   | código correspondiente al material o materia prima                                       |
| ID_Material_Receta  | INT          | Foreign Key   | código identificativo de la materia prima o material usado en la receta                  |
| Cantidad_Material   | FLOAT        | -             | cantidad de materia prima o material usado en la receta                                  |
| Unidad_Medida       | VARCHAR      | -             | unidad de medida de la materia prima o material usado en la receta                       |
| Categroria_Proceso  | VARCHAR      | -             | etapa del proceso de la receta correspondiente al registro (“prefermento”, “laminado”, etc)|
