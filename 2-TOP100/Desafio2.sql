--1. Crear una base de datos llamada películas. (1 Punto)
CREATE DATABASE Peliculas;
CREATE TABLE pelicula(
    id INT PRIMARY KEY,
    pelicula VARCHAR(100),
    ano_estreno INT,
    director VARCHAR(30)
);

CREATE TABLE reparto(
    id_reparto INT,
    FOREIGN KEY (id_reparto) REFERENCES pelicula (id),
    actores VARCHAR(50)
);

--2. Cargar ambos archivos a su tabla correspondiente. (1 Punto)
\copy pelicula FROM 'peliculas.csv' csv header;
\copy reparto FROM 'reparto.csv' csv header;

--3. Obtener el ID de la película “Titanic”. (1 Punto)
SELECT * FROM pelicula WHERE pelicula= 'Titanic';

--4. Listar a todos los actores que aparecen en la película "Titanic". (1 Puntos)
SELECT * FROM reparto WHERE id_reparto= 2;

--5. Consultar en cuántas películas del top 100 participa Harrison Ford. (2 Puntos)
SELECT *FROM reparto WHERE actores= 'Harrison Ford';
SELECT COUNT (reparto) AS total FROM reparto WHERE actores='Harrison Ford';

--6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente. (1 punto)
SELECT * FROM pelicula WHERE ano_estreno > 1990 AND ano_estreno < 1999 ORDER BY pelicula ASC; 

--Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”. (1 punto)
SELECT pelicula, LENGTH (pelicula) AS longitud_titulo FROM pelicula;

--Consultar cual es la longitud más grande entre todos los títulos de las películas.(2 punto)
SELECT pelicula, LENGTH (pelicula) AS longitud_titulo FROM pelicula ORDER BY longitud_titulo DESC LIMIT(1);