CREATE TABLE JULIO.EDITORIAL (
  CODIGO  char(5) constraint pk_editorial primary key,
  NOMBRE  varchar2(25) not null constraint nombre_edi check (upper(nombre) in ('anaya','santillana','sm'))
) TABLESPACE DATOS;

CREATE TABLE JULIO.LIBRO (
  ISBN  char(13) constraint pk_libro primary key,
  TITULO  varchar2(25) not null,
  EDITORIAL char(5) not null constraint fk_libro references  editorial,
  FEC_EDI date
) TABLESPACE DATOS;

INSERT INTO JULIO.editorial VALUES ('edit1','anaya');
INSERT INTO JULIO.editorial VALUES ('edit2','santillana');
alter session set nls_date_format='DD/MM/YYYY';
INSERT INTO JULIO.libro VALUES ('978-123456789','libro1','edit1','10/10/2019');

