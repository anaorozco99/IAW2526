/* Ana Orozco */


rem con user ana

/* Pregunta 1 */


CREATE USER practica4 
IDENTIFIED BY practica4
DEFAULT TABLESPACE personal
QUOTA 10M ON personal;

GRANT CREATE SESSION, CREATE TABLE TO practica4;



rem creación tablas e inserción datos

create table sucursal (
cod_banco char(3),
cod_suc number(3,0),
nombre varchar(35) not null,
ubicacion varchar(12),
constraint pk_sucursal primary key(cod_banco,cod_suc)
);

create table empleado (
id_emp varchar2(12) constraint pk_empleado primary key,
nombres varchar2(30) not null,
apellidos varchar2(35) not null,
cod_seg char(20),
ingreso date not null,
banco char(3),
sucursal number(3,0),
constraint fk_emp_suc foreign key(banco,sucursal) references sucursal
);


rem insertamos varios datos

alter session set nls_date_format='DD-MM_YY';

insert into sucursal values ('S01',111,'suc1','ubicacion1');
insert into sucursal values ('S02',222,'suc2','ubicacion2');
insert into empleado values ('emp1', 'nombre1','ape1','cod1','10-01-19','S01',111);
insert into empleado values ('emp2', 'nombre2','ape2','cod2','11-01-19','S01',111);
insert into empleado values ('emp3', 'nombre3','ape3','cod3','10-01-19','S01',111);
insert into empleado values ('emp4', 'nombre4','ape4','cod4','11-01-19','S02',222);
insert into empleado values ('emp5', 'nombre5','ape5','cod5','10-01-19','S02',222);
insert into empleado values ('emp6', 'nombre6','ape6','cod6','11-01-19','S02',222);

commit;


rem con user practica4

/* Pregunta 2 */


rem  a

SELECT index_name, index_type, uniqueness 
FROM user_indexes 
WHERE UPPER(table_name) = 'empleado';


rem b

CREATE INDEX iempl ON empleado (apellidos, nombres);

rem la tabla tiene datos

ALTER INDEX iempl REBUILD;


rem c

SELECT index_name, index_type, uniqueness 
FROM user_indexes 
WHERE table_name = 'empleado';


rem Lo que debe ocurrir es que vemos el índice que acabamos de crear con la tabla

/* Pregunta 3 */


rem a

SELECT index_name, table_name, column_name, column_position 
FROM user_ind_columns 
ORDER BY table_name;


rem b 

rem desde user ana

SELECT index_name, table_name, column_name, column_position 
FROM all_ind_columns 
WHERE table_owner = 'practica4'
ORDER BY table_name;



/* Pregunta 4 */

SELECT object_name 
FROM all_objects 
WHERE UPPER(object_type) = 'INDEX' 
AND owner != 'practica4';



/* Ejercicio 5 */


rem a

CREATE UNIQUE INDEX isuc ON sucursal(nombre);
ALTER INDEX isuc REBUILD;

rem b

INSERT INTO sucursal VALUES ('S03', 333, 'suc3', 'ubicacion3');
INSERT INTO sucursal VALUES ('S04', 444, 'suc3', 'ubicacion4');

rem el indice es unico por lo que da error


/* Ejercicio 6 */

ALTER TABLE empleado 
ADD jefe_id_emp VARCHAR2(12) NULL;

/* primero agrego la columna y le digo que puede tener nulos ya que habrá alguno que no tenga jefe que sea otro empleado ya que en la explicación del ejercicio se menciona "algunos empleados tienen un jefe que es otro de los empleados" */

ALTER TABLE empleado
ADD CONSTRAINT fk_jefe_emp FOREIGN KEY (jefe_id_emp) REFERENCES empleado(id_emp);

 rem ahora añado que es clave foranea

/* Ejercicio 7 */


rem a

DROP TABLE empleado;


rem b

SELECT *
FROM user_indexes 
WHERE table_name = 'empleado';

rem no vemos los indices porque estan en la papelera

rem c

SELECT object_name, original_name, type, can_undrop 
FROM user_recyclebin;

rem por eso consultamos la papelera

rem d

FLASHBACK TABLE empleado TO BEFORE DROP;


rem e

SELECT *
FROM user_indexes 
WHERE table_name = 'EMPLEADO';

rem los nombres son los mismos que tenían en la papelera, empiezan por BIN$noseque

rem f

ALTER INDEX "nombre que empieza por BIN$1" RENAME TO pk_empleado;
ALTER INDEX "nombre que empieza por BIN$2" RENAME TO iempl;

rem los reconstruimos

ALTER INDEX pk_empleado REBUILD;
ALTER INDEX iempl REBUILD;

rem al no tener la bd corriendo he tenido que ver qué pasa por vídeos de youtube 

/* Ejercicio 8 */

DROP TABLE empleado PURGE;


rem con usuario system

/* Ejercicio 9 */


rem a

SELECT instance_name, host_name, status, archiver 
FROM V$INSTANCE;

/*no puedo mostrar lo que devuelve porque no la he podido poner porque no tengo la bd pero debería devolver:

instance_name --> el nombre de la instancia de la bd
host_name --> el nombre del servidor
status --> el estado en el que se encuenta la instancia
archiver --> el estado del proceso de archivado de redo logs  

porque V$INSTANCE es una vista dinamica que proporciona informacion de la bd a la que nos conectamos, tiene otros campos como database_status, logins y instance_role*/



rem b

SELECT tablespace_name, SUM(bytes/1024) AS MB_libres
FROM dba_free_space
GROUP BY tablespace_name;


rem c

SELECT tablespace_name, SUM(bytes/1024) AS KB_libres
FROM dba_free_space
WHERE upper(tablespace_name) = 'PERSONAL'



rem d

rem con usuario ana

SELECT tablespace_name, SUM(bytes/1024) AS KB_ocupados
FROM user_segments
GROUP BY tablespace_name;

rem con usuario system

SELECT tablespace_name, SUM(bytes)/1024 AS KB_ocupados
FROM dba_segments
WHERE upper(owner)='SYSTEM'
