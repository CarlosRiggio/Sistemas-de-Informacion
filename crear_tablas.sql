DROP DATABASE IF EXISTS Taquilla;
CREATE DATABASE Taquilla;
USE Taquilla;

SELECT DATABASE();

CREATE TABLE Espectaculo 
(
    nombre_espectaculo VARCHAR(50) PRIMARY KEY,
    descripcion_espectaculo VARCHAR(50),
    participantes_espectaculo VARCHAR(50)
);

CREATE TABLE Recinto 
(
    nombre_recinto VARCHAR(50) PRIMARY KEY,
    localidades_recinto INT 
);

CREATE TABLE Grada 
(
    nombre_grada VARCHAR(50),
    nombre_recinto_grada VARCHAR(50),
    num_localidades_reservar_grada INT,
    precio_grada INT,
    FOREIGN KEY(nombre_recinto_grada) REFERENCES Recinto(nombre_recinto),
    PRIMARY KEY(nombre_grada, nombre_recinto_grada)
);

CREATE TABLE Usuario 
(
    tipo_usuario ENUM ('jubilado', 'parado', 'adulto', 'infantil'),
    descuento_usuario INT,
    PRIMARY KEY (tipo_usuario)
);

CREATE TABLE Localidad 
(
    localizacion_localidad VARCHAR(50),
    nombre_recinto_localidad VARCHAR(50),
    nombre_grada_localidad VARCHAR(50),
    precio_base_localidad INT,
    estado_localidad ENUM ('disponible', 'no disponible'),
    FOREIGN KEY(nombre_recinto_localidad) REFERENCES Recinto(nombre_recinto),
    FOREIGN KEY(nombre_grada_localidad) REFERENCES Grada(nombre_grada),
    PRIMARY KEY (localizacion_localidad, nombre_recinto_localidad, nombre_grada_localidad)

);

CREATE TABLE Cliente
(
    dni_cliente VARCHAR(50) UNIQUE,
    datos_bancarios_cliente VARCHAR(34),
    PRIMARY KEY (dni_cliente)
);

CREATE TABLE Evento
(
    nombre_espectaculo_evento VARCHAR(50),
    nombre_recinto_evento VARCHAR(50),
    fecha_evento DATETIME,
    estado_evento ENUM('cerrado', 'finalizado', 'abierto'),
    FOREIGN KEY(nombre_espectaculo_evento) REFERENCES Espectaculo(nombre_espectaculo),
    FOREIGN KEY(nombre_recinto_evento) REFERENCES Recinto(nombre_recinto),
    PRIMARY KEY(nombre_espectaculo_evento, nombre_recinto_evento, fecha_evento)
    
);

CREATE TABLE UsLoc
(
    tipo_usuario_usloc ENUM ('jubilado', 'parado', 'adulto', 'infantil'),
    localizacion_localidad_usloc VARCHAR(50),
    nombre_grada_usloc VARCHAR(50),
    nombre_recinto_usloc VARCHAR(50),
    FOREIGN KEY(tipo_usuario_usloc) REFERENCES Usuario(tipo_usuario),
    FOREIGN KEY(localizacion_localidad_usloc) REFERENCES Localidad(localizacion_localidad),
    FOREIGN KEY(nombre_grada_usloc) REFERENCES Grada(nombre_grada),
    FOREIGN KEY(nombre_recinto_usloc) REFERENCES Recinto(nombre_recinto),
    PRIMARY KEY(tipo_usuario_usloc, localizacion_localidad_usloc, nombre_grada_usloc, nombre_recinto_usloc)
);

CREATE TABLE Oferta
(
    nombre_espectaculo_oferta VARCHAR(50),
    nombre_recinto_oferta VARCHAR(50),
    tipo_usuario_oferta ENUM('jubilado', 'parado', 'adulto', 'infantil'),
    localizacion_localidad_oferta VARCHAR(50),
    nombre_grada_oferta VARCHAR(50),
    fecha_evento_oferta DATETIME,
    estado_localidad_oferta ENUM('pre-reservado', 'reservado', 'deteriorado', 'libre'),
    FOREIGN KEY(tipo_usuario_oferta, localizacion_localidad_oferta, nombre_grada_oferta, nombre_recinto_oferta) 
    REFERENCES UsLoc(tipo_usuario_usloc, localizacion_localidad_usloc, nombre_grada_usloc, nombre_recinto_usloc), -- add comma here

    PRIMARY KEY(nombre_espectaculo_oferta, nombre_recinto_oferta, tipo_usuario_oferta, localizacion_localidad_oferta, nombre_grada_oferta,fecha_evento_oferta)  
);



CREATE TABLE Compra
(
    dni_cliente_compra VARCHAR (50),
    tipo_usuario_compra ENUM ('jubilado', 'parado', 'adulto', 'infantil'),
    espectaculo_compra VARCHAR(50),
    fecha_compra DATETIME,
    localizacion_localidad_compra VARCHAR(50),
    nombre_grada_compra VARCHAR(50),
    nombre_recinto_compra VARCHAR(50),
    FOREIGN KEY(dni_cliente_compra) REFERENCES Cliente(dni_cliente),
    FOREIGN KEY(tipo_usuario_compra) REFERENCES UsLoc(tipo_usuario_usloc),
    FOREIGN KEY(localizacion_localidad_compra) REFERENCES UsLoc(localizacion_localidad_usloc),
    FOREIGN KEY(nombre_grada_compra) REFERENCES UsLoc(nombre_grada_usloc),
    FOREIGN KEY(nombre_recinto_compra) REFERENCES UsLoc(nombre_recinto_usloc),
    PRIMARY KEY(dni_cliente_compra, tipo_usuario_compra, localizacion_localidad_compra, nombre_grada_compra, nombre_recinto_compra,espectaculo_compra,fecha_compra)
);
