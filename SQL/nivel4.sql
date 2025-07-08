-- CARDINALIDAD
-- Relación numérica entre filas de una tabla con respecto a otra
-- Principalmente cuando se diseñan relaciones entre entidades(tablas)
-- Sirve para entender cómo se relacionan las tablas en una base de datos y realizar consultas efectivas

-- UNO A UNO (1:1)
-- Cada fila de la tabla 1 se relaciona con UNA SOLA FILA de la tabla 2, viceversa
-- No es tan común, utilizada para separar información sensible o poco usada
-- Cada persona tiene un DNI y cada DNI pertenece a una persona
persona (id)       <->     documento (persona_id)
1                          1

-- UNO A MUCHOS (1:n / n:1)
-- Una fila de la tabla 1 puede relacionarse con MUCHAS FILAS de la tabla 2
-- PERO una fila de la tabla 2 SOLO puede relacionar con UNA FILA de la tabla 1
-- Un departamento tiene muchos empleados, pero cada empleado solo un departamento
departamento (id)       ->     empleados (departamento_id)
1                              1
1                              2

-- MUCHOS A MUCHOS (n:m)
-- Una fila de la tabla 1 puede relacionarse con MUCHAS filas de la tabla 2 y viceversa
-- Un estudiante puede inscribirse en varios cursos, un curso puede tener varios estudiantes
-- Se necesita de una tabla intermediaria con dos claves foráneas
estudiantes (id)
cursos (id)
inscripciones (estudiante_id, curso_id) --> tabla intermedia

-- NORMALIZACIÓN
-- Es un proceso que organiza los datos para reducir redundancia y evitar anomalías
-- Esto garantiza una base de datos escalable y sostenible a lo largo del tiempo
-- A través de "Normal Form", cada una con reglas más estrictas

-- Nivel 1: First Normal Form (1NF)
-- Todos los campos deben contener valores únicos atómicos (conjuntos, listas, etc)
-- Forma Correcta:
ID | Nombre | Teléfono
1  | Ana    | 11-1111

-- Forma Incorrecta:
ID | Info de Empleados
1  | Ana - 11-1111

-- Nivel 2: 2NF
-- Estar en 1NF y que cada atributo (que no sea un key) dependa completamente de la clave primaria
-- Se resuelve separando en tablas más pequeñas

-- Nivel 3: 3NF
-- Estar en 2NF y que ningún campo no key dependa de otro campo no key
-- Evitar dependencias transitivas
-- Forma Incorrecta:
ID | Nombre | CódigoPostal | Ciudad
-- La ciudad depende del código postal, no directamente del ID.

-- Forma Correcta:
ID | Nombre | CodigoPostal
CP | Ciudad

-- Nivel 4: 4NF
-- Cada tabla debe tener una clave primaria compuesta, consta de múltiples columnas y no una sola
-- Evita independiencias multivaluadas y la redundancia de datos

-- Nivel 5: 5NF
-- Se asegura de que no haya dependencia de unión entre los atributos
-- Es decir, si un atributo depende de que se unan atributos de varias tabls entonces tiene que ser movido a otra tabla.

-- ÍNDICES
-- Es una estructura de datos que mejora la velocidad de búsqueda y filtrado en una tabla
-- Similar a un libro: en lugar de escanear(leer) toda la tabla(libro) se dirige directo a la sección de interés
-- ¿Cúando usarlos? En columnas que filtran y agrupan o PK/FK

CREATE INDEX idx_nombre ON empleados(nombre);

CREATE UNIQUE INDEX fullname ON empleados(nombre, apellido) 
-- Se crea un index único, logrando que cada campo tenga valores únicos

DROP INDEX idx_nombre;
-- Para eliminarlo

-- VISTAS
-- Es una tabla virtual , basada en una consulta. No almacena datos, solo definiciones
-- Reutilizar consultas complejas, simplifica el trabajo para otros usuarios
-- Restringe columnas sensibles (ej: ocultar sueldos)

CREATE VIEW empleados_activos AS

SELECT id, nombre, salario FROM empleados
WHERE salario IS NOT NULL;

-- Para ocultar
SELECT * FROM empleados_activos

-- Para eliminarla
DROP VIEW IF EXISTS empleados_activos
-- (if exists (opcional) para verificar que exista)

-- BLOQUEO Y TRANSACCIONES
-- Cuando dos usuarios acceden o modifican los mismos datos al mismo tiempo, los bloqueos evitan inconsistencias

-- BLOQUEO LECTURA(compartido): Varios pueden leer
-- BLOQUEO ESCRITURA(exclusivo): Uno escribe, los demás esperan
