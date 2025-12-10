rem está los ejercicios en  folio EMPLE Y DEPART 21FEB

rem 1. ***********  

rem ordena los departamentos con los apellidos de los empleados y los agrupa
SELECT dept_no, apellido
FROM emple
ORDER BY dept_no;

rem sale el número de empleados que hay en cada departamento
SELECT dept_no, count(*)
FROM emple
GROUP BY dept_no;

rem 2. ***********

SELECT dept_no, AVG(salario)
FROM emple
GROUP BY dept_no;

rem 3. ***********

SELECT oficio, COUNT(oficio)
FROM emple
GROUP BY oficio;

rem 4. ***********

SELECT dept_no, SUM(salario), MAX(salario), MIN(salario)
FROM emple
GROUP BY dept_no
ORDER BY MIN(salario);

rem CARMBIAR FORMATO : lo mismo pero pasando el number a char DONDE PONEMOS G PUNTOS Y 9 PARA CARACTER lo que está en comillas dobles "" es para cambiar nombre del nombre de la columna que crea

SELECT
    DEPT_NO,
    TO_CHAR(SUM(SALARIO), '9G999G999G9') "Suma",
    TO_CHAR(MAX(SALARIO), '9G999G999G9') "Máximo",
    TO_CHAR(MIN(SALARIO), '9G999G999G9') "Mínimo"
FROM
    EMPLE
GROUP BY
    DEPT_NO
ORDER BY
    MIN(SALARIO);

rem 5. ***********

SELECT dept_no, count(*)
FROM emple
GROUP BY dept_no
HAVING count(*)>4;

rem 6. ***********

SELECT dept_no, oficio, count(emp_no)
FROM emple
GROUP BY dept_no, oficio
ORDER BY dept_no;

rem hay q poner dept_no porque sino da error de sintaxis: cualquier cosa q este en el select y no sea count o lo q sea xd debe ir en el group by


rem ahora en vez de mostrar solo el cod del dept que muestre el nombre de la tabla depart

SELECT e.dept_no, dnombre, oficio, count(*)
FROM emple e, depart d
WHERE e.dept_no=d.dept_no
GROUP BY e.dept_no,dnombre oficio
ORDER BY e.dept_no;



rem 7. ***********

rem así nos sale el mayor numero de empleados pero sin departamento
SELECT MAX(count(*))
FROM emple
GROUP BY dept_no



rem 8. ***********


rem así nos sale una tabla con numero dept y el numero total de todos los empleados de ese dept.
SELECT dept_no, count(*)
FROM emple
GROUP BY dept_no;

rem subconsulta
SELECT dept_no, count(*)
FROM emple
GROUP BY dept_no
HAVING count(*)= 
(SELECT MAX(count(*))
FROM emple
GROUP BY dept_no);









