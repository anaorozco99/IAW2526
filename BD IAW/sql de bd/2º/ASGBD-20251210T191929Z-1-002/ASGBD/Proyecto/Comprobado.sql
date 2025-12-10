-- Como usuario G10Proyecto(administrador):
CREATE USER G10Proyecto IDENTIFIED BY amazonas
DEFAULT TABLESPACE users;
GRANT DBA TO G10Proyecto;

-- Crearemos TableSpace (usando G10Proyecto):
CREATE TABLESPACE proyecto
DATAFILE '/Ora2/datos/proyecto.dbf' SIZE 20M
AUTOEXTEND ON NEXT 512K MAXSIZE 35M;

-- Creación de las tablas usando usuario G10Proyecto(administrador):
CREATE TABLE Reyes(
id_reyes CHAR(5) CONSTRAINT pk_reyes PRIMARY KEY,
Nombre varchar2(30),
Descripcion varchar2(50),
Vestimenta varchar2(10) CHECK (vestimenta IN
('Baltasar','Gaspar','Melchor'))
) TABLESPACE proyecto;

CREATE TABLE Carroza(
id_carroza number(2,0) CONSTRAINT pk_carroza PRIMARY KEY,
Titulo varchar2(20),
Descripcion varchar2(50),
Tematica varchar2(15),
Tipo varchar2(11) CONSTRAINT ck_tipo_carroza CHECK (Tipo IN
('Tractor','Todoterreno')),
Ciudad varchar2(11),
Num_pajes NUMBER(3),
id_reyes CHAR(5) CONSTRAINT fk_id_reyes REFERENCES Reyes
) TABLESPACE proyecto;
-- ALTER TABLE G10Proyecto.CARROZA add num_pajes number(3);
CREATE TABLE Pasacalle(
id_pas number(3,0) CONSTRAINT pk_pasacalle PRIMARY KEY,
Titulo varchar2(15),
Descripcion varchar2(50),
Tematica varchar2(15),
Instrumento varchar2(15),
id_carroza number(2,0) CONSTRAINT fk_pasacalle_id_carroza REFERENCES
Carroza
) TABLESPACE proyecto;

CREATE TABLE Persona(
Codigo CHAR(5) CONSTRAINT pk_persona PRIMARY KEY,
Nif CHAR(9),
Nombre varchar2(30),
Apellido varchar2(20),
Direccion varchar2(30),
Edad NUMBER(2,0) NOT NULL,
Responsable CHAR(5) CONSTRAINT fk_persona_responsable REFERENCES
Persona
) TABLESPACE proyecto;

CREATE TABLE Desfila(
Codigo CHAR(5) CONSTRAINT fk_desfila_persona REFERENCES Persona,
id_pas number(3,0) CONSTRAINT fk_desfila_pasacalle REFERENCES
Pasacalle,
Orden number(2,0),
Tiene_Rey CHAR(1) CONSTRAINT ck_desfila_rey CHECK (Tiene_Rey IN
('S','N')),
CONSTRAINT pk_desfila PRIMARY KEY(Codigo,id_pas)
) TABLESPACE proyecto;

CREATE TABLE Ubica(
Codigo CHAR(5) CONSTRAINT fk_ubica_codigo REFERENCES Persona,
id_carroza number(2,0) CONSTRAINT fk_ubica_carroza REFERENCES Carroza,
Menor_edad CHAR(1) CONSTRAINT ck_ubica_edad CHECK (Menor_edad IN
('S','N')),
CONSTRAINT pk_ubica PRIMARY KEY(Codigo,id_carroza)
) TABLESPACE proyecto;


-- Creamos usuario “comoquieras” (en nuestro caso Ana) como usuario G10Proyecto(administrador):
CREATE USER AnaPro IDENTIFIED BY amazonas
DEFAULT TABLESPACE personal;
GRANT CREATE SESSION TO AnaPro;

-- Le daremos privilegios:
GRANT CREATE ANY TABLE TO AnaPro;
GRANT INSERT, SELECT, ALTER, DELETE, UPDATE ON G10Proyecto.Reyes TO AnaPro;
GRANT INSERT, SELECT, ALTER, DELETE, UPDATE ON G10Proyecto.Carroza TO AnaPro;
GRANT INSERT, SELECT, ALTER, DELETE, UPDATE ON G10Proyecto.Pasacalle TO AnaPro;
GRANT INSERT, SELECT, ALTER, DELETE, UPDATE ON G10Proyecto.Persona TO AnaPro;
GRANT INSERT, SELECT, ALTER, DELETE, UPDATE ON G10Proyecto.Desfila TO AnaPro;
GRANT INSERT, SELECT, ALTER, DELETE, UPDATE ON G10Proyecto.Ubica TO AnaPro;

-- Creamos usuario “comoquieras2” (en nuestro caso Carlos) como usuario G10Proyecto(administrador):
CREATE USER Carlos IDENTIFIED BY amazonas
DEFAULT TABLESPACE users;
GRANT CREATE SESSION TO Carlos;

-- Con usuario Ana(comoquieras):(Le daremos los permisos especícos para evitar que tengan demasiados privilegios)
GRANT CREATE ANY VIEW TO AnaPro;
-- GRANT SELECT ON G10Proyecto.VG10reyes TO AnaPro WITH GRANT OPTION;
-- GRANT SELECT ON G10Proyecto.VG10pasacalles TO AnaPro WITH GRANT OPTION;

-- 1. El usuario se ha dado cuenta que el esquema no reeja en cual de las carrozas de la cabalgata está sentado cada Rey Mago, 
-- ni tampoco los pajes que llevan los reyes. Refleja el cambio correspondiente en el esquema para reejar está informacion.

-- Creo una tabla donde aparece Reyes, Carroza y Pasacalles

CREATE TABLE G10Proyecto.RCP (id_reyes, id_Carroza, id_pas) AS
SELECT R.id_reyes, C.id_Carroza, P.id_pas FROM G10Proyecto.Reyes
R, G10Proyecto.Carroza C, G10Proyecto.Pasacalle P
WHERE R.id_reyes=C.id_reyes AND C.id_Carroza=P.id_Carroza;

-- 1.A. Introduce algunos datos en el esquema anterior
INSERT INTO G10Proyecto.Reyes (id_reyes, Nombre, Descripcion, Vestimenta) 
VALUES ('R0001', 'Baltasar', 'Rey Mago', 'Baltasar');
INSERT INTO G10Proyecto.Reyes (id_reyes, Nombre, Descripcion, Vestimenta) 
VALUES ('R0002', 'Gaspar', 'Rey Mago', 'Gaspar');
INSERT INTO G10Proyecto.Carroza (id_carroza, Titulo, Descripcion, Tematica, Tipo, Ciudad, id_reyes) 
VALUES ('01', 'Carroza Maravillosa', 'La maravillosa carroza ','Fantastica', 'Todoterreno', 'Sevilla', 'R0001'); 
INSERT INTO G10Proyecto.Carroza (id_carroza, Titulo, Descripcion, Tematica, Tipo, Ciudad, id_reyes)
VALUES ('02', 'Carroza Diabolica', 'La temible carroza del inframundo', 'Miedo', 'Tractor', 'Madrid', 'R0002');
INSERT INTO G10Proyecto.Pasacalle (id_pas, Titulo, Descripcion,Tematica, Instrumento, id_carroza)
VALUES ('001', 'Abraham', 'El encantador de serpientes','Fantastica', 'Flauta', '01');
INSERT INTO G10Proyecto.Pasacalle (id_pas, Titulo, Descripcion, Tematica, Instrumento, id_carroza)
VALUES ('002', 'Gohan', 'El diablo quemador', 'Miedo', 'Guitarra','02');
INSERT INTO G10Proyecto.Persona (Codigo, Nif, Nombre, Apellido,Direccion, Edad, Responsable)
VALUES ('P0001', '12345678X', 'Javi', 'Leuis', 'Calle la florentin', '23', '');
INSERT INTO G10Proyecto.Persona (Codigo, Nif, Nombre, Apellido, Direccion, Edad, Responsable)
VALUES ('P0002', '12345678L', 'Jacpo', 'Bernier', 'Calle la carbonara', '16', 'P0001');
INSERT INTO G10Proyecto.Desfila (Codigo, id_pas, Orden, Tiene_Rey)
VALUES ('P0001', '001', '01', 'S');
INSERT INTO G10Proyecto.Desfila (Codigo, id_pas, Orden, Tiene_Rey)
VALUES ('P0002', '002', '02', 'N');
INSERT INTO G10Proyecto.Ubica (Codigo, id_carroza, Menor_edad)
VALUES ('P0001', '001', 'N');
INSERT INTO G10Proyecto.Ubica (Codigo, id_carroza, Menor_edad)
VALUES ('P0002', '002', 'S');

-- 2. Crea una vista llamada “VGXreyes” que muestre el nombre de rey, la carroza en la que va sentado y el n.o de pajes que tiene.
CREATE VIEW G10Proyecto.VG10reyes AS
SELECT R.Nombre , C.Titulo, C.Num_Pajes
FROM G10Proyecto.Reyes R, G10Proyecto.Carroza C
WHERE R.id_reyes = C.id_reyes;

-- 3. Crea otra vista llamada VGXpasacalles que muestre el nombre de las personas que están en el pasacalle que se titula “xxx”.
CREATE VIEW G10Proyecto.VG10pasacalles AS
SELECT P.Nombre, P.Apellido
FROM G10Proyecto.Persona P, G10Proyecto.Desfila D,
G10Proyecto.Pasacalle PA
WHERE P.Codigo = D.Codigo
AND D.id_pas = PA.id_pas
AND PA.Titulo = 'pasacalles1';

-- 4. Haz que todos los usuarios del sistema puedan consultar esas vistas. Compruébalo con cualquier usuario)
GRANT SELECT ON G10Proyecto.VG10reyes TO PUBLIC;
GRANT SELECT ON G10Proyecto.VG10pasacalles TO PUBLIC;

-- 5. Crea una vista llamada VGXrepresenta en el esquema de “carlos” que Muestra nif,
-- nombre y apellido de la persona que representa a otra persona junto con el nombre y
-- apellido de la persona representada.
CREATE VIEW Carlos.VG10representa 
(NIF_REPRESENTANTE, REPRESENTANTE, APELLIDO_REPRESENTANTE, REPRESENTADO, APELLIDO_REPRESENTADO) AS 
SELECT p1.NIF, p1.NOMBRE, p1.APELLIDO, p2.NOMBRE, p2.APELLIDO
FROM G10PROYECTO.PERSONAS p1, G10PROYECTO.PERSONAS p2 
WHERE p1.RESPONSABLE = p2.CODIGO;

-- Con usuario Carlos(comoquieras2):
-- Le daremos los permisos especícos para evitar que tengan demasiados privilegios:
GRANT CREATE TABLE TO carlos;
GRANT SELECT ON G10Proyecto.Persona TO Carlos;
GRANT SELECT ON G10Proyecto.Ubica TO Carlos;
GRANT SELECT ON G10Proyecto.Carroza TO Carlos;
GRANT CREATE SEQUENCE TO Carlos;

-- 1. Crea una tabla llamada TGX que contenga nombre y apellido de la persona junto con título de la carroza y algún dato más.
CREATE TABLE TG10 (Nombre, Apellido, Titulo_Carroza, Ciudad) AS
SELECT Nombre, Apellido, Titulo, Ciudad 
FROM G10Proyecto.Persona P, G10Proyecto.Carroza C, G10Proyecto.Ubica U
WHERE C.id_Carroza=U.id_carroza AND P.Codigo=U.Codigo;

-- 2. Haz que esa tabla tenga un campo que sea clave primaria y añádele datos de la forma (1,2,3....) a través de una secuencia
ALTER TABLE TG10 ADD ID NUMBER(5) PRIMARY KEY;
ALTER TABLE TG10 ADD ID NUMBER(5);

CREATE SEQUENCE TG10_SEQ START WITH 1 INCREMENT BY 1;
GRANT CREATE SEQUENCE TO Carlos;

-- Con usuario G10Proyecto:
ALTER USER Carlos QUOTA 5M ON users;

-- Inserción de datos en la secuencia
INSERT INTO TG10 (Nombre, Apellido, Titulo_Carroza, Ciudad, ID)
VALUES ('Paco', 'Pérez', 'Carroza Re', 'Madrid',TG10_SEQ.NEXTVAL);
INSERT INTO TG10 (Nombre, Apellido, Titulo_Carroza, Ciudad, id)
VALUES ('María', 'Ordoñez', 'Carroza Fantasía', 'Sevilla',
TG10_SEQ.NEXTVAL);

-- 3. Realiza 2 consultas que usen group by y having.
-- Consulta 1: Número de personas por ciudad

SELECT Ciudad, COUNT(P.Codigo) AS Numero_Personas
FROM G10Proyecto.Carroza C,G10Proyecto.Persona P,
G10Proyecto.Ubica U WHERE P.Codigo = U.Codigo AND C.id_Carroza =
U.id_Carroza
GROUP BY Ciudad
HAVING COUNT(P.Codigo) > 1;

-- Consulta 2: Número de carrozas por título
SELECT Titulo, COUNT(*) AS Num_Carrozas
FROM G10Proyecto.Carroza
GROUP BY Titulo
HAVING COUNT(*) >= 1;

-- 4.Realiza 2 sentencias que usen update y otras dos que usen delete
-- Update 1: Cambiar la ciudad de una persona
UPDATE TG10 SET Ciudad = 'Barcelona' WHERE Nombre = 'Juan';

-- Update 2: Cambiar el título de la carroza
UPDATE TG10 SET Titulo_Carroza = 'Carroza Mágica' WHERE Ciudad = 'Sevilla';

-- Delete 1: Eliminar un registro por ID
DELETE FROM TG10 WHERE ID = 1;

-- Delete 2: Eliminar registros con una ciudad especíca
DELETE FROM TG10 WHERE Ciudad = 'Barcelona';

























