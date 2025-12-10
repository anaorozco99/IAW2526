INSERT
  INTO Pizzas (codigo, nombre, medida, precio_base)
  VALUES (1,'Jalisco','M',10.5);
INSERT
  INTO Pizzas (codigo,nombre, medida, precio_base)
  VALUES (2,'Jalisco','G',12);
INSERT
  INTO Pizzas (codigo,nombre, medida, precio_base)
  VALUES (3,'Ahumados ','M',9.5);
INSERT
  INTO Pizzas (codigo,nombre, medida,precio_base)
  VALUES (4,'Ahumados ','G',11);
INSERT
  INTO Pizzas (codigo,nombre, medida,precio_base)
  VALUES (5,'Carbonara ','M',10);
INSERT
  INTO Pizzas (codigo,nombre, medida,precio_base)
  VALUES (6,'Carbonara','G',12.20);
INSERT
  INTO Pizzas (codigo,nombre, medida,precio_base)
  VALUES (7,'Chips ','M',11.5);
INSERT
  INTO Pizzas (codigo,nombre, medida,precio_base)
  VALUES (8,'Chips','G',14);
INSERT
  INTO Pizzas (codigo,nombre, medida,precio_base)
  VALUES (9,'BASE','P',4);
INSERT
  INTO Pizzas (codigo,nombre, medida,precio_base)
  VALUES (10,'BASE ','M',5);
INSERT
  INTO Pizzas (codigo,nombre, medida,precio_base)
  VALUES (11,'BASE','G',6);


INSERT  INTO Clientes 
  VALUES (11111,'Jose','Lopez Lopez','Saravia 1','957466633','11111111A');
INSERT  INTO Clientes 
  VALUES (11112,'Jorge','Garcia Garcia','Avenida America 4','913433633','22222222B');
INSERT INTO Clientes 
  VALUES (11113,'Gonzalo','Castillo Castillo','Cruz Conde 2', '913433633','33333333C');
INSERT INTO Clientes 
  VALUES (11114,'Maria','Jimenez Jimenez','La Paz 23','913433553', '44444444D');
INSERT INTO Clientes 
  VALUES (11115,'Rafael','Latorre Latorre','La Paz 13','983433553', '55555555E');
INSERT INTO Clientes 
 VALUES (11116,'Juana','Castillo Jimenez','Saravia 13','916633553', '66666666F');
INSERT INTO Clientes 
  VALUES (11117,'Joel','Tiger Tiger','La Paz 43','984533553', '77777777G');

INSERT  INTO Repartidores 
  VALUES ('22222222T','Jorge Lopez', 'Sco1','19/08/2000','20/08/2019');
INSERT INTO Repartidores
 VALUES ('33333333U','Juan Garcia','Sco2','02/11/2001','01/01/2020');
INSERT INTO Repartidores 
  VALUES ('44444444G','Javier Garcia', 'Sco3','04/05/2001','01/06/2020');
INSERT INTO Repartidores 
  VALUES ('55555555I','Gustavo Garcia','Sco4','19/08/2002','06/01/2020');
INSERT INTO Repartidores 
  VALUES ('66666666F','Juana Castillo','Sco5','20/10/2002','15/11/2020');

INSERT INTO TiposPedidos VALUES ('L',1.5, 12);
INSERT INTO TiposPedidos VALUES ('R',1, 14);
INSERT INTO TiposPedidos VALUES ('D', 3.5, 18);

INSERT INTO Pedidos VALUES (111,'08/06/2020','L',11111,'22222222T', 120.5);
INSERT INTO Pedidos VALUES (112,'06/01/2020','R',11112,'33333333U', 10.5);
INSERT INTO Pedidos VALUES (113,'05/11/2022','D',11113,'44444444G', 19);
INSERT INTO Pedidos VALUES (114,'20/02/2021','D',11114,'55555555I', 22);
INSERT INTO Pedidos VALUES (115,'16/08/2021','L',11115,'22222222T', 31.5);
INSERT INTO Pedidos VALUES (116,'20/02/2021','R',11116,'44444444G', 23);
INSERT INTO Pedidos VALUES (117,'10/06/2021','R',11117,'33333333U', 4);
INSERT INTO Pedidos VALUES (118,'15/08/2021','R',11116,'44444444G', 10);
INSERT INTO Pedidos VALUES (119,'10/10/2021','L',11112,'22222222T', 31.5);
INSERT INTO Pedidos VALUES (120,'10/01/2022','L',11113,'22222222T', 24);
INSERT INTO Pedidos VALUES (121,'08/01/2022','L',11114,'22222222T', 12);
INSERT INTO Pedidos VALUES (122,'07/01/2023','L',11115,'22222222T', 9.5);
INSERT INTO Pedidos VALUES (123,'07/01/2023','L',11116,'22222222T', 10.5);
INSERT INTO Pedidos VALUES (124,'07/01/2023','L',11117,'44444444G', 32);

INSERT INTO PedidosPizzas VALUES (111,1,5);
INSERT INTO PedidosPizzas VALUES (111,3,4);
INSERT INTO PedidosPizzas VALUES (111,5,3);
INSERT INTO PedidosPizzas VALUES (112,1,1);
INSERT INTO PedidosPizzas VALUES (113,3,2);
INSERT INTO PedidosPizzas VALUES (114,4,2);
INSERT INTO PedidosPizzas VALUES (115,1,3);
INSERT INTO PedidosPizzas VALUES (116,7,2);
INSERT INTO PedidosPizzas VALUES (117,9,1);
INSERT INTO PedidosPizzas VALUES (118,10,2);
INSERT INTO PedidosPizzas VALUES (119,1,3);
INSERT INTO PedidosPizzas VALUES (120,2,2);
INSERT INTO PedidosPizzas VALUES (121,2,1);
INSERT INTO PedidosPizzas VALUES (122,3,1);
INSERT INTO PedidosPizzas VALUES (123,3,1);
INSERT INTO PedidosPizzas VALUES (124,3,1);
INSERT INTO PedidosPizzas VALUES (124,2,1);
INSERT INTO PedidosPizzas VALUES (124,1,1);
commit;





