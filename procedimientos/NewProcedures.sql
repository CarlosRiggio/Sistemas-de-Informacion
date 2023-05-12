

DROP PROCEDURE IF EXISTS CalcularPrecio;
DROP PROCEDURE IF EXISTS ttt;


DELIMITER //

CREATE PROCEDURE CalcularPrecio (

    -- ! Como se supone que identificamos a los clientes con los usuarios?
    -- ! Hay que cambiar las tablas con estados, porque los corta

    -- Datos Grada      ---> IncrementoPrecio
    -- Datos Localidad  ---> PrecioBase
    -- Datos Usuario    ---> DescuentoPrecio

    IN nombreGrada VARCHAR(50),
    IN nombreRecintoGrada VARCHAR(50),
    IN tipoUsuario VARCHAR(30),

    IN localizacionLocalidad VARCHAR(50),
    IN nombreRecintoLocalidad VARCHAR(50),
    IN nombreGradaLocalidad VARCHAR(50),
    
    OUT precioFinal FLOAT

)
BEGIN
    
    DECLARE incrementoPrecioGrada FLOAT;
    DECLARE precioBaseLocalidad FLOAT;
    DECLARE descuentoUsuario FLOAT;

    SELECT precio_grada INTO incrementoPrecioGrada
    FROM Grada
    WHERE nombre_grada = nombreGrada AND
        nombre_recinto_grada = nombreRecintoGrada
    ;

    SELECT precio_base_localidad INTO precioBaseLocalidad 
    FROM Localidad
    WHERE localizacion_localidad = localizacionLocalidad AND
        nombre_recinto_localidad = nombreRecintoLocalidad AND
        nombre_grada_localidad = nombreGradaLocalidad
    ;


    SELECT descuento_usuario INTO descuentoUsuario
    FROM Usuario
    WHERE tipo_usuario = tipoUsuario; 


    SET precioFinal = incrementoPrecioGrada * precioBaseLocalidad * descuentoUsuario;

END // 


CREATE PROCEDURE ttt ()
BEGIN
    DECLARE precio FLOAT;
    CALL CalcularPrecio("Grada Norte", "Camp Nou", "parado", "Romero", "Camp Nou", "Grada Norte", precio);
    SELECT precio AS message;
END //


DELIMITER ;



