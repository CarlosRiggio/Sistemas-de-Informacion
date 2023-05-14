import mysql.connector
import random

# Conexión a la base de datos
connection = mysql.connector.connect(
    host="localhost",
    user="juan",
    password="1234",
    database="Taquilla"
)

# Crear un cursor para ejecutar el procedimiento almacenado
cursor = connection.cursor()

# Obtener los datos necesarios para la compra de entradas
cursor.execute("""
    SELECT dni_cliente, datos_bancarios_cliente
    FROM Cliente
""")
clientes = cursor.fetchall()

# Obtener los datos de las ofertas disponibles
cursor.execute("""
    SELECT o.nombre_espectaculo_oferta, o.nombre_recinto_oferta, o.localizacion_localidad_oferta,
           o.nombre_grada_oferta, o.fecha_evento_oferta, u.tipo_usuario_usloc
    FROM Oferta o
    INNER JOIN UsLoc u ON o.tipo_usuario_oferta = u.tipo_usuario_usloc
                      AND o.localizacion_localidad_oferta = u.localizacion_localidad_usloc
                      AND o.nombre_grada_oferta = u.nombre_grada_usloc
                      AND o.nombre_recinto_oferta = u.nombre_recinto_usloc
    WHERE o.estado_localidad_oferta = 'libre'
""")
entradas = cursor.fetchall()

# Verificar si hay ofertas disponibles
if len(entradas) == 0:
    print("No hay ofertas disponibles para comprar.")
    exit()

# Generar y ejecutar las compras de entradas
for entrada in entradas:
    cliente = random.choice(clientes)  # Seleccionar un cliente al azar
    dni_cliente = cliente[0]
    tipo_usuario = entrada[5]
    nombre_espectaculo = entrada[0]
    nombre_recinto = entrada[1]
    localizacion_localidad = entrada[2]
    nombre_grada = entrada[3]
    fecha_evento = entrada[4]

    try:
        # Llamar al procedimiento almacenado para realizar la compra de la entrada
        cursor.callproc("ComprarEntrada", (dni_cliente, tipo_usuario, nombre_espectaculo,
                                        nombre_recinto, localizacion_localidad,
                                        nombre_grada, fecha_evento))
        
        connection.commit()
    except mysql.connector.errors.DatabaseError as e:
            print("Error al crear la compra:", e)

# Cerrar el cursor y la conexión
cursor.close()
connection.close()