-- FUNCIONES DE AGREGACIÓN
-- Son funciones que operan sobre un conjunto de filas y devuelven un único resultado

-- COUNT(): Cuenta la cantidad de registros en un campo
SELECT COUNT(id_productos) FROM productos

-- Tenemos la cantidad total de productos existentes
SELECT COUNT(*) AS total_productos FROM productos

-- SUM(): Suma los valores de una columna
SELECT SUM(precio) FROM Products

-- Tenemos la suma total del precio del prodcuto con ID 5
SELECT SUM(Price * Unit) FROM productos
WHERE ProductID = 5

-- AVG(): Calcula el promedio de una columna numérica
SELECT AVG(Price) FROM productos

-- ROUND: Redoneamos el promedio de la columna
SELECT ROUND(AVG(Price)) FROM productos

-- Agregamos por ejemplo, 2 decimales
SELECT ROUND(AVG(Price),2) FROM productos

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

-- WHERE filtra ANTES del AGRUPAMIENTO
-- HAVING filtra DESPUÉS, sobre RESULTADOS de funciones de agregación.

-- No se puede usar una función de agregación con un valor de otra función de agregación
-- No se puede mezclar, salvo en subconsultas

-- El orden sería el siguiente:
SELECT ... FROM ...
WHERE ...
GROUP BY ...
HAVING ...
ORDER BY ...
LIMIT ...

SELECT id_categoria, AVG(precio_productos) FROM producto -- Devuelve el promedio
GROUP BY id_categoria -- Los agrupa por ID
HAVING AVG(precio_productos) < 100 -- FILTRA los productos con ID de promedio MENOR a 100

-- Para facilitar la mirada al código podemos usar  AS
SELECT id_categoria, AVG(precio_productos) AS promedio FROM producto -- Devuelve el promedio
GROUP BY id_categoria -- Los agrupa por ID
HAVING promedio < 100 -- FILTRA los productos con ID de promedio MENOR a 100

-- SUBCONSULTAS
-- Es una consulta interna que se utiliza dentro de otra consulta principal
-- Filtra Resultado, Calcular Valores, Comprar Resultados entre Tablas o Datos
-- Se coloca entre paréntesis y puede ir en: SELECT, FROM, WHERE, HAVING

-- Extraemos las columnas 'ProductID' y 'Quantity'
SELECT ProductID, Quantity,
-- Traemos el nombre del producto usando la tabla Products, donde el ProductID coincida con el ProductID que está en la fila actual de OrderDetails” 
	(SELECT ProductName FROM Products WHERE OrderDetails.ProductID = ProductID) AS Subconsulta
	FROM OrderDetails

SELECT ProductName, Price FROM Products -- Traemos las columnas específicas de la tabla 'Products'
WHERE Price > (SELECT AVG(Price) FROM Products) -- Se seleccionan aquellos cuyo precio sea mayor a ese promedio

-- JOINS
-- Son una operación que nos permite combinar la información de dos o más tablas en una base de datos
-- Esa información se devuelve en una sola tabla, se toman dos tablas y se devuelve una nuevab
-- ON: Indica la condición de unión entre dos tablas, es decir, cómo están relacionadas dos tablas

-- INNER JOIN: Trae SOLO los registros que tienen coincidencia en ambas tablas
SELECT Orders.OrderID, Customers.CompanyName FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID; -- Devuelve solo las órdenes que están asociadas a un cliente

-- LEFT JOIN: Trae TODOS los registros de la tabla izquierda, y los que coincidan con los de la derecha
SELECT Customers.CompanyName, Orders.OrderID FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID; -- Devuelve todos los clientes, aunque no hayan realizado pedidos

-- RIGHT JOIN: Trae TODOS los registros de la tabla derecha, y los que coincidan con los de la izquierda

-- FULL JOIN: Deuvelve todas las filas de ambas tablas y coloca NULL donde no hay coincidencia
SELECT Customers.CustomerID, Orders.OrderID FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID

UNION

SELECT Customers.CustomerID, Orders.OrderID FROM Orders
LEFT JOIN Customers ON Customers.CustomerID = Orders.CustomerID;

-- CROSS JOIN: Devuelve el producto cartesiano, es decir, todas las combinaciones posibles entre filas de ambas tablas
SELECT Customers.CompanyName, Products.ProductName FROM Customers
CROSS JOIN Products; -- Si hay 5 clientes y 10 productos, devuelve 50 filas (5x10)

-- UNION y UNION ALL
-- Ambos sirven para combinar los restuldos de dos o más consultas de SELECT
-- PERO: UNION elimina duplicados, UNION ALL no y muestra todos.

-- REQUISITOS:
-- Ambas consultas deben tener el mismo número de columnas
-- Deben ser de tipos compatibles
-- El orden de las columnas deben coincidir

-- Supongamos que queremos ver nombres de empleados y nombres de clientes juntos
SELECT FirstName AS NOMBRE FROM Employees
UNION
SELECT ContactName FROM Customers -- Devuelve una única lista y elimina duplicados

SELECT FirstName AS NOMBRE FROM Employees
UNION ALL
SELECT ContactName FROM Customers -- Muestra todos los nombres aunque estén repetidos