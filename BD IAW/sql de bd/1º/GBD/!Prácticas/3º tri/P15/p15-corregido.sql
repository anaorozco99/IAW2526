
rem usar upper o lower en todo

1.-
create table tpreg1 as
select c.codigo, nombre from instituto c, tutores t
where c.codigo=t.codigo
group by c.codigo, nombre having count(*)<3;

rem puede salir cualquier tipo de empleado, para q solo salgan profes es necesario hacerlo con programacion antes
rem no queremos q aparezca el count por eso solo lo ponemos en el group by



2.-
select nombre, count(nif) from instituto c, personal p
where c.codigo=p.codigo(+) and tipo='S'
group by nombre
order by count(nif);




3.-

update personal set salario = salario-50
where nif in(
select p.nif from personal p, tutores t
where p.nif=t.nif and num_alumnos <
(select avg(num_alumnos) from tutores)
);



4.-

insert into personal
select 12345678, c.codigo, 'Ana Orozco', p.funcion, p.salario
from instituto c, personal p where APELLIDOS='Ruiz Lafuente, Manuel'
and nombre'Antoñete'




5.-

delete from tutores where nif in (
select nif from personal where lower(apellidos) 
like '% Luis' and lower(funcion)='profesor')

rem si quiero q borre a luisa y luis y no a luisita se pondría '% Luis_'



6.-

update personal set codigo=
(select codigo from instituto where=nombre'Planeta Tierra')
where upper(funcion) !='PROFESOR' and codigo in
(select codigo from instituto where nombre'Los Danzantes');




7.-
insert into instituto
select 55, tipo, 'Machado', direccion, telefono, num_plazas
from instituto i, personal p
where funcion='Conserje' AND apellidos='Sarro Molina, Carmen';

rem es mas facil con subconsultas




8.-
delete tutores where codigo in
(select codigo from instituto where nombre='El quijote');
 rem se borra primero los tutotes

delete personal where codigo in
(select codigo from instituto where nombre='El quijote')
and funcion='Profesor'








