Usando faker para generar datos:
pip install Faker mysql-connector-python 


CREATE USER 'riggio'@'localhost' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON Taquilla.* TO 'riggio'@'localhost';
FLUSH PRIVILEGES;


python3 -m venv /home/juan/pyenv
source /home/juan/pyenv/bin/activate

Cargar csv en tabla:
LOAD DATA INFILE 'ruta_al_archivo/recintos.csv'
INTO TABLE TuTabla
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


source /home/juan/SINF/procedimientos/crear_tablas.sql
source /home/juan/SINF/procedimientos/procedimientos_total.sql


Orden poblar:
Espectaculo
Recinto
Grada 
Localidad
Evento
Usuario(ya esta) con el procedimiento
UsLoc
Cliente
Oferta
Compra
