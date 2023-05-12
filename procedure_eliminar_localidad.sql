/*ELIMINAR LOCALIDAD*/
CREATE PROCEDURE EliminarLocalidad (
    @localizacion_localidad VARCHAR(50),
    @nombre_recinto_localidad VARCHAR(50),
    @nombre_grada_localidad VARCHAR(50)
)
AS
BEGIN
    DELETE FROM Localidad
    WHERE localizacion_localidad = @localizacion_localidad
        AND nombre_recinto_localidad = @nombre_recinto_localidad
        AND nombre_grada_localidad = @nombre_grada_localidad
END
