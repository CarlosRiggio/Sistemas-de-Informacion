-- Crear el recinto
CALL crear_recinto('Estadio O Poste', 10000);

-- Crear la grada
CALL crear_gradas('Grada Rubian', 'Estadio O Poste', 100, 50);

-- Crear el espectáculo
CALL crear_espectaculo('Playoff de Ascenso', 'Partido decisivo', 'Equipos participantes');

-- Crear el evento
CALL CrearEvento('Playoff de Ascenso', 'Estadio O Poste', '2024-01-24 21:00:00', 'Abierto');

-- Crear la localidad deteriorada
CALL crear_localidad('Tribuna 1', 'Estadio O Poste', 'Grada Rubian', 50, 'disponible');


CALL crear_usLoc('Tribuna 1', 'Grada Rubian', 'Estadio O Poste', 'infantil');


-- Crear la oferta con localidad deteriorada
CALL crearOferta('Playoff de Ascenso', 'Estadio O Poste', '2024-01-24 21:00:00', 'infantil', 'Tribuna 1', 'Grada Rubian');

-- Creamos cliente
INSERT INTO Cliente (dni_cliente, datos_bancarios_cliente) VALUES ('48505128', '1234-5678-9012-3456');

SELECT * FROM Oferta;

-- Llamar al procedimiento para comprar la entrada
CALL ComprarEntrada('48505128', 'parado', 'Playoff de Ascenso', 'Estadio O Poste','Tribuna 1', 'Grada Rubian', '2024-01-24 21:00:00');
CALL ComprarEntrada('48505128', 'adulto', 'Playoff de Ascenso', 'Estadio O Poste','Tribuna 1', 'Grada Rubian', '2024-01-24 21:00:00');
CALL ComprarEntrada('48505128', 'jubilado', 'Playoff de Ascenso', 'Estadio O Poste','Tribuna 1', 'Grada Rubian', '2024-01-24 21:00:00');
CALL ComprarEntrada('48505128', 'infantil', 'Playoff de Ascenso', 'Estadio O Poste','Tribuna 1', 'Grada Rubian', '2024-01-24 21:00:00');

SELECT * FROM Oferta;
SELECT * FROM Compra;


