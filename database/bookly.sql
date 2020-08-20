CREATE DATABASE BOOKLY;
USE BOOKLY;
DROP DATABASE BOOKLY;
USE ventas;
DROP DATABASE BOOKLY;

CREATE TABLE USUARIO
    (
        UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
        NombresEmail VARCHAR(60),
        NombresUsuario VARCHAR(45),
        ApellidosUsuario VARCHAR(60),
        FechaNacUsuario DATE,
        GeneroUsuario CHAR
    );

CREATE TABLE RESENIA
    (
        ReseniaID INT AUTO_INCREMENT PRIMARY KEY,
        TituloResenia VARCHAR(45),
        DescripResenia VARCHAR(45),
        UsuarioID_F INT,
        FOREIGN KEY (UsuarioID_F) REFERENCES USUARIO(UsuarioID)

    );

CREATE TABLE CATEGORIA
    (
        CategoriaId INT AUTO_INCREMENT PRIMARY KEY,
        NombresCategoria VARCHAR(45),
        DescripCategoria VARCHAR(45)
    );

CREATE TABLE CATEGORIA_RESENIA
    (
        CatResID INT AUTO_INCREMENT PRIMARY KEY,
        FechaCatRes DATE,
        CategoriaId_F INT,
        ReseniaID_F INT,

        FOREIGN KEY (CategoriaId_F) REFERENCES CATEGORIA(CategoriaId),
        FOREIGN KEY (ReseniaID_F) REFERENCES RESENIA(ReseniaID)
    );

CREATE TABLE GENERO
    (
        GeneroID INT AUTO_INCREMENT PRIMARY KEY,
        NombresGenero VARCHAR(45),
        TipoGenero VARCHAR(45)
    );

CREATE TABLE LIBRO
    (
        LibroID INT AUTO_INCREMENT PRIMARY KEY,
        TituloLibro VARCHAR(45),
        AutorLibro VARCHAR(45),
        Sipnosis VARCHAR(500),
        AnioLibro DATE,
        GeneroID_F INT,
        ReseniaID_F INT,
        FOREIGN KEY (GeneroID_F) REFERENCES GENERO(GeneroID),
        FOREIGN KEY (ReseniaID_F) REFERENCES RESENIA(ReseniaID)
    );