drop procedure if exists crearOferta;
DELIMITER &&
CREATE PROCEDURE crearOferta(IN nombreEspectaculo CHAR(50), IN nombreRecinto CHAR(50), IN fechaEvento DATETIME, IN tipoUsuarioOfertado CHAR(50), IN localizacionLocalidad CHAR(50), IN nombreGrada CHAR(50))
BEGIN
DECLARE done BOOLEAN;
DECLARE valido BOOLEAN;
DECLARE consulta VARCHAR(50);
DECLARE estado_localidad VARCHAR(50);
DECLARE recinto VARCHAR(100);
DECLARE cursito CURSOR FOR (SELECT nombre_recinto_localidad FROM Localidad WHERE localizacion_localidad=localizacionLocalidad AND nombre_grada_localidad=nombreGrada);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;
SET valido = FALSE;
SET done = FALSE;
SELECT nombre_espectaculo_evento INTO consulta from Evento where nombre_recinto_evento = nombreRecinto and nombre_espectaculo_evento=nombreEspectaculo and fecha_evento=fechaEvento;
SELECT estado_localidad INTO estado_localidad from Localidad where nombre_recinto_localidad=nombreRecinto and nombre_grada_localidad and localizacion_localidad=localizacionLocalidad;
SELECT(consulta);
OPEN cursito;

loop1:LOOP/*loop con etiqueta*/
FETCH cursito INTO recinto;/*saca el valor de la tupla de la busqueda y lo mete en codigo*/
SELECT(recinto);
IF done = TRUE THEN /*si no quedan mas tuplas, el handler se activara y pondra @done a true*/
LEAVE loop1;
ELSE 
IF recinto=nombreRecinto THEN/*hace una operacion en concreto sobre cada tupla del cursor*/
IF consulta IS NOT NULL THEN
IF estado_localidad = 'disponible' THEN
SET valido = TRUE;
LEAVE loop1;
END IF;
END IF;
END IF;
END IF;
END LOOP;

CLOSE cursito;

IF valido = TRUE THEN 
INSERT INTO Oferta VALUES (nombreEspectaculo, nombreRecinto, tipoUsuarioOfertado, localizacionLocalidad, nombreGrada, 'libre');
END IF;

END 
&&/*no usar el mismo nombre para los parametros que para las columnas de las tablas -> los confundira*/
DELIMITER ;