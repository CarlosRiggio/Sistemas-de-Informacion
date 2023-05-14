import csv
import mysql.connector
import sys

# Configura la conexión a la base de datos
config = {
    'user': 'juan',
    'password': '1234',
    'host': 'localhost',
    'database': 'Taquilla'
}

# Crea la conexión a la base de datos
cnx = mysql.connector.connect(**config)

# Crea un cursor para ejecutar consultas
cursor = cnx.cursor()

# Obtén el nombre de la tabla como argumento de línea de comandos
if len(sys.argv) > 1:
    table_name = sys.argv[1]
else:
    print("Por favor, proporciona el nombre de la tabla como argumento.")
    sys.exit()

# Consulta para obtener los primeros 1000 registros de la tabla
query = f"SELECT * FROM {table_name} LIMIT 1000"

try:
    # Ejecuta la consulta
    cursor.execute(query)

    # Obtiene los registros
    rows = cursor.fetchall()

    # Imprime los primeros 5 registros
    print("Los primeros 5 registros:")
    for i in range(min(5, len(rows))):
        print(rows[i])

    # Nombre del archivo CSV
    csv_filename = 'datos_tabla.csv'

    # Guarda los registros restantes en el archivo CSV
    with open(csv_filename, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow([i[0] for i in cursor.description])  # Escribe los encabezados de las columnas
        csv_writer.writerows(rows[5:])  # Escribe los registros restantes a partir del índice 5

    print(f"Los datos se han guardado correctamente en el archivo {csv_filename}")

except mysql.connector.Error as err:
    # Manejo de errores en caso de que ocurra un problema con la consulta
    print(f"Error al ejecutar la consulta: {err}")

# Cierra el cursor y la conexión a la base de datos
cursor.close()
cnx.close()
