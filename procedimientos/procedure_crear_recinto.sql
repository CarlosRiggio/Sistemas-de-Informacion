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
