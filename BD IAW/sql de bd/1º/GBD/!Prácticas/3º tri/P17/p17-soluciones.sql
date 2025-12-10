drop table actuar;
drop table actor;
drop table pelicula;
drop table director;

create table director(
    nif char(9) constraint pk_dir primary key,
    nombre varchar2(20) not null,
    apellido varchar2(30),
    npremios number(2)
);

create table pelicula(
    codigo char(4) constraint pk_pel primary key,
    coste number(9,2),
    titulo varchar2(50) not null,
    genero varchar2(40) not null,
    duracion number(5),
    npremios number(3),
    fecha date,
    director char(9) constraint fk_pel_dic references director,
    nominacion varchar2(20) constraint ck_pel_no check(nominacion in ('NOMINADO','GANADOR'))
);

create table actor(
    nif char(9) constraint pk_act primary key,
    nombre varchar2(30) not null,
    apellido varchar2(60),
    salario number (10,2),
    cache number(9),
    npremios number(3),
    sexo varchar2(1) constraint in_act check(sexo in('H','M')),
    nominacion varchar2(20) constraint ck_ac_no check(nominacion in ('NOMINADO','GANADOR'))
);

create table actuar(
    nif char(9) constraint fk_actu_act references actor,
    codigo_pelicula char(4) constraint fk_actu_pel references pelicula,
    personaje varchar2(40),
    constraint pk_actu primary key (codigo_pelicula,nif)
);








REM DIRECTOR
insert into director values ('11111112A', 'Salvador Calvo', 'Rodríguez', 2);
insert into director values ('22222223B', 'Calvo Sotelo', 'Ramírez', 1);
insert into director values ('33333334C', 'Pedro Picapiedra', 'Picaposte', 4);
insert into director values ('44444445D', 'Pedro Manola', 'Naprawa', 2);
insert into director values ('55555556E', 'Lola', 'García', 7);
insert into director values ('66666667F', 'Juan', 'González', 1);
insert into director values ('77777778G', 'Nicolás Piedrahita', 'Sánchez', '0');
insert into director values ('88888889H', 'Manolo', 'PiesDeBronce', 5);
insert into director values ('99999990I', 'Enrique', 'Pisada', 3);
insert into director values ('11111113J', 'Luna', 'Clark', 0);


REM PELICULAS
insert into pelicula values ('0001',3500000, 'Operación camarón', 'Comedia', 120, 3, '7/8/2013', '11111112A', 'GANADOR');
insert into pelicula values ('0002', 1800000, 'Anacleto:Agente Secreto', 'Acción', 100, 0, '7/8/2013', '22222223B', 'NOMINADO');
insert into pelicula values ('0003', 1000000, 'Platero', 'Ciencia Ficción', 60, 0, '1/3/2013', '55555556E', 'NOMINADO');
insert into pelicula values ('0004', 2100000, '8 apellido andaluze', 'Romántico', 80, 2, '17/5/2016', '11111112A', 'GANADOR');
insert into pelicula values ('0005', 4300000, 'Catalán rastrero', 'Drama', 180, 4, '17/5/2016', '66666667F', 'GANADOR');
insert into pelicula values ('0006',1500000, 'Pipas al poder', 'Ciencia Ficción', 100, 4, '2/9/2017', '33333334C', 'GANADOR');
insert into pelicula values ('0007', 1700000, 'Titán de miel', 'Acción', 100, 0, '5/11/2016', '44444445D', 'NOMINADO');
insert into pelicula values ('0008', 1020000, 'Manolito pies de plata', 'Drama', 60, 0, '9/4/2011', '88888889H', 'NOMINADO');
insert into pelicula values ('0009', 2100000, 'Enrique Manoplas', 'Romántico', 80, 2, '18/6/2012', '77777778G', 'GANADOR');
insert into pelicula values ('0010', 4500000, 'Catalán rastrero 2', 'Drama', 180, 3, '21/5/2010', '66666667F', 'GANADOR');
insert into pelicula values ('0011', 2500000, 'La pizza Voladora', 'Ciencia Ficción', 180, 1, '21/5/2023', '33333334C', 'NOMINADO');

REM ACTORES
insert into actor values ('11111111A', 'Pedro', 'García', 12000.01, 30000, 4, 'H', 'GANADOR');
insert into actor values ('22222222B', 'Rocío', 'Valdelagrana', 13000.02, 20000, 0, 'M', 'NOMINADO');
insert into actor values ('33333333C', 'Juan', 'Pérez', 14000.03, 50000, 0, 'H', 'NOMINADO');
insert into actor values ('44444444D', 'Nicolás', 'Valverde', 15000.04, 10000, 1, 'H', 'GANADOR');
insert into actor values ('55555555E', 'Mia', 'Johansson', 16000.06, 60000, 2, 'H', 'GANADOR');
insert into actor values ('66666666F', 'Lana', 'Rhoades', 17000.07, 15000, 3, 'M', 'GANADOR');
insert into actor values ('77777777G', 'Torrente', 'Torrente', 18000.08, 30000, 0, 'H', 'NOMINADO');
insert into actor values ('88888888H', 'Sergio', 'Ramos', 19000.09, 12000, 3, 'H', 'GANADOR');
insert into actor values ('99999999J', 'Jennifer', 'Malkova', 45210.95, 84010, 0, 'M', 'NOMINADO');
insert into actor values ('12345678P', 'Robert', 'Anthony de Niro', 29000.99, 42000, 0, 'H', 'NOMINADO');

REM ACTUAR
insert into actuar values('11111111A','0001','Camarón');
insert into actuar values('22222222B','0002','Anacleta');
insert into actuar values('33333333C','0003','Burro');
insert into actuar values('44444444D','0004','Pedro Sanchez');
insert into actuar values('55555555E','0005','Assumpció');
insert into actuar values('66666666F','0006','Grefusa Man');
insert into actuar values('44444444D','0006','Sevillana con sal');
insert into actuar values('77777777G','0007','Torrente');
insert into actuar values('88888888H','0008','Manolito');
insert into actuar values('99999999J','0009','Pepa Manoplas');
insert into actuar values('11111111A','0009','Pepe Manotazo');
insert into actuar values('12345678P','0010','Biel');

commit;


rem !!!!! delete y update: en la subconsulta se puede hacer combinacion de tablas FUERA NO

/*1. Crea una tabla llamada Tdirige que contenga Nombre y apellido del director y no de
películas que ha dirigido*/

create table Tdirige as
select d.nombre, d.apellido, count(p.codigo) "Nº peliculas"
from director d, pelicula p
where d.nif = p.director
group by nombre, apellido;
rem --- hay q poner group by porque hay un count (es una operacion de conjunto)
rem --- en create table si se pone count hay q darle un alias a esa columna

create table Tdirige (nombre, apelllidos,npeliculas)as
select d.nombre, d.apellido, count(p.codigo) 
from director d, pelicula p
where d.nif = p.director
group by nombre, apellido;

/*2. Crea una tabla llamada Tactor que contenga nombre, apellido del actor que ha actuado en la
pelicula del director que ha recibido mas premios*/

create table tactor as
select nombre, apellido
from actor a, pelicula p, actuar ac
where a.nif=ac.nif and ac.codigo_pelicula=p.codigo and p.codigo=
(select codigo from pelicula where director=(select nif from director where npremios= (select  max(npremios) from director)));


rem otro método:
CREATE TABLE Tactor AS
SELECT NOMBRE, APELLIDO
FROM ACTOR
WHERE NIF = (SELECT NIF FROM ACTUAR WHERE CODIGO_PELICULA = 
(SELECT CODIGO FROM PELICULA WHERE DIRECTOR IN 
(SELECT NIF FROM DIRECTOR WHERE NPREMIOS = (SELECT MAX(NPREMIOS) FROM DIRECTOR))));

rem solución:

create table tactor as
select nombre, apellido
from actor a, pelicula p, actuar ac
where a.nif=ac.nif and ac.codigo_pelicula=p.codigo and p.director=d.nif 
and d.npremios = (select max(npremios) from director)


/*3. Los directores que han ganado mas nominaciones han decididos ser actor. Los datos que no
se conocen se dejan en blanco en la tabla actor*/

insert into actor 
select nif, nombre, apellido, null, null, d.npremios, null, null
from director d, pelicula p
where nif in
(select  director from pelicula where upper(nominacion)='GANADOR' group by director having count(nominacion) =
(select max(count(nominacion)) from pelicula where upper(nominacion)='GANADOR' group by director))

rem solución:

insert into actor (nif, nombre, apellido)
select nif, nombre, apellido from director where nif in
(select director from pelicula where upper(nominacion)='GANADOR' group by director having count(*)=(select max(count(*)) from pelicula where upper(upper)=nominacion='GANADOR' group by director)  )


/*4. Los actores que no tienen salario, pasan a tener el mismo salario, cache y numero de
premios que el actor que ha hecho el personaje de de Camarón*/

 update actor 
 set (salario, cache, npremios)=
(select salario, cache, npremios
from actor
where nif (select nif from actuar where upper(personaje)='CAMARÓN')
and salario is null));

rem solución:
update actor 
 set (salario, cache, npremios)=
(select salario, cache, npremios
from actor, actuar
where actuar.nif=actor.nif and upper(personaje)='CAMARÓN')
where salario is null;

/*5. El cache de los actores que han actuado en alguna pelicula de Ciencia Ficción ha aumentado
en 1000*/

update actor set cache= cache + 1000
where nif in(select nif from actuar where codigo_pelicula in (select codigo from pelicula where upper(genero)='CIENCIA FICCION'));

rem solución:
update actor set cache= cache + 1000
where nif in(select nif from actuar a, pelicula p
where codigo_pelicula=codigo and upper(genero)='CIENCIA FICCION');


/*6. Refleja en el esquema que el actor con salario 15000.04 y que actúa en la pelicula pipas al
poder ha dejado de actuar en esa pelicula*/

delete actuar 
where nif = (select nif from actor where salario=15000.04) 
and codigo_pelicula=( select codigo from pelicula where upper(título)='PIPAS AL PODER'))

rem solución:
delete from actuar where codigo_pelicula in
(select codigo from pelicula where upper(titulo)='PIPAS AL PODER') and nif=
(select nif from actor where salario= 15000.04);

/*7. Borra la pelicula que no tenga ningun actor actuando en ella*/
 se hace mirando tabla pelicula el codigo q no este en tala actuar

delete pelicula 
where codigo not in
(select codigo_pelicula from actuar);



rem delete y delete from es lo mismo, si da error se puede probar con el otro, pero en principio da igual




