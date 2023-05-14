import csv

# Ruta del archivo de entrada y salida
archivo_entrada = 'pelis.csv'
archivo_salida = 'pelis_limpio.csv'

# Campos que deseas extraer
campos_deseados = ['Title', 'Actors', 'Description']

# Abrir el archivo de entrada en modo lectura
with open(archivo_entrada, 'r') as archivo_lectura:
    # Crear el objeto lector CSV
    lector_csv = csv.DictReader(archivo_lectura)
    
    # Abrir el archivo de salida en modo escritura
    with open(archivo_salida, 'w', newline='') as archivo_escritura:
        # Crear el objeto escritor CSV
        escritor_csv = csv.DictWriter(archivo_escritura, fieldnames=campos_deseados)
        
        # Escribir los encabezados en el archivo de salida
        escritor_csv.writeheader()
        
        # Leer cada fila del archivo de entrada
        for fila in lector_csv:
            # Crear un diccionario con los campos deseados de cada fila
            fila_extraida = {campo: fila[campo] for campo in campos_deseados}
            
            # Escribir la fila extraída en el archivo de salida
            escritor_csv.writerow(fila_extraida)

print("Extracción completada. Se ha guardado en el archivo:", archivo_salida)
