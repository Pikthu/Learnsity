CREATE DATABASE dbLearnsity
USE dbLearnsity
GO

-- Tabla Usuario
CREATE TABLE Usuario (
    ID_usuario INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido_Paterno VARCHAR(100),
    Apellido_Materno VARCHAR(100),
    Correo VARCHAR(150),
    Fecha_nacimiento DATE
);

-- Tabla Curso
CREATE TABLE Curso (
    ID_curso INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Duracion INT,
    Nivel VARCHAR(50)
);

-- Tabla Instructor
CREATE TABLE Instructor (
    ID_instructor INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido_Paterno VARCHAR(100),
    Apellido_Materno VARCHAR(100),
    Especialidad VARCHAR(100),
    Biografia TEXT,
    Imagen TEXT
);

-- Tabla Temario
CREATE TABLE Temario (
    ID_temario INT PRIMARY KEY,
    Titulo VARCHAR(100),
    Descripcion TEXT,
    ID_curso INT,
    FOREIGN KEY (ID_curso) REFERENCES Curso(ID_curso)
);

-- Relación Dicta (Temario - Instructor)
CREATE TABLE Dicta (
    ID_temario INT,
    ID_instructor INT,
    PRIMARY KEY (ID_temario, ID_instructor),
    FOREIGN KEY (ID_temario) REFERENCES Temario(ID_temario),
    FOREIGN KEY (ID_instructor) REFERENCES Instructor(ID_instructor)
);

-- Tabla Categoría
CREATE TABLE Categoria (
    ID_categoria INT PRIMARY KEY,
    Nombre VARCHAR(100)
);

-- Relación Pertenece (Curso - Categoría)
CREATE TABLE Pertenece (
    ID_curso INT,
    ID_categoria INT,
    PRIMARY KEY (ID_curso, ID_categoria),
    FOREIGN KEY (ID_curso) REFERENCES Curso(ID_curso),
    FOREIGN KEY (ID_categoria) REFERENCES Categoria(ID_categoria)
);

-- Tabla Inscripción
CREATE TABLE Inscripcion (
    ID_inscripcion INT PRIMARY KEY,
    ID_usuario INT,
    ID_curso INT,
    Fecha_inscripcion DATE,
    Estado VARCHAR(50),
    FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario),
    FOREIGN KEY (ID_curso) REFERENCES Curso(ID_curso)
);

-- Relación Curso - Instructor (relación muchos a muchos)
CREATE TABLE Curso_Instructor (
    ID_curso INT,
    ID_instructor INT,
    PRIMARY KEY (ID_curso, ID_instructor),
    FOREIGN KEY (ID_curso) REFERENCES Curso(ID_curso),
    FOREIGN KEY (ID_instructor) REFERENCES Instructor(ID_instructor)
);


--usuarios
INSERT INTO Usuario VALUES
(8, 'Natalia', 'Mendoza', 'Ruiz', 'natalia.mendoza@example.com', '1995-08-14'),
(9, 'Ricardo', 'Torres', 'García', 'ricardo.torres@example.com', '1990-06-30'),
(10, 'Andrea', 'Castañeda', 'Lopez', 'andrea.casta@example.com', '1998-02-15'),
(11, 'Gabriel', 'Ríos', 'Navarro', 'gabriel.rios@example.com', '1985-11-20'),
(12, 'Claudia', 'Vargas', 'Díaz', 'claudia.vargas@example.com', '1992-03-10'),
(13, 'Daniel', 'Moreno', 'Silva', 'daniel.moreno@example.com', '1997-09-25'),
(14, 'Alejandra', 'Reyes', 'Soto', 'ale.reyes@example.com', '1996-07-19');
-- curso
INSERT INTO Curso VALUES
(8, 'Introducción a Java', 40, 'Básico'),
(9, 'Front-End con React', 45, 'Intermedio'),
(10, 'Deep Learning', 60, 'Avanzado'),
(11, 'Administración MySQL', 35, 'Intermedio'),
(12, 'Diseño Gráfico', 30, 'Básico'),
(13, 'Hacking Ético', 50, 'Avanzado'),
(14, 'Excel Avanzado', 20, 'Intermedio');
-- Instructor 
INSERT INTO Instructor VALUES
(8, 'Diego', 'Luna', 'Martínez', 'Java', 'Especialista en programación Java.', 'img8.jpg'),
(9, 'Sara', 'Campos', 'Hernández', 'React', 'Desarrolladora Front-End.', 'img9.jpg'),
(10, 'Iván', 'Muñoz', 'López', 'Deep Learning', 'Doctor en Ciencias de la Computación.', 'img10.jpg'),
(11, 'Sofía', 'Peña', 'Alvarez', 'MySQL', 'Ingeniera de bases de datos.', 'img11.jpg'),
(12, 'Hugo', 'Gallegos', 'Bravo', 'Diseño Gráfico', 'Diseñador gráfico profesional.', 'img12.jpg'),
(13, 'Rebeca', 'Zamora', 'Salinas', 'Ciberseguridad', 'Hackera ética certificada.', 'img13.jpg'),
(14, 'Jorge', 'Salvador', 'Trejo', 'Ofimática', 'Consultor en productividad digital.', 'img14.jpg');
--Temario
INSERT INTO Temario VALUES
(8, 'Variables y estructuras', 'Sintaxis básica en Java.', 8),
(9, 'Componentes en React', 'Introducción al framework.', 9),
(10, 'Redes neuronales', 'Fundamentos de redes neuronales.', 10),
(11, 'Consultas y uniones', 'JOINs y subconsultas en SQL.', 11),
(12, 'Teoría del color', 'Fundamentos de diseño gráfico.', 12),
(13, 'Tipos de ataques', 'Ataques comunes en sistemas.', 13),
(14, 'Tablas dinámicas', 'Funciones y visualización en Excel.', 14);
-- DICTA
INSERT INTO Dicta VALUES
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14);
-- categoría
INSERT INTO Categoria VALUES
(8, 'Java'),
(9, 'Frontend'),
(10, 'Inteligencia Artificial'),
(11, 'Bases de Datos'),
(12, 'Diseño Gráfico'),
(13, 'Ciberseguridad'),
(14, 'Ofimática');
-- Pertenece 
INSERT INTO Pertenece VALUES
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14);
--Inscripcion 
INSERT INTO Inscripcion VALUES
(8, 8, 8, '2024-04-17', 'Activa'),
(9, 9, 9, '2024-04-18', 'Pendiente'),
(10, 10, 10, '2024-04-19', 'Completada'),
(11, 11, 11, '2024-04-20', 'Cancelada'),
(12, 12, 12, '2024-04-21', 'Activa'),
(13, 13, 13, '2024-04-22', 'Activa'),
(14, 14, 14, '2024-04-23', 'Pendiente');
-- Curso_Instructor
INSERT INTO Curso_Instructor VALUES
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14);