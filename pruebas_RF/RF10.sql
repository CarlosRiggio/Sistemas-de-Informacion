-- No anular una compra poco timepo antes de hacerse

UPDATE Evento
SET fecha_evento = '2023-05-15 01:00:00'
WHERE nombre_espectaculo_evento = 'Kimi no na wa fsu' 
AND nombre_recinto_evento = 'Jack Trice Stadium mtq' 
AND fecha_evento = '2027-02-10 00:00:00';


UPDATE Oferta SET fecha_evento_oferta = '2023-05-15 20:00:00' 
WHERE nombre_espectaculo_oferta = 'Kimi no na wa fsu' 
AND nombre_recinto_oferta = 'Jack Trice Stadium mtq' 
AND tipo_usuario_oferta = 'infantil' 
AND localizacion_localidad_oferta = 'Butaca 4' 
AND nombre_grada_oferta = 'Grada Sur Tribuna' 
AND fecha_evento_oferta = '2027-02-10 00:00:00';


CALL ComprarEntrada('123456789', 'infantil', 'Kimi no na wa fsu', 'Jack Trice Stadium mtq', 'Butaca 4', 'Grada Sur Tribuna', '2023-05-15 01:00:00');

select * from Compra;

CALL anular_compra('123456789', 'infantil', 'Kimi no na wa fsu','2023-05-15 01:00:00','Butaca 4', 'Grada Sur Tribuna', 'Jack Trice Stadium mtq' );
select * from Compra;