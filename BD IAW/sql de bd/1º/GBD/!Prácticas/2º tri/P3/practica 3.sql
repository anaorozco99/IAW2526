/*Creación de tablas*/

CREATE TABLE GALERIA (
  COD_GAL NUMBER(3) CONSTRAINT PK_GAL PRIMARY KEY,
  NOM_GAL VARCHAR2(20),
  ORIENTACION VARCHAR2(20) CONSTRAINT ORIENT_IN CHECK (ORIENTACION IN('Norte','Sur','Este','Oeste')),
  PRESUPUESTO NUMBER(10,2),
  GASTOS NUMBER(10,2)
);

CREATE TABLE OBRA (
  NOM_OBRA VARCHAR2(30) CONSTRAINT PK_OBRA PRIMARY KEY,
  NOM_AUTOR VARCHAR2(40),
  FECHA_CREAC DATE,
  COD_GAL NUMBER(3) CONSTRAINT FK_OBRA_GAL REFERENCES GALERIA
  );
  
CREATE TABLE ENCARGADOS (
  NIF_EMPLE CHAR(10) CONSTRAINT PK_ENCARG PRIMARY KEY,
  NOM_EMPLE VARCHAR2(20),
  APELL1_EMPLE VARCHAR2(15),
  APELL2_EMPLE VARCHAR2(15),
  FECHA_NAC DATE,
  SUELDO_BASE NUMBER(10,2),
  TRIENIOS NUMBER(2),
  N_HIJOS NUMBER(2)
);

CREATE TABLE CUIDAN (
  NIF_EMPLE CHAR(10) CONSTRAINT FK_CUIDAN_ENCARG REFERENCES ENCARGADOS,
  COD_GAL NUMBER(3) CONSTRAINT FK_CUIDAN_GAL REFERENCES GALERIA,
  CONSTRAINT PK_CUIDAN PRIMARY KEY (NIF_EMPLE, COD_GAL)
);

/*Inserción de datos*/

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

INSERT INTO GALERIA VALUES (1, 'Arte raro', 'Norte', 12000.00, 120.00);
INSERT INTO GALERIA VALUES (2, 'Pintura rupestre', 'Sur', 45000.00, 11223.23);
INSERT INTO GALERIA VALUES (3, 'Escultura en gachas', 'Este', 20000.00, 15000.00);
INSERT INTO GALERIA VALUES (4, 'Clavos de almanaque', 'Oeste', 200000.00, 123456.78);
COMMIT;

INSERT INTO OBRA VALUES ('Clavo número dos', 'Óscar Adura', '12/07/1985', 4);
INSERT INTO OBRA VALUES ('Clavo número uno', 'Óscar Adura', '20/12/1987', 4);
INSERT INTO OBRA VALUES ('El vacío mental', 'Begoña Cañaca', '10/01/1991', 1);
INSERT INTO OBRA VALUES ('La lucha entre uno', 'Marta Berna', '12/08/1998', 3);
INSERT INTO OBRA VALUES ('La noche y el día', 'Juanjo Dido', '08/09/1989', 1);
INSERT INTO OBRA VALUES ('Los amantes de Teruel', 'Pepe Tardo', '24/01/1998', 4);
INSERT INTO OBRA VALUES ('Perspectiva patrás', 'Enrique Jica', '30/12/1986', 2);
INSERT INTO OBRA VALUES ('Plato de gachas con clavos', 'Óscar Adura', '23/11/1997', 3);
INSERT INTO OBRA VALUES ('Tíos cazando un bisonte', 'Ana Vegar', '07/06/1987', 2);
COMMIT;

INSERT INTO ENCARGADOS VALUES ('11111111A', 'Manolo', 'Cabeza', 'Bolo', '22/03/1960', 12000.00, 6, 5);
INSERT INTO ENCARGADOS VALUES ('22222222E', 'Luisa', 'Pancha', 'Más', '31/01/1940', 34562.00, 8, 2);
INSERT INTO ENCARGADOS VALUES ('33333333L', 'Susana', 'Toma', 'Momia', '18/09/1950', 22.50, null, 1);
INSERT INTO ENCARGADOS VALUES ('44444444G', 'Pedro', 'Estaca', 'Flipado', '12/12/1930', 543.00, 3, 4);
INSERT INTO ENCARGADOS VALUES ('55555555A', 'Alberto', 'Fuerte', 'Delira', '04/06/1950', 0.60, 2, 1);
COMMIT;

INSERT INTO CUIDAN VALUES ('11111111A', 1);
INSERT INTO CUIDAN VALUES ('11111111A', 2);
INSERT INTO CUIDAN VALUES ('22222222E', 3);
INSERT INTO CUIDAN VALUES ('22222222E', 4);
INSERT INTO CUIDAN VALUES ('33333333L', 2);
INSERT INTO CUIDAN VALUES ('44444444G', 1);
INSERT INTO CUIDAN VALUES ('55555555A', 1);
INSERT INTO CUIDAN VALUES ('55555555A', 2);
INSERT INTO CUIDAN VALUES ('55555555A', 3);
INSERT INTO CUIDAN VALUES ('55555555A', 4);
COMMIT;

/*Consultas*/

/*1 Titulo de la obra, junto con su autor que hay en la galería 4*/

SELECT NOM_OBRA, NOM_AUTOR, COD_GAL FROM OBRA WHERE COD_GAL = 4;

/*2 Autores que exponen en la galería 3 o en la galería 4. No debe salir ninguna tupla 
repetida.*/

SELECT DISTINCT NOM_AUTOR FROM OBRA WHERE COD_GAL = 3 OR COD_GAL = 4;

/*3 Muestra todos los gastos de la galería ordenado descendentemente por gastos*/

SELECT GASTOS FROM GALERIA ORDER BY GASTOS DESC;

/*4 Muestra todos los datos de los encargados que tengan una u en el segundo lugar de su 
nombre
*/

SELECT NOM_EMPLE FROM ENCARGADOS WHERE SUBSTR(NOM_EMPLE, 2, 1) = 'u';

/*5 Nif de los encargados que cuidan la galería 2*/

SELECT NIF_EMPLE, COD_GAL FROM CUIDAN WHERE COD_GAL = 2;

/*6 Nombre completo, sueldo , nº de trienio y sueldo total, (el sueldo total es el sueldo base
junto con 100 euros por cada trienio) del encargado.*/

SELECT NOM_EMPLE, SUELDO_BASE, TRIENIOS, SUELDO_BASE + (100 * NVL(TRIENIOS,0)) "SUELDO TOTAL" FROM ENCARGADOS;

/*7 Nombre de la galería cuyos gastos este comprendido en 10.000 y 20.000 Euros*/

SELECT COD_GAL FROM GALERIA WHERE GASTOS BETWEEN 10000 AND 20000;

/*8 Titulo y autor de las obras que hayan sido creadas antes del año 1990 ordenada por 
autor*/

SELECT NOM_OBRA, NOM_AUTOR FROM OBRA WHERE FECHA_CREAC < '01/01/1990';

/*9 Autor de la obra “Los amantes de Teruel”.*/

SELECT NOM_AUTOR FROM OBRA WHERE UPPER(NOM_OBRA) = 'LOS AMANTES DE TERUEL';

/*10 Numero de encargados que tienen trienios (Función: Count)*/

SELECT COUNT(TRIENIOS) FROM ENCARGADOS;








