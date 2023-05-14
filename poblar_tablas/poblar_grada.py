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

# Consulta de los recintos existentes
cursor = connection.cursor()
cursor.execute("SELECT nombre_recinto FROM Recinto")
recintos = cursor.fetchall()

# Lista de adjetivos y nombres de dirección para los nombres de las gradas
adjetivos = ["Norte", "Sur", "Este", "Oeste", "Roja", "Verde", "Azul", "Blanca", "Negra", "Amarilla"]
direcciones = ["Grada", "Tribuna", "Sector", "Zona", "Sector"]



# Generación y ejecución de la inserción de gradas por recinto
for recinto in recintos:
    # Conjunto para almacenar los nombres de las gradas generadas
    gradas_generadas = set()
    nombre_recinto = recinto[0]
    num_gradas = random.randint(1, 3)
    
    while len(gradas_generadas) < num_gradas:
        nombre_grada = "Grada " + random.choice(adjetivos) + " " + random.choice(direcciones)
        
        # Verificar si el nombre de grada ya ha sido generado
        if nombre_grada not in gradas_generadas:
            gradas_generadas.add(nombre_grada)
            
            num_localidades = random.randint(1, 50)
            precio_grada = random.randint(10, 100)
            
            cursor = connection.cursor()
            cursor.callproc("crear_gradas", [nombre_grada, nombre_recinto, num_localidades, precio_grada])
            connection.commit()
            cursor.close()

# Cierre de la conexión
cursor.close()
connection.close()
