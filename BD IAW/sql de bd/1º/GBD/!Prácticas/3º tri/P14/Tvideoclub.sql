drop table peliculas cascade constraints;
drop table socios cascade constraints;
drop table prestamos cascade constraints;


REM ************* CREAMOS TABLAS PELICULAS *************

CREATE TABLE peliculas (
    pelicula number(3) constraint pk_pelicula primary key,
    titulo varchar2(40) NOT NULL,
    duracion number,
    tema varchar2(15),
    clasificacion char(4),
    produccion number,
    fec_compra date,
    pais varchar2(15),
    precio number
);

REM ***************** CREAMOS TABLAS SOCIOS


CREATE TABLE socios (
    socio number(3) constraint pk_socio primary key,
    nombre varchar2(50) NOT NULL,
    fec_ingreso date,
    dni char(9) constraint uniq_socio unique NOT NULL,
    direccion varchar2(20),
    telefono character(9)
);

REM ************ CREAMOS TABLA PRESTAMOS

CREATE TABLE prestamos (
    pelicula number(3) constraint fk_pr_pel references peliculas,
    socio number(3) constraint fk_pr_soc references socios,
    fec_retirada date NOT NULL,
    fec_entrega date,
    constraint pk_prestamo primary key (pelicula, socio, fec_retirada)
);




