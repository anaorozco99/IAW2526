drop table alumnos cascade constraints;
drop table instructores cascade constraints;
drop table clases cascade constraints;
drop table asistencias cascade constraints;
drop table pagos cascade constraints;

/*Creación de la tabla de alumnos*/
CREATE TABLE alumnos (
    codigo NUMBER(6) CONSTRAINT PK_ALUMNOS PRIMARY KEY ,
    nombre VARCHAR2(30),
    apellido VARCHAR2(30),
    fec_nac DATE,
    direccion VARCHAR2(30),
    telefono VARCHAR2(11),
    nivel char(1) CONSTRAINT CK_TIPO CHECK(nivel IN ('P','I','A'))
  );

/*Creación de la tabla de Instructores*/
CREATE TABLE instructores (
    codigo NUMBER(6) cONSTRAINT PK_INST PRIMARY KEY,
    nombre VARCHAR2(30),
    apellido VARCHAR2(30),
    sueldo_mes number(7,2)
);

/*Creación de la tabla de Clases*/
CREATE TABLE clases (
    codigo VARCHAR2 (6) CONSTRAINT PK_CL PRIMARY KEY ,
    nombre VARCHAR2(30),
    dia VARCHAR2(13),
    hora_inicio VARCHAR2(14),
    id_instructor NUMBER(6) CONSTRAINT FK_CL_INST REFERENCES INSTRUCTORES
);

/*Creación de la tabla de Asistencias*/
CREATE TABLE asistencias (
    id_asistencia NUMBER(4) CONSTRAINT PK_ASIS PRIMARY KEY,
    fecha DATE,
    id_alumno NUMBER(6) CONSTRAINT FK_ASIS_ALUMNO REFERENCES ALUMNOS,
    id_clase VARCHAR2(6) CONSTRAINT FK_ASIS_CLASE REFERENCES clases
);

/*Creación de la tabla de Pagos*/
CREATE TABLE pagos (
    fecha DATE,
    alumno number (6)  CONSTRAINT FK_PAG_AL REFERENCES ALUMNOS,
    clase varchar2(6) CONSTRAINT FK_PAG_CLASE REFERENCES CLASES,
    cuota number (7,2),
    CONSTRAINT PK_PAG PRIMARY KEY (fecha,alumno,clase)
);

alter session set nls_date_format='dd/mm/yyyy';

insert into  alumnos values(12345,'Ivan','Perez Gomez','12/02/1999','Calle Betis 23, 1A','6176995','I');
insert into  alumnos values(21345,'Rocio','Garrido Alvarez','2/05/2000','Plaza Alfalfa 12, 6A','6087587','A');
insert into  alumnos values(31245,'David','Ruiz Luna','01/07/2004','Calle Solea 1, 4C','6818789','I');
insert into  alumnos values(41235,'Marcos','Molina Ruiz','05/10/2005','Calle Arroyo 2, 3B','7221653','P');
insert into  alumnos values(51234,'Antonio','Gutierrez Fernandez','08/09/2006', 'Carretera Carmona 12, 6C','6065598','A');
insert into  alumnos values(52134,'Carlos','Navarro Lopez','23/02/1990','Avenida de la Palmera 4, 1A','6328039','I');
insert into  alumnos values(71234,'Lola','Perez Perez', '10/03/2000','Calle Arroyo, 80','632565236','P');

insert into instructores values (82997,'Maria','Jimenez Mendoza', 1200);
insert into instructores values (42949,'Alex','Carrero Garcia',1400.5);
insert into instructores values (71620,'Josefina','Rufino Hernandez',1200);
insert into instructores values (18146,'Xavi','Fernandez Cuevas',1200);
insert into instructores values (48436,'Bibiana','Rodriguez Leal',1400.5);
insert into instructores values (69974,'Francisco','Maestre LLamas',1100);
insert into instructores values (30192,'Nieves','Sanchez Luna',500);


insert into clases values ('C1','Karate','Miercoles','17:00',82997);
insert into clases values ('C2','Judo','Lunes','20:00',42949);
insert into clases values ('C3','Kung-fu','Viernes','16:00',30192);
insert into clases values ('C4','Boxeo','Viernes','17:00',18146);
insert into clases values ('C5','Jiu-jitsu','Miercoles','12:00',82997);
insert into clases values ('C6','Capoeira','Viernes','17:00',30192);
insert into clases values ('C7','Muay Thai','Miercoles','17:00',48436);
insert into clases values ('C8','Krav Maga','Lunes','23:00',82997);
insert into clases values ('C9','Kendo', 'Lunes','17:30',69974);
insert into clases values ('C10','Aikido','Lunes','18:30',71620);
insert into clases values ('C11','Taekwondo','Miercoles','17:00',42949);


insert into asistencias values (1,'12/04/2023',12345,'C11');
insert into asistencias values (2,'06/07/2020',21345,'C1');
insert into asistencias values (3,'12/04/2023',21345,'C1');
insert into asistencias values (4,'06/07/2020',41235,'C7');
insert into asistencias values (5,'06/07/2020',31245,'C6');
insert into asistencias values (6,'28/01/2022',52134,'C9');
insert into asistencias values (7,'05/07/2021',12345,'C11');
insert into asistencias values (8,'12/04/2023',52134,'C10');
insert into asistencias values (9,'12/04/2023',51234,'C8');
insert into asistencias values (10,'20/03/2024',41235,'C7');
insert into asistencias values (11,'05/07/2021',31245,'C6');
insert into asistencias values (12,'20/03/2024',12345,'C11');
insert into asistencias values (13,'05/07/2021',21345,'C1');

Insert into pagos values ('25/12/2020',12345,'C11',50.20);
Insert into pagos values ('23/04/2024',31245,'C6',34.40);
Insert into pagos values ('23/04/2024',51234,'C8',45.60);
Insert into pagos values ('25/12/2020',51234,'C8',60.20);
Insert into pagos values ('29/01/2022',21345,'C1',70.20);
Insert into pagos values ('20/07/2021',51234,'C8',56.90);
Insert into pagos values ('29/01/2022',31245,'C6',67.80);
Insert into pagos values ('20/07/2021',52134,'C10',72.30);
Insert into pagos values ('20/07/2021',71234,'C10',65.40);
Insert into pagos values ('23/04/2023',21345,'C1',60.00);
Insert into pagos values ('25/12/2020',52134,'C9',34.56);
Insert into pagos values ('20/07/2021',12345,'C11',45.45);
Insert into pagos values ('29/01/2022',51234,'C8',67.80);
Insert into pagos values ('29/01/2024',31245,'C6',57.90);
Insert into pagos values ('25/12/2020',31245,'C6',73.45);
Insert into pagos values ('23/04/2024',21345,'C1',44.80);
Insert into pagos values ('25/12/2023',12345,'C11',78.67);

commit;

rem 1-

create table Tasistencia as
select a.nombre, a.apellido, i.nombre "Instructor", c.nombre "Clase"
from alumnos a, instructores i, clases c, asistencias asi
where c.id_instructor=i.codigo and asi.id_alumno=a.codigo and asi.id_clase=c.codigo
and fecha  between '01/01/2020' and '31/12/2020';


rem 2-

select distinct i.nombre, i.sueldo_mes 
from instructores i, alumnos a, clases c
where c.id_instructor=i.codigo and upper(nivel)='A';


rem 3-
select i.nombre, i.apellido
from instructores i, clases c, asistencias asi, alumnos a
where asi.id_alumno=a.codigo and asi.id_clase=c.codigo 
group by i.nombre, i.apellido
having max(id_asistencia);

rem 4-
create table tviernes_1 as
select distinct c.nombre "Clase", a.nombre "Nombre Alumno", a. apellido
from clases c, alumnos a, asistencias asi
where asi.id_clase=c.codigo and asi.id_alumno=a.codigo and
upper(a.nivel)='I' and upper(c.dia)='VIERNES';


rem 5-

create table Tpago as
select nombre, apellido, SUM(cuota) "Cuota"
from alumnos a, pagos p
where p.alumno=a.codigo
group by nombre, apellido;


rem 6-

insert into clases 
select 'C12', 'TaiChi', dia, hora_inicio, id_instructor
from 



rem 8-
insert into alumnos
select 22222, 'Juan',  'Malos Pelos', fec_nac, direccion, telefono, nivel
from alumnos a, asistencias asi, clases c
where asi.id_alumno=a.codigo and asi.id_clase=c.codigo 
and asi.fecha='20/03/2024' and upper(c.nombre)='TAEKWONDO';


rem 9-
update alumnos 
set direccion = 
(select direccion from alumnos where upper(nombre)='DAVID')
where upper(nombre)='MARCOS';

rem 10-
update instructores
set sueldo_mes=sueldo_mes-200 
where codigo in(select id_instructor 
from clases c, asistencias asi, alumnos a
where asi.id_clase=c.codigo and asi.id_alumno=a.codigo
group by id_instructor
having count(id_alumno)<2);

rem 11- me daba error con upper

update alumnos
set nivel='P'
where codigo IN (
select codigo
from alumnos a, asistencias asi
where asi.id_alumno=a.codigo
group by codigo
having count(id_alumno)<2);



rem 12-

ALTER TABLE pagos DROP CONSTRAINT FK_PAG_AL;

ALTER TABLE pagos ADD CONSTRAINT FK_pago_al FOREIGN KEY (alumno)
REFERENCES alumnos (codigo) on delete cascade;

delete from alumnos
where codigo not in (select id_alumno from asistencias);


rem 13-

ALTER TABLE clases DROP CONSTRAINT FK_CL_INST;

ALTER TABLE clases ADD CONSTRAINT FK_CL_INST FOREIGN KEY (id_instructor)
REFERENCES instructores (codigo) on delete cascade;

delete instructores
where codigo =(
select codigo 
from instructores 
where upper(apellido) like 'MAESTRE %');









