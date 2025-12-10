drop table equipo cascade constraints;
drop table ciclista cascade constraints;
drop table puerto cascade constraints;
drop table etapa cascade constraints;
drop table llevar cascade constraints;
drop table maillot cascade constraints;

CREATE TABLE equipo (
	equipo VARCHAR2(25) NOT NULL,
	director VARCHAR2(100) NULL,
	CONSTRAINT PK_equi PRIMARY KEY (equipo));

CREATE TABLE ciclista (
	dorsal NUMBER(3) NOT NULL, 
	nombre VARCHAR2(30) NOT NULL, 
	edad NUMBER(2) NULL, 
	equipo varchar(25) NULL,
	CONSTRAINT PK_cicli PRIMARY KEY (dorsal),
	CONSTRAINT FK_cicli_equi FOREIGN KEY (equipo) REFERENCES equipo (equipo));

CREATE TABLE etapa (
	numero NUMBER(2) NOT NULL,
	km number(3) NULL,
	salida varchar(35),
	llegada varchar(35),
	dorsal number(3),
	CONSTRAINT PK_eta PRIMARY KEY (numero),
	CONSTRAINT FK_etapa_cicli FOREIGN KEY (dorsal) REFERENCES ciclista (dorsal));

CREATE TABLE puerto (
	nompuerto VARCHAR2(35) NOT NULL, 
	altura number(4) NULL, 
	categoria char(1) NULL, 
	pendiente number(3,2) NULL, 
	numero NUMBER(2) not NULL,
	dorsal number(3) NULL,
	CONSTRAINT PK_puerto PRIMARY KEY (nompuerto),
	CONSTRAINT FK_puerto_eta FOREIGN KEY (numero) REFERENCES etapa (numero),
	CONSTRAINT FK_puerto_cicli FOREIGN KEY (dorsal) REFERENCES ciclista(dorsal));

CREATE TABLE maillot (
	CODIGO CHAR(3) NOT NULL, 
	TIPO VARCHAR2(30) NULL, 
	color varchar2(20) NULL, 
	premio number(7) NULL,
	CONSTRAINT PK_mai PRIMARY KEY (CODIGO));

CREATE TABLE llevar (
	dorsal NUMBER(3) NOT NULL, 
	numero number(2) NOT NULL,
	codigo char(3) not null,
	CONSTRAINT PK_lle PRIMARY KEY (numero, CODIGO),
	CONSTRAINT FK_llevar_cicli FOREIGN KEY (dorsal) REFERENCES ciclista (dorsal),
	CONSTRAINT FK_llevar_etapa FOREIGN KEY (numero) REFERENCES etapa (numero),
	CONSTRAINT FK_llevar_mai FOREIGN KEY (codigo) REFERENCES maillot (codigo));

Insert into  maillot values('MGE','General','Amarillo',8000000);
Insert into  maillot values('MMO','Montaña','Blanco y Rojo',2000000);
Insert into  maillot values('MMS','Mas Sufrido','Estrellitas moradas',2000000);
Insert into  maillot values('MMV','Metas volantes','Rojo',2000000);
Insert into  maillot values('MRE','Regularidad','Verde',2000000);
Insert into  maillot values('MSE','Sprints especiales','Rosa',2000000);


insert into equipo values ('Artiach','José Peréz');
insert into equipo values ('Banesto','Miguel Echevarria');
insert into equipo values ('Bresciali-Refin','Pietro Armani');
insert into equipo values ('Carrera','Luigi Petroni');
insert into equipo values ('Castorama','Jean Philip');
insert into equipo values ('Euskadi','Pedro Txucaru');
insert into equipo values ('Gatorade','Gian Luca Pacceli');
insert into equipo values ('Gewiss','Moreno Argentin');
insert into equipo values ('Jolly Club','Johan Richard');
insert into equipo values ('Kelme','Álvaro Pino');
insert into equipo values ('Lotus Festina','Suarez Cuevas');
insert into equipo values ('Mapei-Clas','Juan Fernandez');
insert into equipo values ('Mercatone Uno','Ettore Romano');
insert into equipo values ('Motorola','John Fidwell');
insert into equipo values ('Navigare','Lonrenzo Sciacci');
insert into equipo values ('ONCE','Manuel Sainz');
insert into equipo values ('PDM','Piet Van Der Kruis');
insert into equipo values ('Seguros Amaya','Minguez');
insert into equipo values ('Telecom','Morgan Reikcard');
insert into equipo values ('TVM','Steveens Henk');
insert into equipo values ('Wordperfect','Bill Gates');
insert into equipo values ('Amore Vita','Ricardo Padacci');

insert into ciclista values (1,'Miguel Indurain',32,'Banesto');
insert into ciclista values (2,'Pedro Delgado',35,'Banesto');
insert into ciclista values (3,'Alex Zulle',27,'ONCE');
insert into ciclista values (4,'Tony Rominger',30,'Mapei-Clas');
insert into ciclista values (5,'Gert-Jan Theunisse',32,'TVM');
insert into ciclista values (6,'Adriano Baffi',33,'Mercatone Uno');
insert into ciclista values (7,'Massimiliano Lelli',30,'Mercatone Uno');
insert into ciclista values (8,'Jean Van Poppel',33,'Lotus Festina');
insert into ciclista values (9,'Massimo Podenzana',34,'Navigare');
insert into ciclista values (10,'Mario Cipollini',28,'Mercatone Uno');
insert into ciclista values (11,'Flavio Giupponi',31,'Bresciali-Refin');
insert into ciclista values (12,'Alessio Di Basco',31,'Amore Vita');
insert into ciclista values (13,'Lale Cubino',28,'Seguros Amaya');
insert into ciclista values (14,'Roberto Pagnin',33,'Navigare');
insert into ciclista values (15,'Jesper Skibby',31,'TVM');
insert into ciclista values (16,'Dimitri Konishev',29,'Jolly Club');
insert into ciclista values (17,'Bruno Leali',37,'Bresciali-Refin');
insert into ciclista values (18,'Robert Millar',37,'TVM');
insert into ciclista values (19,'Julian Gorospe',34,'Banesto');
insert into ciclista values (20,'Alfonso Gutiérrez',29,'Artiach');
insert into ciclista values (21,'Erwin Nijboer',31,'Artiach');
insert into ciclista values (22,'Giorgio Furlan',32,'Gewiss');
insert into ciclista values (23,'Lance Armstrong',27,'Motorola');
insert into ciclista values (24,'Claudio Chiappucci',29,'Carrera');
insert into ciclista values (25,'Gianni Bugno',32,'Gatorade');
insert into ciclista values (26,'Mikel Zarrabeitia',27,'Banesto');
insert into ciclista values (27,'Laurent Jalabert',28,'ONCE');
insert into ciclista values (28,'Jesus Montoya',33,'Banesto');
insert into ciclista values (29,'Angel Edo',28,'Kelme');
insert into ciclista values (30,'Melchor Mauri',28,'Banesto');
insert into ciclista values (31,'Vicente Aparicio',30,'Banesto');
insert into ciclista values (32,'Laurent Dufaux',28,'ONCE');
insert into ciclista values (33,'Stefano della Santa',29,'Mapei-Clas');
insert into ciclista values (34,'Angel Yesid Camargo',30,'Kelme');
insert into ciclista values (35,'Erik Dekker',28,'Wordperfect');
insert into ciclista values (36,'Gian Matteo Fagnini',32,'Mercatone Uno');
insert into ciclista values (37,'Scott Sunderland',29,'TVM');
insert into ciclista values (38,'Javier Palacin',25,'Euskadi');
insert into ciclista values (39,'Rudy Verdonck',30,'Lotus Festina');
insert into ciclista values (40,'Viatceslav Ekimov',32,'Wordperfect');
insert into ciclista values (41,'Rolf Aldag',25,'Telecom');
insert into ciclista values (42,'Davide Cassani',29,'TVM');
insert into ciclista values (43,'Francesco Casagrande',28,'Mercatone Uno');
insert into ciclista values (44,'Luca Gelfi',27,'Gatorade');
insert into ciclista values (45,'Alberto Elli',26,'Artiach');
insert into ciclista values (46,'Agustin Sagasti',24,'Euskadi');
insert into ciclista values (47,'Laurent Pillon',32,'Gewiss');
insert into ciclista values (48,'Marco Saligari',29,'Gewiss');
insert into ciclista values (49,'Eugeni Berzin',23,'Gewiss');
insert into ciclista values (50,'Fernando Escartin',27,'Mapei-Clas');
insert into ciclista values (51,'Udo Bolts',30,'Telecom');
insert into ciclista values (52,'Vladislav Bobrik',26,'Gewiss');
insert into ciclista values (53,'Michele Bartoli',28,'Mercatone Uno');
insert into ciclista values (54,'Steffen Wesemann',30,'Telecom');
insert into ciclista values (55,'Nicola Minali',28,'Gewiss');
insert into ciclista values (56,'Andrew Hampsten',29,'Banesto');
insert into ciclista values (57,'Stefano Zanini',28,'Navigare');
insert into ciclista values (58,'Gerd Audehm',34,'Telecom');
insert into ciclista values (59,'Mariano Picolli',28,'Mercatone Uno');
insert into ciclista values (60,'Giovanni Lombardi',28,'Bresciali-Refin');
insert into ciclista values (61,'Walte Castignola',26,'Navigare');
insert into ciclista values (62,'Raul Alcala',30,'Motorola');
insert into ciclista values (63,'Alvaro Mejia',32,'Motorola');
insert into ciclista values (64,'Giuseppe Petito',28,'Mercatone Uno');
insert into ciclista values (65,'Pascal Lino',29,'Amore Vita');
insert into ciclista values (66,'Enrico Zaina',24,'Gewiss');
insert into ciclista values (67,'Armand de las Cuevas',28,'Castorama');
insert into ciclista values (68,'Angel Citracca',28,'Navigare');
insert into ciclista values (69,'Eddy Seigneur',27,'Castorama');
insert into ciclista values (70,'Sandro Heulot',29,'Banesto');
insert into ciclista values (71,'Prudencio Indur?in',27,'Banesto');
insert into ciclista values (72,'Stefano Colage',28,'Bresciali-Refin');
insert into ciclista values (73,'Laurent Fignon',35,'Gatorade');
insert into ciclista values (74,'Claudio Chioccioli',36,'Amore Vita');
insert into ciclista values (75,'Juan Romero',32,'Seguros Amaya');
insert into ciclista values (76,'Marco Giovannetti',34,'Gatorade');
insert into ciclista values (77,'Javier Mauleon',33,'Mapei-Clas');
insert into ciclista values (78,'Antonio Esparza',35,'Kelme');
insert into ciclista values (79,'Johan Bruyneel',33,'ONCE');
insert into ciclista values (80,'Federico Echave',37,'Mapei-Clas');
insert into ciclista values (81,'Piotr Ugrumov',33,'Gewiss');
insert into ciclista values (82,'Edgar Corredor',30,'Kelme');
insert into ciclista values (83,'Hernan Buenahora',32,'Kelme');
insert into ciclista values (84,'Jon Unzaga',31,'Mapei-Clas');
insert into ciclista values (85,'Dimitri Abdoujaparov',30,'Carrera');
insert into ciclista values (86,'Juan Martinez Oliver',32,'Kelme');
insert into ciclista values (87,'Fernando Mota',32,'Artiach');
insert into ciclista values (88,'Angel Camarillo',28,'Mapei-Clas');
insert into ciclista values (89,'Stefan Roche',36,'Carrera');
insert into ciclista values (90,'Ivan Ivanov',27,'Artiach');
insert into ciclista values (91,'Nestor Mora',28,'Kelme');
insert into ciclista values (92,'Federico Garcia',27,'Artiach');
insert into ciclista values (93,'Bo Hamburger',29,'TVM');
insert into ciclista values (94,'Marino Alonso',30,'Banesto');
insert into ciclista values (95,'Manuel Guijarro',31,'Lotus Festina');
insert into ciclista values (96,'Tom Cordes',29,'Wordperfect');
insert into ciclista values (97,'Casimiro Moreda',28,'ONCE');
insert into ciclista values (98,'Eleuterio Anguita',25,'Artiach');
insert into ciclista values (99,'Per Pedersen',29,'Seguros Amaya');
insert into ciclista values (100,'William Palacios',30,'Jolly Club');

insert into etapa values (1,9,'Valladolid','Valladolid',1);
insert into etapa values (2,180,'Valladolid','Salamanca',36);
insert into etapa values (3,240,'Salamanca','Caceres',12);
insert into etapa values (4,230,'Almendralejo','Córdoba',83);
insert into etapa values (5,170,'Córdoba','Granada',27);
insert into etapa values (6,150,'Granada','Sierra Nevada',52);
insert into etapa values (7,250,'Baza','Alicante',22);
insert into etapa values (8,40,'Benidorm','Benidorm',1);
insert into etapa values (9,150,'Benidorm','Valencia',35);
insert into etapa values (10,200,'Igualada','Andorra',2);
insert into etapa values (11,195,'Andorra','Estación de Cerler',65);
insert into etapa values (12,220,'Benasque','Zaragoza',12);
insert into etapa values (13,200,'Zaragoza','Pamplona',93);
insert into etapa values (14,172,'Pamplona','Alto de la Cruz de la Demanda',86);
insert into etapa values (15,207,'Santo Domingo de la Calzada','Santander',10);
insert into etapa values (16,160,'Santander','Lagos de Covadonga',5);
insert into etapa values (17,140,'Cangas de Onis','Alto del Naranco',4);
insert into etapa values (18,195,'Ávila','Ávila',8);
insert into etapa values (19,190,'Ávila','Destilerias Dyc',2);
insert into etapa values (20,52,'Segovia','Destilerias Dyc',2);
insert into etapa values (21,170,'Destilerias Dyc','Madrid',27);

Insert into llevar values (1,1,'MGE');
Insert into llevar values (1,1,'MMO');
Insert into llevar values (67,1,'MMS');
Insert into llevar values (1,1,'MMV');
Insert into llevar values (1,1,'MRE');
Insert into llevar values (1,1,'MSE');
Insert into llevar values (1,2,'MGE');
Insert into llevar values (25,2,'MMO');
Insert into llevar values (69,2,'MMS');
Insert into llevar values (16,2,'MMV');
Insert into llevar values (27,2,'MRE');
Insert into llevar values (8,2,'MSE');
Insert into llevar values (1,3,'MGE');
Insert into llevar values (25,3,'MMO');
Insert into llevar values (67,3,'MMS');
Insert into llevar values (16,3,'MMV');
Insert into llevar values (27,3,'MRE');
Insert into llevar values (12,3,'MSE');
Insert into llevar values (1,4,'MGE');
Insert into llevar values (24,4,'MMO');
Insert into llevar values (69,4,'MMS');
Insert into llevar values (17,4,'MMV');
Insert into llevar values (27,4,'MRE');
Insert into llevar values (8,4,'MSE');
Insert into llevar values (2,5,'MGE');
Insert into llevar values (25,5,'MMO');
Insert into llevar values (16,5,'MMV');
Insert into llevar values (27,5,'MRE');
Insert into llevar values (12,5,'MSE');
Insert into llevar values (2,6,'MGE');
Insert into llevar values (26,6,'MMO');
Insert into llevar values (16,6,'MMV');
Insert into llevar values (20,6,'MRE');
Insert into llevar values (12,6,'MSE');
Insert into llevar values (2,7,'MGE');
Insert into llevar values (26,7,'MMO');
Insert into llevar values (33,7,'MMV');
Insert into llevar values (20,7,'MRE');
Insert into llevar values (99,7,'MSE');
Insert into llevar values (4,8,'MGE');
Insert into llevar values (26,8,'MMO');
Insert into llevar values (33,8,'MMV');
Insert into llevar values (20,8,'MRE');
Insert into llevar values (99,8,'MSE');
Insert into llevar values (26,9,'MGE');
Insert into llevar values (26,9,'MMO');
Insert into llevar values (48,9,'MMV');
Insert into llevar values (20,9,'MRE');
Insert into llevar values (99,9,'MSE');
Insert into llevar values (26,10,'MGE');
Insert into llevar values (30,10,'MMO');
Insert into llevar values (48,10,'MMV');
Insert into llevar values (20,10,'MRE');
Insert into llevar values (99,10,'MSE');
Insert into llevar values (3,11,'MGE');
Insert into llevar values (30,11,'MMO');
Insert into llevar values (48,11,'MMV');
Insert into llevar values (20,11,'MRE');
Insert into llevar values (99,11,'MSE');
Insert into llevar values (3,12,'MGE');
Insert into llevar values (30,12,'MMO');
Insert into llevar values (48,12,'MMV');
Insert into llevar values (20,12,'MRE');
Insert into llevar values (99,12,'MSE');
Insert into llevar values (30,13,'MGE');
Insert into llevar values (30,13,'MMO');
Insert into llevar values (48,13,'MMV');
Insert into llevar values (20,13,'MRE');
Insert into llevar values (99,13,'MSE');
Insert into llevar values (30,14,'MGE');
Insert into llevar values (28,14,'MMO');
Insert into llevar values (42,14,'MMV');
Insert into llevar values (20,14,'MRE');
Insert into llevar values (22,14,'MSE');
Insert into llevar values (30,15,'MGE');
Insert into llevar values (28,15,'MMO');
Insert into llevar values (42,15,'MMV');
Insert into llevar values (20,15,'MRE');
Insert into llevar values (22,15,'MSE');
Insert into llevar values (1,16,'MGE');
Insert into llevar values (28,16,'MMO');
Insert into llevar values (42,16,'MMV');
Insert into llevar values (20,16,'MRE');
Insert into llevar values (22,16,'MSE');
Insert into llevar values (1,17,'MGE');
Insert into llevar values (28,17,'MMO');
Insert into llevar values (42,17,'MMV');
Insert into llevar values (20,17,'MRE');
Insert into llevar values (22,17,'MSE');
Insert into llevar values (1,18,'MGE');
Insert into llevar values (26,18,'MMO');
Insert into llevar values (20,18,'MMV');
Insert into llevar values (27,18,'MRE');
Insert into llevar values (10,18,'MSE');
Insert into llevar values (1,19,'MGE');
Insert into llevar values (28,19,'MMO');
Insert into llevar values (42,19,'MMV');
Insert into llevar values (20,19,'MRE');
Insert into llevar values (22,19,'MSE');
Insert into llevar values (1,20,'MGE');
Insert into llevar values (28,20,'MMO');
Insert into llevar values (42,20,'MMV');
Insert into llevar values (20,20,'MRE');
Insert into llevar values (22,20,'MSE');
Insert into llevar values (1,21,'MGE');
Insert into llevar values (2,21,'MMO');
Insert into llevar values (42,21,'MMV');
Insert into llevar values (20,21,'MRE');
Insert into llevar values (22,21,'MSE');

insert into puerto values ('Alto del Naranco',565,'1',6.90,10,30);
insert into puerto values ('Arcalis',2230,'E',6.50,10,4);
insert into puerto values ('Cerler-Circo de Ampriu',2500,'E',5.87,11,9);
insert into puerto values ('Coll de la Comella',1362,'1',8.07,10,2);
insert into puerto values ('Coll de Ordino',1980,'E',5.30,10,7);
insert into puerto values ('Cruz de la Demanda',1850,'E',7.00,11,20);
insert into puerto values ('Lagos de Covadonga',1134,'E',6.86,16,42);
insert into puerto values ('Navacerrada',1860,'1',7.50,19,2);
insert into puerto values ('Puerto de Alisas',672,'1',5.80,15,1);
insert into puerto values ('Puerto de la Morcuera',1760,'2',6.50,19,2);
insert into puerto values ('Puerto de Mijares',1525,'1',4.90,18,24);
insert into puerto values ('Puerto de Navalmoral',1521,'2',4.30,18,2);
insert into puerto values ('Puerto de Pedro Bernardo',1250,'1',4.20,18,25);
insert into puerto values ('Sierra Nevada',2500,'E',6.00,2,26);

commit;






rem Consultas

rem 1.-Obtener el numero de las etapa que tienen algún puerto de montaña, indicando cuántos
tiene cada una de ellas.

select numero, count(*) "Nº puertos"
from puerto 
group by numero;

rem con el group by si hay count es mejor poner alias a esa columna

rem 2.- Obtener los datos de las etapas que no comienzan en la misma ciudad en que acaba la
etapa anterior.

select et1.*
from etapa et1, etapa et2
where et1.numero=et2.numero+1  
and et1.salida != et2.llegada;


rem 3.- Obtener los datos de los ciclistas que han llevado todos los maillots (no necesariamente
en la misma etapa)

rem distint para evitar maillots repetidos
----
explicacion:
select * from maillot;
select count(*) from maillot; veo los maillot q hay
---

veo los ciclistas q han llevado maillot el numero de maillot q han llevado, incluyo si han repetido maillot.

select dorsal, count(codigo) from llevar
group by dorsal
order by dorsal;


idem pero sin repetir codigos

select dorsal, count(distinct codigo) from llevar
group by dorsal
order by dorsal;


SOLUCION:
    

select c.dorsal, nombre, edad, equipo
from ciclista c, llevar l
where c.dorsal = l.dorsal
group by c.dorsal, nombre, edad, euipo
having count(distint L.codigo) = (SELECT COUNT(*)FROM MAILLOT);


rem 4.- Todas las etapas que tienen 2 puertos de montaña han pasado a tener los mismos kms que
la etapa número 5.

update etapa
set km=  (select km from etapa where numero= 5)/*columnas que cambias= dato que quieres poner, si solo ponemos esto se aplica a toda la columna km de todos los datos*/
where numero in (select numero from puerto group by numero having count(numero)=2 ); /*condicion sobre a que columna se aplica */
/* subconsulta da  numero etapa que tienen 2 puertos solamente */

rem 5.- Todas las etapa que tienen 3 0 4 puertos de montaña y mas de 170 km han pasado a tener
los mismos kms que la etapa número 5

update etapa
set km=  (select km from etapa where numero= 5)
where numero in (select numero from puerto group by numero having count(numero)=3 or having count(numero)=4)
and km > 170;


otra solucion:

update etapa set km = (select km from etapa where numero=5)
where numero in
(select e.numero from puerto p, etapa e
where p.numero=e.numero and km>170
group by e.numero
having count(e.numero)in (3,4));


rem 6.- Crea una tabla llamada nuevamaillot con los mismo campos que maillot pero que tenga
los datos de aquellos maillots que sólo han sido llevados por ciclista de un mismo equipo.


SOLUCION:
create table nuevamaillot as
SELECT M.codigo, M.tipo, M.color, M.premio
FROM LLEVAR L, CICLISTA C, MAILLOT M
WHERE L.dorsal=C.dorsal AND L.codigo=M.codigo
GROUP BY M.codigo, M.tipo, M.color, M.premio
HAVING COUNT(DISTINCT C.equipo)=1;

explicacion:  obtenemos codigo de maillot con el equipo q ha llevado ese maillot
select l.codigo, equipo from llevar l, ciclista c
where l.dorsal=c.dorsal
order by l.codigo,equipo;

sale codigo de maillot con el numero de veces q lo han llevado 
select l.codigo, count(codigo) from llevar l, ciclista c
where l.dorsal=c.dorsal
group by l.codigo;

aqui sale sin repetir
select l.codigo, count(distinct codigo) from llevar l, ciclista c
where l.dorsal=c.dorsal
group by l.codigo;
--having count(distinct c.equipo)=1;  con esto solo sale

rem NO SE PONE DISTINCT CON ASTERISCO
rem EN EL GROUP BY TODO LO Q NO SEA OPERACION SE CONJUNTO SE METE (LO Q ESTA EN EL SELECT)

rem 7.-Poner el nombre en mayúscula y aumenta un año a los ciclista que han ganado los
puertos de mayor alturas.

update ciclista
set nombre=upper(nombre), edad= edad+1
where dorsal in (select dorsal from puerto where altura=(select max(altura) from puerto));



rem 8.- Da de alta un ciclista con el dorsal 101, tu nombre, la misma edad y equipo del ciclista
que ha ganado la etapa 8.

rem la insercion es en orden de las tablas existentes, edad y equipo lo añadimos en where

insert into ciclista 
select 101, 'Ana Orozco', edad, equipo
from ciclista c, etapa e
where c.dorsal = e.dorsal and numero = 8;

POR SI ACASO TE DA MÁS DE 1 FILA:
insert into ciclista
select distinct 101,'tu nombre', edad, equipo from ciclista c, etapa e
where c.dorsal=e.dorsal and e.numero=8;

rem 9.- Crea una tabla llamada ganadores que contenga el dorsal y nombre de los ciclistas que
han llevado dos o mas maillote en una misma etapa.
La tabla también ha de contener el equipo del ciclista, la etapa y el número de de maillot
que han llevado en esa etapa.
Los campos de la nueva tabla han de tener los siguientes nombres:
Dorsal, Nombre, Equipo, Etapa, Nmaillot.

create table ganadores (dorsal, nombre, equipo, etapa, nmaillot) as
select DISTINCT c.dorsal, c.nombre, c.equipo, numero, count(*)
from ciclista c, llevar l
where l.dorsal= c.dorsal 
group by l.numero, c.dorsal, c.nombre, c.equipo, e.numero, 
having count(*)>=2;



explicacion:


SELECT DISTINCT c.dorsal, numero "etapa", codigo "maillot"
from ciclista c, llevar l
where c.dorsal = l.dorsal
order by c.dorsal, numero;



agrupando por dorsal y por numero
select distinct c.dorsal, numero, count(*)
from ciclista c, llevar l
where c.dorsal= l.dorsal
group by c.dorsal, numero
:::order by c.dorsal:: se pone siempre al final!!
---- having count(*)>=2;  

rem 10.- Borra los maillot que han sido llevados por Melchor Mauri (en un sólo paso)
Nota: has de poner el borrado en cascada en la tabla llevar que referencia a maillot.

ANTES DE NADA HAY Q CAMBIAR UNA RESTRICIÓN:

ALTER TABLE LLEVAR DROP CONSTRAINT FK_LLEVAR_MAI;  -- borramos la restricción

ALTER TABLE LLEVAR ADD CONSTRAINT FK_llevar_mai FOREIGN KEY (codigo)
REFERENCES maillot (codigo) on delete cascade;  -- creamos una nueva con borrado cascada



rem la sintasis de los delete y upate solo te deja 1 tabla, por lo que no se puede haciendo igualacion hay que hacer subconsultas

delete maillot
where codigo in 
(select codigo from llevar where dorsal=
(select dorsal from ciclista where upper(nombre)= 'MELCHOR MAURI'));


OTRA SOLUCION:

delete maillot where codigo in 
( select distinct codigo from ciclista c, llevar l
where nombre='Melchor Mauri' and
c.dorsal=l.dorsal );