CREATE DATABASE IF NOT EXISTS Taquilla;
USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS crear_espectaculo//

CREATE PROCEDURE crear_espectaculo(
    IN nombre_espectaculo_in VARCHAR(50),
    IN descripcion_espectaculo_in VARCHAR(50),
    IN participantes_espectaculo_in VARCHAR(50)
)
BEGIN
    CREATE TABLE IF NOT EXISTS Espectaculo (
        nombre_espectaculo VARCHAR(50) PRIMARY KEY,
        descripcion_espectaculo VARCHAR(50),
        participantes_espectaculo VARCHAR(50)
    );

    INSERT INTO Espectaculo (nombre_espectaculo, descripcion_espectaculo, participantes_espectaculo)
    VALUES (nombre_espectaculo_in, descripcion_espectaculo_in, participantes_espectaculo_in);

    SELECT 'La tabla Espectaculo se ha creado correctamente y el espectáculo ha sido insertado.' AS mensaje;
END//

DELIMITER ;

CALL crear_espectaculo('El Clásico', 'El partido del año', 'Barca, Real Madrid');


CREATE DATABASE IF NOT EXISTS Taquilla;
USE Taquilla;

DROP TABLE IF EXISTS Recinto;
CREATE TABLE Recinto (
    nombre_recinto VARCHAR(50) PRIMARY KEY,
    localidades_recinto INT
);

DELIMITER //

DROP PROCEDURE IF EXISTS crear_recinto//

CREATE PROCEDURE crear_recinto(
    IN nombre_recinto_in VARCHAR(50),
    IN localidades_recinto_in INT
)
BEGIN
    INSERT INTO Recinto (nombre_recinto, localidades_recinto)
    VALUES (nombre_recinto_in, localidades_recinto_in);

    SELECT 'El recinto ha sido creado correctamente.' AS mensaje;
END//

DELIMITER ;

CALL crear_recinto('Camp Nou', 89000);


USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS crear_gradas//

CREATE PROCEDURE crear_gradas(IN nombre_grada_in VARCHAR(50), IN nombre_recinto_grada_in VARCHAR(50), num_localidades_reservar_grada_in int, precio_grada_in int)
BEGIN

CREATE TABLE IF NOT EXISTS Grada 
(
    nombre_grada VARCHAR(50),
    nombre_recinto_grada VARCHAR(50),
    num_localidades_reservar_grada INT,
    precio_grada INT,
    FOREIGN KEY(nombre_recinto_grada) REFERENCES Recinto(nombre_recinto),
    PRIMARY KEY(nombre_grada, nombre_recinto_grada)
);

INSERT INTO Grada(nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) VALUES (nombre_grada_in, nombre_recinto_grada_in, num_localidades_reservar_grada_in, precio_grada_in);

END//

DELIMITER ;

CALL crear_gradas('Grada Norte', 'Camp Nou', 10000, 50);


CREATE DATABASE IF NOT EXISTS Taquilla;
USE Taquilla;
    
CREATE TABLE IF NOT EXISTS Localidad (
        localizacion_localidad VARCHAR(50),
        nombre_recinto_localidad VARCHAR(50),
        nombre_grada_localidad VARCHAR(50),
        precio_base_localidad INT,
        estado_localidad ENUM('disponible', 'no disponible')
    );
DELIMITER //

DROP PROCEDURE IF EXISTS crear_localidad//

CREATE PROCEDURE crear_localidad(
    IN localizacion_localidad_in VARCHAR(50),
    IN nombre_recinto_localidad_in VARCHAR(50),
    IN nombre_grada_localidad_in VARCHAR(50),
    IN precio_base_localidad_in INT,
    IN estado_localidad_in ENUM('disponible', 'no disponible')
)
BEGIN
    INSERT INTO Localidad (
        localizacion_localidad,
        nombre_recinto_localidad,
        nombre_grada_localidad,
        precio_base_localidad,
        estado_localidad
    ) VALUES (
        localizacion_localidad_in,
        nombre_recinto_localidad_in,
        nombre_grada_localidad_in,
        precio_base_localidad_in,
        estado_localidad_in
    );
END//

DELIMITER ;

CALL crear_localidad('Asiento 1', 'Camp Nou', 'Grada Norte', 50, 'disponible');
