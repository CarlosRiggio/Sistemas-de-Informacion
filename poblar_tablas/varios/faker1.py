import random
from faker import Faker
import mysql.connector

# Conexión a la base de datos
connection = mysql.connector.connect(
    host="localhost",
    user="juan",
    password="1234",
)

# Crear la base de datos si no existe
database_name = "test1"
cursor = connection.cursor()
cursor.execute(f"CREATE DATABASE IF NOT EXISTS {database_name}")
connection.database = database_name

# Crear la tabla si no existe
cursor.execute("""
    CREATE TABLE IF NOT EXISTS espectaculos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255),
        descripcion TEXT,
        participantes VARCHAR(255)
    )
""")

# Crea un objeto Faker
fake = Faker()

# Genera datos y los inserta en la tabla de espectáculos
num_espectaculos = 1000000  # Número de espectáculos a generar

for _ in range(num_espectaculos):
    nombre = fake.company()  # Genera un nombre de espectáculo ficticio
    descripcion = fake.text()  # Genera una descripción ficticia
    
    # Genera una lista de dos nombres de participantes ficticios
    participantes = [fake.name() for _ in range(2)]
    participantes = ', '.join(participantes)  # Convierte la lista en una cadena separada por comas
    
    # Crea y ejecuta la consulta SQL de inserción
    query = "INSERT INTO espectaculos (nombre, descripcion, participantes) VALUES (%s, %s, %s)"
    values = (nombre, descripcion, participantes)
    cursor.execute(query, values)

# Confirmar los cambios en la base de datos
connection.commit()

# Cierra la conexión a la base de datos
connection.close()
