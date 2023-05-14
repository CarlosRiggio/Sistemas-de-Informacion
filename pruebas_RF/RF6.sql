USE Taquilla;


--Creamos el evento que va a estar cerrado para asegurarnos

CALL crear_espectaculo('El Clasico', 'El partido del año', 'Barca, Real Madrid');

CALL CrearEvento ("El Clasico", "Camp Nou", "2023-5-12 5:00:00", "Cerrado");

--Intenta comprar una entrada de un evento cerrado

CALL ComprarEntrada('97780491', 'jubilado', 'El Clasico', '2023-05-15 01:00:00', 'Suelo 99', 'Grada Norte', 'Camp Nou');
