-- IDENTIFICADORES: Claves que permiten diferenciar registros dentro de una tabla

-- PRIMARY KEY: Un campo ÚNICO que identifica de manera exclusiva cada fila
-- Evita registros duplicados, facilita la búsqueda de datos

-- FORAIN KEY: Un campo de de REFERENCIA a la PK de otra tabla
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

-- DISTINCT
-- Selecciona los valores únicos, todos los que se repitan o duplicados no los trae
SELECT DISTINCT nombre_productos FROM productos

-- WHERE
-- Filtra y facilita la búsqueda de datos específicos

SELECT nombre_productos FROM productos  -- Pedimos específicamente los datos del campo "nombre_productos" de la tabla 'productos'
WHERE id_productos = 14 -- SOLAMENTE del id: 14

SELECT * FROM productos -- Pedimos todos los datos de la tabla 'productos'
WHERE id_productos = 14 -- PERO solo del id: 14

SELECT * FROM productos
WHERE nombre_productos = 'Tofu' -- Solo los que tengan un nombre específico

SELECT nombre_productos,precio FROM productos -- Pedimos el nombre y el precio
WHERE precio <= 40 -- Solo los productos que tengan un valor menor o igual a 40

-- OPERADORES LÓGICOS: AND, OR, NOT
-- Se usan con la cláusula WHERE para filtrar registros según múltiples condiciones
-- Solo se devuelven los registros que devuelven todas las condiciones

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

-- LIMIT
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

-- != (DISTINTO DE)
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

SELECT * FROM empleados -- Muestra TODOS los campos de la TABLA "empleados"
WHERE cargo != "repositor" -- PERO que NO tengan el cargo de "repositor"
ORDER BY name_empleado; -- Y Mostramelos por ORDEN alfabético

-- Podemos usar NOT IN para excluir valores de forma más limpia
SELECT * FROM empleados
WHERE cargo NOT IN ("repositor", "vendedor");

-- BETWEEN
-- Permite seleccionar valores dentro de un rango específico, incluyendo los extremos
-- Se utilizan en la cláusula WHERE y puede aplicarse a números, fechas y texto
-- Solo podemos seleccionar valores/tipos de datos compatibles (NyN, TxtyTxt, etc)
 
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

-- LIKE
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
WHERE nombre_clientes LIKE "_A%" -- Clientes cuyo nombre su segundo carácter sea un 'A'

SELECT * FROM clientes
WHERE nombre_clientes LIKE "__V__" -- Clientes cuyo nombres el tercer carácter sea una 'V'

-- NOT LIKE: EXCLUIR patrones
SELECT * FROM clientes
WHERE nombre_clientes NOT LIKE "F%" -- Clientes cuyo nombres NO comiencen con 'F'

-- IS NULL/IS NOT NULL
-- IS NULL: Se usa para encotrar registros donde un campo NO TIENE ningún valor asignado
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