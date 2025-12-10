DROP TABLE ARRESTAR CASCADE CONSTRAINTS;
DROP TABLE DELINCUENTE CASCADE CONSTRAINTS;
DROP TABLE POLICIA CASCADE CONSTRAINTS;

CREATE TABLE POLICIA
(
  CODIGO CHAR(4) CONSTRAINT PK_POLI PRIMARY KEY,
  NOMBRE VARCHAR2(25) NOT NULL,
  APELLIDO VARCHAR2(25) NOT NULL,
  FUNCION VARCHAR2(25),
  JEFE CHAR(4) CONSTRAINT FK_jefe REFERENCES POLICIA
);

CREATE TABLE DELINCUENTE
(
  CODIGO CHAR(4) CONSTRAINT PK_DELIC PRIMARY KEY,
  NOMBRE VARCHAR2(25)NOT NULL,
  ALIAS VARCHAR2(25),
  FECHNAC DATE NOT NULL,   
  NUMVECES NUMBER(2)
);

CREATE TABLE ARRESTAR
(
  COD_POL CHAR(4) CONSTRAINT FK_ARR_POL REFERENCES POLICIA,
  COD_DEL CHAR(4) CONSTRAINT FK_ARR_DEL REFERENCES DELINCUENTE,
  FECHA_ARRESTO DATE,
  CONSTRAINT PK_ARRESTO PRIMARY KEY (COD_POL, COD_DEL, FECHA_ARRESTO)  
);

REM INSERTO EN POLICIA;

INSERT INTO POLICIA VALUES ('121P', 'Carmelo', 'Cotón', 'Inspector', NULL);
INSERT INTO POLICIA VALUES ('122P', 'Aitor', 'Tilla', 'Patrulla', '121P');
INSERT INTO POLICIA VALUES ('123P', 'Lola', 'Mento', 'Patrulla', '122P');
INSERT INTO POLICIA VALUES ('124P', 'Alan', 'Brito', 'Técnico', '121P');
INSERT INTO POLICIA VALUES ('125P', 'Encarna', 'Vales', 'Administrativo', '121P');
INSERT INTO POLICIA VALUES ('126P', 'Andrés', 'Trozado', 'Patrulla', '121P');
INSERT INTO POLICIA VALUES ('127P', 'Estela', 'Gartija', 'Patrulla', '126P');
INSERT INTO POLICIA VALUES ('128P', 'Jesús', 'Piro', 'Administrativo', '125P');


REM INSERTO EN DELINCUENTE;
alter session set nls_date_format ='DD/MM/YYYY';
INSERT INTO DELINCUENTE VALUES ('500D', 'Antonio García', NULL, '01/01/1995', 1);
INSERT INTO DELINCUENTE VALUES ('501D', 'Manuel Sánchez', 'Manos Largas', '02/02/2000', 12);
INSERT INTO DELINCUENTE VALUES ('502D', 'Jesús Pérez', 'Tortas City', '03/03/2002', 6);
INSERT INTO DELINCUENTE VALUES ('503D', 'Samuel García', 'El niño de Santiponce', '04/04/1999', 1);
INSERT INTO DELINCUENTE VALUES ('504D', 'Juan Carlos López', 'El Juanca', '05/05/2002', 1);
INSERT INTO DELINCUENTE VALUES ('505D', 'Matilde Vargas', 'Yayi', '06/06/2001', 6);
INSERT INTO DELINCUENTE VALUES ('506D', 'Pedro Núñez', NULL, '07/07/1994', 3);
INSERT INTO DELINCUENTE VALUES ('507D', 'Luis Gómez', 'Mecherito', '08/08/2003', 8);
INSERT INTO DELINCUENTE VALUES ('508D', 'Jesús Gutiérrez', 'El Chino', '09/09/2000', 9);
INSERT INTO DELINCUENTE VALUES ('509D', 'Martín Jiménez', 'Biberón', '10/10/2001', 2);
INSERT INTO DELINCUENTE VALUES ('510D', 'Sebastiana Ruiz', 'La Chana', '11/11/1994', 5);

REM INSERTO EN ARRESTAR;

INSERT INTO ARRESTAR VALUES ('122P', '500D','01/10/2020');
INSERT INTO ARRESTAR VALUES ('122P', '500D','01/12/2023');
INSERT INTO ARRESTAR VALUES ('121P', '508D','10/5/2020');
INSERT INTO ARRESTAR VALUES ('126P', '510D','12/10/2021');
INSERT INTO ARRESTAR VALUES ('123P', '503D','13/1/2021');
INSERT INTO ARRESTAR VALUES ('121P', '503D','14/2/2022');
INSERT INTO ARRESTAR VALUES ('121P', '501D','14/8/2022');
INSERT INTO ARRESTAR VALUES ('127P', '502D','12/9/2023');
INSERT INTO ARRESTAR VALUES ('127P', '505D','21/11/2023');
INSERT INTO ARRESTAR VALUES ('127P', '504D','11/10/2022');
INSERT INTO ARRESTAR VALUES ('126P', '505D','01/10/2022');
INSERT INTO ARRESTAR VALUES ('127P', '510D','11/10/2020');
INSERT INTO ARRESTAR VALUES ('122P', '510D','21/10/2020');

COMMIT;


rem Ana Orozco

rem Pregunta 1:
SELECT d.nombre, d.alias, d.fechnac, p.nombre AS PoliciaArresto
FROM delincuente d, policia p, arrestar a
WHERE a.cod_pol=p.codigo and a.cod_del=d.codigo 
and a.fecha_arresto BETWEEN '01/01/2020' AND '31/12/2020';



rem Pregunta 2:
Select nombre, apellido from policia where codigo  in
(select codigo from policia where funcion='Inspector');





rem Pregunta 3:
select p1.nombre, p2.nombre
from policia p1, policia p2
where p1.funcion=p2.funcion
and p1.nombre > p2.nombre;




rem Pregunta 4:
SELECT * FROM delincuente
WHERE NumVeces  IN (Select max(NumVeces) from delincuente);


rem Pregunta 5:
select nombre, funcion from policia where codigo in (
select a.cod_pol
from arrestar a, policia p
group by a.cod_pol
having count(*)>=3);





rem Pregunta 6:
SELECT nombre, jefe FROM policia;




rem Pregunta 7:
SELECT  d.nombre, d.alias, COUNT(cod_del)
FROM delincuente d, arrestar a
where a.cod_del(+)=d.codigo
GROUP BY d.nombre, d.alias;


rem Pregunta 8:
SELECT * FROM policia
MINUS
SELECT a.cod_pol, COUNT(a.cod_pol)
FROM arrestar a, delincuente d
where a.cod_pol=d.codigo 
GROUP BY a.cod_pol
having count(a.cod_pol)=0;







