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

-- Para facilitar la mirada al código podemos usar  AS
SELECT id_categoria, AVG(precio_productos) AS promedio FROM producto -- Devuelve el promedio
GROUP BY id_categoria -- Los agrupa por ID
HAVING promedio < 100 -- FILTRA los productos con ID de promedio MENOR a 100