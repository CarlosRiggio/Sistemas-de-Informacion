SET FOREIGN_KEY_CHECKS=0;

DROP PROCEDURE IF EXISTS ComprarEntrada;
DROP PROCEDURE IF EXISTS CalcularPrecio;
DROP PROCEDURE IF EXISTS ttt;


DELIMITER //

-- CREATE PROCEDURE ttt ()
-- BEGIN
--     DECLARE precio FLOAT;
--     -- CALL CalcularPrecio("Grada Norte", "Camp Nou", "parado", "Romero", "Camp Nou", "Grada Norte", precio);
--     CALL CalcularPrecio ("Grada Norte", "Camp Nou", "Romero", "parado", precio);
--     SELECT precio AS message;
-- END //



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
    IF ( (SELECT EXISTS(SELECT * FROM Recinto WHERE nombre_recinto = nombreRecinto) ) = 0) THEN
        CALL Error(2, "No existe dicho Recinto.");
    END IF;

    IF ( (SELECT EXISTS(SELECT * FROM Grada WHERE nombre_grada = nombreGrada AND nombre_recinto_grada = nombreRecinto) ) = 0) THEN
        CALL Error(6, "No existe dicha Grada.");
    END IF;

    IF ( (SELECT EXISTS(SELECT * FROM Localidad 
    WHERE localizacion_localidad = localizacionLocalidad AND nombre_recinto_localidad = nombreRecinto AND nombre_grada_localidad = nombreGrada) ) = 0) THEN
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
    DECLARE consulta VARCHAR(50);
    
    SELECT dni_cliente INTO consulta FROM Cliente WHERE dni_cliente = dni_cliente_IN;
    
    IF consulta IS NULL THEN
    	CALL Error (10,"Cliente inexistente");
    END IF;

    IF (SELECT EXISTS(SELECT * FROM Evento WHERE (
        nombre_espectaculo_evento = nombre_espectaculo_ofertaIN AND
        nombre_recinto_evento = nombre_recinto_ofertaIN AND
        fecha_evento = fecha_evento_ofertaIN AND
        estado_evento = "abierto"
    )) = 0 ) THEN 
        CALL Error (5, "Evento inexistente.");
    END IF;

    IF (SELECT EXISTS (SELECT * FROM Localidad WHERE (
        localizacion_localidad = localizacion_localidad_ofertaIN AND
        nombre_recinto_localidad = nombre_recinto_ofertaIN AND
        nombre_grada_localidad = nombre_grada_ofertaIN AND
        estado_localidad = 'disponible'
    )) = 0) THEN
        CALL Error(8, "Localidad no disponible.");
    END IF;

    IF (SELECT EXISTS (SELECT * FROM Oferta WHERE (
        nombre_espectaculo_oferta = nombre_espectaculo_ofertaIN AND
        nombre_recinto_oferta = nombre_recinto_ofertaIN AND
        localizacion_localidad_oferta = localizacion_localidad_ofertaIN AND
      	tipo_usuario_oferta = tipo_usuario_IN AND
        nombre_grada_oferta = nombre_grada_ofertaIN AND
        fecha_evento_oferta = fecha_evento_ofertaIN AND
        estado_localidad_oferta = 'libre'
    )) = 0 ) THEN
        CALL Error (9, "No existen ofertas para esta localidad.");
    END IF;

    CALL CalcularPrecio (nombre_grada_ofertaIN, nombre_recinto_ofertaIN, localizacion_localidad_ofertaIN, tipo_usuario_IN, precio);


    INSERT INTO Compra (
        dni_cliente_compra,
        tipo_usuario_compra,
        espectaculo_compra,
        fecha_compra,
        localizacion_localidad_compra,
        nombre_grada_compra,
        nombre_recinto_compra,
        precioFinal
    ) 
    Values (
        dni_cliente_IN,
        tipo_usuario_IN,
        nombre_espectaculo_ofertaIN,
        fecha_evento_ofertaIN,
        localizacion_localidad_ofertaIN,
        nombre_grada_ofertaIN,
        nombre_recinto_ofertaIN,
        precio
    );

    UPDATE Oferta SET estado_localidad_oferta = 'pre-reservado'  
    WHERE (
        nombre_espectaculo_oferta = nombre_espectaculo_ofertaIN AND
        nombre_recinto_oferta = nombre_recinto_ofertaIN AND
        localizacion_localidad_oferta = localizacion_localidad_ofertaIN AND
        nombre_grada_oferta = nombre_grada_ofertaIN AND
        fecha_evento_oferta = fecha_evento_ofertaIN
    );


END //






DELIMITER ;
