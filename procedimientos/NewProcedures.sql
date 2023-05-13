

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


CREATE PROCEDURE ttt ()
BEGIN
    DECLARE precio FLOAT;
    -- CALL CalcularPrecio("Grada Norte", "Camp Nou", "parado", "Romero", "Camp Nou", "Grada Norte", precio);
    CALL CalcularPrecio ("Grada Norte", "Camp Nou", "Romero", "parado", precio);
    SELECT precio AS message;
END //


DELIMITER ;



