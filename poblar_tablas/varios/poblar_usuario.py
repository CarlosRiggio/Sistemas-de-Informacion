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

# Sentencias SQL
sql_queries = [
    "INSERT INTO Usuario VALUES ('adulto', 0)",
    "INSERT INTO Usuario VALUES ('parado', 10)",
    "INSERT INTO Usuario VALUES ('jubilado', 20)",
    "INSERT INTO Usuario VALUES ('infantil', 30)"
]

# Ejecutar las sentencias SQL
for query in sql_queries:
    cursor.execute(query)

# Confirmar los cambios en la base de datos
connection.commit()

# Cerrar el cursor y la conexión
cursor.close()
connection.close()
