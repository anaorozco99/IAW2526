
/*1. Obtener el codigo del coche , nombre y modelo distribuido por algún concesionario de
Barcelona. No puede salir ninguna tupla repetida*/

SELECT DISTINCT co.codcoche, co.nombre, co.modelo 
FROM coches co, concesionario con, distribucion di
WHERE co.codcoche = di.codcoche AND con.cifc = di.cifc AND ciudad = 'BARCELONA';



/*2. Obtener el código de los coches de aquellos coches vendidos a clientes de Madrid.*/

SELECT CO.CODCOCHE
FROM COCHES CO, CLIENTES CLI, VENTAS VEN
WHERE CO.CODCOCHE = VEN.CODCOCHE AND VEN.DNI = CLI.DNI AND ciudad = 'MADRID';

/*3. Obtener nombre y apellido de los clientes que han adquirido algun coche del concesionario
Dcar (Realizarlo con subconsulta)*/

SELECT CLI.NOMBRE, CLI.APELLIDO 
FROM CLIENTES CLI, CONCESIONARIOS CON, VENTAS VEN
WHERE CON.CIFC = VEN.CIFC AND CLI.DNI = VEN.DNI AND UPPER(CON.NOMBRE) = 'DCAR';

SELECT NOMBRE, APELLIDO
FROM CLIENTES
WHERE DNI IN (SELECT DNI FROM VENTAS WHERE CIFC IN (SELECT CIFC FROM CONCESIONARIOS WHERE UPPER(NOMBRE) = 'DCAR'));

/*4. Obtener el nombre y la cantidad total de coche que ha distribuido cada concesionario
(agrupamiento).*/

SELECT NOMBRE, SUM(CANTIDAD) 
FROM CONCESIONARIOS CON, DISTRIBUCION DIS 
WHERE CON.CIFC = DIS.CIFC 
GROUP BY NOMBRE;

/*5. Obtener el nombre de las marcas que tienen modelo gti*/

SELECT DISTINCT(MAR.NOMBRE) 
FROM COCHES CO, MARCAS MAR, MARCO MCO 
WHERE MAR.CIFM = MCO.CIFM AND CO.CODCOCHE = MCO.CODCOCHE AND UPPER(MODELO) = 'GTI';

/*6. Obtener los nombres de los coches que no tienen modelo gtd (usar operación de conjunto)*/

SELECT NOMBRE FROM COCHES 
MINUS 
SELECT NOMBRE FROM COCHES WHERE MODELO = 'gtd';

/*7. Obtener el cif de todos los concesionarios que disponen de una cantidad de coches
comprendida entre 10 y 18 unidades (agrupamiento con having).*/

SELECT CON.CIFC, SUM(CANTIDAD)
FROM CONCESIONARIOS CON, DISTRIBUCION DIS 
WHERE CON.CIFC = DIS.CIFC 
GROUP BY CON.CIFC 
HAVING SUM(CANTIDAD) BETWEEN 10 AND 18;

/*8. Obtener dni, nombre y apellido de todos los clientes, mostrando el código de coche
que han comprado.*/

SELECT CLI.DNI, NOMBRE, APELLIDO, CODCOCHE 
FROM CLIENTES CLI, VENTAS VEN 
WHERE CLI.DNI = VEN.DNI;

/*9. Obtener el codcoche de los coches que han sido adquiridos por un cliente de Madrid en
un concesionario de Madrid*/

SELECT CODCOCHE 
FROM VENTAS VEN, CONCESIONARIOS CON, CLIENTES CLI
WHERE CLI.DNI = VEN.DNI AND CON.CIFC = VEN.CIFC AND UPPER(CON.CIUDAD) = 'MADRID' AND UPPER(CLI.CIUDAD) ='MADRID';

/*10. Obtener los codche de los coches comprados en un concesionario de la misma ciudad
que el cliente que lo compra*/

SELECT CODCOCHE
FROM VENTAS VEN, CONCESIONARIOS CON, CLIENTES CLI
WHERE CLI.DNI = VEN.DNI AND CON.CIFC = VEN.CIFC AND CLI.CIUDAD = CON.CIUDAD;


/*11. Obtener todas las parejas de nombre de marcas que sean de la misma ciudad*/

SELECT MA1.NOMBRE, MA2.NOMBRE, MA1.CIUDAD, MA2.CIUDAD
FROM MARCAS MA1, MARCAS MA2
WHERE MA1.CIUDAD = MA2.CIUDAD AND MA1.NOMBRE > MA2.NOMBRE;

/*12. Obtener las parejas de modelos de coches cuyo nombre es el mismo y cuya marca es de
Bilbao*/

SELECT CO1.MODELO, CO2.MODELO
FROM COCHES CO1, COCHES CO2, MARCAS MAR, MARCO MCO
WHERE MAR.CIFM = MCO.CIFM AND CO1.CODCOCHE = MCO.CODCOCHE AND CO2.CODCOCHE = MCO.CODCOCHE AND CO1.NOMBRE = CO2.NOMBRE AND UPPER(CIUDAD) ='BILBAO';

/*13. Obtener el nombre y el apellido de los clientes que han adquieridos un coche modelo gti
de color blanco (realizar con subconsultas)*/

SELECT CLI.NOMBRE, APELLIDO
FROM CLIENTES CLI, VENTAS VEN, COCHES CO
WHERE CLI.DNI = VEN.DNI AND CO.CODCOCHE = VEN.CODCOCHE AND UPPER(COLOR) = 'BLANCO' AND UPPER(MODELO) = 'GTI';

SELECT NOMBRE, APELLIDO
FROM CLIENTES
WHERE DNI IN (SELECT DNI FROM VENTAS WHERE UPPER(COLOR) = 'BLANCO' AND CODCOCHE IN (SELECT CODCOCHE FROM COCHES WHERE UPPER(MODELO) = 'GTI'));

