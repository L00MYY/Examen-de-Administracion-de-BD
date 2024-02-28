CREATE DATABASE if NOT EXISTS db_libro_express;
USE db_libro_express;

-- Tabla de clientes
CREATE TABLE IF NOT EXISTS tb_clientes(
	id_cliente BINARY(36) PRIMARY KEY DEFAULT UUID(),
	nombre_cliente VARCHAR(50) NOT NULL,
	email_cliente VARCHAR(100) NOT NULL,
	telefono VARCHAR(10) NOT NULL
);

-- Tabla de prestamos
CREATE TABLE IF NOT EXISTS tb_prestamos(
	id_prestamo BINARY(36) PRIMARY KEY DEFAULT UUID(),
	id_cliente BINARY(36) NOT NULL,
	fecha_inicio DATE,
	fecha_devolucion DATE,
	estado ENUM('Activo','Inactivo')
);

-- Tabla de generos de libros
CREATE TABLE IF NOT EXISTS tb_generos_libros(
	id_genero_libro BINARY(36) PRIMARY KEY DEFAULT UUID(),
	nombre_genero_libro VARCHAR(50)
);

-- Tabla de libros
CREATE TABLE IF NOT EXISTS tb_libros(
	id_libros BINARY(36) PRIMARY KEY DEFAULT UUID(),
	titulo_libro VARCHAR(50),
	anio_publicacion INT,
	id_genero_libro BINARY(36) NOT NULL,
	estodo ENUM('Disponible','Prestado')
);

-- tabla de detalles del prestamo
CREATE TABLE IF NOT EXISTS tb_detalles_prestamos(
	id_detalle_prestamo BINARY(36) PRIMARY KEY DEFAULT UUID(),
	id_prestamo BINARY(36) NOT NULL,
	id_libros BINARY(36) NOT NULL
);

-- Renstricciones

/*tb_clientes*/
-- Unique de telefono
ALTER TABLE tb_clientes ADD
CONSTRAINT verificar_telefono
UNIQUE (telefono);

-- Unique de telefono
ALTER TABLE tb_clientes ADD
CONSTRAINT verificar_email
UNIQUE (email_cliente);

/*tb_prestamos*/
-- Llave Foranea
ALTER TABLE tb_prestamos ADD
CONSTRAINT fk_tb_clientes_tb_prestamos FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente);

-- Check de fechas
ALTER TABLE tb_prestamos ADD
CONSTRAINT verificar_fecha
CHECK (fecha_inicio>fecha_devolucion);

/*tb_generos_libros*/
-- Unique de telefono
ALTER TABLE tb_generos_libros ADD
CONSTRAINT verificar_nombre_genero_libro
UNIQUE (nombre_genero_libro);

/*tb_libros*/
-- Llave Foranea
ALTER TABLE tb_libros ADD
CONSTRAINT fk_tb_generos_libros_tb_libros FOREIGN KEY (id_genero_libro) REFERENCES tb_generos_libros(id_genero_libro);

-- Check de anio_publicacion
ALTER TABLE tb_libros ADD
CONSTRAINT verificar_anio_publicacion
CHECK (anio_publicacion<1000);

/*tb_libros*/
-- Llave Foranea id_prestamo
ALTER TABLE tb_detalles_prestamos ADD
CONSTRAINT fk_tb_prestamos_tb_detalles_prestamos FOREIGN KEY (id_prestamo) REFERENCES tb_prestamos(id_prestamo);

-- Llave Foranea id_libros
ALTER TABLE tb_detalles_prestamos ADD
CONSTRAINT fk_tb_libros_tb_detalles_prestamos FOREIGN KEY (id_libros) REFERENCES tb_libros(id_libros);
