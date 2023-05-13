USE Taquilla;

INSERT INTO Recinto(nombre_recinto, localidades_recinto) VALUES ('Camp Nou', '300');
INSERT INTO Recinto(nombre_recinto, localidades_recinto) VALUES ('Bernabeu', '500');
INSERT INTO Recinto(nombre_recinto, localidades_recinto) VALUES ('Balaidos', '450');

INSERT INTO Grada(nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) VALUES ('SUR', 'Camp Nou', '30', '15');
INSERT INTO Grada(nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) VALUES ('NORTE', 'Bernabeu', '50', '30');
INSERT INTO Grada(nombre_grada, nombre_recinto_grada, num_localidades_reservar_grada, precio_grada) VALUES ('OESTE', 'Balaidos', '70', '45');