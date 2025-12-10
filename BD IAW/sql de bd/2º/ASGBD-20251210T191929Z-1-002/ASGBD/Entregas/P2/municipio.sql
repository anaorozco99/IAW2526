CREATE TABLE municipio(
codigo CHAR(5) CONSTRAINT pk_municipio PRIMARY KEY,
nombre VARCHAR2(25),
poblacion VARCHAR2(25)
) TABLESPACE personal;

CREATE TABLE vivienda(
codigo CHAR(5) CONSTRAINT pk_vivienda PRIMARY KEY,
habitaciones number(2),
metros number(5),
municipio CHAR(5) NOT NULL CONSTRAINT fk_vivienda REFERENCES municipio
) TABLESPACE personal;

CREATE TABLE persona(
codigo CHAR(5) CONSTRAINT pk_persona PRIMARY KEY,
nif CHAR(9) CONSTRAINT nif_persona UNIQUE not null,
nombre VARCHAR2(25),
apellidos VARCHAR2(25),
otros VARCHAR2(50),
habita CHAR(5) NOT NULL CONSTRAINT fk_persona REFERENCES vivienda,
cab_fam CHAR(5) CONSTRAINT cabeza_familia REFERENCES persona
) TABLESPACE personal;

CREATE TABLE propiedad (
persona char(5) CONSTRAINT fk_prop_per REFERENCES persona,
vivienda char(5) CONSTRAINT fk_prop_viv REFERENCES vivienda,
CONSTRAINT pk_propiedad PRIMARY KEY (persona, vivienda)
) TABLESPACE personal;
