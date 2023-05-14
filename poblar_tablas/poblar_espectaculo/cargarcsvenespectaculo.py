import csv
import mysql.connector

# Configura la conexión a la base de datos
config = {
    'user': 'root',
    'password': '123456',
    'host': 'localhost',
    'database': 'Taquilla'
}

# Crea la conexión a la base de datos
conexion = mysql.connector.connect(**config)

# Crea un cursor para ejecutar consultas
cursor = conexion.cursor()

# Nombre del archivo CSV a importar
archivo_csv = 'nuevas_pelis.csv'

try:
    # Leer el archivo CSV
    with open(archivo_csv, 'r') as file:
        reader = csv.reader(file)
        next(reader)  # Ignorar la primera línea (encabezados)

        # Iterar sobre cada fila del archivo CSV
        for row in reader:
            nombre_espectaculo = row[0]
            actores_espectaculo = row[1]
            descripcion_espectaculo = row[2]

            # Ejecutar el procedimiento almacenado utilizando parámetros de Python
            cursor.callproc('crear_espectaculo', (nombre_espectaculo, descripcion_espectaculo, actores_espectaculo))
            conexion.commit()

    print("Los datos se han cargado correctamente utilizando el procedimiento almacenado.")

except mysql.connector.Error as err:
    # Manejo de errores en caso de que ocurra un problema con la carga de datos
    print(f"Error al cargar los datos: {err}")

# Cerrar el cursor y la conexión a la base de datos
cursor.close()
conexion.close()
