drop table tiendas cascade constraints;
drop table articulos cascade constraints;


create table articulos(
cod_articulo number(3) constraint pk_articulo primary key,
nombre varchar2(50) not null,
peso number(4,0),
categoria varchar2 (50),
precio_venta number (5,2),
precio_costo number(5,2),
existencias number(3)
);


INSERT INTO ARTICULOS VALUES (1,'Macarrones', 1, 'Primera',100,98,120);
INSERT INTO ARTICULOS VALUES (2,'Tallarines', 2, 'Primera',120,100,100);
INSERT INTO ARTICULOS VALUES (3,'Tallarines', 1, 'Segunda',99,50,100);
INSERT INTO ARTICULOS VALUES (4,'Macarrones', 1, 'Tercera',80,50,100);
INSERT INTO ARTICULOS VALUES (5,'Atún', 3, 'Primera',200,150,220);
INSERT INTO ARTICULOS VALUES (6,'Atún', 3, 'Segunda',150,100,220);
INSERT INTO ARTICULOS VALUES (7,'Atún', 3, 'Tercera',100,50,220);
INSERT INTO ARTICULOS VALUES (8,'Sardinillas', 1, 'Primera',250,200,200);
INSERT INTO ARTICULOS VALUES (9,'Sardinillas', 1, 'Segunda',200,160,200);
INSERT INTO ARTICULOS VALUES (10,'Sardinillas', 1,'Tercera',100,150,220);
INSERT INTO ARTICULOS VALUES (11,'Mejillones',1,'Tercera',90,50,200);
INSERT INTO ARTICULOS VALUES (12,'Mejillones',2, 'Primera',200,150,300);
INSERT INTO ARTICULOS VALUES (13,'Fideos', 1, 'Segunda',75,50,100);
INSERT INTO ARTICULOS VALUES (14,'Fideos', 1, 'Primera',100,80,100);


create table tiendas (
nif char(9) constraint pk_tienda primary key,
nombre varchar2(50),
direccion varchar2(50),
poblacion varchar2(50),
provincia varchar2(50),
codpostal number(5,0)
);

INSERT INTO TIENDAS VALUES('1111-A','Almacenes Pérez', 'C/Toledo, 20',
 'Siguenza','GUADALAJARA',19104); 
INSERT INTO TIENDAS VALUES('5555-B','La gacela', 'C/Santander Rios, 45',
 'Azuqueca','GUADALAJARA', 19209);
INSERT INTO TIENDAS VALUES('2222-A','Comestibles Rodolfo', 
'C/ del Val s/n', 'Alcalá de Henares','MADRID',28804);
INSERT INTO TIENDAS VALUES('4444-A','La Pasta Gansa', 'C/Alcalá, 2',
 'Ajalvir','MADRID', 28765);
 INSERT INTO TIENDAS VALUES('3333-N','Ultramarinos Montse',
  'Avda. Pio 10', 'Toledo','TOLEDO',45100);
INSERT INTO TIENDAS VALUES('4141-B','Todo Toledo',
 'C/Avila 24', 'Talavera','TOLEDO',45199);

commit;

rem Ana Orozco Asensio

rem Apartado A:

CREATE TABLE pedido (
nif char(9) CONSTRAINT fk_nif REFERENCES tiendas,
cod_articulo number(3) CONSTRAINT fk_codart REFERENCES articulos,
fecha_pedido DATE,
unidades_pedidas number(5),
CONSTRAINT pk_nifcodfecha PRIMARY KEY (nif, cod_articulo, fecha_pedido)
);

INSERT INTO pedido VALUES ( '1111-A', 1 , '27/04/2023', 38);
INSERT INTO pedido VALUES ( '5555-B', 1 , '21/01/2023', 809);


SELECT * FROM pedido;



rem Apartado B:

ALTER TABLE articulos ADD CONSTRAINT valores CHECK (existencias BETWEEN 100 AND 400);


ALTER TABLE tiendas DROP COLUMN codpostal;
SELECT * FROM tiendas;

rem Apartado C:

CREATE TABLE fabricante (
cod_fab NUMBER(3) CONSTRAINT pk_codfab PRIMARY KEY,
nombre varchar2(19) UNIQUE NOT NULL,
pais varchar2(8) CONSTRAINT ck_pais CHECK (pais in( 'España' , 'Portugal')),
cod_articulo number(3) CONSTRAINT fk_codartfab REFERENCES articulos
);

