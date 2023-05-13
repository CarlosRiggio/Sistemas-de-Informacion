USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS crear_usLoc;

CREATE PROCEDURE crear_usLoc(IN localizacion_localidad_in VARCHAR(50), IN nombre_grada_in VARCHAR(50), IN nombre_recinto_in VARCHAR(50), IN tipo_usuario ENUM('jubilado','parado','adulto','infantil'))
BEGIN

DECLARE consulta VARCHAR(50);

SELECT localizacion_localidad INTO consulta FROM Localidad WHERE nombre_recinto_localidad=nombre_recinto_in AND localizacion_localidad=localizacion_localidad_in AND nombre_grada_localidad=nombre_grada_in;

IF localizacion_localidad = localizacion_localidad_in THEN
INSERT INTO UsLoc VALUES (tipo_usuario,localizacion_localidad_in,nombre_grada_in,ombre_recinto_in);

END//

DELIMITER ;
