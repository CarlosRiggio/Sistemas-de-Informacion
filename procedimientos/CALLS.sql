

CALL crear_espectaculo('El Clásico', 'El partido del año', 'Barca, Real Madrid');


CALL CrearEvento ("El Rey Leon", "Yelmo Cines", "2023-5-15 5:00:00", "Abierto");

CALL crear_gradas('Grada Norte', 'Estadio XYZ', 100, 50);
CALL crear_gradas('Grada SUR', 'Estadio WANDA', 10, 67);
CALL crear_gradas('Grada Puerto Rico', 'Jolines macho', 56, 3);

CALL crear_recinto('Camp Nou', 89000);

CALL eliminar_gradas('Grada Norte', 'Estadio XYZ', 100, 50);

CALL obtener_eventos_por_estado('finalizado');