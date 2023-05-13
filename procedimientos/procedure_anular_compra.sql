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
END//

DELIMITER ;

CALL anular_compra('123456789', 'jubilado', 'REY LEON','2023-05-13 15:30:00', '1', 'SUR', 'Camp Nou' );
