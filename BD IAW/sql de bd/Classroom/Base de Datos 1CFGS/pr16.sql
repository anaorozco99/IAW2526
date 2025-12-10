rem Consultas

rem 1.-Obtener el numero de las etapa que tienen algún puerto de montaña, indicando cuántos tiene cada una de ellas.

select numero, count(*)
from puerto 
group by numero;


rem 2.- Obtener los datos de las etapas que no comienzan en la misma ciudad en que acaba la
etapa anterior.

select e1.* 
from etapa e1, etapa e2
where e1.salida !=e2.llegada and e1.numero=e2.numero+1

rem esto es lo que han comentado en clase q hay q hacer
[
select et1.*
from etapa et1, etapa 2
where et1.numero-1 = et2.numero and et1.salida= et2.llegada;
]


rem 3.- Obtener los datos de los ciclistas que han llevado todos los maillots (no necesariamente en la misma etapa)

select c.* from ciclista c, maillot m, llevar l
where l.codigo=m.codigo AND l.dorsal=c.dorsal
group by c.dorsal, nombre, edad, equipo
having count(*) = (select count(codigo) from maillot);

rem distint para evitar maillots repetidos
rem copiado de clase, a partir de los [] no entiendo

rem 4.- Todas las etapa que tienen 2 puertos de montaña han pasado a tener los mismos kms que la etapa número 5.

update etapa
set km=  (select km from etapa where numero= 5)/*columnas que cambias= dato que quieres poner, si solo ponemos esto se aplica a toda la columna km de todos los datos*/
where numero in (select numero from puerto group by numero having count(numero)=2 ); /*condicion sobre a que columna se aplica */
/* subconsulta da  numero etapa que tienen 2 puertos solamente */

rem 5.- Todas las etapa que tienen 3 0 4 puertos de montaña y mas de 170 km han pasado a tener los mismos kms que la etapa número 5

update etapa
set km=  (select km from etapa where numero= 5)
where numero in (select numero from puerto group by numero having count(numero)=3 or count(numero)=4)
and km > 170;



rem 6.- Crea una tabla llamada nuevamaillot con los mismo campos que maillot pero que tenga los datos de aquellos maillots que sólo han sido llevados por ciclista de un mismo equipo.

create table nuevamaillot as
select m.codigo, m.color, e.equipo
from maillot m, llevar l, ciclista c, equipo e
where m.codigo=l.codigo and l.dorsal=c.dorsal and c.equpo=e.equipo


rem 7.-Poner el nombre en mayúscula y aumenta un año a los ciclista que han ganado los puertos de mayor alturas.

update ciclista
set nombre=upper(nombre), edad= edad+1
where dorsal in (select dorsal from puerto where altura=(select max(altura) from puerto));



rem 8.- Da de alta un ciclista con el dorsal 101, tu nombre, la misma edad y equipo del ciclista que ha ganado la etapa 8.

rem la insercion es en orden de las tablas existentes, edad y equipo lo añadimos en where

insert into ciclista 
select 101, 'Ana Orozco', edad, equipo
from ciclista c, etapa e
where c.dorsal = e.dorsal and numero = 8;

rem 9.- Crea una tabla llamada ganadores que contenga el dorsal y nombre de los ciclistas que han llevado dos o mas maillote en una misma etapa.
rem La tabla también ha de contener el equipo del ciclista, la etapa y el número de de maillot que han llevado en esa etapa.
rem Los campos de la nueva tabla han de tener los siguientes nombres: Dorsal, Nombre, Equipo, Etapa, Nmaillot.

create table ganadores as
select c.dorsal, c.nombre, c.equipo, e.numero, l.codigo
from ciclista c, etapa e, llevar l
where c.dorsal=e.dorsal and l.dorsal= c.dorsal and l.numero=e.numero
group by l.numero, c.dorsal, c.nombre, c.equipo, e.numero, l.codigo
having count(*)>=2;


rem 10.- Borra los maillot que han sido llevados por Melchor Mauri (en un sólo paso) Nota: has de poner el borrado en cascada en la tabla llevar que referencia a maillot.

delete  maillot
where 

rem la sintasis de los delete solo te deja 1 tabla, por lo que no se puede haciendo igualacion hay que hacer subconsultas
rem solucion de compañero dicha en clase, dudas con delete

delete maillot
where codigo in 
(select codigo from llevar where dorsal=
(select dorsal from ciclista where upper(nombre)= 'MELCHOR MAURI'))