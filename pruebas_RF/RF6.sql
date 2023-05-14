USE Taquilla;

CALL CrearEvento ('El Clasico', 'Camp Nou', '2023-05-18 08:00:00', 'Cerrado');


CALL crearOferta('El Clasico', 'Camp Nou', '2023-05-18 08:00:00', 'jubilado', 'Asiento 1', 'Grada Norte');
CALL crearOferta('El Clasico', 'Camp Nou', '2023-05-18 08:00:00', 'parado', 'Asiento 1', 'Grada Norte');
CALL crearOferta('El Clasico', 'Camp Nou', '2023-05-18 08:00:00', 'adulto', 'Asiento 1', 'Grada Norte');
CALL crearOferta('El Clasico', 'Camp Nou', '2023-05-18 08:00:00', 'infantil', 'Asiento 1', 'Grada Norte');

SELECT * FROM Oferta 
WHERE nombre_espectaculo_oferta = 'El Clasico' 
AND nombre_recinto_oferta = 'Camp Nou' 
AND localizacion_localidad_oferta = 'Asiento 1' 
AND nombre_grada_oferta = 'Grada Norte';

SELECT * FROM Evento;

CALL ComprarEntrada('123456789', 'jubilado', 'El Clasico', 'Camp Nou', 'Asiento 1', 'Grada Norte', '2023-05-18 08:00:00');

