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
DECLARE total_localidades_reservadas INT;

-- Obtener el número de localidades del recinto correspondiente
SELECT localidades_recinto INTO localidades_recinto_proc 
FROM Recinto WHERE nombre_recinto = nombre_recinto_grada_in;

-- Obtener el sumatorio de localidades reservadas para el recinto correspondiente
SELECT IFNULL(SUM(num_localidades_reservar_grada), 0) INTO total_localidades_reservadas
FROM Grada WHERE nombre_recinto_grada = nombre_recinto_grada_in;

IF total_localidades_reservadas + num_localidades_reservar_grada_in > localidades_recinto_proc THEN
    SIGNAL SQLSTATE '45001' 
        SET MESSAGE_TEXT = 'No hay tanto aforo';
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

CALL crear_gradas('GRADA CN3', 'CAMP NOU', 5, 20);