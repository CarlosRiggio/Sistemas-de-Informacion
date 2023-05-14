
-- RF 3: Venta de Entradas al precio estipulado

-- Comprar varias entradas de diferente usuario y checkear el precio final de sus entradas.

-- Hacemos INSERT de esto:
-- INSERT INTO Cliente(dni_cliente, datos_bancarios_cliente) VALUES ('QQQQQQQQQ','1234567890123456789012345678901234');

CALL crear_espectaculo ('Cars 2', 'Secuela de Cars', 'Rayo McQueen');

CALL crear_recinto ('Casa de Santi', 5);

CALL crear_gradas ('sofa', 'Casa de Santi', 5, 10);

CALL crear_localidad ('Asiento 1', 'Casa de Santi', 'sofa', 5, 'disponible');
CALL crear_localidad ('Asiento 2', 'Casa de Santi', 'sofa', 5, 'disponible');
CALL crear_localidad ('Asiento 3', 'Casa de Santi', 'sofa', 5, 'disponible');
CALL crear_localidad ('Asiento 4', 'Casa de Santi', 'sofa', 5, 'disponible');
CALL crear_localidad ('Asiento 5', 'Casa de Santi', 'sofa', 5, 'disponible');

CALL CrearEvento ('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'abierto');

CALL crear_usLoc ('Asiento 1', 'sofa', 'Casa de Santi', 'adulto');
CALL crear_usLoc ('Asiento 1', 'sofa', 'Casa de Santi', 'jubilado');
CALL crear_usLoc ('Asiento 1', 'sofa', 'Casa de Santi', 'parado');
CALL crear_usLoc ('Asiento 1', 'sofa', 'Casa de Santi', 'infantil');

CALL crear_usLoc ('Asiento 2', 'sofa', 'Casa de Santi', 'adulto');
CALL crear_usLoc ('Asiento 2', 'sofa', 'Casa de Santi', 'jubilado');
CALL crear_usLoc ('Asiento 2', 'sofa', 'Casa de Santi', 'parado');
CALL crear_usLoc ('Asiento 2', 'sofa', 'Casa de Santi', 'infantil');

CALL crear_usLoc ('Asiento 3', 'sofa', 'Casa de Santi', 'adulto');
CALL crear_usLoc ('Asiento 3', 'sofa', 'Casa de Santi', 'jubilado');
CALL crear_usLoc ('Asiento 3', 'sofa', 'Casa de Santi', 'parado');
CALL crear_usLoc ('Asiento 3', 'sofa', 'Casa de Santi', 'infantil');

CALL crear_usLoc ('Asiento 4', 'sofa', 'Casa de Santi', 'adulto');
CALL crear_usLoc ('Asiento 4', 'sofa', 'Casa de Santi', 'jubilado');
CALL crear_usLoc ('Asiento 4', 'sofa', 'Casa de Santi', 'parado');
CALL crear_usLoc ('Asiento 4', 'sofa', 'Casa de Santi', 'infantil');

CALL crear_usLoc ('Asiento 5', 'sofa', 'Casa de Santi', 'adulto');
CALL crear_usLoc ('Asiento 5', 'sofa', 'Casa de Santi', 'jubilado');
CALL crear_usLoc ('Asiento 5', 'sofa', 'Casa de Santi', 'parado');
CALL crear_usLoc ('Asiento 5', 'sofa', 'Casa de Santi', 'infantil');


CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'adulto', 'Asiento 1', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'jubilado', 'Asiento 1', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'parado', 'Asiento 1', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'infantil', 'Asiento 1', 'sofa');

CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'adulto', 'Asiento 2', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'jubilado', 'Asiento 2', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'parado', 'Asiento 2', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'infantil', 'Asiento 2', 'sofa');

CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'adulto', 'Asiento 3', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'jubilado', 'Asiento 3', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'parado', 'Asiento 3', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'infantil', 'Asiento 3', 'sofa');

CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'adulto', 'Asiento 4', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'jubilado', 'Asiento 4', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'parado', 'Asiento 4', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'infantil', 'Asiento 4', 'sofa');

CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'adulto', 'Asiento 5', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'jubilado', 'Asiento 5', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'parado', 'Asiento 5', 'sofa');
CALL crearOferta('Cars 2', 'Casa de Santi', '2023-12-12 20:00:00', 'infantil', 'Asiento 5', 'sofa');


SELECT * FROM Oferta;
SELECT * FROM Usuario;

CALL ComprarEntrada ('QQQQQQQQQ', 'adulto', 'Cars 2', 'Casa de Santi', 'Asiento 1', 'sofa', '2023-12-12 20:00:00');
CALL ComprarEntrada ('QQQQQQQQQ', 'jubilado', 'Cars 2', 'Casa de Santi', 'Asiento 2', 'sofa', '2023-12-12 20:00:00');
CALL ComprarEntrada ('QQQQQQQQQ', 'parado', 'Cars 2', 'Casa de Santi', 'Asiento 3', 'sofa', '2023-12-12 20:00:00');
CALL ComprarEntrada ('QQQQQQQQQ', 'infantil', 'Cars 2', 'Casa de Santi', 'Asiento 4', 'sofa', '2023-12-12 20:00:00');

SELECT * FROM Compra;
