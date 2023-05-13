USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS crear_localidad;

CREATE PROCEDURE crear_localidad(
    IN p_localizacion VARCHAR(50), 
    IN p_nombre_recinto VARCHAR(50), 
    IN p_nombre_grada VARCHAR(50),
    IN p_precio_base INT, 
    IN p_estado ENUM('disponible', 'no disponible')
)
BEGIN
    DECLARE recinto_existe INT DEFAULT 0;
    DECLARE grada_existe INT DEFAULT 0;
    
    -- Comprobar si el recinto existe
    SELECT COUNT(*) INTO recinto_existe FROM Recinto WHERE nombre_recinto = p_nombre_recinto;
    
    -- Comprobar si la grada existe
    SELECT COUNT(*) INTO grada_existe FROM Grada WHERE nombre_grada = p_nombre_grada AND nombre_recinto_grada = p_nombre_recinto;
    
    IF recinto_existe > 0 AND grada_existe > 0 THEN
        -- Insertar nueva localidad si tanto el recinto como la grada existen
        INSERT INTO Localidad(localizacion_localidad, nombre_recinto_localidad, nombre_grada_localidad, precio_base_localidad, estado_localidad)
        VALUES (p_localizacion, p_nombre_recinto, p_nombre_grada, p_precio_base, p_estado);
        
        SELECT "La localidad ha sido creada exitosamente." AS mensaje;
    ELSE
        SELECT "Error: El recinto o la grada no existen." AS mensaje;
    END IF;
END//

DELIMITER ;

