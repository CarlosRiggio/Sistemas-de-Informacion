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
    DECLARE num_tuplas INT DEFAULT 0;
    DECLARE num_localidades_reservar INT DEFAULT 0;
    
    -- Comprobar si el recinto existe
    SELECT COUNT(*) INTO recinto_existe FROM Recinto WHERE nombre_recinto = p_nombre_recinto;
    
    -- Comprobar si la grada existe y obtener el número de localidades a reservar
    SELECT num_localidades_reservar_grada, COUNT(*) INTO num_localidades_reservar, grada_existe 
    FROM Grada WHERE nombre_grada = p_nombre_grada AND nombre_recinto_grada = p_nombre_recinto
    GROUP BY num_localidades_reservar_grada;
    
    IF recinto_existe > 0 AND grada_existe > 0 THEN
        -- Obtener el número de tuplas con el mismo recinto y la misma grada
        SELECT COUNT(*) INTO num_tuplas FROM Localidad WHERE nombre_recinto_localidad = p_nombre_recinto AND nombre_grada_localidad = p_nombre_grada;
        
        -- Comprobar si se pueden reservar más localidades en la grada
        IF num_tuplas < num_localidades_reservar THEN
            -- Insertar nueva localidad si tanto el recinto como la grada existen y se pueden reservar más localidades
            INSERT INTO Localidad(localizacion_localidad, nombre_recinto_localidad, nombre_grada_localidad, precio_base_localidad, estado_localidad)
            VALUES (p_localizacion, p_nombre_recinto, p_nombre_grada, p_precio_base, p_estado);
        
            -- Imprimir el número de tuplas con el mismo recinto y la misma grada
            SELECT CONCAT("La localidad ha sido creada exitosamente. Hay ", num_tuplas+1, " localidades en la misma grada y el mismo recinto.") AS mensaje;
        ELSE
            SELECT "Error: No se pueden reservar más localidades en esta grada." AS mensaje;
        END IF;
    ELSE
        SELECT "Error: El recinto o la grada no existen." AS mensaje;
    END IF;
END//

DELIMITER ;

CALL crear_localidad('2', 'Bernabeu', 'GRADA PRUEBA2', 23, 'disponible');
CALL crear_localidad('3', 'Bernabeu', 'GRADA PRUEBA2', 23, 'disponible');
CALL crear_localidad('4', 'Bernabeu', 'GRADA PRUEBA2', 23, 'disponible');
CALL crear_localidad('5', 'Bernabeu', 'GRADA PRUEBA2', 23, 'disponible');
