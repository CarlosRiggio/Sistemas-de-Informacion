import mysql.connector
import random
import datetime

# Conexión a la base de datos
connection = mysql.connector.connect(
    host="localhost",
    user="riggio",
    password="123456",
    database="Taquilla"
)

# Crear un cursor para ejecutar procedimientos almacenados
cursor = connection.cursor()


# Obtener los nombres de los espectáculos existentes
cursor.execute("SELECT nombre_espectaculo FROM Espectaculo")
espectaculos = cursor.fetchall()

# Obtener los nombres de los recintos existentes
cursor.execute("SELECT nombre_recinto FROM Recinto")
recintos = cursor.fetchall()

print(espectaculos)
print(recintos)
# Generar eventos aleatorios para cada espectáculo
for espectaculo in espectaculos:
    for _ in range(4):
        # Generar fecha aleatoria posterior a julio de 2023
        fecha_evento = datetime.datetime(random.randint(2024, 2027), random.randint(1, 12), random.randint(1, 28))
        estado_evento = 'abierto'
        
        # Seleccionar un recinto aleatorio
        recinto = random.choice(recintos)[0]
        
        # Llamar al procedimiento almacenado para insertar el evento
        cursor.callproc("CrearEvento", (espectaculo[0], recinto, fecha_evento, estado_evento))
        connection.commit()


# Cerrar el cursor y la conexión
cursor.close()
connection.close()
