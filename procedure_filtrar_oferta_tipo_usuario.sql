USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS obtener_oferta_por_tipo_usuario//

CREATE PROCEDURE obtener_oferta_por_tipo_usuario(tipo ENUM('jubilado', 'parado', 'adulto', 'infantil'))
BEGIN
    SELECT * FROM Oferta WHERE tipo_usuario_oferta = tipo;
END //
DELIMITER ;

CALL obtener_oferta_por_tipo_usuario('jubilado');
CALL obtener_oferta_por_tipo_usuario('parado');
CALL obtener_oferta_por_tipo_usuario('adulto');
CALL obtener_oferta_por_tipo_usuario('infantil');



