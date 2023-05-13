

-- * Indice Procedimientos




-- Drop Procedures

DROP PROCEDURE IF EXISTS cambiarestadoLocalidadOfertada;
DROP PROCEDURE IF EXISTS AgregarLocalidad;
DROP PROCEDURE IF EXISTS EliminarLocalidad;
DROP PROCEDURE IF EXISTS obtener_eventos_por_estado;
DROP PROCEDURE IF EXISTS eliminar_gradas;
DROP PROCEDURE IF EXISTS crear_recinto;
DROP PROCEDURE IF EXISTS crearOferta;
DROP PROCEDURE IF EXISTS crear_gradas;
DROP PROCEDURE IF EXISTS crear_espectaculo;
DROP PROCEDURE IF EXISTS CrearEvento;

DROP PROCEDURE IF EXISTS Error;




-- **********************
-- *                    *
-- *   Procedimientos   *
-- *                    *
-- **********************


DELIMITER //


CREATE PROCEDURE Error (
    ERRNO BIGINT UNSIGNED,
    message_text VARCHAR(100)
)

BEGIN
    SIGNAL SQLSTATE 'ERROR'
SET
    MESSAGE_TEXT = message_text,
    MYSQL_ERRNO = ERRNO;
END //



CREATE PROCEDURE crear_espectaculo(
    IN nombre_espectaculo_in VARCHAR(50),
    IN descripcion_espectaculo_in VARCHAR(50),
    IN participantes_espectaculo_in VARCHAR(50)
)

BEGIN
    CREATE TABLE IF NOT EXISTS Espectaculo (
        nombre_espectaculo VARCHAR(50) PRIMARY KEY,
        descripcion_espectaculo VARCHAR(50),
        participantes_espectaculo VARCHAR(50)
    );

    INSERT INTO Espectaculo (nombre_espectaculo, descripcion_espectaculo, participantes_espectaculo)
    VALUES (nombre_espectaculo_in, descripcion_espectaculo_in, participantes_espectaculo_in);

    SELECT 'La tabla Espectaculo se ha creado correctamente y el espectáculo ha sido insertado.' AS mensaje;
END //





CREATE PROCEDURE CrearEvento (

    IN nombre_espectaculo_IN VARCHAR(50),
    IN nombre_recinto_IN VARCHAR(50),
    IN fecha_evento_IN DATETIME,
    IN estado_evento_IN VARCHAR(50)

)

BEGIN
    -- Pasos
    -- 
    --  2. Checkeamos si existen el Recinto y el Espectaculo
    --  3. Check Fecha T-T
    --  4. Check dato Estado en los datos de entrada
    --  5. Hacemos el insert de los datos de entrada

    -- 2.
    IF ( (SELECT EXISTS(SELECT * FROM Espectaculo WHERE nombre_espectaculo = nombre_espectaculo_IN) ) = '') THEN
        CALL Error(1, "No existe dicho Espectaculo.");
    END IF;

    IF ( (SELECT EXISTS(SELECT * FROM Recinto WHERE nombre_recinto = nombre_recinto_IN) ) = '') THEN
        CALL Error(2, "No existe dicho Recinto.");
    END IF;

    -- 3.
    -- ! Esto vamos a tener que retocarlo
    -- ! No es que tenga mucho sentido que puedan entrar eventos para ya
    IF (fecha_evento_IN <= NOW())  THEN
        CALL Error (3, "Fecha incorrecta.");
    END IF;

    -- 4. 
    -- ? Entiendo que cuando un Evento pasa el punto T1, donde no se pueden
    -- ? comprar entradas, es cuando pasa de Estado = Abierto a Estado = No Disponible
    IF ( estado_evento_IN = "Finalizado" ) THEN
        CALL Error (4, "Estado de Evento: Incorrecto.");
    END IF;

    -- 5.
    INSERT INTO Evento (nombre_espectaculo_evento, nombre_recinto_evento, fecha_evento, estado_evento)
    VALUE (nombre_espectaculo_IN, nombre_recinto_IN, fecha_evento_IN, estado_evento_IN);
    
END //




CREATE PROCEDURE crear_gradas(
    IN nombre_grada_in VARCHAR(50), 
    IN nombre_recinto_grada_in VARCHAR(50), 
    IN num_localidades_reservar_grada_in INT, 
    IN precio_grada_in INT
)
BEGIN
    INSERT INTO Grada (nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) 
    VALUES (nombre_grada_in, nombre_recinto_grada_in, num_localidades_reservar_grada_in, precio_grada_in);
END //



CREATE PROCEDURE AgregarLocalidad(
    IN localizacion_localidad VARCHAR(50),
    IN nombre_recinto_localidad VARCHAR(50),
    IN nombre_grada_localidad VARCHAR(50),
    IN precio_base_localidad INT,
    IN estado_localidad VARCHAR(20) ENUM ('disponible', 'no disponible')
)
BEGIN
    INSERT INTO Localidad (localizacion_localidad, nombre_recinto_localidad, nombre_grada_localidad, precio_base_localidad, estado_localidad) 
    VALUES (localizacion_localidad, nombre_recinto_localidad, nombre_grada_localidad, precio_base_localidad, estado_localidad);
END //



CREATE PROCEDURE crearOferta(
    IN nombreEspectaculo CHAR(50), 
    IN nombreRecinto CHAR(50), 
    IN fechaEvento DATETIME, 
    IN tipoUsuarioOfertado CHAR(50), 
    IN localizacionLocalidad CHAR(50), 
    IN nombreGrada CHAR(50)
)
BEGIN
    DECLARE done BOOLEAN;
    DECLARE valido BOOLEAN;
    DECLARE consulta VARCHAR(50);
    DECLARE recinto VARCHAR(100);
    DECLARE cursito CURSOR FOR (SELECT nombre_recinto_localidad FROM Localidad WHERE localizacion_localidad=localizacionLocalidad AND nombre_grada_localidad=nombreGrada);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;
    SET valido = FALSE;
    SET done = FALSE;
    SELECT nombre_espectaculo_evento INTO consulta from Evento where nombre_recinto_evento = nombreRecinto and nombre_espectaculo_evento=nombreEspectaculo and fecha_evento=fechaEvento;
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
                        SET valido = TRUE;
                        LEAVE loop1;
                    END IF;
                END IF;
            END IF;
        END LOOP;
    CLOSE cursito;

    IF valido = TRUE THEN 
        INSERT INTO Oferta VALUES (nombreEspectaculo, nombreRecinto, tipoUsuarioOfertado, localizacionLocalidad, nombreGrada, 'libre');
    END IF;

END // /*no usar el mismo nombre para los parametros que para las columnas de las tablas -> los confundira*/




CREATE PROCEDURE crear_recinto(
    IN nombre_recinto_in VARCHAR(50),
    IN localidades_recinto_in INT
)
BEGIN
    INSERT INTO Recinto (nombre_recinto, localidades_recinto)
    VALUES (nombre_recinto_in, localidades_recinto_in);

    SELECT 'El recinto ha sido creado correctamente.' AS mensaje;
END //




CREATE PROCEDURE eliminar_gradas(
    IN nombre_grada_in VARCHAR(50), 
    IN nombre_recinto_grada_in VARCHAR(50), 
    IN num_localidades_reservar_grada_in INT, 
    IN precio_grada_in INT
)
BEGIN

    DELETE * FROM Grada
    WHERE nombre_grada = nombre_grada_in AND
        nombre_recinto_grada = nombre_recinto_grada_in AND
        num_localidades_reservar_grada = num_localidades_reservar_grada_in AND
        precio_grada = precio_grada_in
    ;

END //


CREATE PROCEDURE EliminarLocalidad (
    IN localizacion_localidad VARCHAR(50),
    IN nombre_recinto_localidad VARCHAR(50),
    IN nombre_grada_localidad VARCHAR(50)
)

BEGIN
    DELETE FROM Localidad
    WHERE localizacion_localidad = localizacion_localidad
        AND nombre_recinto_localidad = nombre_recinto_localidad
        AND nombre_grada_localidad = nombre_grada_localidad;
END //


CREATE PROCEDURE obtener_eventos_por_estado(
    IN estado_parametro ENUM('cerrado', 'finalizado', 'abierto')
)
BEGIN
    SELECT nombre_espectaculo_evento, nombre_recinto_evento, fecha_evento, estado_evento
    FROM Evento
    WHERE estado_evento = estado_parametro;
END //



CREATE PROCEDURE cambiarestadoLocalidadOfertada(
    IN nuevoEstado CHAR(50), 
    IN recinto CHAR(50), 
    IN grada CHAR(50), 
    IN localizacion CHAR(50)
)
BEGIN
    IF(nuevoEstado IN('libre','deteriorado','reservado','pre-reservado')) THEN
        UPDATE Oferta SET estado_localidad_ofertada=nuevoEstado WHERE nombre_grada_oferta=grada AND localizacion_localidad_oferta=localizacion AND nombre_recinto_oferta=recinto;
    END IF;
END // /*no usar el mismo nombre para los parametros que para las columnas de las tablas -> los confundira*/



DELIMITER ;