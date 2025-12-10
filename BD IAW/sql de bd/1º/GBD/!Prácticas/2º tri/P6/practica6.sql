rem *** borro las tablas
drop table envios;
drop table proveedores;
drop table pieza;	


rem Creacion de las TABLAS

create table proveedores
(codigo_p varchar2(3) constraint pk_proveedor primary key,
 nombre varchar2(10),
 estado number(3),
 ciudad varchar2(10)
); 
create table pieza
(codigo_pz varchar2(3) constraint pk_pieza primary key,
 nombre varchar2(10),
 color  varchar2(10),
 peso  number(3),
 ciudad varchar2(10)
); 

create table envios
(codigo_p varchar2(3) not null,
 codigo_pz varchar2(3) not null,
 cantidad number(5),
 constraint pk_envio primary key (codigo_p,codigo_pz),
 constraint fk_env_prov foreign key (codigo_p) references proveedores,
 constraint fk_env_pieza foreign key (codigo_pz) references pieza
);

rem  Alta de entradas dentro de las tablas

insert into proveedores values ('PR1','CARLOS',20,'SEVILLA' );
insert into proveedores values ('PR2','JUAN',10,'MADRID' );
insert into proveedores values ('PR3','JOSE',30,'SEVILLA' );
insert into proveedores values ('PR4','INMA',20,'SEVILLA' );
insert into proveedores values ('PR5','EVA',30,'CACERES' );
insert into pieza values ('P1','X3A','ROJO',12,'SEVILLA');
insert into pieza values ('P2','B35','VERDE',17,'MADRID');
insert into pieza values ('P3','C4B','AZUL',17,'MALAGA');
insert into pieza values ('P4','C4B','ROJO',14,'SEVILLA');
insert into pieza values ('P5','VT8','AZUL',12,'MADRID');
insert into pieza values ('P6','C30','ROJO',19,'SEVILLA');

insert into envios values ('PR1','P1',200);
insert into envios values ('PR2','P3',400);
insert into envios values ('PR2','P4',200);
insert into envios values ('PR2','P5',100);
insert into envios values ('PR3','P3',200);
insert into envios values ('PR3','P4',500);
insert into envios values ('PR4','P6',300);
insert into envios values ('PR4','P5',300);
insert into envios values ('PR5','P2',200);
insert into envios values ('PR5','P3',100);
insert into envios values ('PR5','P5',500);
insert into envios values ('PR5','P6',200);
insert into envios values ('PR5','P1',100);
insert into envios values ('PR5','P4',800);

/*CONSULTAS*/

/*1 Obtener el nombre de los proveedores que suministran la pieza con el código P2*/

SELECT NOMBRE FROM PROVEEDORES PR, ENVIOS EN WHERE EN.CODIGO_P = PR.CODIGO_P AND CODIGO_PZ = 'P2';

/*2 Obtener el código de todas las piezas de las que se han vendido una cantidad
comprendida entre 200 y 300 ambas inclusiva. (con group by)*/

SELECT CODIGO_PZ FROM ENVIOS WHERE CANTIDAD BETWEEN 200 AND 300 GROUP BY CODIGO_PZ;

/*3 Obtener el nombre de las piezas de color rojo suministradas por los proveedores de la
ciudad de Londres.*/

SELECT PZ.NOMBRE FROM PIEZA PZ, PROVEEDORES PR, ENVIOS EN WHERE EN.CODIGO_P = PR.CODIGO_P AND EN.CODIGO_PZ = PZ.CODIGO_PZ AND COLOR = 'ROJO' AND PR.CIUDAD = 'LONDRES';

/*4 Obtener los datos de los envíos de más de 100 unidades, mostrando también el nombre
del proveedor y el de la pieza.*/

SELECT EN.*, PZ.NOMBRE "NOMBRE PIEZA", PR.NOMBRE "NOMBRE PROV" FROM ENVIOS EN, PIEZA PZ, PROVEEDORES PR WHERE EN.CODIGO_P = PR.CODIGO_P AND EN.CODIGO_PZ = PZ.CODIGO_PZ AND CANTIDAD > 100;

/*5 Obtener todos los datos de los proveedores, juntos con sus envíos. También tienen que
aparecer todos lo datos de las piezas. */

SELECT PR.*, EN.CODIGO_PZ, CANTIDAD, PZ.* FROM ENVIOS EN, PIEZA PZ, PROVEEDORES PR WHERE EN.CODIGO_P = PR.CODIGO_P AND EN.CODIGO_PZ = PZ.CODIGO_PZ;

/*6 Obtener el nombre de los proveedores que no suministran la pieza con el código P2*/

SELECT DISTINCT(NOMBRE) FROM PROVEEDORES PR, ENVIOS EN WHERE EN.CODIGO_P = PR.CODIGO_P AND CODIGO_PZ != 'P2';

/*7 Mostrar todos los datos de relación envío ampliandolo a un atributo llamado “Total” en
el que aparezca el resultado de multiplicar por 4 el atributo cantidad y mostrar las tuplas
de la relación resultante en las que el el atributo Total es mayor que 30.*/

SELECT EN.*, CANTIDAD*4 "TOTAL" FROM ENVIOS EN WHERE CANTIDAD*4 > 30;

/*8 Obtener los datos del envío de más piezas*/

SELECT * FROM ENVIOS ORDER BY CANTIDAD DESC FETCH FIRST 1 ROW ONLY;

/*9 Obtener el código de los proveedores que realizan envíos en cantidades superiores a la
cantidad media por envío*/

SELECT CODIGO_P FROM ENVIOS GROUP BY CODIGO_P HAVING AVG(CANTIDAD) > (SELECT AVG(CANTIDAD) FROM ENVIOS);

/*10 Obtener todas las parejas de nombre de proveedores que sean de la misma ciudad*/

SELECT P1.NOMBRE, P2.NOMBRE, P1.CIUDAD, P2.CIUDAD FROM PROVEEDORES P1, PROVEEDORES P2 WHERE P1.CIUDAD = P2.CIUDAD AND P1.NOMBRE > P2.NOMBRE;


