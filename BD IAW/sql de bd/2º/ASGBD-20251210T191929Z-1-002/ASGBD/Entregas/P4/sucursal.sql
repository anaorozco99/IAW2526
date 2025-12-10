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
