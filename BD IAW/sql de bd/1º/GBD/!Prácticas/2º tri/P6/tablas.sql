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
