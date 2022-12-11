

CREATE TABLE Hotel(
 cod_htl varchar (7) Primary KEY not null,
 nombre varchar(50) not null,
 direccion varchar(68) not null
);

create table Cliente(
  id varchar(15) Primary KEY not null,
  nombre varchar (50) not null,
   tfno varchar (18) not null
);

 CREATE TABLE Reserva(
 cod_htl varchar (7) not null,
 id varchar (15) not null,
 fechain DATE,
 fechaout DATE,
 cantidad_personas integer not null,

constraint pk_Reserva PRIMARY KEY (cod_htl, id),
constraint fk_cod_htl FOREIGN KEY (cod_htl) REFERENCES Hotel (cod_htl),
constraint fk_id FOREIGN KEY (id) REFERENCES Cliente (id),
constraint ck_cantidadP check (cantidad_personas=0)
);



 CREATE TABLE Aerolinea(
 cod_aerolinea varchar(10) PRIMARY KEY not null,
 descuento integer,
 constraint ck_descuento check (descuento >= 10)
);


CREATE TABLE Boleto(
 cod_boleto varchar (10) Primary KEY not null,
 id varchar(15) not null,
 cod_aerolinea varchar (10) not null,
 numeroVuelo integer not null,
 fecha DATE,
 destino varchar (65) not null,

 constraint fk_id1 FOREIGN KEY(id) REFERENCES Cliente (id),
 constraint fk_cod_aerolinea FOREIGN KEY(cod_aerolinea) REFERENCES Aerolinea(cod_aerolinea),
 constraint ck_destino check (destino in ( 'USA', 'Honduras', 'COSTA-RICA'))
 );