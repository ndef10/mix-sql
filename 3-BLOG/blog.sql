-- 1. Crear base de datos llamada blog.
CREATE DATABASE B;
\c B;

-- 2. Crear las tablas indicadas de acuerdo al modelo de datos.
CREATE TABLE usuario(
id SERIAL PRIMARY KEY,
email VARCHAR(50)
);

CREATE TABLE posts(
    id SERIAL PRIMARY KEY,
    usuario_id INT,
    FOREIGN KEY(usuario_id) REFERENCES usuario (id),
    titulo VARCHAR(50),
    fecha DATE
);

CREATE TABLE comentario(
    id SERIAL PRIMARY KEY,
    posts_id INT,
    FOREIGN KEY(posts_id) REFERENCES posts(id),
    usuario_id INT,
    FOREIGN KEY(usuario_id) REFERENCES usuario(id),
    texto VARCHAR(100),
    fecha DATE
);

-- 3. Insertar los siguientes registros.

INSERT INTO usuario(email) VALUES
    ('usuario01@gmail.com'),
    ('usuario02@gmail.com'),
    ('usuario03@gmail.com'),
    ('usuario04@hotmail.com'),
    ('usuario05@yahoo.com'),
    ('usuario06@hotmail.com'),
    ('usuario07@yahoo.com'),
    ('usuario08@yahoo.com'),
    ('usuario09@yahoo.com');


INSERT INTO posts (usuario_id, titulo, fecha) VALUES
(1, 'Post 1: Esto es malo', '2020-06-29'),
(5, 'Post 2: Esto es malo', '2020-06-20'),
(1, 'Post 3: Esto es excelente', '2020-05-30'),
(9, 'Post 4: Esto es bueno', '2020-05-09'),
(7, 'Post 5: Esto es bueno', '2020-07-10'),
(5, 'Post 6: Esto es excelente', '2020-07-18'),
(8, 'Post 7: Esto es excelente', '2020-07-07'),
(5, 'Post 8: Esto es excelente', '2020-05-14'),
(2, 'Post 9: Esto es bueno', '2020-05-08'),
(6, 'Post 10: Esto es bueno', '2020-06-02'),
(4, 'Post 11: Esto es bueno', '2020-05-05'),
(9, 'Post 12: Esto es malo', '2020-07-23'),
(5, 'Post 13: Esto es excelente','2020-05-30'),
(8, 'Post 14: Esto es excelente', '2020-05-01');
INSERT INTO posts (usuario_id, titulo, fecha) VALUES(7, 'Post 15: Esto es malo','2020-06-17');

INSERT INTO comentario(id, posts_id, usuario_id, texto, fecha) VALUES
(1, 6, 3, 'Este es el comentario 1', '2020-07-08'),
(2, 2, 4, 'Este es el comentario 2', '2020-06-07'),
(3, 4, 6, 'Este es el comentario 3', '2020-06-16'),
(4, 13, 2, 'Este es el comentario 4', '2020-06-15'),
(5, 6, 6, 'Este es el comentario 5', '2020-05-14'),
(6, 3, 3, 'Este es el comentario 6', '2020-07-08'),
(7, 1, 6, 'Este es el comentario 7', '2020-05-22'),
(8, 7, 6, 'Este es el comentario 8', '2020-07-09'),
(9, 13, 8, 'Este es el comentario 9', '2020-06-30'),
(10, 6, 8, 'Este es el comentario 10', '2020-06-19'),
(11, 1, 5, 'Este es el comentario 11', '2020-05-09'),
(12, 15, 8, 'Este es el comentario 12', '2020-06-17'),
(13, 9, 1, 'Este es el comentario 13', '2020-05-01'),
(14, 5, 2, 'Este es el comentario 14','2020-05-31'),
(15, 3, 4, 'Este es el comentario 15', '2020-06-28');


-- 4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT y.email, y.id, x.titulo
 from (
    SELECT titulo FROM posts WHERE usuario_id =5
)as x
    INNER JOIN usuario AS y ON y.id = 5;


-- 5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados
-- por el usuario con email usuario06@hotmail.com.
SELECT y.email, y.id, x.texto
 FROM (
    SELECT texto FROM comentario WHERE usuario_id !=6
)as x
    INNER JOIN usuario AS y ON y.id != 6;


-- 6. Listar los usuarios que no han publicado ningún post.
SELECT * FROM usuario FULL OUTER JOIN posts ON usuario.id= posts.usuario_id WHERE posts IS NULL;


-- 7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen
-- comentarios).
SELECT * FROM posts FULL OUTER JOIN comentario ON posts.usuario_id= comentario.posts_id;


-- 8. Listar todos los usuarios que hayan publicado un post en Junio.
SELECT* FROM usuario FULL OUTER JOIN posts ON usuario.id = posts.usuario_id WHERE posts.fecha > '2020-06-01' AND posts.fecha < '2020-06-30';

