rem  Alta de entradas dentro de las tablas

insert into proveedores values ('PR1','CARLOS',20,'SEVILLA' );
insert into proveedores values ('PR2','JUAN',10,'MADRID' );
insert into proveedores values ('PR3','JOSE',30,'SEVILLA' );
insert into proveedores values ('PR4','INMA',20,'SEVILLA' );
insert into proveedores values ('PR5','EVA',30,'CACERES' );
insert into pieza values ('P1','X3A','ROJO',12,'SEVILLA');
insert into pieza values ('P2','B35','VERDE',17,'MADRID');
insert into pieza values ('P3','C4B','AZUL',17,'MALAGA');
insert into pieza values ('P4','C4B','ROJO',14,'SEVILLA');
insert into pieza values ('P5','VT8','AZUL',12,'MADRID');
insert into pieza values ('P6','C30','ROJO',19,'SEVILLA');

insert into envios values ('PR1','P1',200);
insert into envios values ('PR2','P3',400);
insert into envios values ('PR2','P4',200);
insert into envios values ('PR2','P5',100);
insert into envios values ('PR3','P3',200);
insert into envios values ('PR3','P4',500);
insert into envios values ('PR4','P6',300);
insert into envios values ('PR4','P5',300);
insert into envios values ('PR5','P2',200);
insert into envios values ('PR5','P3',100);
insert into envios values ('PR5','P5',500);
insert into envios values ('PR5','P6',200);
insert into envios values ('PR5','P1',100);
insert into envios values ('PR5','P4',800);