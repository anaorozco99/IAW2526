drop table equipo cascade constraints;
drop table ciclista cascade constraints;
drop table puerto cascade constraints;
drop table etapa cascade constraints;
drop table llevar cascade constraints;
drop table maillot cascade constraints;

CREATE TABLE equipo (
	nomeq VARCHAR2(25) NOT NULL, 
	director VARCHAR2(100) NULL,
	CONSTRAINT PK_equi PRIMARY KEY (nomeq));

CREATE TABLE ciclista (
	dorsal NUMBER(3) NOT NULL, 
	nombre VARCHAR2(30) NOT NULL, 
	edad NUMBER(2) NULL, 
	nomeq varchar(25) NULL,
	CONSTRAINT PK_cicli PRIMARY KEY (dorsal),
	CONSTRAINT FK_cicli_equi FOREIGN KEY (nomeq) REFERENCES equipo (nomeq));

CREATE TABLE etapa (
	netapa NUMBER(2) NOT NULL, 
	km number(3) NULL,
	salida varchar(35),
	llegada varchar(35),
	dorsal number(3),
	CONSTRAINT PK_eta PRIMARY KEY (netapa),
	CONSTRAINT FK_etapa_cicli FOREIGN KEY (dorsal) REFERENCES ciclista (dorsal));

CREATE TABLE puerto (
	nompuerto VARCHAR2(35) NOT NULL, 
	altura number(4) NULL, 
	categoria char(1) NULL, 
	pendiente number(3,2) NULL, 
	netapa NUMBER(2) not NULL, 
	dorsal number(3) NULL,
	CONSTRAINT PK_puerto PRIMARY KEY (nompuerto),
	CONSTRAINT FK_puerto_eta FOREIGN KEY (netapa) REFERENCES etapa (netapa),
	CONSTRAINT FK_puerto_cicli FOREIGN KEY (dorsal) REFERENCES ciclista(dorsal));

CREATE TABLE maillot (
	CODIGO CHAR(3) NOT NULL, 
	TIPO VARCHAR2(30) NULL, 
	color varchar2(20) NULL, 
	premio number(7) NULL,
	CONSTRAINT PK_mai PRIMARY KEY (CODIGO));

CREATE TABLE llevar (
	dorsal NUMBER(3) NOT NULL, 
	netapa number(2) NOT NULL,
	codigo char(3) not null,
	CONSTRAINT PK_lle PRIMARY KEY (netapa, CODIGO),
	CONSTRAINT FK_llevar_cicli FOREIGN KEY (dorsal) REFERENCES ciclista (dorsal),
	CONSTRAINT FK_llevar_etapa FOREIGN KEY (netapa) REFERENCES etapa (netapa),
	CONSTRAINT FK_llevar_mai FOREIGN KEY (codigo) REFERENCES maillot (codigo));




