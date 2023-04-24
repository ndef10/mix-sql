--1. Crear el modelo en una base de datos llamada biblioteca, considerando las tablas definidas y sus atributos. (2 puntos).

CREATE DATABASE biblioteca;
\c biblioteca;

CREATE TABLE libro(
    isbn VARCHAR(20) PRIMARY KEY NOT NULL,
    titulo VARCHAR(80),
    paginas INT,    
    cod_autor INT,
    cod_coautor INT 
);

CREATE TABLE autor (
    codigo_autor INT PRIMARY KEY UNIQUE,
    nombre_autor VARCHAR(50),
    apellido_autor VARCHAR(50),
    nacimiento_autor INT,
    muerte_autor INT,
    libro_isbn VARCHAR(20) REFERENCES libro(isbn)
);

CREATE TABLE socios (
    rut VARCHAR(10) PRIMARY KEY NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL UNIQUE,
    telefono VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE historial_de_prestamos (
    rut_socio VARCHAR(10) REFERENCES socios (rut),
    isbn_libro VARCHAR(20) REFERENCES libro (isbn),
    fecha_de_prestamo DATE NOT NULL,
    fecha_de_devolucion DATE,
    fecha_de_devolucion_efectiva DATE
);

--2. Se deben insertar los registros en las tablas correspondientes (1 punto).

-- tabla libro
INSERT INTO libro (isbn, titulo, paginas, cod_autor, cod_coautor) VALUES ('1111111111111', 'Cuentos de terror', 334,3,4);
INSERT INTO libro (isbn, titulo, paginas, cod_autor, cod_coautor) VALUES ('2222222222222', 'Poesías contemporaneas', 167, 1, 0);
INSERT INTO libro (isbn, titulo, paginas, cod_autor, cod_coautor) VALUES ('3333333333333', 'Historia de Asia', 511, 2, 0);
INSERT INTO libro (isbn, titulo, paginas, cod_autor, cod_coautor) VALUES ('4444444444444', 'Manual de macánica', 298, 5, 0);

--tabla autor
INSERT INTO autor (codigo_autor, nombre_autor, apellido_autor, nacimiento_autor, muerte_autor, libro_isbn) VALUES (3, 'José', 'Salgado', 1968, 2020, '1111111111111');
INSERT INTO autor (codigo_autor, nombre_autor, apellido_autor, nacimiento_autor, muerte_autor, libro_ISBN) VALUES (1, 'Andrés', 'Ulloa', 1982, 0, '2222222222222');
INSERT INTO autor (codigo_autor, nombre_autor, apellido_autor, nacimiento_autor, muerte_autor, libro_ISBN) VALUES (2, 'Sergio', 'Mardones', 1950, 2012, '3333333333333');
INSERT INTO autor (codigo_autor, nombre_autor, apellido_autor, nacimiento_autor, muerte_autor, libro_ISBN) VALUES (5, 'Martín', 'Porta', 1976, 0, '4444444444444');
INSERT INTO autor (codigo_autor, nombre_autor, apellido_autor, nacimiento_autor, muerte_autor, libro_isbn) VALUES (4, 'Ana', 'Salgado', 1972, 0, '1111111111111');

--tabla socios
INSERT INTO socios (rut, nombre, apellido, direccion, telefono)VALUES ('1111111-1','Juan', 'Soto','Avenida 1, Santiago', '911111111');
INSERT INTO socios (rut, nombre, apellido, direccion, telefono)VALUES ('2222222-2','Ana', 'Pérez','Pasaje 2, Santiago', '922222222');
INSERT INTO socios (rut, nombre, apellido, direccion, telefono)VALUES ('3333333-3','Sandra', 'Aguilar','Avenida 2, Santiago', '933333333');
INSERT INTO socios (rut, nombre, apellido, direccion, telefono)VALUES ('4444444-4','Esteban', 'Jeréz','Avenida 3, Santiago', '944444444');
INSERT INTO socios (rut, nombre, apellido, direccion, telefono)VALUES ('5555555-5','Silvana', 'Muñoz','Pasaje 3, Santiago', '955555555');

--tabla historial de prestamos

INSERT INTO historial_de_prestamos (rut_socio, isbn_libro,fecha_de_prestamo,fecha_de_devolucion, fecha_de_devolucion_efectiva) VALUES ('1111111-1', '1111111111111', '2020-01-20', '2020-01-27', '2020-01-27');
INSERT INTO historial_de_prestamos (rut_socio, isbn_libro,fecha_de_prestamo,fecha_de_devolucion, fecha_de_devolucion_efectiva) VALUES ('5555555-5', '2222222222222', '2020-01-20', '2020-01-27', '2020-01-30');
INSERT INTO historial_de_prestamos (rut_socio, isbn_libro,fecha_de_prestamo,fecha_de_devolucion, fecha_de_devolucion_efectiva) VALUES ('3333333-3', '3333333333333', '2020-01-22', '2020-01-29', '2020-01-30');
INSERT INTO historial_de_prestamos (rut_socio, isbn_libro,fecha_de_prestamo,fecha_de_devolucion, fecha_de_devolucion_efectiva) VALUES ('4444444-4', '4444444444444', '2020-01-23', '2020-01-30', '2020-01-30');
INSERT INTO historial_de_prestamos (rut_socio, isbn_libro,fecha_de_prestamo,fecha_de_devolucion, fecha_de_devolucion_efectiva) VALUES ('2222222-2', '1111111111111', '2020-01-27', '2020-01-03', '2020-02-04');
INSERT INTO historial_de_prestamos (rut_socio, isbn_libro,fecha_de_prestamo,fecha_de_devolucion, fecha_de_devolucion_efectiva) VALUES ('1111111-1', '4444444444444', '2020-01-31', '2020-02-07', '2020-02-12');
INSERT INTO historial_de_prestamos (rut_socio, isbn_libro,fecha_de_prestamo,fecha_de_devolucion, fecha_de_devolucion_efectiva) VALUES ('3333333-3', '2222222222222', '2020-01-31', '2020-02-07', '2020-02-12');

--a. Mostrar todos los libros que posean menos de 300 páginas. (0.5 puntos)
SELECT libro.titulo, libro.paginas FROM libro WHERE paginas < 300;

--b. Mostrar todos los autores que hayan nacido después del 01-01-1970. (0.5 puntos)
SELECT autor.nombre_autor, autor.apellido_autor, autor.nacimiento_autor FROM autor where nacimiento_autor > 1970;

--c. ¿Cuál es el libro más solicitado? (0.5 puntos).
SELECT y.titulo, mas_solicitado
 from (
    SELECT isbn_libro, count(*) from historial_de_prestamos group by isbn_libro LIMIT(1)

)as mas_solicitado
    INNER JOIN libro AS y ON y.isbn = mas_solicitado.isbn_libro;

--d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días. (0.5 puntos)

SELECT y.nombre, y.apellido, multa
 from (
    SELECT (fecha_de_devolucion - fecha_de_devolucion_efectiva)*100 FROM historial_de_prestamos WHERE  rut_socio = '1111111-1'
)as multa
    INNER JOIN socios AS y ON rut = '1111111-1';
 










