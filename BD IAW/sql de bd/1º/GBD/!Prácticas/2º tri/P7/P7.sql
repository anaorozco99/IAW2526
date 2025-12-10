
/*Práctica 7*/


/*1. Obtener el codigo del coche , nombre y modelo distribuido por algún concesionario de
Barcelona. No puede salir ninguna tupla repetida*/

SELECT DISTINCT co.codcoche, co.nombre, co.modelo 
FROM coches co, concesionario con, distribucion di
WHERE co.codcoche = di.codcoche AND con.cifc = di.cifc AND ciudad = 'Barcelona';



/*2. Obtener el código de los coches de aquellos coches vendidos a clientes de Madrid.*/

SELECT co.codcoche
FROM coches co, clientes cli, ventas ve
WHERE co.codcoche = ve.codcoche AND ve.dni = cli.dni AND ciudad = 'Madrid';

/*3. Obtener nombre y apellido de los clientes que han adquirido algun coche del concesionario
Dcar (Realizarlo con subconsulta)*/


SELECT nombre, apellido
FROM clientes
WHERE dni IN (
    SELECT dni
    FROM ventas
    WHERE cifc IN (
        SELECT cifc
        FROM concesionario
        WHERE nombre = 'Dcar'
    )
);

/*4. Obtener el nombre y la cantidad total de coche que ha distribuido cada concesionario
(agrupamiento).*/

SELECT nombre, SUM(cantidad) 
FROM concesionario c, distribucion d
WHERE c.cifc = d.cifc
GROUP BY nombre;

/*5. Obtener el nombre de las marcas que tienen modelo gti*/

SELECT DISTINCT(m.nombre) 
FROM coches c, marcas m, marco ma
WHERE m.cifm = ma.cifm AND c.codcoche = ma.codcoche AND modelo = 'gti';

/*6. Obtener los nombres de los coches que no tienen modelo gtd (usar operación de conjunto)*/

SELECT nombre 
FROM coches 
where modelo NOT IN (
    SELECT modelo
    FROM coches
    where modelo LIKE 'gtd'
);


/*7. Obtener el cif de todos los concesionarios que disponen de una cantidad de coches
comprendida entre 10 y 18 unidades (agrupamiento con having).*/

SELECT c.cifc
FROM concesionario c, distribucion d
WHERE c.cifc = d.cifc
GROUP BY c.cifc
HAVING COUNT(cantidad) BETWEEN 10 AND 18;

/*8. Obtener dni, nombre y apellido de todos los clientes, mostrando el código de coche
que han comprado.*/

SELECT c.dni, nombre, apellido, codcoche
FROM cliente c, ventas v 
WHERE c.dni = v.dni;

/*9. Obtener el codcoche de los coches que han sido adquiridos por un cliente de Madrid en
un concesionario de Madrid*/

SELECT codcoche 
FROM ventas v, concesionario c, clientes cli
WHERE cli.dni = v.dni AND c.cifc = c.cifc AND cli.ciudad = 'Madrid' AND c.ciudad ='Madrid';

/*10. Obtener los codche de los coches comprados en un concesionario de la misma ciudad
que el cliente que lo compra*/

SELECT codcoche
FROM ventas v, concesionario c, clientes cli
WHERE cli.dni = v.dni AND c.cifc = v.cifc AND cli.ciudad = c.ciudad;


/*11. Obtener todas las parejas de nombre de marcas que sean de la misma ciudad*/




/*12. Obtener las parejas de modelos de coches cuyo nombre es el mismo y cuya marca es de
Bilbao*/



/*13. Obtener el nombre y el apellido de los clientes que han adquieridos un coche modelo gti
de color blanco (realizar con subconsultas)*/

SELECT nombre, apellido
FROM clientes
WHERE dni IN (
    SELECT dni
    FROM ventas v
    WHERE codcoche IN (
        SELECT codcoche
        FROM coches
        WHERE modelo IN (
            SELECT modelo
            FROM coches
            WHERE modelo = 'gti'
        )
        AND v.color = 'blanco'
    )
);

