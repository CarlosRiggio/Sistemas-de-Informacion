CREATE DATABASE IF NOT EXISTS Taquilla;
USE Taquilla;

DROP PROCEDURE IF EXISTS CrearEvento;

DROP PROCEDURE IF EXISTS Error;



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




CREATE PROCEDURE CrearEvento (

    IN nombre_espectaculo_IN VARCHAR(50),
    IN nombre_recinto_IN VARCHAR(50),
    IN fecha_evento_IN DATETIME,
    IN estado_evento_IN VARCHAR(50)

)

BEGIN
    -- Pasos
    -- 
    --  1. Declaramos variables
    --  2. Checkeamos si existen el Recinto y el Espectaculo
    --  3. Check Fecha ? T-T
    --  4. Check dato Estado en los datos de entrada
    --  5. Hacemos el insert de los datos de entrada
    --  6. Gestion de las Localidades del Evento (JAJA salu2)


    -- TODO: 1.
    -- DECLARE numEventoNuevo INIT;
    -- DECLARE numLocalicades INIT;
    -- DECLARE cursorLocalidades


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

    -- TODO: 6.
    
END //

DELIMITER ;

CALL CrearEvento('El Clasico', 'Camp Nou', '2023-12-12 20:00:00', 'Abierto');
