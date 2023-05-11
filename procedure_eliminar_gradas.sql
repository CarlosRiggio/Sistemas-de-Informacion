USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS eliminar_gradas//

CREATE PROCEDURE eliminar_gradas(IN nombre_grada_in VARCHAR(50), IN nombre_recinto_grada_in VARCHAR(50), num_localidades_reservar_grada_in int, precio_grada_in int)
BEGIN

DELETE FROM Grada
WHERE nombre_grada = nombre_grada_in AND
    nombre_recinto_grada = nombre_recinto_grada_in AND
    num_localidades_reservar_grada = num_localidades_reservar_grada_in AND
    precio_grada = precio_grada_in;

END//

DELIMITER ;

CALL eliminar_gradas('Grada Norte', 'Estadio XYZ', 100, 50);

