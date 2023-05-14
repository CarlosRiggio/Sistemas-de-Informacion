USE Taquilla;

DELIMITER //

DROP PROCEDURE IF EXISTS crear_gradas;

CREATE PROCEDURE crear_gradas(IN nombre_grada_in VARCHAR(50), IN nombre_recinto_grada_in VARCHAR(50), num_localidades_reservar_grada_in int, precio_grada_in int)
BEGIN

CREATE TABLE IF NOT EXISTS Grada 
(
    nombre_grada VARCHAR(50),
    nombre_recinto_grada VARCHAR(50),
    num_localidades_reservar_grada INT,
    precio_grada INT,
    FOREIGN KEY(nombre_recinto_grada) REFERENCES Recinto(nombre_recinto),
    PRIMARY KEY(nombre_grada, nombre_recinto_grada)
);

INSERT INTO Grada(nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) VALUES (nombre_grada_in, nombre_recinto_grada_in, num_localidades_reservar_grada_in, precio_grada_in);

END//

DELIMITER ;

CALL crear_gradas('Grada Norte', 'Camp Nou', 10000, 50);
