drop procedure if exists cambiarestadoLocalidadOfertada;
DELIMITER &&
CREATE PROCEDURE cambiarestadoLocalidadOfertada(IN nuevoEstado CHAR(50), in recinto CHAR(50), IN grada CHAR(50), IN localizacion CHAR(50), IN espectaculo CHAR(50), IN tipoUsuario CHAR(50), IN fecha CHAR(50))
BEGIN

IF(nuevoEstado IN('libre','deteriorado','reservado','pre-reservado')) THEN
UPDATE Oferta SET estado_localidad_oferta=nuevoEstado WHERE nombre_grada_oferta=grada AND localizacion_localidad_oferta=localizacion AND nombre_recinto_oferta=recinto AND nombre_espectaculo_oferta=espectaculo AND tipo_usuario_oferta=tipoUsuario AND fecha_evento_oferta=fecha;
END IF;
END 
&&/*no usar el mismo nombre para los parametros que para las columnas de las tablas -> los confundira*/
DELIMITER ;