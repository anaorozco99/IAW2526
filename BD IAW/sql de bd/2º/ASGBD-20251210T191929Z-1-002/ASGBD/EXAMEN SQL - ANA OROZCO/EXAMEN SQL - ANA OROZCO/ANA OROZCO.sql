drop table actuan;
drop table actores;
drop table peliculas;
drop table directores;

create table directores(
    cod_dir char(9) constraint pk_dir primary key,
    nombre varchar2(20) not null,
    apellido varchar2(30),
    npremios number(2)
);

create table peliculas(
    cod_pel char(4) constraint pk_pel primary key,
    coste number(9,2),
    titulo varchar2(50) not null,
    genero varchar2(40) not null,
    duracion number(5),
    npremios number(3),
    fecha date,
    cod_dir char(9) constraint fk_pel_dic references directores,
    nominacion varchar2(20) constraint ck_pel_no check(nominacion in ('NOMINADO','GANADOR'))
);

create table actores(
    cod_actor char(9) constraint pk_act primary key,
    nombre varchar2(30) not null,
    apellido varchar2(60),
    salario number (10,2),
    cache number(9),
    npremios number(3),
    sexo varchar2(1) constraint in_act check(sexo in('H','M')),
    nominacion varchar2(20) constraint ck_ac_no check(nominacion in ('NOMINADO','GANADOR'))
);

create table actuan(
    cod_actor char(9) constraint fk_actu_act references actores,
    cod_pel char(4) constraint fk_actu_pel references peliculas,
    personaje varchar2(40),
    constraint pk_actu primary key (cod_pel,cod_actor)
);



REM DIRECTORES
insert into directores values ('11111112A', 'Salvador Calvo', 'Rodríguez', 2);
insert into directores values ('22222223B', 'Calvo Sotelo', 'Ramírez', 1);
insert into directores values ('33333334C', 'Pedro Picapiedra', 'Picaposte', 4);
insert into directores values ('44444445D', 'Pedro Manola', 'Naprawa', 2);
insert into directores values ('55555556E', 'Lola', 'García', 7);
insert into directores values ('66666667F', 'Juan', 'González', 1);
insert into directores values ('77777778G', 'Nicolás Piedrahita', 'Sánchez', '0');
insert into directores values ('88888889H', 'Manolo', 'PiesDeBronce', 5);
insert into directores values ('99999990I', 'Enrique', 'Pisada', 3);
insert into directores values ('11111113J', 'Luna', 'Clark', 0);


REM PELICULAS
insert into peliculas values ('0001',3500000, 'Operación camarón', 'Comedia', 120, 3, '7/8/2013', '11111112A', 'GANADOR');
insert into peliculas values ('0002', 1800000, 'Anacleto:Agente Secreto', 'Acción', 100, 0, '7/8/2013', '22222223B', 'NOMINADO');
insert into peliculas values ('0003', 1000000, 'Platero', 'Ciencia Ficción', 60, 0, '1/3/2013', '55555556E', 'NOMINADO');
insert into peliculas values ('0004', 2100000, '8 apellido andaluze', 'Romántico', 80, 2, '17/5/2016', '11111112A', 'GANADOR');
insert into peliculas values ('0005', 4300000, 'Catalán rastrero', 'Drama', 180, 4, '17/5/2016', '66666667F', 'GANADOR');
insert into peliculas values ('0006',1500000, 'Pipas al poder', 'Ciencia Ficción', 100, 4, '2/9/2017', '33333334C', 'GANADOR');
insert into peliculas values ('0007', 1700000, 'Titán de miel', 'Acción', 100, 0, '5/11/2016', '44444445D', 'NOMINADO');
insert into peliculas values ('0008', 1020000, 'Manolito pies de plata', 'Drama', 60, 0, '9/4/2011', '88888889H', 'NOMINADO');
insert into peliculas values ('0009', 2100000, 'Enrique Manoplas', 'Romántico', 80, 2, '18/6/2012', '77777778G', 'GANADOR');
insert into peliculas values ('0010', 4500000, 'Catalán rastrero 2', 'Drama', 180, 3, '21/5/2010', '66666667F', 'GANADOR');
insert into peliculas values ('0011', 2500000, 'La pizza Voladora', 'Ciencia Ficción', 180, 1, '21/5/2023', '33333334C', 'NOMINADO');

REM ACTORES
insert into actores values ('11111111A', 'Pedro', 'García', 12000.01, 30000, 4, 'H', 'GANADOR');
insert into actores values ('22222222B', 'Rocío', 'Valdelagrana', 13000.02, 20000, 0, 'M', 'NOMINADO');
insert into actores values ('33333333C', 'Juan', 'Pérez', 14000.03, 50000, 0, 'H', 'NOMINADO');
insert into actores values ('44444444D', 'Nicolás', 'Valverde', 15000.04, 10000, 1, 'H', 'GANADOR');
insert into actores values ('55555555E', 'Mia', 'Johansson', 16000.06, 60000, 2, 'H', 'GANADOR');
insert into actores values ('66666666F', 'Lana', 'Rhoades', 17000.07, 15000, 3, 'M', 'GANADOR');
insert into actores values ('77777777G', 'Torrente', 'Torrente', 18000.08, 30000, 0, 'H', 'NOMINADO');
insert into actores values ('88888888H', 'Sergio', 'Ramos', 19000.09, 12000, 3, 'H', 'GANADOR');
insert into actores values ('99999999J', 'Jennifer', 'Malkova', 45210.95, 84010, 0, 'M', 'NOMINADO');
insert into actores values ('12345678P', 'Robert', 'Anthony de Niro', 29000.99, 42000, 0, 'H', 'NOMINADO');

REM ACTUAN
insert into actuan values('11111111A','0001','Camarón');
insert into actuan values('22222222B','0002','Anacleta');
insert into actuan values('33333333C','0003','Burro');
insert into actuan values('44444444D','0004','Pedro Sanchez');
insert into actuan values('55555555E','0005','Assumpció');
insert into actuan values('66666666F','0006','Grefusa Man');
insert into actuan values('44444444D','0006','Sevillana con sal');
insert into actuan values('77777777G','0007','Torrente');
insert into actuan values('88888888H','0008','Manolito');
insert into actuan values('99999999J','0009','Pepa Manoplas');
insert into actuan values('11111111A','0009','Pepe Manotazo');
insert into actuan values('12345678P','0010','Biel');

commit;


/*EXAMEN*/

/*Parte 2*/
 
 /*A*/
 
REM CREAMOS ROL Y OTORGAMOS PERMISOS AL ROL

CREATE ROLE ROLOROZCO;
GRANT SELECT ON OROZCO.DIRECTORES TO ROLOROZCO;
GRANT SELECT ON OROZCO.PELICULAS TO ROLOROZCO;
GRANT SELECT ON OROZCO.ACTORES TO ROLOROZCO;
GRANT SELECT ON OROZCO.ACTUAN TO ROLOROZCO;

GRANT UPDATE (CACHE) ON OROZCO.ACTORES TO ROLOROZCO;
GRANT UPDATE (SALARIO) ON OROZCO.ACTORES TO ROLOROZCO;

GRANT INSERT ON OROZCO.ACTORES TO ROLOROZCO;

REM LE DAMOS EL ROL A ASENSIO
GRANT ROLOROZCO TO ASENSIO;

/*B*/
REM B1- CON ADMIN DI PERMISOS DE CREAR VISTA Y ESTA SE EJECUTA CON ASENSIO
CREATE VIEW VDIRIGE (NOMBRE,APELLIDO, NPELICULAS) AS;
SELECT D.NOMBRE, D.APELLIDO, COUNT(P.COD_PEL)
FROM OROZCO.DIRECTORES D, OROZCO.PELICULAS P
WHERE D.COD_DIR=P.COD_DIR
GROUP BY NOMBRE,APELLIDO;


REM B2
UPDATE OROZCO.ACTORES SET (SALARIO, CACHE) = (
SELECT SALARIO, CACHE 
FROM OROZCO.ACTORES A, OROZCO.ACTUAN AC
WHERE A.COD_ACTOR=AC.COD_ACTOR
AND UPPER(PERSONAJE)='ASSUMPCIÓ')
WHERE COD_ACTOR IN(
SELECT COD_ACTOR 
FROM OROZCO.ACTORES 
WHERE SALARIO < 15000);

SELECT * FROM OROZCO.ACTORES;

REM B3
-

REM B4
CREATE TABLE TPELICULAS (NOMACT, TITULOPEL, NOMDIR)
AS (
SELECT A.NOMBRE, P.TITULO, D.NOMBRE AS NOMDIR
FROM OROZCO.ACTORES A, OROZCO.PELICULAS P, OROZCO.ACTUAN AC,OROZCO.DIRECTORES D
WHERE AC.COD_ACTOR=A.COD_ACTOR
AND AC.COD_PEL=P.COD_PEL);

SELECT * FROM TPELICULAS;


REM B5
DELETE OROZCO.PELICULAS WHERE COD_PEL NOT IN(
SELECT AC.COD_PEL FROM OROZCO.PELICULAS P, OROZCO.ACTORES A, OROZCO.ACTUAN AC 
WHERE AC.COD_ACTOR=A.COD_ACTOR
AND AC.COD_PEL=P.COD_PEL);


REM ASÍ VEMOS EL COD_PEL QUE NO APARECE EN TABLA ACTUAR
SELECT COD_PEL FROM OROZCO.PELICULAS WHERE COD_PEL NOT IN(
SELECT AC.COD_PEL FROM OROZCO.PELICULAS P, OROZCO.ACTORES A, OROZCO.ACTUAN AC 
WHERE AC.COD_ACTOR=A.COD_ACTOR
AND AC.COD_PEL=P.COD_PEL)

REM VEMOS SI HAY ACTORES QUE NO ACTUEN -- NO SIRVE EN ESTE APARTADO 
SELECT COD_ACTOR FROM OROZCO.ACTUAN WHERE COD_ACTOR NOT IN (
SELECT AC.COD_ACTOR FROM OROZCO.PELICULAS P, OROZCO.ACTORES A, OROZCO.ACTUAN AC 
WHERE AC.COD_ACTOR=A.COD_ACTOR
AND AC.COD_PEL=P.COD_PEL)



/*PARTE 1*/

REM PREGUNTA 1

/*A*/

CREATE TABLE CONDUCTOR (
COD_MEC NUMBER(9),
NOMBRE VARCHAR(10),
CONSTRAINT COD_MEC_PK PRIMARY KEY(COD_MEC),
CONSTRAINT NOMBRE_MAYUS_CK CHECK (NOMBRE = UPPER(NOMBRE))
);

CREATE TABLE TAXI (
MATRICULA VARCHAR2(10),
MARCA VARCHAR2(10) NOT NULL,
COLOR VARCHAR (10),
COD_MEC NUMBER(9),
CONSTRAINT MATRICULA_PK PRIMARY KEY (MATRICULA),
CONSTRAINT COD_MEC_TAXI_FK FOREIGN KEY (COD_MEC) 
REFERENCES CONDUCTOR(COD_MEC),
CONSTRAINT MARCA_CK CHECK (MARCA IN ('TOYOTA', 'SEAT'))
);


/*B*/

ALTER TABLE TAXI DROP CONSTRAINT MATRICULA_PK;
ALTER TABLE TAXI ADD CONSTRAINT MATRI_MEC_PK
PRIMARY KEY (MATRICULA, COD_MEC);

ALTER TABLE TAXI ADD (FECHA DATE);

alter session set nls_date_format='DD/MM/YYYY';

INSERT INTO CONDUCTOR VALUES (123456789, 'ANA');
INSERT INTO TAXI VALUES ('8760HTY', 'TOYOTA','ROJO', 123456789 , SYSDATE);
