import random
import string
import io

# Crear un objeto de archivo en memoria para almacenar los comandos SQL
sql_file = io.StringIO()


# Generar 10 registros aleatorios y añadirlos a la tabla
for i in range(1000000):
    dni = ''.join(random.choice(string.digits) for _ in range(8)) + random.choice(string.ascii_uppercase)
    numero_de_tarjeta = ''.join(random.choice(string.digits) for _ in range(16))
    sql_file.write("INSERT INTO cliente (dni, numero_de_tarjeta) VALUES ('%s', '%s');\n" % (dni, numero_de_tarjeta))

# Escribir el contenido del objeto de archivo en un archivo .sql
with open('clientes.sql', 'w') as f:
    f.write(sql_file.getvalue())

# Cerrar el objeto de archivo en memoria
sql_file.close()
