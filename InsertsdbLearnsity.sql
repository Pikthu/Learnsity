USE dbLearnsityMultidimensional;
GO

-- Deshabilitar temporalmente las restricciones de clave externa para facilitar la carga masiva en el orden deseado
-- (Opcional, pero puede ser útil si se ejecuta el script en partes o si hay dependencias complejas)
-- EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
-- GO

-- =======================================================================================================
-- INSERTS PARA DIMENSIONES
-- =======================================================================================================

-- -------------------------------------------------------------------------------------------------------
-- Dim_Fecha
-- (7 fechas específicas por mes para Enero - Mayo 2024)
-- -------------------------------------------------------------------------------------------------------
INSERT INTO Dim_Fecha (ID_Fecha_CS, Fecha_Completa, Anio, Mes, Trimestre, Nombre_Mes, Semana_Anio, Dia_Anio, Dia_Semana_Numero, Nombre_Dia_Semana, Es_Fin_De_Semana) VALUES
-- Enero 2024
(20240101, '2024-01-01', 2024, 1, 1, 'Enero', 1, 1, 1, 'Lunes', 0),
(20240105, '2024-01-05', 2024, 1, 1, 'Enero', 1, 5, 5, 'Viernes', 0),
(20240110, '2024-01-10', 2024, 1, 1, 'Enero', 2, 10, 3, 'Miércoles', 0),
(20240115, '2024-01-15', 2024, 1, 1, 'Enero', 3, 15, 1, 'Lunes', 0),
(20240120, '2024-01-20', 2024, 1, 1, 'Enero', 3, 20, 6, 'Sábado', 1),
(20240125, '2024-01-25', 2024, 1, 1, 'Enero', 4, 25, 4, 'Jueves', 0),
(20240130, '2024-01-30', 2024, 1, 1, 'Enero', 5, 30, 2, 'Martes', 0),
-- Febrero 2024
(20240201, '2024-02-01', 2024, 2, 1, 'Febrero', 5, 32, 4, 'Jueves', 0),
(20240205, '2024-02-05', 2024, 2, 1, 'Febrero', 6, 36, 1, 'Lunes', 0),
(20240210, '2024-02-10', 2024, 2, 1, 'Febrero', 6, 41, 6, 'Sábado', 1),
(20240215, '2024-02-15', 2024, 2, 1, 'Febrero', 7, 46, 4, 'Jueves', 0),
(20240220, '2024-02-20', 2024, 2, 1, 'Febrero', 8, 51, 2, 'Martes', 0),
(20240225, '2024-02-25', 2024, 2, 1, 'Febrero', 8, 56, 7, 'Domingo', 1),
(20240228, '2024-02-28', 2024, 2, 1, 'Febrero', 9, 59, 3, 'Miércoles', 0),
-- Marzo 2024
(20240301, '2024-03-01', 2024, 3, 1, 'Marzo', 9, 61, 5, 'Viernes', 0),
(20240305, '2024-03-05', 2024, 3, 1, 'Marzo', 10, 65, 2, 'Martes', 0),
(20240310, '2024-03-10', 2024, 3, 1, 'Marzo', 10, 70, 7, 'Domingo', 1),
(20240315, '2024-03-15', 2024, 3, 1, 'Marzo', 11, 75, 5, 'Viernes', 0),
(20240320, '2024-03-20', 2024, 3, 1, 'Marzo', 12, 80, 3, 'Miércoles', 0),
(20240325, '2024-03-25', 2024, 3, 1, 'Marzo', 13, 85, 1, 'Lunes', 0),
(20240330, '2024-03-30', 2024, 3, 1, 'Marzo', 13, 90, 6, 'Sábado', 1),
-- Abril 2024
(20240401, '2024-04-01', 2024, 4, 2, 'Abril', 14, 92, 1, 'Lunes', 0),
(20240405, '2024-04-05', 2024, 4, 2, 'Abril', 14, 96, 5, 'Viernes', 0),
(20240410, '2024-04-10', 2024, 4, 2, 'Abril', 15, 101, 3, 'Miércoles', 0),
(20240415, '2024-04-15', 2024, 4, 2, 'Abril', 16, 106, 1, 'Lunes', 0),
(20240420, '2024-04-20', 2024, 4, 2, 'Abril', 16, 111, 6, 'Sábado', 1),
(20240425, '2024-04-25', 2024, 4, 2, 'Abril', 17, 116, 4, 'Jueves', 0),
(20240430, '2024-04-30', 2024, 4, 2, 'Abril', 18, 121, 2, 'Martes', 0),
-- Mayo 2024
(20240501, '2024-05-01', 2024, 5, 2, 'Mayo', 18, 122, 3, 'Miércoles', 0),
(20240505, '2024-05-05', 2024, 5, 2, 'Mayo', 18, 126, 7, 'Domingo', 1),
(20240510, '2024-05-10', 2024, 5, 2, 'Mayo', 19, 131, 5, 'Viernes', 0),
(20240515, '2024-05-15', 2024, 5, 2, 'Mayo', 20, 136, 3, 'Miércoles', 0),
(20240520, '2024-05-20', 2024, 5, 2, 'Mayo', 21, 141, 1, 'Lunes', 0),
(20240525, '2024-05-25', 2024, 5, 2, 'Mayo', 21, 146, 6, 'Sábado', 1),
(20240530, '2024-05-30', 2024, 5, 2, 'Mayo', 22, 151, 4, 'Jueves', 0);

-- -------------------------------------------------------------------------------------------------------
-- Dim_Usuario (ID_Usuario_CS es IDENTITY)
-- -------------------------------------------------------------------------------------------------------
INSERT INTO Dim_Usuario (ID_Usuario_CN, Nombre_Completo, Nickname, Correo, Fecha_Nacimiento, Password_Hash) VALUES
(102, 'Carlos Alberto Ruiz Soto', 'charly_dev', 'carlos.ruiz@email.com', '1995-08-22', '$2a$08$YgZ.N2gL7aH9bC.EaF0G.e/Uq0nKi7oKl1d.j5mXz.9mXv1aCb9iG'),
(103, 'Beatriz Elena Mendoza Luna', 'bea_luna', 'beatriz.m@email.com', '2001-01-30', '$2a$08$pL8.F3gO.9jH2k.LdG5H.u/Wp4nLi8pLm2e.k6nYz.1nZw2bDc0hH'),
(104, 'David Alejandro Vargas Paz', 'david_vp', 'david.vargas@email.com', '1988-11-12', '$2a$08$cK9.B4hP.1mJ3l.NhH6I.o/Xq5oMj9qNn3f.l7oAz.2oAx3cEd1iI'),
(105, 'Laura Valentina Gómez Ríos', 'lau_gomez', 'laura.gomez@email.com', '2003-04-05', '$2a$08$dM0.C5iQ.2nK4m.PiI7J.p/Yq6pOk0rOo4g.m8pBz.3pBy4dFe2jJ'),
(106, 'Javier Francisco Castillo', 'javi_cast', 'javier.castillo@email.com', '1999-07-19', '$2a$08$eN1.D6jR.3o_L5n.QjH8K.q/Zq7pPl1sPp5h.n9cA.4qCz5eGf3kK'),
(107, 'Sofía Isabel Herrera Mora', 'sofi_hm', 'sofia.herrera@email.com', '1992-02-25', '$2a$08$fO2.E7kS.4pM6o.RkI9L.r/Ar8qQm2tQq6i.o0dB.5rDa6fHg4l_L'),
(108, 'Miguel Ángel Paredes', 'miguel_coder', 'miguel.paredes@email.com', '1997-06-10', '$2a$08$gP3.F8lT.5qN7p.SlJ0M.s/Bs9rRn3uRr7j.p1eC.6sEb7gIh5m.M'),
(109, 'Fernanda Lucía Núñez Cruz', 'fer_nunez', 'fernanda.nunez@email.com', '2000-09-01', '$2a$08$hQ4.G9mU.6rO8q.TmK1N.t/Ct0sSo4vSs8k.q2fD.7tFc8hJi6n.N'),
(110, 'Ricardo Andrés Flores Gil', 'ricky_flores', 'ricardo.f@email.com', '1994-12-15', '$2a$08$iR5.H0nV.7sP9r.Un_L2O.u/Du1tTp5wTt9l.r3gE.8uGd9kJ7o.O'),
(111, 'Gabriela Ponce de León', 'gaby_ponce', 'gaby.ponce@email.com', '1998-03-28', '$2a$08$jS6.I1oW.8tQ0s.Vo_M3P.v/Ev2uUq6xUu0m.s4hF.9vHe0lK8p.P'),
(112, 'Martín Alonso Silva Díaz', 'martin_silva', 'martin.silva@email.com', '2002-10-18', '$2a$08$kT7.J2pX.9uR1t.Wp_N4Q.w/Fw3vVr7yVv1n.t5iG.0wHf1m_L9q.Q'),
(113, 'Daniela Rojas Morales', 'dani_rojas', 'daniela.rojas@email.com', '1996-05-21', '$2a$08$lU8.K3qY.0vS2u.Xq_O5R.x/Gx4wWs8zWw2o.u6jH.1xIg2n.M0r.R'),
(114, 'Sergio Mateo Ramos Vega', 'sergio_rv', 'sergio.ramos@email.com', '1991-08-08', '$2a$08$mV9.L4rZ.1wT3v.Yr_P6S.y/Hy5xXt9aXx3p.v7kI.2yJh3o.N1s.S'),
(115, 'Valeria Sofía Pineda', 'vale_pin', 'valeria.pineda@email.com', '2004-01-14', '$2a$08$nW0.M5sA.2xU4w.Zs_Q7T.z/Iz6yYu0bYy4q.w8lJ.3zKi4p.O2t.T'),
(116, 'Andrés Felipe Guerrero', 'andy_guerrero', 'andres.guerrero@email.com', '1993-11-30', '$2a$08$oX1.N6tB.3yV5x.At_R8U.A/Ja7zZv1cZz5r.x9mK.4aLj5q.P3u.U');
-- -------------------------------------------------------------------------------------------------------
-- Dim_Categoria
-- -------------------------------------------------------------------------------------------------------
INSERT INTO Dim_Categoria (ID_Categoria_CS, ID_Categoria_CN, Nombre_Categoria) VALUES
(1, 10, 'Desarrollo Web'),
(2, 20, 'Ciencia de Datos'),
(3, 30, 'Marketing Digital'),
(4, 40, 'Diseño Gráfico'),
(5, 50, 'Idiomas');

-- -------------------------------------------------------------------------------------------------------
-- Dim_Curso
-- (ID_Curso_CN debe ser único si se usa como referencia en Dim_Temario con FK)
-- -------------------------------------------------------------------------------------------------------
INSERT INTO Dim_Curso (ID_Curso_CS, ID_Curso_CN, Nombre_Curso, Duracion_Horas, Nivel_Curso, ID_Categoria_CS) VALUES
(1, 1001, 'Introducción a HTML y CSS', 40, 'Básico', 1),
(2, 1002, 'JavaScript para Principiantes', 60, 'Básico', 1),
(3, 1003, 'Python para Ciencia de Datos', 80, 'Intermedio', 2),
(4, 1004, 'Fundamentos de SEO', 30, 'Básico', 3),
(5, 1005, 'Diseño de Logos con Illustrator', 50, 'Intermedio', 4),
(6, 1006, 'Inglés para Negocios', 100, 'Avanzado', 5),
(7, 1007, 'Desarrollo Backend con Node.js', 70, 'Intermedio', 1),
(8, 1008, 'Machine Learning Aplicado', 90, 'Avanzado', 2),
(9, 1009, 'Redes Sociales para Empresas', 35, 'Básico', 3),
(10, 1010, 'Photoshop Esencial', 45, 'Básico', 4);

-- -------------------------------------------------------------------------------------------------------
-- Dim_Instructor
-- -------------------------------------------------------------------------------------------------------
INSERT INTO Dim_Instructor (ID_Instructor_CS, ID_Instructor_CN, Nombre_Completo_Instructor, Especialidad, Biografia, URL_Imagen) VALUES
(1, 201, 'Carlos Santana López', 'Desarrollo Full Stack', 'Experto en tecnologías web con más de 10 años de experiencia.', 'http://example.com/carlos.jpg'),
(2, 202, 'Elena Rivera Mesa', 'Científica de Datos', 'PhD en Inteligencia Artificial, apasionada por el Big Data.', 'http://example.com/elena.jpg'),
(3, 203, 'Roberto Fernández Gil', 'Marketing y SEO', 'Consultor de marketing digital para grandes marcas.', 'http://example.com/roberto.jpg'),
(4, 204, 'Lucía Méndez Parra', 'Diseñadora Gráfica Senior', 'Creativa y especialista en identidad de marca.', 'http://example.com/lucia.jpg'),
(5, 205, 'David Osorio Kent', 'Profesor de Idiomas', 'Políglota con experiencia en enseñanza de inglés de negocios.', 'http://example.com/david.jpg');

-- -------------------------------------------------------------------------------------------------------
-- Dim_Temario
-- (ID_Curso_CN_Referencia se vincula a ID_Curso_CN de Dim_Curso)
-- -------------------------------------------------------------------------------------------------------
INSERT INTO Dim_Temario (ID_Temario_CS, ID_Temario_CN, ID_Curso_CN_Referencia, Titulo_Temario, Descripcion_Temario) VALUES
(1, 301, 1001, 'Módulo 1: Fundamentos de HTML', 'Estructura básica, etiquetas principales.'),
(2, 302, 1001, 'Módulo 2: Estilos con CSS', 'Selectores, propiedades, layout.'),
(3, 303, 1002, 'Módulo 1: Variables y Tipos de Datos en JS', 'Introducción a la sintaxis de JavaScript.'),
(4, 304, 1002, 'Módulo 2: Funciones y DOM', 'Manipulación del Document Object Model.'),
(5, 305, 1003, 'Unidad 1: Introducción a Python', 'Sintaxis, estructuras de control.'),
(6, 306, 1003, 'Unidad 2: NumPy y Pandas', 'Librerías esenciales para datos.'),
(7, 307, 1004, 'Tema 1: ¿Qué es el SEO?', 'Conceptos clave y importancia.'),
(8, 308, 1004, 'Tema 2: Palabras Clave', 'Investigación y selección.'),
(9, 309, 1005, 'Lección 1: Interfaz de Illustrator', 'Herramientas básicas para logos.'),
(10, 310, 1005, 'Lección 2: Vectorización', 'Creación de formas y trazados.'),
(11, 311, 1006, 'Parte 1: Vocabulario Financiero', 'Términos comunes en inglés.'),
(12, 312, 1006, 'Parte 2: Presentaciones Efectivas', 'Comunicación en reuniones.'),
(13, 313, 1007, 'Sección 1: API REST con Express', 'Construcción de endpoints.'),
(14, 314, 1007, 'Sección 2: Bases de Datos NoSQL', 'Integración con MongoDB.'),
(15, 315, 1008, 'Capítulo 1: Regresión Lineal', 'Modelos predictivos básicos.'),
(16, 316, 1008, 'Capítulo 2: Árboles de Decisión', 'Clasificación y regresión.'),
(17, 317, 1009, 'Módulo A: Facebook e Instagram Ads', 'Creación de campañas.'),
(18, 318, 1009, 'Módulo B: Métricas y KPIs', 'Análisis de rendimiento.'),
(19, 319, 1010, 'Tema Principal 1: Capas y Máscaras', 'Edición no destructiva.'),
(20, 320, 1010, 'Tema Principal 2: Retoque Fotográfico', 'Mejora de imágenes.');

-- -------------------------------------------------------------------------------------------------------
-- Puente_Curso_Instructor
-- -------------------------------------------------------------------------------------------------------
INSERT INTO Puente_Curso_Instructor (ID_Curso_CS, ID_Instructor_CS) VALUES
(1, 1), (2, 1), (7, 1), -- Carlos Santana imparte cursos de Desarrollo Web
(3, 2), (8, 2),         -- Elena Rivera imparte cursos de Ciencia de Datos
(4, 3), (9, 3),         -- Roberto Fernández imparte cursos de Marketing Digital
(5, 4), (10, 4),        -- Lucía Méndez imparte cursos de Diseño Gráfico
(6, 5);                 -- David Osorio imparte el curso de Idiomas

-- -------------------------------------------------------------------------------------------------------
-- Puente_Temario_Instructor
-- (Asignar instructores a temas específicos)
-- -------------------------------------------------------------------------------------------------------
-- Temarios de Curso 1 (HTML/CSS) por Instructor 1
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (1, 1), (2, 1);
-- Temarios de Curso 2 (JavaScript) por Instructor 1
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (3, 1), (4, 1);
-- Temarios de Curso 3 (Python) por Instructor 2
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (5, 2), (6, 2);
-- Temarios de Curso 4 (SEO) por Instructor 3
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (7, 3), (8, 3);
-- Temarios de Curso 5 (Illustrator) por Instructor 4
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (9, 4), (10, 4);
-- Temarios de Curso 6 (Inglés) por Instructor 5
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (11, 5), (12, 5);
-- Temarios de Curso 7 (Node.js) por Instructor 1
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (13, 1), (14, 1);
-- Temarios de Curso 8 (Machine Learning) por Instructor 2
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (15, 2), (16, 2);
-- Temarios de Curso 9 (Redes Sociales) por Instructor 3
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (17, 3), (18, 3);
-- Temarios de Curso 10 (Photoshop) por Instructor 4
INSERT INTO Puente_Temario_Instructor (ID_Temario_CS, ID_Instructor_CS) VALUES (19, 4), (20, 4);


-- =======================================================================================================
-- INSERTS PARA TABLAS DE HECHOS
-- (7 registros por mes, Enero - Mayo)
-- ID_Usuario_CS va de 1 a 15 (asumiendo que IDENTITY genera estos IDs)
-- ID_Curso_CS va de 1 a 10
-- ID_Fecha_CS son los definidos en Dim_Fecha (YYYYMMDD)
-- =======================================================================================================

-- -------------------------------------------------------------------------------------------------------
-- Hecho_Registros_Usuario (ID_Registro_CS es IDENTITY)
-- -------------------------------------------------------------------------------------------------------
-- Enero (7 registros)
INSERT INTO Hecho_Registros_Usuario (ID_Usuario_CS, ID_Fecha_Registro_CS) VALUES
(1, 20240101), (2, 20240105), (3, 20240110), (4, 20240115), (5, 20240120), (6, 20240125), (7, 20240130);
-- Febrero (7 registros)
INSERT INTO Hecho_Registros_Usuario (ID_Usuario_CS, ID_Fecha_Registro_CS) VALUES
(8, 20240201), (9, 20240205), (10, 20240210), (11, 20240215), (12, 20240220), (13, 20240225), (14, 20240228);
-- Marzo (7 registros)
INSERT INTO Hecho_Registros_Usuario (ID_Usuario_CS, ID_Fecha_Registro_CS) VALUES
(15, 20240301), (1, 20240305), (2, 20240310), (3, 20240315), (4, 20240320), (5, 20240325), (6, 20240330);
-- Abril (7 registros)
INSERT INTO Hecho_Registros_Usuario (ID_Usuario_CS, ID_Fecha_Registro_CS) VALUES
(7, 20240401), (8, 20240405), (9, 20240410), (10, 20240415), (11, 20240420), (12, 20240425), (13, 20240430);
-- Mayo (7 registros)
INSERT INTO Hecho_Registros_Usuario (ID_Usuario_CS, ID_Fecha_Registro_CS) VALUES
(14, 20240501), (15, 20240505), (1, 20240510), (2, 20240515), (3, 20240520), (4, 20240525), (5, 20240530);

-- -------------------------------------------------------------------------------------------------------
-- Hecho_Inscripciones (ID_Inscripcion_CS es IDENTITY)
-- ID_Inscripcion_CN se simula como una secuencia
-- -------------------------------------------------------------------------------------------------------
-- Enero (7 registros)
INSERT INTO Hecho_Inscripciones (ID_Inscripcion_CN, ID_Usuario_CS, ID_Curso_CS, ID_Fecha_Inscripcion_CS, Estado_Inscripcion) VALUES
(1001, 1, 1, 20240101, 'Activa'), (1002, 2, 2, 20240105, 'Activa'), (1003, 3, 3, 20240110, 'Completado'),
(1004, 4, 4, 20240115, 'Activa'), (1005, 5, 5, 20240120, 'Cancelada'), (1006, 6, 6, 20240125, 'Activa'),
(1007, 7, 7, 20240130, 'Completado');
-- Febrero (7 registros)
INSERT INTO Hecho_Inscripciones (ID_Inscripcion_CN, ID_Usuario_CS, ID_Curso_CS, ID_Fecha_Inscripcion_CS, Estado_Inscripcion) VALUES
(1008, 8, 8, 20240201, 'Activa'), (1009, 9, 9, 20240205, 'Activa'), (1010, 10, 10, 20240210, 'Activa'),
(1011, 11, 1, 20240215, 'Completado'), (1012, 12, 2, 20240220, 'Activa'), (1013, 13, 3, 20240225, 'Cancelada'),
(1014, 14, 4, 20240228, 'Activa');
-- Marzo (7 registros)
INSERT INTO Hecho_Inscripciones (ID_Inscripcion_CN, ID_Usuario_CS, ID_Curso_CS, ID_Fecha_Inscripcion_CS, Estado_Inscripcion) VALUES
(1015, 15, 5, 20240301, 'Activa'), (1016, 1, 6, 20240305, 'Completado'), (1017, 2, 7, 20240310, 'Activa'),
(1018, 3, 8, 20240315, 'Activa'), (1019, 4, 9, 20240320, 'Activa'), (1020, 5, 10, 20240325, 'Completado'),
(1021, 6, 1, 20240330, 'Cancelada');
-- Abril (7 registros)
INSERT INTO Hecho_Inscripciones (ID_Inscripcion_CN, ID_Usuario_CS, ID_Curso_CS, ID_Fecha_Inscripcion_CS, Estado_Inscripcion) VALUES
(1022, 7, 2, 20240401, 'Activa'), (1023, 8, 3, 20240405, 'Activa'), (1024, 9, 4, 20240410, 'Completado'),
(1025, 10, 5, 20240415, 'Activa'), (1026, 11, 6, 20240420, 'Cancelada'), (1027, 12, 7, 20240425, 'Activa'),
(1028, 13, 8, 20240430, 'Completado');
-- Mayo (7 registros)
INSERT INTO Hecho_Inscripciones (ID_Inscripcion_CN, ID_Usuario_CS, ID_Curso_CS, ID_Fecha_Inscripcion_CS, Estado_Inscripcion) VALUES
(1029, 14, 9, 20240501, 'Activa'), (1030, 15, 10, 20240505, 'Activa'), (1031, 1, 2, 20240510, 'Activa'),
(1032, 2, 3, 20240515, 'Completado'), (1033, 3, 4, 20240520, 'Activa'), (1034, 4, 5, 20240525, 'Cancelada'),
(1035, 5, 6, 20240530, 'Activa');

-- -------------------------------------------------------------------------------------------------------
-- Hecho_Logins (ID_Login_CS es IDENTITY)
-- -------------------------------------------------------------------------------------------------------
-- Enero (7 logins)
INSERT INTO Hecho_Logins (ID_Usuario_CS, ID_Fecha_Login_CS) VALUES
(1, 20240101), (2, 20240105), (3, 20240110), (4, 20240115), (5, 20240120), (6, 20240125), (7, 20240130);
-- Febrero (7 logins)
INSERT INTO Hecho_Logins (ID_Usuario_CS, ID_Fecha_Login_CS) VALUES
(8, 20240201), (9, 20240205), (10, 20240210), (11, 20240215), (12, 20240220), (13, 20240225), (14, 20240228);
-- Marzo (7 logins)
INSERT INTO Hecho_Logins (ID_Usuario_CS, ID_Fecha_Login_CS) VALUES
(15, 20240301), (1, 20240305), (2, 20240310), (3, 20240315), (4, 20240320), (5, 20240325), (6, 20240330);
-- Abril (7 logins)
INSERT INTO Hecho_Logins (ID_Usuario_CS, ID_Fecha_Login_CS) VALUES
(7, 20240401), (8, 20240405), (9, 20240410), (10, 20240415), (11, 20240420), (12, 20240425), (13, 20240430);
-- Mayo (7 logins)
INSERT INTO Hecho_Logins (ID_Usuario_CS, ID_Fecha_Login_CS) VALUES
(14, 20240501), (15, 20240505), (1, 20240510), (2, 20240515), (3, 20240520), (4, 20240525), (5, 20240530);

-- GO
-- Reactivar las restricciones de clave externa si se deshabilitaron
-- EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"
-- GO

SELECT 'Inserción de datos completada.' AS Mensaje;