USE Taquilla;

INSERT INTO Recinto(nombre_recinto, localidades_recinto) VALUES ('Camp Nou', '300');
INSERT INTO Recinto(nombre_recinto, localidades_recinto) VALUES ('Bernabeu', '500');
INSERT INTO Recinto(nombre_recinto, localidades_recinto) VALUES ('Balaidos', '450');

INSERT INTO Grada(nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) VALUES ('SUR', 'Camp Nou', '30', '15');
INSERT INTO Grada(nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) VALUES ('NORTE', 'Bernabeu', '50', '30');
INSERT INTO Grada(nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) VALUES ('OESTE', 'Balaidos', '70', '45');

INSERT INTO Localidad(localizacion_localidad, nombre_recinto_localidad, nombre_grada_localidad, precio_base_localidad, estado_localidad) VALUES ('1', 'Camp Nou', 'Sur', 30, 'disponible');
INSERT INTO Localidad(localizacion_localidad, nombre_recinto_localidad, nombre_grada_localidad, precio_base_localidad, estado_localidad) VALUES ('2', 'Camp Nou', 'Sur', 30, 'disponible');
INSERT INTO Localidad(localizacion_localidad, nombre_recinto_localidad, nombre_grada_localidad, precio_base_localidad, estado_localidad) VALUES ('3', 'Camp Nou', 'Sur', 30, 'disponible');
INSERT INTO Localidad(localizacion_localidad, nombre_recinto_localidad, nombre_grada_localidad, precio_base_localidad, estado_localidad) VALUES ('4', 'Camp Nou', 'Sur', 30, 'disponible');

INSERT INTO Usuario(tipo_usuario, descuento_usuario) VALUES ('jubilado', 10);
INSERT INTO Usuario(tipo_usuario, descuento_usuario) VALUES ('parado', 20);
INSERT INTO Usuario(tipo_usuario, descuento_usuario) VALUES ('adulto', 30);
INSERT INTO Usuario(tipo_usuario, descuento_usuario) VALUES ('infantil', 40);

INSERT INTO UsLoc(tipo_usuario_usloc, localizacion_localidad_usloc, nombre_grada_usloc, nombre_recinto_usloc) VALUES ('jubilado', '1', 'SUR', 'Camp Nou');
INSERT INTO UsLoc(tipo_usuario_usloc, localizacion_localidad_usloc, nombre_grada_usloc, nombre_recinto_usloc) VALUES ('parado', '2', 'SUR', 'Camp Nou');
INSERT INTO UsLoc(tipo_usuario_usloc, localizacion_localidad_usloc, nombre_grada_usloc, nombre_recinto_usloc) VALUES ('adulto', '3', 'SUR', 'Camp Nou');
INSERT INTO UsLoc(tipo_usuario_usloc, localizacion_localidad_usloc, nombre_grada_usloc, nombre_recinto_usloc) VALUES ('infantil', '4', 'SUR', 'Camp Nou');

INSERT INTO Cliente(dni_cliente, datos_bancarios_cliente) VALUES ('123456789','123456789');
INSERT INTO Cliente(dni_cliente, datos_bancarios_cliente) VALUES ('987654321','987654321');
