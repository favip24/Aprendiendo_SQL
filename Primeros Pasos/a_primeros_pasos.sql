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