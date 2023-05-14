import csv

# Nombre del archivo CSV de entrada y salida
input_file = 'recintos.csv'
output_file = 'nombres_capacidad.csv'

# Lista para almacenar los datos de nombre y capacidad
nombres_capacidad = []

# Leer el archivo CSV de entrada
with open(input_file, 'r') as file:
    reader = csv.reader(file)
    header = next(reader)  # Leer la primera línea (encabezados)

    # Obtener los índices de las columnas de nombre y capacidad
    name_index = header.index('name')
    capacity_index = header.index('capacity')

    # Leer cada línea del archivo
    for row in reader:
        nombre = row[name_index]
        capacidad = row[capacity_index]

        # Agregar los datos de nombre y capacidad a la lista
        nombres_capacidad.append([nombre, capacidad])

# Guardar los datos en un nuevo archivo CSV
with open(output_file, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['Nombre', 'Capacidad'])  # Escribir la primera línea (encabezados)
    writer.writerows(nombres_capacidad)  # Escribir los datos de nombre y capacidad

print(f"Los datos se han guardado correctamente en el archivo {output_file}.")
