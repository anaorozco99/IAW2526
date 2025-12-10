Drop table cientifico cascade constraints;
DROP TABLE PROYECTO CASCADE CONSTRAINTS;
DROP TABLE ASIGNA CASCADE CONSTRAINTS;

CREATE TABLE cientifico (
  NIF CHAR(9) CONSTRAINT PK_CIENTIF PRIMARY KEY,
  NOMBRE VARCHAR2(25) NOT NULL,
  APELLIDO VARCHAR2(50) NOT NULL,
  CIUDAD VARCHAR2(25),
  DIRECCIONCALLE VARCHAR2(50),
  DIRECCIONNUM CHAR(3),
  TELEFONO CHAR(9),
  FECHANACIMIENTO DATE,
  VARON CHAR(1) CONSTRAINT CK_VARON2 CHECK  (VARON IN ('S','N'))
  );

CREATE TABLE PROYECTO(
CODIGO CHAR(3) CONSTRAINT PK_PROY PRIMARY KEY,
NOMBRE VARCHAR2(15),
HORAS NUMBER(3,0)
);

CREATE TABLE ASIGNA (
 nif CHAR(9) CONSTRAINT FK_AS_CIEN REFERENCES CIENTIFICO,
 codigo CHAR(3) CONSTRAINT FK_AS_PR REFERENCES PROYECTO,
 PRIMARY KEY (nif, codigo)
);
 
INSERT INTO CIENTIFICO
VALUES('16161616A','Luis','Ramirez','Haro','Pez','34','941111111','1/1/69','S');
INSERT INTO CIENTIFICO 
VALUES('17171717A','Laura','Beltran','Madrid','Gran Via','23','912121212','8/8/74','N');
INSERT INTO CIENTIFICO
VALUES('18181818A','Pepe','Perez','Madrid','Percebe','13','913131313','2/2/80','N');
INSERT INTO CIENTIFICO
VALUES('19191919A','Juan','Sanchez','Bilbao','Melancolia','7','944141414','3/3/66','S');
INSERT INTO CIENTIFICO
VALUES('20202020A','Luis','Jimenez','Sevilla','Cigena','15','941151515','3/3/79','S');
INSERT INTO CIENTIFICO
VALUES('21212121A','Rosa','Garcia','Huelva','Alegria','16','941161616','4/4/78','N');
INSERT INTO CIENTIFICO
VALUES('23232323A','Jorge','Saenz','Sevilla','Luis Ulloa','17','941171717','9/9/78','S');
INSERT INTO CIENTIFICO
VALUES('24242424A','Maria','Gutierrez','Sevilla','Avda. de la Paz','18','941181818','10/10/64','N');
INSERT INTO CIENTIFICO
VALUES('25252525A','Rosario','Diaz','Huelva','Percebe','19','941191919','11/11/71','N');
INSERT INTO CIENTIFICO
VALUES('26262626A','Elena','Gonzalez','Cadiz','Percebe','20','941202020','5/5/75','N');
insert into proyecto values ('111', 'PROYECTO1',110);
insert into proyecto values ('222', 'PROYECTO2',10);
insert into proyecto values ('333', 'PROYECTO3',235);
insert into proyecto values ('444', 'PROYECTO4',30);
insert into proyecto values ('555', 'PROYECTO5',50);
insert into proyecto values ('666', 'PROYECTO6',200);
insert into proyecto values ('777', 'PROYECTO7','');
insert into asigna values ('16161616A','222');
insert into asigna values ('16161616A','333');
insert into asigna values ('17171717A','222');
insert into asigna values ('17171717A','444');
insert into asigna values ('18181818A','111');
insert into asigna values ('18181818A','333');
insert into asigna values ('19191919A','666');
insert into asigna values ('21212121A','666');
insert into asigna values ('24242424A','111');
insert into asigna values ('24242424A','666');
insert into asigna values ('25252525A','666');
commit;






