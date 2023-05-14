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

DROP PROCEDURE IF EXISTS crear_localidad;

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

CALL crear_localidad('Asiento 1', 'Camp Nou', 'Grada Norte', 50, 'libre');
