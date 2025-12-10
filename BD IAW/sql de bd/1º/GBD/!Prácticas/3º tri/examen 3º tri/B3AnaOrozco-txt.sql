1.
create table Tasistencia as
select a.nombre, a.apellido, i.nombre "Instructor", c.nombre "Clase"
from alumnos a, instructores i, clases c, asistencias asi
where c.id_instructor=i.codigo and asi.id_alumno=a.codigo and asi.id_clase=c.codigo
and fecha  between '01/01/2020' and '31/12/2020';


2.

select distinct i.nombre, i.sueldo_mes 
from instructores i, alumnos a, clases c
where c.id_instructor=i.codigo and upper(nivel)='A';


3.!!

select i.nombre, i.apellido, max(count(id_asistencias))
from instructores i, clases c, asistencias asi, alumnos a
where asi.id_alumno=a.codigo and asi.id_clase=c.codigo
group by i.nombre, i.apellido
having max(count(id_asistencias))


4-

create table tviernes_1 as
select distinct c.nombre "Clase", a.nombre "Nombre Alumno", a. apellido
from clases c, alumnos a, asistencias asi
where asi.id_clase=c.codigo and asi.id_alumno=a.codigo and
upper(a.nivel)='I' and upper(c.dia)='VIERNES';

5-

create table Tpago as
select nombre, apellido, SUM(cuota) "Cuota"
from alumnos a, pagos p
where p.alumno=a.codigo
group by nombre, apellido


 

6.

insert into clases 




7-


8-

insert into alumnos
select 22222, 'Juan',  'Malos Pelos', fec_nac, direccion, telefono, nivel
from alumnos a, asistencias asi, clases c
where asi.id_alumno=a.codigo and asi.id_clase=c.codigo 
and asi.fecha='20/03/2024' and upper(c.nombre)='TAEKWONDO';




9-

update alumnos 
set direccion = 
(select direccion from alumnos where upper(nombre)='DAVID')
where upper(nombre)='MARCOS';



10-

update instructores
set sueldo_mes=sueldo_mes-200 
where id_instructor in(select id_instructor 
from clases c, asistencias asi, alumnos a
where asi.id_clase=c.codigo and asi.id_alumno=a.codigo
group by id_instructor
having count(id_alumno)<2);


11.

update alumnos
set upper(nivel)='P'
where codigo in(
select codigo
from alumnos a, asistencias asi
where asi.id_alumno=a.codigo
group by codigo
having count(id_alumno)<2);



12-

delete from alumnos
where codigo not in (select id_alumno from asistencias)


13-






