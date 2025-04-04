CREATE TABLE "usuarios" (
    "nombre" TEXT,
    "apellido" TEXT,
    "edad" INTEGER,
    "altura" FLOAT,
);

CREATE TABLE "empleados" (
    "id_empleado" INTEGER PRIMARY KEY,
    "name_empleado" TEXT,
    "cargo" TEXT,
    "sueldo" FLOAT,
);

CREATE TABLE "clientes" (
    "id_cliente" INTEGER PRIMARY KEY,
    "nombre_clientes" TEXT,
    "correo_electrónico" TEXT,
    "ciudad" TEXT,
);

CREATE TABLE "pedidos" (
    "id_pedidos" INTEGER PRIMARY KEY,
    "nombre_productos" TEXT,
    "cantidad_productos" INTEGER,
    "id_cliente" INTEGER,
    "datos_pedidos" TEXT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE "productos" (
    "id_productos" TEXT,
    "nombre_productos" TEXT,
    "precio_productos" FLOAT,
    "id_categoria" TEXT,
);

CREATE TABLE "categoria" (
	"id_categoria"	INTEGER,
	"nombre_categoria"	TEXT,
	"descripcion"	TEXT,
	PRIMARY KEY("id_categoria")
);