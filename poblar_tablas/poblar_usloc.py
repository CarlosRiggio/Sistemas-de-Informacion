import mysql.connector

# Conexión a la base de datos
connection = mysql.connector.connect(
    host="localhost",
    user="juan",
    password="1234",
    database="Taquilla"
)

# Crear un cursor para ejecutar consultas
cursor = connection.cursor()

# Obtener las localidades disponibles con su recinto y grada correspondientes
cursor.execute("""
    SELECT l.localizacion_localidad, l.nombre_recinto_localidad, l.nombre_grada_localidad
    FROM Localidad l
    WHERE l.estado_localidad = 'disponible'
""")
localidades = cursor.fetchall()

# Crear registros en UsLoc para cada localidad y tipo de usuario
for localidad in localidades:
    for tipo_usuario in ['jubilado', 'parado', 'adulto', 'infantil']:
        try:
            print(f"CALL crear_usLoc('{localidad[0]}', '{localidad[2]}', '{localidad[1]}', '{tipo_usuario}');")

            cursor.callproc("crear_usLoc", [localidad[0], localidad[2], localidad[1], tipo_usuario])
            connection.commit()

            # Obtener el mensaje de salida del procedimiento
            resultados = cursor.stored_results()
            mensaje = resultados.fetchone()[0]
            print("Mensaje de salida:", mensaje)
        except mysql.connector.IntegrityError:
            # Capturar la excepción cuando la tupla ya existe en UsLoc
            print("Error en", localidad[0], localidad[2], localidad[1], tipo_usuario)
            pass

# Cerrar el cursor y la conexión
cursor.close()
connection.close()
