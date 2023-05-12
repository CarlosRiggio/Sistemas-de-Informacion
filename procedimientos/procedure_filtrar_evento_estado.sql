USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS obtener_eventos_por_estado//

CREATE PROCEDURE obtener_eventos_por_estado(IN estado_parametro ENUM('cerrado', 'finalizado', 'abierto'))
BEGIN
    SELECT nombre_espectaculo_evento, nombre_recinto_evento, fecha_evento, estado_evento
    FROM Evento
    WHERE estado_evento = estado_parametro;
END//

DELIMITER ;

CALL obtener_eventos_por_estado('finalizado');

