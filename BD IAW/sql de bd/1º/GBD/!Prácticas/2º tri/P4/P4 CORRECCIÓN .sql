/*PREGUNTA 1: a partir de eer realizar modelo relacional y después sql de creación tablas*/

CREATE TABLE editorial (
cod_editorial VARCHAR2(20) CONSTRAINT pk_codedit PRIMARY KEY,
nombreedit VARCHAR2(20) ----CONSTRAINT nt_nombreedit NOT NULL---- ,
CONSTRAINT ck_nombreedit CHECK (nombreedit IN('Anaya', 'Santillana', 'SM'))
);  /*la constraint check en este sql es de tabla por lo q pondremos coma, los NULL Y NOT NULL no necesitan nombres de restriccion*/


CREATE TABLE libro (
isbn VARCHAR2(16) CONSTRAINT pk_isbn PRIMARY KEY,
titulolibro VARCHAR2(30) ----CONSTRAINT nt_titulo NOT NULL----,
fechaedicion DATE ----CONSTRAINT unique_fechae UNIQUE----,
cod_editorial VARCHAR2(20) CONSTRAINT fk_codedit REFERENCES editorial
);
/* en esta fecha NO se pone unique */


/* al poner esto ponemos el formato de fecha */
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

INSERT INTO editorial VALUES ('edit1', 'Anaya');
INSERT INTO editorial VALUES ('edit2', 'Santillana');
INSERT INTO libro VALUES ('978-123456789', 'libro1', '10/10/2022', 'edit1');


/*PREGUNTA 2*/

ALTER TABLE libro ADD precio NUMBER(5,2) CONSTRAINT nullprecio NULL;

ALTER TABLE libro DROP CONSTRAINT unique_fechae;


/*ELIMINAR PK PARA CREAR PK CONJUNTA*/

ALTER TABLE libro DROP CONSTRAINT pk_isbn;

ALTER TABLE libro ADD CONSTRAINT pk_isbnfecha PRIMARY KEY (isbn,fechaedicion);
/*hay otra solución que es creando otra tabla que se llama edición y con UPDATE que veremos más adelante*/


/*METER EL DATO NUEVO*/

INSERT INTO libro VALUES ('978-123456789', 'libro1', sysdate , 'edit1', 12.36 );

commit; /* para guardar de forma permanente los datos*/

