USE Taquilla;

-- dni cliente, tipo usuario, espectaculo, fecha, localizacion localidad, nombre grada, nombre recinto
CALL ComprarEntrada('123456789','infantil', 'Kimi no na wa fsu', 'Jack Trice Stadium mtq', 'Asiento 2', 'Grada Sur Tribuna', '2027-02-10 00:00:00');

-- seleccionar DNI de otro cliente para comprobar

CALL ComprarEntrada('48505128','infantil', 'Kimi no na wa fsu', 'Jack Trice Stadium mtq', 'Asiento 2', 'Grada Sur Tribuna', '2027-02-10 00:00:00');

-- justificar que 2 entradas no se pueden corresponder a la misma localidad

CALL ComprarEntrada('48505128','jubilado', 'Kimi no na wa fsu', 'Jack Trice Stadium mtq', 'Asiento 2', 'Grada Sur Tribuna', '2027-02-10 00:00:00');

-- seleccionar compra para enserñar que solo se hizo 1 compra
-- seleccionar oferta para ver que se ha cambiado su estado