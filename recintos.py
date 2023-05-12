import sqlite3
import random

# Creamos una conexión a una base de datos SQLite en memoria
conn = sqlite3.connect(':memory:')

# Creamos un cursor para ejecutar consultas SQL
cursor = conn.cursor()

# Creamos la tabla "recinto" con los atributos "nombre_recinto" y "localidades_totales"

# Generamos 100 filas de datos aleatorios sin nombres de recinto repetidos
recintos = []
while len(recintos) < 10000:
    nombre_recinto = f"Recinto {len(recintos)}"
    if nombre_recinto not in recintos:
        recintos.append(nombre_recinto)
        localidades_totales = random.randint(1000, 100000)
        cursor.execute('INSERT INTO Recinto VALUES (?, ?)', (nombre_recinto, localidades_totales))

# Guardamos los cambios en la base de datos
conn.commit()

# Abrimos el archivo "recintos.sql" en modo escritura y guardamos los datos de la tabla "recinto"
with open("recintos.sql", "w") as f:
    for row in cursor.execute('SELECT * FROM recinto'):
        f.write(f"INSERT INTO recinto (nombre_recinto, localidades_totales) VALUES ('{row[0]}', {row[1]});\n")

# Cerramos la conexión a la base de datos
conn.close()