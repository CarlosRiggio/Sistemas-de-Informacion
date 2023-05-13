USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS crear_gradas//

CREATE PROCEDURE crear_gradas(
    IN nombre_grada_in VARCHAR(50), 
    IN nombre_recinto_grada_in VARCHAR(50), 
    IN num_localidades_reservar_grada_in INT, 
    IN precio_grada_in INT
)
BEGIN

DECLARE localidades_recinto_proc INT;

-- Obtener el número de localidades del recinto correspondiente
SELECT localidades_recinto INTO localidades_recinto_proc 
FROM Recinto WHERE nombre_recinto = nombre_recinto_grada_in;

SELECT localidades_recinto_proc;
SELECT num_localidades_reservar_grada_in;

IF num_localidades_reservar_grada_in > localidades_recinto_proc THEN
    SIGNAL SQLSTATE '45001' 
        SET MESSAGE_TEXT = 'El número de localidades reservadas para la grada es mayor que el número de localidades disponibles en el recinto.';
ELSE
    -- Crear la tabla si no existe y hacer la inserción
    CREATE TABLE IF NOT EXISTS Grada (
        nombre_grada VARCHAR(50),
        nombre_recinto_grada VARCHAR(50),
        num_localidades_reservar_grada INT,
        precio_grada INT,
        FOREIGN KEY(nombre_recinto_grada) REFERENCES Recinto(nombre_recinto),
        PRIMARY KEY(nombre_grada, nombre_recinto_grada)
    );
    
    INSERT INTO Grada(nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) 
    VALUES (nombre_grada_in, nombre_recinto_grada_in, num_localidades_reservar_grada_in, precio_grada_in);
END IF;

END//

DELIMITER ;

CALL crear_gradas('GRADA NORTE MADRID', 'Bernabeu', 600, 100);
CALL crear_gradas('GRADA NORTE MADRID', 'Bernabeu', 499, 100);
-- SELECT localidades_recinto FROM Recinto WHERE nombre_recinto = 'Bernabeu';
