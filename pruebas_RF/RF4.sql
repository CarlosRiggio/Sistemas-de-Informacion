CALL crear_recinto('Estadio Balaidos', 10);

CALL crear_gradas('Grada Norte', 'Estadio Balaidos', 2, 30);
CALL crear_gradas('Grada Sur', 'Estadio Balaidos', 2, 30);
CALL crear_gradas('Grada Este', 'Estadio Balaidos', 2, 30);
CALL crear_gradas('Grada Oeste', 'Estadio Balaidos', 2, 30);


CALL crear_gradas('Grada XTRA', 'Estadio Balaidos', 4, 30);

CALL crear_localidad('Butaca 1', 'Estadio Balaidos', 'Grada Norte', 30, 'disponible');
CALL crear_localidad('Butaca 2', 'Estadio Balaidos', 'Grada Norte', 30, 'disponible');


CALL crear_localidad('Butaca XTRA', 'Estadio Balaidos', 'Grada Norte', 30, 'disponible');

SELECT * FROM Recinto;
SELECT * FROM Grada WHERE nombre_recinto_grada = 'Estadio Balaidos';
SELECT * FROM Localidad WHERE nombre_recinto_localidad = 'Estadio Balaidos' AND nombre_grada_localidad = 'Grada Norte';



