
DROP PROCEDURE IF EXISTS ComprarEntrada;
DROP PROCEDURE IF EXISTS CalcularPrecio;
DROP PROCEDURE IF EXISTS ttt;


DELIMITER //

CREATE PROCEDURE CalcularPrecio (

    -- Datos Grada      ---> IncrementoPrecio
    -- Datos Localidad  ---> PrecioBase
    -- Datos Usuario    ---> DescuentoPrecio

    IN nombreGrada VARCHAR(50),
    IN nombreRecinto VARCHAR(50),
    IN localizacionLocalidad VARCHAR(50),
    IN tipoUsuario VARCHAR(50),
    
    OUT precioFinal FLOAT

)
BEGIN
    
    DECLARE incrementoPrecioGrada FLOAT;
    DECLARE precioBaseLocalidad FLOAT;
    DECLARE descuentoUsuario FLOAT;

    -- Check si existe dicha Infraestructura
    IF ( (SELECT EXISTS(SELECT * FROM Recinto WHERE nombre_recinto = nombreRecinto) ) = '') THEN
        CALL Error(2, "No existe dicho Recinto.");
    END IF;

    IF ( (SELECT EXISTS(SELECT * FROM Grada WHERE nombre_grada = nombreGrada AND nombre_recinto_grada_in = nombreRecinto) ) = '') THEN
        CALL Error(6, "No existe dicha Grada.");
    END IF;

    IF ( (SELECT EXISTS(SELECT * FROM Localidad 
    WHERE localizacion_localidad = localizacionLocalidad AND nombre_recinto_localidad = nombreRecinto AND nombre_grada_localidad = nombreGrada) ) = '') THEN
        CALL Error(7, "No existe dicha Localidad.");
    END IF;



    SELECT precio_grada INTO incrementoPrecioGrada
    FROM Grada
    WHERE nombre_grada = nombreGrada AND
        nombre_recinto_grada = nombreRecinto
    ;

    SELECT precio_base_localidad INTO precioBaseLocalidad 
    FROM Localidad
    WHERE localizacion_localidad = localizacionLocalidad AND
        nombre_recinto_localidad = nombreRecinto AND
        nombre_grada_localidad = nombreGrada
    ;


    SELECT descuento_usuario INTO descuentoUsuario
    FROM Usuario
    WHERE tipo_usuario = tipoUsuario; 


    SET precioFinal = incrementoPrecioGrada * precioBaseLocalidad * descuentoUsuario;

END // 


-- CREATE PROCEDURE ttt ()
-- BEGIN
--     DECLARE precio FLOAT;
--     -- CALL CalcularPrecio("Grada Norte", "Camp Nou", "parado", "Romero", "Camp Nou", "Grada Norte", precio);
--     CALL CalcularPrecio ("Grada Norte", "Camp Nou", "Romero", "parado", precio);
--     SELECT precio AS message;
-- END //


CREATE PROCEDURE ComprarEntrada (

    IN dni_cliente_IN VARCHAR(50),
    IN tipo_usuario_IN VARCHAR(50),

    IN nombre_espectaculo_ofertaIN VARCHAR(50), 
    IN nombre_recinto_ofertaIN VARCHAR(50), 
    IN localizacion_localidad_ofertaIN VARCHAR(50), 
    IN nombre_grada_ofertaIN VARCHAR(50),
    IN fecha_evento_ofertaIN DATETIME

)
BEGIN
    DECLARE precio FLOAT;

    IF (SELECT * FROM Evento WHERE (
        nombre_espectaculo_evento = nombre_espectaculo_ofertaIN AND
        nombre_recinto_evento = nombre_espectaculo_ofertaIN AND
        fecha_evento = fecha_evento_ofertaIN AND
        estado_evento = "abierto"
    ) = '' ) THEN 
        CALL Error (5, "Evento inexistente.");
    END IF;

    IF ( SELECT * FROM Localidad WHERE (
        localizacion_localidad = localizacion_localidad_ofertaIN AND
        nombre_recinto_localidad = nombre_espectaculo_ofertaIN AND
        nombre_grada_localidad = nombre_grada_ofertaIN AND
        estado_localidad = 'disponible'
    ) = '') THEN
        CALL Error(8, "Localidad no disponible.");
    END IF;

    IF (SELECT * FROM Oferta WHERE (
        nombre_espectaculo_oferta = nombre_espectaculo_ofertaIN AND
        nombre_recinto_oferta = nombre_recinto_ofertaIN AND
        localizacion_localidad_oferta = localizacion_localidad_ofertaIN AND
        nombre_grada_oferta = nombre_espectaculo_ofertaIN AND
        fecha_evento_oferta = fecha_evento_ofertaIN AND
        estado_localidad_oferta = 'libre'
    ) = '') THEN
        CALL Error (9, "No existen ofertas para esta localidad.");
    END IF;

    
    CALL CalcularPrecio (nombre_espectaculo_ofertaIN, nombre_recinto_ofertaIN, localizacion_localidad_ofertaIN, tipo_usuario_IN, precio);

    INSERT INTO Compra (
        dni_cliente_compra,
        tipo_usuario_compra,
        localizacion_localidad_compra,
        nombre_grada_compra,
        nombre_recinto_compra,
        precioFinal
    ) 
    Values (
        dni_clienteIN,
        tipo_usuario_IN,
        localizacion_localidad_ofertaIN,
        nombre_grada_ofertaIN,
        nombre_recinto_compra,
        precio
    );

    UPDATE Oferta SET estado_localidad_oferta = 'pre-reservado'  
    WHERE (
        nombre_espectaculo_oferta = nombre_espectaculo_ofertaIN AND
        nombre_recinto_oferta = nombre_recinto_ofertaIN AND
        localizacion_localidad_oferta = localizacion_localidad_ofertaIN AND
        nombre_grada_oferta = nombre_espectaculo_ofertaIN AND
        fecha_evento_oferta = fecha_evento_ofertaIN
    );


END //






DELIMITER ;



