
DROP PROCEDURE IF EXISTS ModificarEstadoEvento;

-- ! Suponemos que el procedimiento de Error ya se implemento con CrearEvento()



DELIMITER //


CREATE PROCEDURE ModificarEstadoEvento (

    IN nombre_espectaculo_IN VARCHAR(50),
    IN nombre_recinto_IN VARCHAR(50),
    IN fecha_evento_IN DATETIME,
    IN nuevoEstado VARCHAR(50)

)


    -- ! Hay que tener en cuenta que este procedimiento solo sirve para modificar 
    -- ! un estado por otro, por lo que el resto de acciones a considerar hay que
    -- ! realizarlas en otros procedimientos   

BEGIN

    -- Pasos
    --
    --  1. Buscar el Evento en cuestion
    --  2. Cambiar su estado al nuevo estado
    --  3. IF Estado != NoDisponible or Finalizado or abierto 
    --   


    -- 3.
    IF ( (nuevoEstado != "Abierto") AND (nuevoEstado != "No Disponible") AND (nuevoEstado != "Finalizado") ) THEN
        CALL Error(4, "Estado de Evento: Incorrecto.");
    END IF;

    -- 1.   -- 2.   
    IF ( (SELECT estado_evento FROM Evento WHERE (
        nombre_espectaculo_evento = nombre_espectaculo_IN AND
        nombre_recinto_evento = nombre_recinto_IN AND
        fecha_evento = fecha_evento_IN
    )) != '' ) THEN 
        UPDATE Evento SET estado_evento = nuevoEstado;
    ELSE 
        CALL Error (5, "Evento inexistente.");
    END IF;



END //





DELIMITER ;