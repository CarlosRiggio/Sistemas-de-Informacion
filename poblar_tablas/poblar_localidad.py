import random
import string
import mysql.connector

# Conexión a la base de datos
connection = mysql.connector.connect(
    host="localhost",
    user="juan",
    password="1234",
    database="Taquilla"
)

# Función para generar un nombre de localidad único en una grada y recinto específicos
def generar_nombre_localidad(grada, recinto, contador):
    formatos_localidad = ["Asiento", "Butaca", "Suelo", "Balcón"]
    nombre_localidad = "{} {}".format(random.choice(formatos_localidad), contador)
    
    return nombre_localidad

# Consulta de los recintos existentes
cursor_recintos = connection.cursor()
cursor_recintos.execute("SELECT nombre_recinto FROM Recinto")
recintos = cursor_recintos.fetchall()

# Generación y ejecución de la inserción de localidades por recinto
for recinto in recintos:
    nombre_recinto = recinto[0]
    
    # Consulta de las gradas del recinto
    cursor_gradas = connection.cursor(dictionary=True)
    query_gradas = "SELECT nombre_grada, num_localidades_reservar_grada FROM Grada WHERE nombre_recinto_grada = %s"
    values_gradas = (nombre_recinto,)
    cursor_gradas.execute(query_gradas, values_gradas)
    gradas = cursor_gradas.fetchall()
    
    for grada in gradas:
        num_localidades = grada['num_localidades_reservar_grada']
        contador = 1
        print("Generando {} localidades para la grada {} del recinto {}".format(num_localidades, grada['nombre_grada'], nombre_recinto))
        
        for _ in range(num_localidades):
            nombre_localidad = generar_nombre_localidad(grada, nombre_recinto, contador)
            
            precio_base_localidad = random.randint(5, 50)
            estado_localidad = 'disponible'
            
            cursor_localidades = connection.cursor()
            
            try:
                # Imprimir la línea para llamar al procedimiento almacenado
                #print(f"CALL crear_localidad('{nombre_localidad}', '{nombre_recinto}', '{grada['nombre_grada']}', '{precio_base_localidad}', '{estado_localidad}');")

                # Llamar y ejecutar el procedimiento almacenado
                cursor_localidades.callproc("crear_localidad", (nombre_localidad, nombre_recinto, grada['nombre_grada'], precio_base_localidad, estado_localidad))
                connection.commit()
            
            except mysql.connector.IntegrityError:
                # Capturar la excepción cuando la tupla ya existe en UsLoc
                pass
            contador += 1
    
    cursor_gradas.close()

# Cierre de la conexión
cursor_recintos.close()
connection.close()