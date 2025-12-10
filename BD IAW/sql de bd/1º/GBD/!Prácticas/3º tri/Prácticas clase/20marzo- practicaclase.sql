Modifica los nombres de todos los propietarios de un piso en un bloque de casas 
de las calles  que empiezan por da y estan en el numero 20

UPDATE  persona SET  nombre_persona= 'Ana'
WHERE dni IN
(SELECT dni_p 
FROM piso
WHERE calle LIKE 'Da%' AND numero= 20);


Borrar las casas particulares de menos de 100 metros que estén situadas en 
la zona urbana 'SUBURBIO TERMINAL'.

DELETE FROM  casaparticular 
WHERE (calle, numero) IN 
(SELECT calle, numero
FROM vivienda
WHERE UPPER(nombre_zona) = 'SUBURBIO TERMINAL') 
AND metros_c < 100;

rem metros debe ir fuera de la subconsulta porque va fuera de la subconsulta
