-- Crear Base de Datos
CREATE DATABASE "PRÁCTICAS"

 -- Creamos una tabla
CREATE TABLE "usuarios" (
    "nombre" TEXT, -- Añadimos la columnas "nombre" de tipo "texto"
    "apellido" TEXT, -- Añadimos la columnas "apellido" de tipo "texto"
    "edad" INTEGER, -- Añadimos la columnas "edad" de tipo "int"
    "altura" FLOAT, -- Añadimos la columna "altura" de tipo "float"
);

-- Consultas básicas/Queries

-- Seleccionar/Pedir datos
SELECT * FROM usuarios -- Petición de toda la información de la tabla 'usuarios'
SELECT apellido FROM usuarios -- Petición de una columna específica de una tabla
SELECT nombre,apellido FROM usuarios -- Petición de columnas específicas

-- Insertar/Agregar datos
INSERT INTO usuarios (nombre, apellido, edad, altura) -- Insertar en la tabla 'usuarios' los datos en la siguiente columnas '()'
    VALUES ('Favio','Palermo',25,1.81) -- Los valores en el orden en que colocamos las columnas

INSERT INTO usuarios (nombre, apellido, edad, altura)
    VALUES ('Favio','Palermo',25,1.81),
           ('Ismael','Palacio',22,1.71),
           ('Joaquín','Perez',28,1.90) -- Insertar varios datos en una consulta

-- Modificar/Actualizar datos
UPDATE usuarios SET edad = 24 -- Modificamos todos los campos "edad" de la tabla 'usuarios'

UPDATE usuarios SET nombre  = "Mateo"
WHERE id_usuario = 3 -- Modificamos el valor de un campo específico

UPDATE usuarios SET nombre  = "Mateo", apellido = "Perrone"
WHERE id_usuario = 3 -- Modificamos el valor de dos o más campo específico

-- Eliminar datos
TRUNCATE TABLE usuarios -- Elimina todos los registros de la tabla
DELETE FROM usuarios WHERE id_usuarios = 5 -- Eliminar los registros que cumplan la condición (el cliente con id: 5)
DELETE FROM usuarios -- Eliminar todos los datos de la tabla 'usuarios'
ALTER TABLE usuarios DROP COLUMN altura -- Elimnar una columna específica

-- Identificadores: Claves que permiten diferenciar registros dentro de una tabla

-- Primary Key: Un campo ÚNICO que identifica de manera exclusiva cada fila
-- Evita registros duplicados, facilita la búsqueda de datos

-- Forain Key: Un campo de de REFERENCIA a la PK de otra tabla
-- Relaciona Tablas

CREATE TABLE "clientes" (
    "id_cliente" INTEGER PRIMARY KEY, -- Primary Key -> Identificador Único
    "nombre_clientes" TEXT,
    "correo_electrónico" TEXT,
);

-- En esta tabla el "id_cliente" es la FK que hace referencia a "id_cliente" en la tabla 'clientes'
CREATE TABLE "pedidos" (
    "id_pedidos" INTEGER PRIMARY KEY,
    "nombre_productos" TEXT,
    "id_cliente" INTEGER,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Ordenamiento con ORDER BY
CREATE TABLE "productos" (
    "id_productos" TEXT,
    "nombre_productos" TEXT,
    "precio" FLOAT,
);

SELECT nombre_productos FROM pedidos
ORDER BY precio ASC -- ASCENDENTE, Desde el producto de menos valor hasta el de máximo valor

SELECT edad FROM usuarios
ORDER BY precio DESC -- DESCENDENTE, Desde el producto de mayor valor hasta el de menor

-- Podemos agregar la cláusula 'NULLS LAST/FIRST' para mostrar los valores nulos al último o principio de la tabla
-- ORDER BY precio DESC NULL LAST

SELECT nombre_productos FROM pedidos
ORDER BY nombre_producto ASC -- Ordenados de la A-Z

SELECT nombre_productos FROM pedidos
ORDER BY RANDOM() -- Ordena las consultas de forma al azar

-- Cláusula DISTINCT
-- Selecciona los valores únicos, todos los que se repitan o duplicados no los trae
SELECT DISTINCT nombre_productos FROM productos

-- Cláusula WHERE
-- Filtra y facilita la búsqueda de datos específicos

SELECT nombre_productos FROM productos  -- Pedimos específicamente los datos del campo "nombre_productos" de la tabla 'productos'
WHERE id_productos = 14 -- SOLAMENTE del id: 14

SELECT * FROM productos -- Pedimos todos los datos de la tabla 'productos'
WHERE id_productos = 14 -- PERO solo del id: 14

SELECT * FROM productos
WHERE nombre_productos = 'Tofu' -- Solo los que tengan un nombre específico

SELECT nombre_productos,precio FROM productos -- Pedimos el nombre y el precio
WHERE precio <= 40 -- Solo los productos que tengan un valor menor o igual a 40

-- Operadores Lógicos: AND, OR, NOT
-- Se usan con la cláusula WHERE para filtrar registros según múltiples condiciones
-- Solo se devuelven los registros que devuelven todas las condiciones

CREATE TABLE "clientes" (
    "id_cliente" INTEGER PRIMARY KEY, -- Primary Key -> Identificador Único
    "nombre_clientes" TEXT,
    "edad" INTEGER,
    "ciudad" TEXT,
);
-- AND: Devuelve registros si TODAS las condiciones se cumplen
SELECT * FROM clientes
WHERE ciudad = 'Buenos Aires' AND edad > 25; -- Obtiene los clientes que viven en Buenos Aires Y MAYOR de 30 años

-- OR: Devuelve registros si al menos UNA de las condiciones se cumple
SELECT * FROM clientes
WHERE ciudad = "Buenos Aires" OR ciudad = "Córdoba" -- Muestra clientes que vivan en Buenos Aires O Córdoba

-- NOT: Devuelve registros si la condición NO se cumple, se niega una condición
SELECT * FROM clientes
WHERE NOT ciudad = "Buenos Aires" -- Devuelve todos los clientes que NO VIVEN en Buenos Aires

-- Combinación de Operadores Lógicos
-- Para combinar se usan "()" para controlar el orden de la evaluación
-- Ejercicio:
SELECT * FROM clientes -- Devuelve TODOS los datos de la tabla 'clientes'
WHERE (ciudad = "Buenos Aires" OR ciudad = "Córdoba") -- PERO SOLO los que vivan en BSAS O CBA
AND NOT edad < 25; -- Y TAMBIÉN los que NO TENGAN una edad MENOR a 25 años

-- Entonces: Devuelve TODOS los clientes QUE VIVAN en BSAS O CBA, que NO TENGAN menos de 25 años (Es decir, mayores de 25)

-- Cláusula LIMIT
-- Limita la cantidad de respuestas de una consulta filtrando por cantidad o rango
SELECT * FROM clientes
WHERE Country = "Córdoba"
LIMIT 5
-- Devuelve solo los primeros 5 clientes que vivan en Córdoba

-- Supongamos que queremos saltar un número específico de registros antes de empezar a mostrar los resultados
SELECT * FROM clientes
LIMIT 5 OFFSET 10 -- Devuelve 5 clientes, PERO apartir del 11avo (se saltea los primeros 10)

-- Si no especificamos un orden se seleccionan las filas de manera aleatoria
-- Para asegurar un orden usamos la cláusula ORDER BY
SELECT * FROM clientes
ORDER BY pedidos DESC
LIMIT 3 -- Devuelve los pedidos más recientes ordenados por fecha en orden DESCENDENTE

-- Supongamos que queremos mostrar solamente 5 resultados por consulta
SELECT id_productos FROM productos
LIMIT 5 OFFSET 0 -- Mostramos solamente los primeros 5 productos
-- OFFSET 5 -> Mostraría los siguientes 5 productos (del 5 al 10)

-- Cláusula != (DISTINTO DE)
-- Filtra registros que no sean iguales a un VALOR ESPECÍFICO
SELECT * FROM clientes
WHERE ciudad != "Buenos Aires" -- Muestra todos los clientes que NO SON de BsAs

-- Combinando != y AND/OR
SELECT * FROM pedidos
WHERE clientes != "Buenos Aires" AND clientes != "Mendoza"
-- Entonces, me devolverá los clientes que no son NI DE BsAs NI de Mendoza

-- Valores numéricos
SELECT * FROM productos
WHERE precio != 20 -- Me devuelve todos los productos que NO tengan precio de 20

-- Podemos excluir valores y ordernar el resto de los resultados
CREATE TABLE "empleados" (
    "id_empleado" INTEGER PRIMARY KEY,
    "name_empleado" TEXT,
    "cargo" TEXT,
    "sueldo" FLOAT,
);

SELECT * FROM empleados -- Muestra TODOS los campos de la TABLA "empleados"
WHERE cargo != "repositor" -- PERO que NO tengan el cargo de "repositor"
ORDER BY name_empleado; -- Y Mostramelos por ORDEN alfabético

-- Podemos usar NOT IN para excluir valores de forma más limpia
SELECT * FROM empleados
WHERE cargo NOT IN ("repositor", "vendedor");