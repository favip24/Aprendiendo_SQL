-- SubConsultas
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

-- JOINs
-- Permite combinar registros  de dos o más tablas relacionadas a través de una columna en común
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

-- CROSS JOIN: Devuelve el productocartesiano, es decir, todas las combinaciones posibles entre filas de ambas tablas
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
SELECT ContactName FROM Customers; -- Devuelve una única lista y elimina duplicados

SELECT FirstName AS NOMBRE FROM Employees
UNION ALL
SELECT ContactName FROM Customers; -- Muestra todos los nombres aunque estén repetidos

-- Cardinalidad
-- 
