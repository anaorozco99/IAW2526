
REM *** Creacion tablas

create table fabricante(
  id_fab number(2)  constraint pk_fab primary key,
  nombre varchar2(50),
  pais   varchar2(30))
  TABLESPACE DATOS;

create table programa(
  codigo number(2) constraint pk_prog primary key,
  nombre varchar2(50),
  version varchar2(50))
  TABLESPACE DATOS;

create table desarrolla(
  id_fab number(2),
  codigo number(2),
  constraint pk_des primary key(id_fab,codigo))
  TABLESPACE DATOS;

alter table desarrolla
add constraint fk_des_fab foreign key (id_fab) references fabricante
add constraint fk_des_prg foreign key(codigo) references programa;

REM *** Inserción de datos

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

