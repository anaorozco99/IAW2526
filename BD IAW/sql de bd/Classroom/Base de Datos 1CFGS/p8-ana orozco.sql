/*CONSULTAS*/

/*1. Cuantos alumnos hay matriculados en cada asignatura. (mostrar el idAsignatura )
Idem mostrando el nombre de cada asignatura.*/

SELECT a.idAsignatura, COUNT(alu.Iidalumno)
FROM ualumno alu, uasignatura a, ualumno_uasignatura alua
WHERE alu.idalumno = alua.idalumno AND a.idAsignatura = alua.idAsignatura
GROUP BY a.idAsignatura;

rem asignatura:

SELECT a.idAsignatura, a.nombre, COUNT(alu.Iidalumno)
FROM ualumno alu, uasignatura a, ualumno_uasignatura alua
WHERE alu.idalumno = alua.idalumno AND a.idAsignatura = alua.idAsignatura
GROUP BY a.idAsignatura, a.nombre;

/*2. Cual es el coste básico total en cada titulación.
Crear otra variante mostrando el nombre de la titulación.*/

SELECT t.idtitulacion, SUM(costebasico)
FROM uasignatura a, utitulacion t
WHERE a.idtitulacion = t.idtitulacion
GROUP BY t.idtitulacion;

rem titulacion:

SELECT t.idtitulacion, t.nombre, SUM(costebasico)
FROM uasignatura a, utitulacion t
WHERE a.idtitulacion = t.idtitulacion
GROUP BY t.idtitulacion, t.nombre;

/*3. Coste medio (pormedio) de las asignaturas de cada titulación, para aquellas titulaciones en el que
el coste total de la 1a matrícula sea mayor que 60 euros.*/

SELECT AVG(costebasico), idtitulacion
FROM uasignatura
GROUP BY idtitulacion
HAVING SUM(costebasico) > 60;

/*4. Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez.*/

SELECT idalumno
FROM ualumno_uasignatura
WHERE idAsignatura = '150212'
INTERSECT
SELECT idalumno
FROM ualumno_uasignatura
WHERE idAsignatura = '130113';


/*5. Id de los alumnos matriculados en las asignatura "150212" ó "130113", en una o en otra pero no
en ambas a la vez.*/

-

/*6. Mostrar el DNI de alumnos y profesores.*/

SELECT nif FROM ualumno
UNION
SELECT nif FROM uprofesor;

/*7. Lo mismo pero con filas repetidas:*/

SELECT nif FROM ualumno
UNION ALL
SELECT nif FROM uprofesor;

/*8. DNI de los profesores que también son alumnos.*/

SELECT nif 
FROM uprofesor
WHERE nif IN (SELECT nif FROM ualumno)


/*9. DNI de las personas que no son alumnos ni profesores.*/

SELECT nif
FROM upersona
WHERE nif NOT IN (SELECT nif FROM ualumno)
AND nif NOT IN (SELECT nif FROM uprofesor);


/*10. Lista de asignaturas en las que no se ha matriculado nadie.*/

SELECT idAsignatura
FROM uasignatura
WHERE idAsignatura NOT IN (SELECT IdAsignatura FROM alumno_UASIGNATURA);


/*11. Ciudades en las que vive algún profesor y también algún alumno.*/

SELECT DISTINCT ciudad
FROM upersona
WHERE nif IN (SELECT nif FROM uprofesor UNION SELECT nif FROM ualumno);

/*12. Ciudades en las que vive algún profesor pero ningún alumno.*/

SELECT DISTINCT ciudad
FROM upersona
WHERE nif IN (SELECT nif FROM uprofesor  SELECT nif FROM ualumno);
