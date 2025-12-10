alter session set nls_date_format='yyyy-mm-dd';

REM ************* INSERTAMOS EN PELICULAS


INSERT INTO peliculas VALUES (1, 'El dia de la bestia', 100, 'Comedia', 'NR18', 1995, '2004-02-13', 'España', 3);
INSERT INTO peliculas VALUES (2, 'Casper', 96, 'Infantil', 'TD', 1994, '2004-01-10', 'EE.UU.', 3.5);
INSERT INTO peliculas VALUES (3, 'El primer caballero', 129, 'Aventuras', 'TD', 1995, '2004-10-05', 'EE.UU.', 3);
INSERT INTO peliculas VALUES (4, 'Two Much', 113, 'Comedia', 'TD', 1995, '2004-10-05', 'España', 3.5);
INSERT INTO peliculas VALUES (5, 'Extasis', 88, 'Drama', 'NR18', 1996, '2005-01-02', 'España', 4);
INSERT INTO peliculas VALUES (6, 'Cadena Perpetua', 136, 'Drama', 'NR13', 1994, '2004-03-10', 'EE.UU.', 3);
INSERT INTO peliculas VALUES (7, 'Cuando sali de Cuba', 109, 'Comedia', 'TD', 1995, '2004-06-05', 'EE.UU.', 3.5);
INSERT INTO peliculas VALUES (8, 'Felpudo Maldito', 103, 'Comedia', 'NR13', 1995, '2004-03-05', 'Francia', 4);
INSERT INTO peliculas VALUES (9, 'Congo', 104, 'Aventuras', 'NR13', 1995, '2004-05-03', 'EE.UU.', 3.5);
INSERT INTO peliculas VALUES (10, 'Desperado', 100, 'Accion', 'NR18', 1995, '2004-01-04', 'EE.UU.', 3);
INSERT INTO peliculas VALUES (11, 'Seven', 122, 'Suspense', 'NR18', 1995, '2004-05-03', 'EE.UU.', 4);
INSERT INTO peliculas VALUES (12, 'Apolo 13', 135, 'Accion', 'TD', 1995, '2004-06-02', 'EE.UU.', 4);
INSERT INTO peliculas VALUES (13, 'El silencio de los corderos', 114, 'Suspense', 'NR18', 1991, '2004-02-10', 'EE.UU.', 3);
INSERT INTO peliculas VALUES (14, 'Pena de muerte', 117, 'Drama', 'NR13', 1995, '2004-03-11', 'EE.UU.', 4);
INSERT INTO peliculas VALUES (15, 'Babe, el cerdito valiente', 88, 'Infantil', 'TD', 1995, '2004-03-05', 'Australia', 3.5);
INSERT INTO peliculas VALUES (16, 'Tesis', 119, 'Suspense', 'NR18', 1995, '2004-05-20', 'España', 4);


REM ********** INSERTAMOS EN SOCIOS

INSERT INTO socios VALUES (1, 'Antonio Lopez Carmona', '2004-02-01', '23106595D', 'Alamos 23, 2B', '999231212');
INSERT INTO socios VALUES (2, 'Rosa Cobo Garcia', '2004-12-14', '26897656E', 'Olivo 4, 5B', '999224578');
INSERT INTO socios VALUES (3, 'Maria Marmol Lopez', '2004-05-05', '27005559W', 'Av. Madrid 9, 7A', '999270765');
INSERT INTO socios VALUES (4, 'Angel Baena Morales', '2004-07-10', '26588955J', 'La luna 2, 4A', '999235568');
INSERT INTO socios VALUES (5, 'Nuria Nuñez Jurado', '2004-12-07', '26558936V', 'Almeria 7', '999270012');
INSERT INTO socios VALUES (6, 'Salvador Ortega Rus', '2004-03-18', '27501459X', 'Ceron 3', '999224451');
INSERT INTO socios VALUES (7, 'Fatima Zafra Torres', '2004-11-20', '25741697A', 'Av. Madrid 4, 1B', '999226878');
INSERT INTO socios VALUES (8, 'Carlos Lopez Cano', '2004-10-15', '26543887B', 'Av. Madrid 13', '999235847');
INSERT INTO socios VALUES (9, 'Teresa Sanchez Lopez', '2004-03-19', '27148963G', 'Nogal 6', '999274556');
INSERT INTO socios VALUES (10, 'Rafael Montoro Hoz', '2004-10-15', '24151589P', 'Almeria 22', '999259633');
INSERT INTO socios VALUES (11, 'Antonio Olmo Garcia', '2004-01-20', '27711498D', 'Baeza 12, 5A', '999277415');
INSERT INTO socios VALUES (12, 'Alejandra Bueno Diaz', '2004-12-15', '26003201H', 'Nogal 5', '999236594');
INSERT INTO socios VALUES (13, 'Miguel Armas Ruiz', '2004-01-20', '28565225C', 'Cañamaque 12', '999232367');


REM ********* INSERTAMOS EN PRESTAMOS

INSERT INTO prestamos VALUES (1, 4, '2005-05-03', '2005-05-05');
INSERT INTO prestamos VALUES (5, 7, '2005-05-12', '2005-05-13');
INSERT INTO prestamos VALUES (16, 3, '2005-05-12', '2005-05-17');
INSERT INTO prestamos VALUES (11, 2, '2005-05-20', '2005-05-21');
INSERT INTO prestamos VALUES (4, 8, '2005-06-01', '2005-06-03');
INSERT INTO prestamos VALUES (6, 8, '2005-06-01', '2005-06-03');
INSERT INTO prestamos VALUES (16, 3, '2005-06-07', '2005-06-08');
INSERT INTO prestamos VALUES (11, 2, '2005-06-24', '2005-06-30');
INSERT INTO prestamos VALUES (2, 4, '2005-07-15', '2005-07-16');
INSERT INTO prestamos VALUES (3, 9, '2005-07-19', '2005-07-20');
INSERT INTO prestamos VALUES (11, 5, '2005-07-19', '2005-07-25');
INSERT INTO prestamos VALUES (13, 5, '2005-07-19', '2005-07-25');
INSERT INTO prestamos VALUES (4, 13, '2005-07-25', '2005-07-26');
INSERT INTO prestamos VALUES (16, 8, '2005-07-25', '2005-07-27');
INSERT INTO prestamos VALUES (5, 13, '2005-07-26', '2005-07-28');
INSERT INTO prestamos VALUES (16, 8, '2005-07-31', '2005-08-01');
INSERT INTO prestamos VALUES (11, 8, '2005-07-31', '2005-08-01');
INSERT INTO prestamos VALUES (16, 4, '2005-07-31', '2005-08-02');
INSERT INTO prestamos VALUES (16, 5, '2005-07-31', '2005-08-03');
INSERT INTO prestamos VALUES (4, 7, '2005-08-16', '2005-08-17');
INSERT INTO prestamos VALUES (14, 1, '2005-09-02', '2005-09-03');
INSERT INTO prestamos VALUES (14, 8, '2005-09-02', '2005-09-03');
INSERT INTO prestamos VALUES (4, 10, '2005-09-03', '2005-09-05');
INSERT INTO prestamos VALUES (10, 9, '2005-09-05', '2005-09-11');
INSERT INTO prestamos VALUES (16, 4, '2005-09-10', NULL);
INSERT INTO prestamos VALUES (11, 4, '2005-09-10', NULL);
INSERT INTO prestamos VALUES (10, 10, '2005-09-11', NULL);
INSERT INTO prestamos VALUES (2, 13, '2005-09-11', NULL);








