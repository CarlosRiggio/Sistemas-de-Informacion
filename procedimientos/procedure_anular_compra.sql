USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS anular_compra;

CREATE PROCEDURE anular_compra(
    IN dni_cliente VARCHAR(50), 
    IN tipo_usuario ENUM('jubilado', 'parado', 'adulto', 'infantil'),
    IN espectaculo VARCHAR(50),
    IN fecha DATETIME,
    IN localizacion_localidad VARCHAR(50),
    IN nombre_grada VARCHAR(50),
    IN nombre_recinto VARCHAR(50)
)
BEGIN
    DECLARE compra_fecha DATETIME;
    DECLARE hora_actual DATETIME;
    DECLARE diff_horas INT;
    DECLARE diff_segundos INT;

    -- Obtener la fecha y hora de la compra a anular
    SELECT fecha_compra INTO compra_fecha
    FROM Compra 
    WHERE dni_cliente_compra = dni_cliente
    AND tipo_usuario_compra = tipo_usuario 
    AND espectaculo_compra = espectaculo 
    AND fecha_compra = fecha 
    AND localizacion_localidad_compra = localizacion_localidad 
    AND nombre_grada_compra = nombre_grada 
    AND nombre_recinto_compra = nombre_recinto;
    
    -- Obtener la hora actual
    SELECT NOW() INTO hora_actual;
    SELECT hora_actual;
    
    -- -- Calcular la diferencia de horas entre la hora actual y la hora de la compra a anular
     SELECT TIMESTAMPDIFF(SECOND, hora_actual, fecha) INTO diff_segundos;
     SET diff_horas = diff_segundos / 3600;
     SELECT diff_horas;
    
    -- Si la diferencia de horas es mayor o igual a 12, eliminar la tupla de la tabla Compra y cambiar el estado de la tupla de la tabla Oferta
    IF diff_horas >= 12 THEN
        -- Eliminar la tupla de la tabla Compra que coincida con los valores pasados por parámetro
        DELETE FROM Compra 
        WHERE dni_cliente_compra = dni_cliente
        AND tipo_usuario_compra = tipo_usuario 
        AND espectaculo_compra = espectaculo 
        AND fecha_compra = fecha 
        AND localizacion_localidad_compra = localizacion_localidad 
        AND nombre_grada_compra = nombre_grada 
        AND nombre_recinto_compra = nombre_recinto;

        -- Cambiar el estado de la tupla de la tabla Oferta que coincida con los valores pasados por parámetro
        UPDATE Oferta
        SET estado_localidad_oferta = 'libre'
        WHERE nombre_espectaculo_oferta = espectaculo 
        AND nombre_recinto_oferta = nombre_recinto 
        AND tipo_usuario_oferta = tipo_usuario 
        AND localizacion_localidad_oferta = localizacion_localidad 
        AND nombre_grada_oferta = nombre_grada 
        AND fecha_evento_oferta = fecha 
        AND estado_localidad_oferta = 'pre-reservado';
    ELSE
        -- Si la diferencia de horas es mayor a 12, no hacer nada y mostrar un mensaje de error
        SELECT 'Error: No se puede anular la compra menos de 12 h antes del evento' AS mensaje;
    END IF;
END//

DELIMITER ;
CALL anular_compra('97780491', 'jubilado', 'El Clasico', '2023-05-15 01:00:00', 'Suelo 99', 'Grada Norte', 'Camp Nou');

