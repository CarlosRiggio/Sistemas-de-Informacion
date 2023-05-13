CREATE DATABASE IF NOT EXISTS Taquilla;
USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS crear_espectaculo;

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
