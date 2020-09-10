
CREATE DATABASE booklydb;
USE booklydb ;

create table subgenero
(
    idSubGenero varchar(10) not null
        primary key,
    SubGenero   varchar(45) not null
);

create table tipogenero
(
    idTipoGenero varchar(2)  not null
        primary key,
    TipoGenero   varchar(45) not null
);

create table genero
(
    idGenero                varchar(10) not null
        primary key,
    NombreGenero            varchar(45) not null,
    TipoGenero_idTipoGenero varchar(2)  not null,
    constraint fk_Genero_TipoGenero1
        foreign key (TipoGenero_idTipoGenero) references tipogenero (idTipoGenero)
);

create index fk_Genero_TipoGenero1_idx
    on genero (TipoGenero_idTipoGenero);

create table genero_has_subgenero
(
    Genero_idGenero       varchar(10) not null,
    SubGenero_idSubGenero varchar(10) not null,
    primary key (Genero_idGenero, SubGenero_idSubGenero),
    constraint fk_Genero_has_SubGenero_Genero1
        foreign key (Genero_idGenero) references genero (idGenero),
    constraint fk_Genero_has_SubGenero_SubGenero1
        foreign key (SubGenero_idSubGenero) references subgenero (idSubGenero)
);

create index fk_Genero_has_SubGenero_Genero1_idx
    on genero_has_subgenero (Genero_idGenero);

create index fk_Genero_has_SubGenero_SubGenero1_idx
    on genero_has_subgenero (SubGenero_idSubGenero);

create table libro
(
    idLibro          int auto_increment
        primary key,
    Titlulolibro     varchar(100) not null,
    AutorLibro       varchar(80)  not null,
    PublicacionLibro date         null,
    ColeccionesLibro varchar(45)  null,
    EditorialLibro   varchar(45)  null,
    Genero_idGenero  varchar(10)  not null,
    constraint fk_Libro_Genero1
        foreign key (Genero_idGenero) references genero (idGenero)
);

create index fk_Libro_Genero1_idx
    on libro (Genero_idGenero);

create table usuario
(
    idUsuario          int auto_increment,
    NombreUsuario      varchar(45)  not null,
    EmailUsuario       varchar(45)  not null,
    ContraseniaUsuario varchar(200) not null,
    FechaNacUsuario    date         not null,
    constraint CorreoEUsuario_UNIQUE
        unique (EmailUsuario),
    constraint idUsuario_UNIQUE
        unique (idUsuario)
);

alter table usuario
    add primary key (idUsuario);

create table resenia
(
    idResenia          int auto_increment
        primary key,
    TitluloResenia     varchar(45) not null,
    LibroAReseniar     varchar(45) null,
    DescripcionResenia mediumtext  not null,
    ValoracionResenia  int(5)      null,
    Usuario_idUsuario  int         not null,
    Libro_idLibro      int         null,
    constraint fk_Resenia_Libro
        foreign key (Libro_idLibro) references libro (idLibro),
    constraint fk_Resenia_Usuario1
        foreign key (Usuario_idUsuario) references usuario (idUsuario)
);

create index fk_Resenia_Libro_idx
    on resenia (Libro_idLibro);

create index fk_Resenia_Usuario1_idx
    on resenia (Usuario_idUsuario);

create table usuario_has_usuario
(
    SeguidorId int not null,
    SeguidoId  int not null,
    primary key (SeguidorId, SeguidoId),
    constraint fk_Usuario_has_Usuario_Usuario1
        foreign key (SeguidorId) references usuario (idUsuario),
    constraint fk_Usuario_has_Usuario_Usuario2
        foreign key (SeguidoId) references usuario (idUsuario)
);

create index fk_Usuario_has_Usuario_Usuario1_idx
    on usuario_has_usuario (SeguidorId);

create index fk_Usuario_has_Usuario_Usuario2_idx
    on usuario_has_usuario (SeguidoId);



INSERT INTO booklydb.tipogenero (idTipoGenero, TipoGenero) VALUES ('FI', 'No Ficción');
INSERT INTO booklydb.tipogenero (idTipoGenero, TipoGenero) VALUES ('NF', 'Ficción');

INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('BIO', 'Biografía', 'NF');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('CRO', 'Crónica', 'NF');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('DIV', 'Divulgación', 'NF');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('ENS', 'Ensayo', 'NF');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('GUI', 'Guion', 'FI');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('NOV', 'Novela', 'FI');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('PBLPERF', 'Publicaciones periódicas', 'FI');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('PBLPERNF', 'Publicaciones periódicas', 'NF');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('POE', 'Poesía', 'FI');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('REF', 'Referencia', 'NF');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('REL', 'Relato', 'FI');
INSERT INTO booklydb.genero (idGenero, NombreGenero, TipoGenero_idTipoGenero) VALUES ('TEA', 'Teatro', 'FI');

INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('ARTEN', 'Arte');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('AUTON', 'Autoayuda');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('AVENF', 'Aventuras');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('BELIF', 'Bélico');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('CEXTN', 'Ciencias exactas');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('CFICF', 'Ciencia ficción');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('CNATN', 'Ciencias naturales');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('COMUN', 'Comunicación');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('CRTEN', 'Crítica y teoría literaria');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('DEJUN', 'Deportes y juegos');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('DIDAF', 'Didáctico');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('DIENN', 'Diccionarios y enciclopedias');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('DRAMF', 'Drama');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('EROTF', 'Erótico');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('ESPIN', 'Espiritualidad');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('FANTF', 'Fantástico');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('FILOF', 'Filosófico');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('FILON', 'Filosofía');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('HISTF', 'Histórico');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('HISTN', 'Historia');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('HOGAN', 'Hogar');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('HUMOF', 'Humor');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('HUMON', 'Humor');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('IDION', 'Idiomas');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('INFAF', 'Infantil');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('INTEF', 'Interactivo');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('INTRF', 'Intriga');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('JUVEF', 'Juvenil');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('MACUN', 'Manuales y cursos');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('MEMON', 'Memorias');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('OTROF', 'Otros');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('OTRON', 'Otros');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('PAHIN', 'Padres e hijos');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('POLIF', 'Policial');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('PSICF', 'Psicológico');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('PSICN', 'Psicología');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('REALF', 'Realista');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('ROMAF', 'Romántico');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('SABIN', 'Salud y bienestar');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('SATIF', 'Sátira');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('SEXUN', 'Sexualidad');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('TECNN', 'Tecnología');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('TERRF', 'Terror');
INSERT INTO booklydb.subgenero (idSubGenero, SubGenero) VALUES ('VIAJN', 'Viajes');

INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('BIO', 'HISTN');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('BIO', 'MEMON');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('DIV', 'CEXTN');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('DIV', 'HISTN');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('DIV', 'PSICN');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('DIV', 'TECNN');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('NOV', 'AVENF');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('NOV', 'CFICF');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('NOV', 'FANTF');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('NOV', 'INFAF');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('NOV', 'INTRF');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('NOV', 'JUVEF');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('NOV', 'ROMAF');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('NOV', 'TERRF');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('REL', 'INFAF');
INSERT INTO booklydb.genero_has_subgenero (Genero_idGenero, SubGenero_idSubGenero) VALUES ('REL', 'JUVEF');

INSERT INTO booklydb.usuario (idUsuario, NombreUsuario, EmailUsuario, ContraseniaUsuario, FechaNacUsuario) VALUES (1, 'robin', 'robbin.vicente@gmail.com', '$2y$10$y.PEpgmZweqoFhSqk8TuyOVHaotsPnVzmcQnHQ66iFtsuhBI0pnIe', '2000-06-30');
INSERT INTO booklydb.usuario (idUsuario, NombreUsuario, EmailUsuario, ContraseniaUsuario, FechaNacUsuario) VALUES (2, 'jhon', 'robbin@gmail.com', '$2y$10$bTzX3NMG3cgvRw.GXkX3V.rH5TjTtIZxYkVJNX/aivxzyyxdcUVqK', '2020-09-10');

INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (2, 'Sapiens', 'Yuval Noah Harari', '2015-02-10', null, 'Penguin Random House LLC', 'DIV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (3, 'It', 'Stephen King', '1986-09-15', null, 'Charles Scribner''s Sons', 'NOV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (4, 'El Principito', 'Antoine de Saint-Exupéry', '1943-04-06', null, 'Reynal & Hitchcock', 'REL');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (7, 'Elon Musk', 'Ashlee Vance', '2015-04-19', null, 'Ediciones Península', 'BIO');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (8, 'El Resplandor', 'Stephen King', '1977-01-28', 'Posterior - Doctor Sueño', 'Hodder & Stoughton', 'NOV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (9, 'La Digestión es la Cuestión', 'Giulia Enders', '2015-03-30', '', 'Urano ', 'DIV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (10, 'La historia de la Tierra', 'Robert M. Hazen', '2012-04-26', '', 'Océano', 'DIV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (11, 'Harry Potter y la piedra filosofal', 'J. K. Rowling', '1997-06-26', 'Harry Potter - 1', 'Salamandra', 'NOV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (12, 'Harry Potter y la cámara secreta', 'J. K. Rowling', '1998-02-07', 'Harry Potter - 2', 'Salamandra', 'NOV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (13, 'Harry Potter y el prisionero de Azkaban', 'J. K. Rowling', '1999-07-08', 'Harry Potter - 3', 'Salamandra', 'NOV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (14, 'Harry Potter y el cáliz de fuego', 'J. K. Rowling', '2000-07-08', 'Harry Potter - 4', 'Salamandra', 'NOV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (15, 'Harry Potter y la Orden del Fénix', 'J. K. Rowling', '2003-06-23', 'Harry Potter - 5', 'Salamandra', 'NOV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (16, 'Harry Potter y el misterio del príncipe', 'J. K. Rowling', '2005-07-25', 'Harry Potter - 6', 'Salamandra', 'NOV');
INSERT INTO booklydb.libro (idLibro, Titlulolibro, AutorLibro, PublicacionLibro, ColeccionesLibro, EditorialLibro, Genero_idGenero) VALUES (17, 'Harry Potter y las Reliquias de la Muerte	', 'J. K. Rowling', '2007-07-21', 'Harry Potter - 7', 'Salamandra', 'NOV');


INSERT INTO booklydb.resenia (idResenia, TitluloResenia, LibroAReseniar, DescripcionResenia, ValoracionResenia, Usuario_idUsuario, Libro_idLibro) VALUES (1, ' ''Sin palabras''', ' ''Sapiens''', ' ''Excelente libro que explica el desarrollo de la Humanidad desde sus principios hasta la era actual. Lo hace de una manera amena y de fácil comprensión.', 4, 1, 2)