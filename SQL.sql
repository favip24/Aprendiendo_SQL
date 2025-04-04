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

-- OFFSET: Saltar de Linea
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

-- Operador BETWEEN
-- Permite seleccionar valores dentro de un rango específico, incluyendo los extremos
-- Se utilizan en la cláusula WHERE y puede aplicarse a números, fechas y texto
-- Solo podemos comparar valores/tipos de datos compatibles (NyN, TxtyTxt, etc)

-- Obtenemos los productos con precio entre 50 y 100
-- El 1r valor siempre tiene que ser el menor
SELECT nombre_producto, precio FROM productos
WHERE precio BETWEEN 50 AND 100

-- Obtenemos los pedidos entre el 01/01 y 31/03 del 2025
SELECT id_pedidos, datos_pedidos FROM pedidos
WHERE datos_pedidos BETWEEN '01/01/2025' AND '31/03/2025';

-- Obtenemos los clientes cuyo nombres estén entre 'A' y 'M' por orden alfabético
SELECT id_cliente, datos_clientes FROM cliente
WHERE datos_clientes BETWEEN 'A' AND 'M';

-- NOT BETWEEN: EXCLUIR UN RANGO
-- Devuelve TODOS los productos con precio MENOR a 50 y MAYOR a 100
SELECT nombre_producto, precio FROM productos
WHERE precio NOT BETWEEN 50 AND 100;

-- Operador LIKE
-- Se utiliza con la cláusula WHERE
-- Busca valores que coincidan con un patrón determinado en una columna de tipo TEXT
SELECT id_empleado, cargo FROM empleados 
WHERE cargo LIKE 'QA'; -- Equivalente a '=' pero con búsqueda flexible.

-- La diferencia está en los caracteres comodines
-- '%': Sustituye cero o más caracteres
-- '_': Sustitutye un solo carácter

-- 'A%': Comienza con 'A'
SELECT * FROM clientes
WHERE nombre_clientes LIKE "J%" -- Clientes cuyo nombre comiencen con 'J'

-- '%A': Terminen con 'A'
SELECT * FROM clientes
WHERE nombre_clientes LIKE "%A" -- Clientes cuyo nombre terminen con 'A'

-- '%A%': Contiene 'A' en cualquier posición
SELECT * FROM clientes
WHERE nombre_clientes LIKE "%A%" -- Clientes cuyo nombre TENGAN una 'A'

SELECT * FROM clientes
WHERE nombre_clientes LIKE "%an%" -- Clientes cuyo nombre TENGAN un 'an'

-- 'A_%': Comienza con 'A' y tiene al menos UN carácter
SELECT * FROM clientes
WHERE nombre_clientes LIKE "A_%" 

-- '_%A': 'A' es el segundo carácter
SELECT * FROM clientes
WHERE nombre_clientes LIKE "_%A" -- Clientes cuyo nombre su segundo carácter sea un 'A'

SELECT * FROM clientes
WHERE nombre_clientes LIKE "__V__" -- Clientes cuyo nombres el tercer carácter sea una 'V'

-- NOT LIKE: EXCLUIR patrones
SELECT * FROM clientes
WHERE nombre_clientes NOT LIKE "F%" -- Clientes cuyo nombres no comiencen con 'F'

-- Operador: IS NULL / IS NOT NULL
-- IS NULL: Se usa para ecnotrar registros donde un campo NO TIENE ningún valor asignado
-- IS NOT NULL: Se usa para encontrar registros donde un campo TIENE un valor asignado

-- Traemos TODOS los empleados que NO tengan un mail asignado
SELECT * FROM empleados
WHERE correo_electrónico IS NULL

-- Podemos trar TODOS los empleados que SI tengan un mail definido
SELECT * FROM empleados
WHERE correo_electrónico IS NOT NULL

-- OPERADOR IN y NOT IN
-- Se usa para comparar un valor con una lista de valores específicos
-- Es una alternativa más limpia y eficiente que múltiples consultas 'OR'

-- IN: Devuelve los registros donde el valor de la columna coincide con alguno de los de la lista
-- NOT IN: Deveulve los registros donde el valor NO coincida con alguno de la lista

SELECT nombre_productos FROM productos
WHERE categoria_productos IN ("auriculares", "usb", "cargadores")

SELECT nombre_producto FROM productos
WHERE categoria_productos NOT IN ("celulares", "parlantes")

-- Funciones de Agregación
-- Son funciones que operan sobre un conjunto de filas y devuelven un único resultado

-- COUNT(): Cuenta el número de filas en una consulta
SELECT COUNT(id_productos) FROM productos -- Trae la cantidad total de registros que tiene la columna 'id_productos'

-- Tenemos la cantidad total de productos existentes
SELECT COUNT(*) AS total_productos FROM productos

-- SUM(): Suma los valores de una columna numérica
SELECT SUM(precio) FROM Products -- Calcula el total de la suma de todos los productos

-- Tenemos la suma total del precio del prodcuto con ID 5
SELECT SUM(Price * Unit) FROM productos
WHERE ProductID = 5

-- AVG(): Calcula el promedio de una columna numérica
SELECT AVG(Price) FROM productos

-- ROUND: Redoneamos el promedio de la columna
SELECT ROUND(AVG(Price)) FROM productos

-- MAX(): Devuelve el valor máximo en una columna
-- MIN(): Devuelve el valor mínimo en una columna
SELECT MAX(Price), MIN(Price) FROM productos

SELECT nombre_producto, MIN(Price) FROM productos
WHERE id_productos = 4 -- Devuelve el producto con el precio de menor valor con ID-4

SELECT nombre_producto, MAX(Price) FROM productos
WHERE id_productos = 4 -- Devuelve el producto con el precio de mayor valor con ID-4

-- GROUP BY
-- Se usa para agrupar filas que tienen los mismos valores en una o más columnas
-- Se utiliza junto a las funciones de agregación vistas anteriormente

SELECT id_categoria, AVG(precio_productos) FROM productos -- Devuelve el promedio del precio del campo id_categoria 
GROUP BY id_categoria -- Devuelve el promedio de los precio PERO AGRUPADOS POR ID de CATEGORÍA
ORDER BY precio DESC -- Devuelve los promedios ORDENADOS de forma DESCENDENTE

-- HAVING
-- Se usa para filtrar resultados después de agruparlos 
-- porque WHERE filtra ANTES, y HAVING filtra DESPUÉS

SELECT id_categoria, AVG(precio_productos) FROM producto -- Devuelve el promedio
GROUP BY id_categoria -- Los agrupa por ID
HAVING AVG(precio_productos) < 100 -- FILTRA los productos con ID de promedio MENOR a 100
