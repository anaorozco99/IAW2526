
CREATE TABLE Pizzas  (
  codigo NUMBER(3) CONSTRAINT PKPIZZA PRIMARY KEY,
  nombre VARCHAR2(10) NOT NULL,
  medida CHAR(1) NOT NULL,
  precio_base NUMBER(4,2)
);


CREATE TABLE Clientes  (
  codigo number(5) CONSTRAINT pk_clientes PRIMARY KEY,
  nombre VARCHAR2(20) NOT NULL,
  apellidos VARCHAR2(40) NOT NULL,
  direccion VARCHAR2(30),
  telf varchar2(9),
  nif varchar2(9) unique NOT NULL);


CREATE TABLE Repartidores  (
  nif VARCHAR2(9) CONSTRAINT pk_repart PRIMARY KEY,
  nombre VARCHAR2(30) NOT NULL,
  scooter VARCHAR2(6) NOT NULL,
  fecha_nac date,
  fecha_ing date );

CREATE TABLE TiposPedidos  (
  clase VARCHAR2(10) constraint pk_tipoped primary key,
  incremento number(3,2),
  minimo number(2) NOT NULL,
  CONSTRAINT ck_tipoped check (clase in ('L','R','D'))
);


CREATE TABLE Pedidos  (
  codigo number CONSTRAINT pk_pedidos PRIMARY KEY , 
  fecha DATE NOT NULL,
  clase VARCHAR2(10) NOT NULL,
  codigo_c number(5),
  nif_r VARCHAR2(9),
  precio number NOT NULL,
  CONSTRAINT fk_ped_cli 
        FOREIGN KEY (codigo_c) REFERENCES clientes,
  CONSTRAINT fk_ped_rep
      FOREIGN KEY (nif_r) REFERENCES Repartidores,
  CONSTRAINT fk_ped_tpe
      FOREIGN KEY (clase) REFERENCES TiposPedidos);


CREATE TABLE PedidosPizzas  (
  codigo_ped number NOT NULL,
  codigo_pz number(3) NOT NULL,
  cantidad number,
  CONSTRAINT pk_PedidosPizzas PRIMARY KEY (codigo_ped,codigo_pz),
  CONSTRAINT fk_pp_ped FOREIGN KEY (codigo_ped) REFERENCES Pedidos,
  CONSTRAINT fk_pp_piz  FOREIGN KEY (codigo_pz) REFERENCES Pizzas);










