rem 1. Muestra el dni, nombre, salario y universidad de los trabajadores que tenga un salario
comprendido entre 1800 y 2100 y que estan en una universidad privada (tipo=S)

select dni, t.nombre, u.nombre, salario 
from trabajador t, universidad u
where t.codigo=u.codigo and salario between 1800 and 2100
and tipo='S';

---AND UPPER(tipo)='S';  convierte todos los datos de la columna que está en paréntesis en mayusculas          ---
--- AND LOWER(tipo)='s';  convierte todos los datos de la columna que está en paréntesis en minúsculas          ---
--- INITCAP(tipo) Pone primera letra mayúscula ---

rem 2. Código y nombre de todas las Universidades donde no haya trabajadores

select codigo, nombre from universidad where codigo not in (select codigo from trabajador);


    rem variante minus

SELECT CODIGO, NOMBRE
FROM UNIVERSIDAD

MINUS

SELECT TRABAJADOR.CODIGO, UNIVERSIDAD.NOMBRE
FROM TRABAJADOR, UNIVERSIDAD;



3. Mostrar por cada universidad (ha de salir el nombre y dirección) el numero de trabajadores

select u.nombre, direccion, count(dni) from universidad u, trabajador t
where  u.codigo=t.codigo
group by u.nombre, direccion;

rem --todo lo q este en el select q no sea funcion debe estar en group by


rem --variante: Idem que antes, pero Si la universidad no tiene trabajadores ha de salir 0

select u.nombre, direccion, count(dni) from universidad u, trabajador t
where u.codigo=t.codigo(+)
group by u.nombre, direccion;

rem --- (+) se pone donde no hay la correspondencia 
rem --- count(*) cuenta la tupla NO si hay dato

rem 4.Mostrar todos los datos de los trabajadores que esten en una universidad donde haya 3 catedráticos

select * from trabajador where codigo in (
select u.codigo 
from universidad u, catedratico c
where u.codigo=c.codigo
group by u.codigo
having count(*)=3);

rem -- ponemos IN para que de más de 1 valor

rem -- variante: combinacion tablas

select trabajador.* from trabajador,universidad,catedratico
where trabajador.codigo=universidad.codigo
and catedratico.codigo=universidad.codigo
group by trabajador.dni, trabajador.codigo, trabajador.nombre, funcion,
salario
having count(catedratico.dni)=3;



rem 5. Nombre del catedratico que tiene menos profesores a su cargo

select nombre from catedratico c, trabajador t
where t.dni and nprof = (select min(nprof) from catedratico);

rem --- ponemos = porq min siempre va a ser solo 1 valor.


rem 6.Mostrar la pareja de nombre de trabajadores que tienen el mismo salario y que están en distinta universidad

select t1.nombre, t2.nombre
from trabajador t1, trabajador t2
where t1.salario=t2.salario
and t1.codigo<>t2.codigo   - distinta universidad
and t1.nombre >t2.nombre   - para que no las de repetidas 

rem --- <> y !=  significan distinto







