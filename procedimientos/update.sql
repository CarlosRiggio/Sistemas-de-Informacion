DROP TABLE IF EXISTS Compra;

CREATE TABLE Compra
(
    dni_cliente_compra VARCHAR (50),
    tipo_usuario_compra ENUM ('jubilado', 'parado', 'adulto', 'infantil'),
    espectaculo_compra VARCHAR(50),
    fecha_compra DATETIME,
    localizacion_localidad_compra VARCHAR(50),
    nombre_grada_compra VARCHAR(50),
    nombre_recinto_compra VARCHAR(50),
    precioFinal FLOAT,
    FOREIGN KEY(dni_cliente_compra) REFERENCES Cliente(dni_cliente),
    FOREIGN KEY(tipo_usuario_compra) REFERENCES UsLoc(tipo_usuario_usloc),
    FOREIGN KEY(localizacion_localidad_compra) REFERENCES UsLoc(localizacion_localidad_usloc),
    FOREIGN KEY(nombre_grada_compra) REFERENCES UsLoc(nombre_grada_usloc),
    FOREIGN KEY(nombre_recinto_compra) REFERENCES UsLoc(nombre_recinto_usloc),
    PRIMARY KEY(dni_cliente_compra, tipo_usuario_compra, localizacion_localidad_compra, nombre_grada_compra, nombre_recinto_compra,espectaculo_compra,fecha_compra)
);