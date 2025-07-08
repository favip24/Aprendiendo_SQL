-- 1: SELECT Y FILTROS BÁSICOS
-- Mostrar todos los empleados
SELECT * FROM empleados

-- Mostrar todos los empleados mayores de 30 años
SELECT * FROM empleados
WHERE edad > 30

-- Mostrar los empleados con salario mayor a 55000.
SELECT * FROM empleados
WHERE salario > 55000

-- Mostrar solo los nombres distintos de los empleados.
SELECT DISTINCT nombre FROM empleados

-- Mostrar los empleados que no tienen asignado un departamento.
SELECT * FROM empleados
WHERE departamento_id IS NULL


-- 2: FILTROS COMPUESTOS Y OPERADORES
-- Mostrar los empleados que trabajan en el departamento 1 y tienen un salario mayor a 50000.
SELECT * FROM empleados
WHERE departamento_id = 1 AND salario > 50000

-- Mostrar los empleados que no tienen salario cargado.
SELECT * FROM empleados
WHERE salario IS NULL

-- Mostrar los empleados cuya edad esté entre 30 y 40 años.
SELECT * FROM empleados
WHERE edad BETWEEN 30 AND 40

-- Mostrar los empleados cuyo nombre comience con 'A'.
SELECT * FROM empleados
WHERE nombre LIKE'A%'

-- Mostrar los empleados con nombre no igual a 'Martín'.
SELECT * FROM empleados
WHERE nombre != 'Martín'

SELECT * FROM empleados
WHERE nombre NOT IN ('Martín')


-- 3: AGREGACIÓN Y AGRUPAMIENTOS
-- Contar cuántos empleados hay en total.
SELECT COUNT(*) FROM empleados

-- Mostrar el salario promedio de todos los empleados.
SELECT AVG(salario) FROM empleados

-- Mostrar el salario máximo y mínimo.
SELECT MAX(salario), MIN(salario) FROM empleados
WHERE salario IS NOT NULL

-- Mostrar cuántos empleados hay por cada departamento.
SELECT departamento_id, COUNT(*) FROM empleados
GROUP BY departamento_id

-- Mostrar el salario promedio por departamento, solo si es mayor a 55000.
SELECT departamento_id, AVG(salario) AS promedio FROM empleados
GROUP BY departamento_id
HAVING promedio > 55000
ORDER BY promedio DESC

-- 4: JOINS Y COMBINACIONES
-- Mostrar el nombre del empleado y el nombre del departamento al que pertenece.
SELECT empleados.nombre, departamentos.nombre FROM empleados
INNER JOIN departamentos ON empleados.departamento_id = departamentos.id

-- Mostrar los empleados y su departamento, incluyendo los que no tienen uno asignado.
SELECT empleados.nombre, departamentos.nombre AS departamento FROM empleados
LEFT JOIN departamentos ON empleados.departamento_id = departamentos.id

-- Unir todos los nombres de empleados y departamentos en una sola lista (con UNION).
SELECT nombre FROM empleados
UNION ALL
SELECT nombre FROM departamentos

-- Mostrar todos los empleados del departamento "IT"
SELECT empleados.nombre, departamentos.nombre AS departamento FROM empleados
INNER JOIN departamentos ON empleados.departamento_id = departamentos.id
WHERE departamentos.nombre = 'IT'

-- 2d Opción:
SELECT empleados.nombre, departamentos.nombre AS departamento FROM empleados
INNER JOIN departamentos ON empleados.departamento_id = departamentos.id
WHERE departamentos.nombre LIKE 'IT'

-- Mostrar los empleados cuyo departamento NO SEA "Recursos Humanos"
SELECT empleados.nombre, departamentos.nombre AS departamento FROM empleados
INNER JOIN departamentos ON empleados.departamento_id = departamentos.id
WHERE departamentos.nombre != 'Recursos Humanos'

-- 2d Opción:
SELECT empleados.nombre, departamentos.nombre AS departamento FROM empleados
INNER JOIN departamentos ON empleados.departamento_id = departamentos.id
WHERE departamentos.nombre NOT LIKE 'Recursos Humanos'