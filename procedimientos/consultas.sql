USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS consultarPorFecha;

CREATE PROCEDURE consultarPorFecha(IN fecha_consulta VARCHAR(50))
BEGIN
    SELECT *
    FROM Evento
    WHERE fecha_evento = fecha_consulta;
END//

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS consultarPorRecinto;

CREATE PROCEDURE consultarPorRecinto(IN recinto_consulta VARCHAR(50))
BEGIN
    SELECT *
    FROM Evento
    WHERE nombre_recinto_evento = recinto_consulta;
END//

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS consultarLocalidades;

CREATE PROCEDURE consultarLocalidades(IN recinto_consulta VARCHAR(50), IN grada_consulta VARCHAR(50))
BEGIN
    SELECT *
    FROM Localidad
    WHERE nombre_recinto_localidad = recinto_consulta AND nombre_grada_localidad = grada_consulta;
END//

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS consultarMisCompras;

CREATE PROCEDURE consultarMisCompras(IN dni_cliente_consulta VARCHAR(50))
BEGIN
    SELECT *
    FROM Compra
    WHERE dni_cliente_compra = dni_cliente_consulta;
END//

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS obtener_oferta_por_tipo_usuario//

CREATE PROCEDURE obtener_oferta_por_tipo_usuario(tipo ENUM('jubilado', 'parado', 'adulto', 'infantil'))
BEGIN
    SELECT * FROM Oferta WHERE tipo_usuario_oferta = tipo;
END //
DELIMITER ;

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
