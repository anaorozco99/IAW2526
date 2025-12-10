Parte 1:

Pregunta 1.-

GRANT CREATE any table TO julia;
GRANT CREATE any index TO julia;

GRANT SELECT, INSERT ON julio.editorial TO julia;
GRANT SELECT, INSERT ON julio.libro TO julia;

ALTER USER julio QUOTA 20M ON datos;

GRANT ALTER ON julio.libro TO julia;
GRANT DROP any index TO julia;


Pregunta 2.-

DROP TABLE julio.editorial CASCADE CONSTRAINTS;
DROP TABLE julio.libro CASCADE CONSTRAINTS;

CREATE TABLE julio.editorial (
  codigo  CHAR(5) CONSTRAINT pk_editorialj PRIMARY KEY,
  nombre  VARCHAR2(25) NOT NULL CONSTRAINT nombre_edi check (nombre IN ('ANAYA','SANTILLANA','SM'))
) TABLESPACE DATOS;

CREATE TABLE julio.libro (
  isbn  CHAR(13) CONSTRAINT pk_libro PRIMARY KEY,
  titulo  VARCHAR2(25) NOT NULL,
  editorial char(5) not null constraint fk_libro references  JULIO.EDITORIAL,
  fec_edi date
) TABLESPACE DATOS;

alter session set nls_date_format='DD/MM/YYYY';


INSERT INTO julio.editorial VALUES ('edit1','ANAYA');
INSERT INTO julio.editorial VALUES ('edit2','SANTILLANA');
INSERT INTO julio.libro VALUES ('978-123456789','libro1','edit1','10/10/2019');

ALTER USER julio DEFAULT TABLESPACE datos;
ALTER TABLE julio.libro DROP CONSTRAINT pk_libro;
ALTER TABLE julio.libro ADD (CONSTRAINT pk_libro PRIMARY KEY (isbn,fec_edi));

INSERT INTO JULIO.LIBRO VALUES ('978-123456789','libro1','edit1',SYSDATE);


Pregunta 3.-

SELECT table_name, tablespace_name
FROM user_tables;

select table_name, tablespace_name, owner from all_tables;

SELECT c.table_name, c.constraint_name, c.column_name, a.search_condition
from user_cons_columns c, user_constraints a
where c.constraint_name = a.constraint_name
and constraint_type = 'C';



Parte 2:

Pregunta 4-

GRANT CREATE role TO julia; 
GRANT CREATE view TO julia WITH ADMIN OPTION;
GRANT CREATE synonym TO julia WITH ADMIN OPTION;

CREATE USER practica3 IDENTIFIED BY Oracle2024;
GRANT CREATE SESSION TO practica3;


Pregunta 5.-

CREATE TABLE fabricante(
  id_fab number(3)  constraint pk_fab primary key,
  nombre varchar2(50),
  pais   varchar2(50))
  TABLESPACE DATOS;

CREATE TABLE programa(
  codigo number(3) constraint pk_prog primary key,
  nombre varchar2(50),
  version varchar2(50))
  TABLESPACE DATOS;

CREATE TABLE desarrolla(
  id_fab number(3),
  codigo number(3),
  constraint pk_des primary key(id_fab,codigo))
  TABLESPACE DATOS;

ALTER TABLE desarrolla
ADD CONSTRAINT fk_des_fab foreign key (id_fab) REFERENCES fabricante
ADD CONSTRAINT fk_des_prg foreign key(codigo) REFERENCES programa;

REM insercion de los datos del script
insert into fabricante values(1,'Oracle','Estados Unidos');
insert into fabricante values(2,'Microsoft','Estados Unidos');
insert into fabricante values(3,'IBM','Estados Unidos');
insert into fabricante values(4,'Dinamic','España');
insert into fabricante values(5,'Borland','Estados Unidos');
insert into fabricante values(6,'Symantec','Estados Unidos');

insert into programa values(1,'Application Server','9i');
insert into programa values(2,'Database','8i');
insert into programa values(3,'Database','9i');
insert into programa values(4,'Database','10g');
insert into programa values(5,'Developer','6i');
insert into programa values(6,'Access','97');
insert into programa values(7,'Access','2000');
insert into programa values(8,'Access','XP');
insert into programa values(9,'Windows','98');
insert into programa values(10,'Windows','XP Professional');
insert into programa values(11,'Windows','XP Home Edition');
insert into programa values(12,'Windows','2003 Server');
insert into programa values(13,'Norton Internet Security','2004');
insert into programa values(14,'Freddy Hardest',NULL);
insert into programa values(15,'Paradox','2');
insert into programa values(16,'C++ Builder','5.5');
insert into programa values(17,'DB/2','2.0');
insert into programa values(18,'OS/2','1.0');
insert into programa values(19,'JBuilder','X');
insert into programa values(20,'La prision','1.0');

insert into desarrolla values(1,1);
insert into desarrolla values(1,2);
insert into desarrolla values(1,3);
insert into desarrolla values(1,4);
insert into desarrolla values(1,5);
insert into desarrolla values(2,6);
insert into desarrolla values(2,7);
insert into desarrolla values(2,8);
insert into desarrolla values(2,9);
insert into desarrolla values(2,10);
insert into desarrolla values(2,11);
insert into desarrolla values(2,12);
insert into desarrolla values(6,13);
insert into desarrolla values(4,14);
insert into desarrolla values(5,15);
insert into desarrolla values(5,16);
insert into desarrolla values(3,17);
insert into desarrolla values(3,18);
insert into desarrolla values(5,19);
insert into desarrolla values(4,20);


Pregunta 6.-


CREATE ROLE roljulia;

GRANT SELECT ON Fabricante TO roljulia;
GRANT SELECT ON Programa TO roljulia;
GRANT SELECT ON Desarrolla TO roljulia;

GRANT INSERT ON Fabricante TO roljulia;

GRANT UPDATE (version) ON Programa TO roljulia;

GRANT CREATE VIEW TO roljulia;
GRANT CREATE SYNONYM TO roljulia;

GRANT roljulia TO practica3;


Pregunta 7.



































