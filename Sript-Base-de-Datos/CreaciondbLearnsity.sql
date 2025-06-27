CREATE DATABASE dbLearnsityMultidimensional;
USE dbLearnsityMultidimensional;
GO
CREATE TABLE Dim_Usuario (
    ID_Usuario_CS INT PRIMARY KEY IDENTITY (1,1), -- Clave Subrogada, se mantiene auto-incremental
    ID_Usuario_CN INT,                            -- Clave Natural del origen
    Nombre_Completo VARCHAR(300),                 -- Combinado de Nombre, Apellido_Paterno, Apellido_Materno
    Nickname VARCHAR(16),
    Correo VARCHAR(150) UNIQUE,                   -- El correo debe ser único para el login
    Fecha_Nacimiento DATE,
    Password_Hash VARCHAR(255) NOT NULL,          -- ¡NUEVO CAMPO ESENCIAL PARA LA CONTRASEÑA!
    Fecha_Insercion_Fila DATETIME DEFAULT GETDATE(),
    Fecha_Modificacion_Fila DATETIME DEFAULT GETDATE()
);
CREATE TABLE Dim_Categoria (
    ID_Categoria_CS INT PRIMARY KEY,          -- Clave Subrogada, ingreso manual
    ID_Categoria_CN INT,                      -- Clave Natural del origen (Categoria.ID_categoria) [cite: 5, 2]
    Nombre_Categoria VARCHAR(100),
    Fecha_Insercion_Fila DATETIME DEFAULT GETDATE(),
    Fecha_Modificacion_Fila DATETIME DEFAULT GETDATE()
);
CREATE TABLE Dim_Curso (
    ID_Curso_CS INT PRIMARY KEY,              -- Clave Subrogada, ingreso manual
    ID_Curso_CN INT,                          -- Clave Natural del origen (Curso.ID_curso) [cite: 2, 4]
    Nombre_Curso VARCHAR(100),
    Duracion_Horas INT,                       -- Del atributo Duracion [cite: 2]
    Nivel_Curso VARCHAR (50),
    ID_Categoria_CS INT,                      -- Clave Foránea a Dim_Categoria (para copo de nieve) [cite: 2]
    -- Potencialmente añadir otros atributos [cite: 4]
    Fecha_Insercion_Fila DATETIME DEFAULT GETDATE(),
    Fecha_Modificacion_Fila DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ID_Categoria_CS) REFERENCES Dim_Categoria (ID_Categoria_CS)
);
CREATE TABLE Dim_Instructor (
    ID_Instructor_CS INT PRIMARY KEY,         -- Clave Subrogada, ingreso manual
    ID_Instructor_CN INT,                     -- Clave Natural del origen (Instructor.ID_instructor) [cite: 3, 4]
    Nombre_Completo_Instructor VARCHAR (300), -- Combinado de Nombre, Apellido_Paterno, Apellido_Materno [cite: 3]
    Especialidad VARCHAR(100),
    Biografia TEXT,
    URL_Imagen TEXT,                          -- Del atributo Imagen [cite: 3]
    Fecha_Insercion_Fila DATETIME DEFAULT GETDATE(),
    Fecha_Modificacion_Fila DATETIME DEFAULT GETDATE()
);
CREATE TABLE Dim_Temario (
    ID_Temario_CS INT PRIMARY KEY,            -- Clave Subrogada, ingreso manual
    ID_Temario_CN INT,                        -- Clave Natural del origen (Temario.ID_temario) [cite: 4]
    ID_Curso_CN_Referencia INT,               -- Clave Natural del curso al que pertenece este tema, para relacionar [cite: 6]
    Titulo_Temario VARCHAR(100),
    Descripcion_Temario TEXT,
    Fecha_Insercion_Fila DATETIME DEFAULT GETDATE(),
    Fecha_Modificacion_Fila DATETIME DEFAULT GETDATE()
    -- Opcional: FOREIGN KEY (ID_Curso_CN_Referencia) REFERENCES Dim_Curso (ID_Curso_CN) si las CN son estables en Dim_Curso [cite: 6]
);
CREATE TABLE Dim_Fecha (
    ID_Fecha_CS INT PRIMARY KEY,              -- ej., AAAAMMDD como 20240530 [cite: 7]
    Fecha_Completa DATE NOT NULL,
    Anio INT NOT NULL,
    Mes INT NOT NULL,
    Trimestre INT NOT NULL,
    Nombre_Mes VARCHAR (20) NOT NULL,
    Semana_Anio INT NOT NULL,
    Dia_Anio INT NOT NULL,
    Dia_Semana_Numero INT NOT NULL,
    Nombre_Dia_Semana VARCHAR(20) NOT NULL,
    Es_Fin_De_Semana BIT NOT NULL
    -- Añadir otros atributos de fecha relevantes (periodos fiscales, festivos, etc.) [cite: 8]
);
CREATE TABLE Hecho_Registros_Usuario (
    ID_Registro_CS BIGINT PRIMARY KEY IDENTITY(1,1), -- Clave Subrogada para el registro de hecho, se mantiene auto-incremental
    ID_Usuario_CS INT,                               -- Clave Foránea a Dim_Usuario [cite: 8]
    ID_Fecha_Registro_CS INT,                        -- Clave Foránea a Dim_Fecha (fecha de registro) [cite: 8]
    Cantidad_Registros INT DEFAULT 1,                -- Medida: Número de registros (usualmente 1 por fila) [cite: 8]
    -- Añadir otras CFs si el registro está ligado a una campaña, fuente de referencia, etc. [cite: 8]
    FOREIGN KEY (ID_Usuario_CS) REFERENCES Dim_Usuario (ID_Usuario_CS),
    FOREIGN KEY (ID_Fecha_Registro_CS) REFERENCES Dim_Fecha (ID_Fecha_CS)
);
CREATE TABLE Hecho_Inscripciones (
    ID_Inscripcion_CS BIGINT PRIMARY KEY IDENTITY (1,1), -- Clave Subrogada para el registro de hecho, se mantiene auto-incremental
    ID_Inscripcion_CN INT,                               -- Clave Natural del origen (Inscripcion.ID_inscripcion) [cite: 8]
    ID_Usuario_CS INT,                                   -- Clave Foránea a Dim_Usuario [cite: 8]
    ID_Curso_CS INT,                                     -- Clave Foránea a Dim_Curso [cite: 8]
    ID_Fecha_Inscripcion_CS INT,                         -- Clave Foránea a Dim_Fecha (usando Inscripcion.Fecha_inscripcion) [cite: 8]
    Estado_Inscripcion VARCHAR(50),                      -- Dimensión Degenerada: De Inscripcion.Estado [cite: 8, 9]
    Cantidad_Inscripciones INT DEFAULT 1,                -- Medida: Número de inscripciones (usualmente 1) [cite: 9]
    -- Potencialmente añadir medidas como estado de completitud si se rastrea numéricamente, o precio si los cursos se vuelven de pago [cite: 9]
    FOREIGN KEY (ID_Usuario_CS) REFERENCES Dim_Usuario (ID_Usuario_CS),
    FOREIGN KEY (ID_Curso_CS) REFERENCES Dim_Curso (ID_Curso_CS),
    FOREIGN KEY (ID_Fecha_Inscripcion_CS) REFERENCES Dim_Fecha (ID_Fecha_CS)
);
CREATE TABLE Hecho_Logins (
    ID_Login_CS BIGINT PRIMARY KEY IDENTITY(1,1), -- Clave subrogada, se mantiene auto-incremental [cite: 13]
    ID_Usuario_CS INT NOT NULL,                   -- Clave foránea a Dim_Usuario [cite: 13]
    ID_Fecha_Login_CS INT NOT NULL,               -- Clave foránea a Dim_Fecha [cite: 13]
    Cantidad_Logins INT DEFAULT 1,                -- Medida [cite: 13]
    FOREIGN KEY (ID_Usuario_CS) REFERENCES Dim_Usuario (ID_Usuario_CS),
    FOREIGN KEY (ID_Fecha_Login_CS) REFERENCES Dim_Fecha (ID_Fecha_CS)
);
CREATE TABLE Puente_Curso_Instructor (
    ID_Curso_CS INT,
    ID_Instructor_CS INT,
    PRIMARY KEY (ID_Curso_CS, ID_Instructor_CS),
    FOREIGN KEY (ID_Curso_CS) REFERENCES Dim_Curso (ID_Curso_CS),
    FOREIGN KEY (ID_Instructor_CS) REFERENCES Dim_Instructor (ID_Instructor_CS)
);
CREATE TABLE Puente_Temario_Instructor (
    ID_Temario_CS INT,
    ID_Instructor_CS INT,
    PRIMARY KEY (ID_Temario_CS, ID_Instructor_CS),
    FOREIGN KEY (ID_Temario_CS) REFERENCES Dim_Temario (ID_Temario_CS),
    FOREIGN KEY (ID_Instructor_CS) REFERENCES Dim_Instructor (ID_Instructor_CS)
);