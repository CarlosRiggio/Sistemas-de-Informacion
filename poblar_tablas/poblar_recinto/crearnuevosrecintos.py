import csv
import random

numero_estadios = 100
# Archivo CSV con los nombres y capacidades de los recintos
archivo_csv = 'nombres_capacidad.csv'

# Lista para almacenar los nombres de recintos
nombres_recintos = []

# Leer el archivo CSV y obtener los nombres de los recintos
with open(archivo_csv, 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        nombres_recintos.append(row['Nombre'])

# Crear 10,000 estadios con nombres aleatorios basados en la lista original
nuevos_estadios = []
for _ in range(numero_estadios):
    nombre_recinto = random.choice(nombres_recintos)
    palabra_aleatoria = ''.join(random.choice('abcdefghijklmnopqrstuvwxyz') for _ in range(3))
    nuevo_nombre = f"{nombre_recinto} {palabra_aleatoria}"
    capacidad_estadio = random.randint(100, 100000)
    nuevos_estadios.append({'Nombre': nuevo_nombre, 'Capacidad': capacidad_estadio})

# Guardar los nuevos estadios en un archivo CSV
output_file = 'nuevos_estadios.csv'
with open(output_file, 'w', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=['Nombre', 'Capacidad'])
    writer.writeheader()
    writer.writerows(nuevos_estadios)

print(f"Se han creado y guardado los {numero_estadios} estadios en el archivo {output_file}.")
