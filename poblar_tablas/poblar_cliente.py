import mysql.connector
from faker import Faker


numero_tuplas = 10

# Conexión a la base de datos
connection = mysql.connector.connect(
    host="localhost",
    user="juan",
    password="1234",
    database="Taquilla"
)

# Crear un cursor para ejecutar consultas
cursor = connection.cursor()

# Instanciar el generador de datos falsos
fake = Faker()

# Generar y ejecutar las inserciones de tuplas para la tabla Cliente
for _ in range(numero_tuplas):
    dni_cliente = fake.unique.random_number(digits=8)
    datos_bancarios_cliente = fake.bban()
    
    query = "INSERT INTO Cliente (dni_cliente, datos_bancarios_cliente) VALUES (%s, %s)"
    values = (dni_cliente, datos_bancarios_cliente)
    
    cursor.execute(query, values)
    connection.commit()

# Cerrar el cursor y la conexión
cursor.close()
connection.close()
