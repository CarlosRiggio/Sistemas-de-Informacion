CREATE PROCEDURE AgregarLocalidad(
    @localizacion_localidad VARCHAR(50),
    @nombre_recinto_localidad VARCHAR(50),
    @nombre_grada_localidad VARCHAR(50),
    @precio_base_localidad INT,
    @estado_localidad ENUM ('pre-reservado', 'reservado', 'deteriorado', 'libre')
)
AS
BEGIN
    INSERT INTO Localidad (
        localizacion_localidad,
        nombre_recinto_localidad,
        nombre_grada_localidad,
        precio_base_localidad,
        estado_localidad
    ) VALUES (
        @localizacion_localidad,
        @nombre_recinto_localidad,
        @nombre_grada_localidad,
        @precio_base_localidad,
        @estado_localidad
    )
END
