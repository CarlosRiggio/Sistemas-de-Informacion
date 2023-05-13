

DROP PROCEDURE IF EXISTS CalcularPrecio;
DROP PROCEDURE IF EXISTS ttt;


DELIMITER //

CREATE PROCEDURE CalcularPrecio (

    -- ? Como se supone que identificamos a los clientes con los usuarios?
    -- ? Los eventos modifican el precio base de las localidades?
    -- ? Como identificamos a los clientes con sus entradas?

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



