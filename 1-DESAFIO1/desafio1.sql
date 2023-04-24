CREATE DATABASE Posts;
\c Posts;

CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(30),
    fecha_de_creacion VARCHAR(10), 
    contenido VARCHAR(100),
    descripcion VARCHAR(100)    
);

//Agregar 2 post para Pamela
INSERT INTO post(nombre_usuario, fecha_de_creacion, contenido, descripcion) VALUES('Pamela','01/04/2022','Este es el primer post de Pamela','Primer post');
INSERT INTO post(nombre_usuario, fecha_de_creacion, contenido, descripcion) VALUES('Pamela','02/04/2022','Este es el segundo post de Pamela','Segundo post');

//Agregar 1 post para Carlos
INSERT INTO post(nombre_usuario, fecha_de_creacion, contenido, descripcion) VALUES('Carlos','02/04/2022','Este es el primer post de Carlos','Primer post');

//agregar una columna llamada Titulo
ALTER TABLE Post ADD Titulo VARCHAR(30);

//Agregar titulo a las publicaciones ya ingresadas
UPDATE post SET titulo = 'Primer titulo de Pamela' WHERE nombre_usuario= 'Pamela' AND id= 1;
UPDATE post SET titulo = 'Segundo titulo de Pamela' WHERE nombre_usuario= 'Pamela' AND id= 2;
UPDATE post SET titulo = 'Primer titulo de Carlos' WHERE nombre_usuario= 'Carlos';

//Insertar 2 post para el usuario Pedro
INSERT INTO post(nombre_usuario, fecha_de_creacion, contenido, descripcion, titulo) VALUES('Pedro','05/04/2022','Este es el primer post de Pedro','Primer post','Primer titulo Pedro'); 
INSERT INTO post(nombre_usuario, fecha_de_creacion, contenido, descripcion, titulo) VALUES('Pedro','06/04/2022','Este es el segundo post de Pedro','segundo post','Segundo titulo Pedro'); 

//Eliminar el post de Carlos
DELETE FROM post WHERE nombre_usuario= 'Carlos';


//Ingresar un nuevo post para el usuario Carlos
INSERT INTO post(nombre_usuario, fecha_de_creacion, contenido, descripcion, titulo) VALUES('Carlos','10/04/2022','Este es un renovado post de Carlos','nuevo post','Nuevo post de Carlos');

//Parte2
//Crear una nueva tabla llamada 'comentarios' con los atributos id, fecha de creacion y contenido que se relacione con la tabla post
CREATE TABLE comentarios (
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES post (id),
    fecha_de_creacion VARCHAR(10), 
    contenido VARCHAR(255)      
);

//Crear 2 comentarios para el post de Pamela y 4 para Carlos
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es un comentario de Pamela');
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es un segundo comentario de Pamela');
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es un comentario de Carlos');
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es un segundo comentario de Carlos');
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es un tercer comentario de Carlos');
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es un cuarto comentario de Carlos');

//Crear un nuevo post para Margarita
INSERT INTO post(nombre_usuario, fecha_de_creacion, contenido, descripcion, titulo) VALUES('Margarita','25/04/2022','ESte es un post de Margarita','Primer post','Primer post de Margarita'); 


//Ingresar 5 comentarios para el post de Margarita
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es el primer comentario de Margarita');
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es el segundo comentario de Margarita');
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es el tercer comentario de Margarita');
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es el cuarto comentario de Margarita');
INSERT INTO comentarios(fecha_de_creacion,contenido)VALUES('20/10/2022','Este es el quinto comentario de Margarita');

SELECT*FROM Post;
SELECT*FROM Comentarios;




