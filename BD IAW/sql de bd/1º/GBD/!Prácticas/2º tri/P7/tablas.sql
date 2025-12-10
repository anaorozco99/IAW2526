/* Se crean las tablas relativas a la base de datos
correspondiente a la venta de coches

Inicialmente se borran los objetos de la base de datos. 
Después se crean las tablas y las restricciones definidas 
en el esquema propuesto
*/

DROP TABLE MARCO CASCADE CONSTRAINTS;
DROP TABLE DISTRIBUCION CASCADE CONSTRAINTS;
DROP TABLE VENTAS CASCADE CONSTRAINTS;
DROP TABLE MARCAS CASCADE CONSTRAINTS;
DROP TABLE CLIENTES CASCADE CONSTRAINTS;
DROP TABLE COCHES CASCADE CONSTRAINTS;
DROP TABLE CONCESIONARIOS CASCADE CONSTRAINTS;


CREATE TABLE MARCAS ( 
  cifm CHAR(4), 
  nombre VARCHAR2(15) NOT NULL,  
  ciudad VARCHAR2(20),  
      CONSTRAINT  pk_marca  
      PRIMARY KEY (cifm));
     
CREATE TABLE CLIENTES ( 
  dni CHAR(4), 
  nombre VARCHAR2(10),
  apellido VARCHAR2(15),
  ciudad VARCHAR2(20),
     CONSTRAINT pk_cl
       PRIMARY KEY (dni));
     
CREATE TABLE COCHES (   
  codcoche CHAR(4),
  nombre VARCHAR2(15),
  modelo VARCHAR2(15),
    CONSTRAINT pk_coches
    PRIMARY KEY (codcoche));
    
CREATE TABLE CONCESIONARIOS (
  cifc CHAR(4),
  nombre VARCHAR2(15),
  ciudad VARCHAR2(20),
  CONSTRAINT pk_conce
  PRIMARY KEY (cifc));
  
CREATE TABLE DISTRIBUCION (
 cifc CHAR(4),
 codcoche CHAR(4),
 cantidad NUMBER(3) NOT NULL,
 CONSTRAINT pk_distrib
  PRIMARY KEY (cifc, codcoche),
 CONSTRAINT fk_dis_conc
   FOREIGN KEY (cifc) REFERENCES CONCESIONARIOS,
 CONSTRAINT ck_cant_dist
   CHECK (cantidad>=0));
     
CREATE TABLE VENTAS (
  cifc CHAR(4),
  dni CHAR (4),
  codcoche CHAR(4),
  color VARCHAR (15),
  CONSTRAINT pk_vent
    PRIMARY KEY (cifc,dni,codcoche),
  CONSTRAINT fk_vent_conce
     FOREIGN KEY (cifc) REFERENCES CONCESIONARIOS,
  CONSTRAINT fk_vent_cl
    FOREIGN KEY (dni) REFERENCES CLIENTES,
  CONSTRAINT fk_vent_coche
     FOREIGN KEY (codcoche) REFERENCES COCHES);
     
CREATE TABLE MARCO (
   cifm CHAR(4),
   codcoche CHAR(4),
   CONSTRAINT pk_marco
     PRIMARY KEY (cifm, codcoche),
   CONSTRAINT fk_marco_marcas
      FOREIGN KEY (cifm) REFERENCES MARCAS,
   CONSTRAINT fk_marco_coche
      FOREIGN KEY (codcoche) REFERENCES COCHES);     
       
 
