import csv
import random

numero_espectaculos = 100
archivo_csv = 'pelis_limpio.csv'

# Leer el archivo CSV y obtener los nombres de los espectáculos
nombres_espectaculos = []
actores_espectaculos = []
descripciones_espectaculos = []

with open(archivo_csv, 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        nombres_espectaculos.append(row['Title'])
        actores_espectaculos.append(row['Actors'])
        descripciones_espectaculos.append(row['Description'])

# Crear espectáculos únicos basados en la lista original
nuevos_espectaculos = set()  # Conjunto para almacenar los espectáculos generados

while len(nuevos_espectaculos) < numero_espectaculos:
    indice_aleatorio = random.randint(0, len(nombres_espectaculos) - 1)
    nombre_espectaculo = nombres_espectaculos[indice_aleatorio][:40]
    actores_espectaculo = actores_espectaculos[indice_aleatorio][:49]
    descripcion_espectaculo = descripciones_espectaculos[indice_aleatorio][:49]

    palabra_aleatoria = ''.join(random.choice('abcdefghijklmnopqrstuvwxyz') for _ in range(3))
    nuevo_nombre = f"{nombre_espectaculo} {palabra_aleatoria}"

    nuevos_espectaculos.add((nuevo_nombre, actores_espectaculo, descripcion_espectaculo))

nuevos_espectaculos = list(nuevos_espectaculos)  # Convertir el conjunto a una lista

# Guardar los nuevos espectáculos en un archivo CSV
output_file = 'nuevas_pelis.csv'
with open(output_file, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['Titulo', 'Actores', 'Descripcion'])
    writer.writerows(nuevos_espectaculos)

print(f"Se han creado y guardado los {len(nuevos_espectaculos)} espectáculos únicos en el archivo {output_file}.")
