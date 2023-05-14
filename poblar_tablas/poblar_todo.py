import subprocess
import random
import string
import mysql.connector
import datetime
from faker import Faker

# Define la lista de scripts en el orden deseado
scripts = [
    'crear_espectaculo.py',
    'crear_recintos.py',
    'cargarcsvenrecinto.py',
    'cargarcsvenespectaculo.py',
    'poblar_cliente.py',
    'poblar_grada.py',
    'poblar_localidad.py',
    'poblar_evento.py',
    'poblar_usloc.py',
    'poblar_oferta.py'
    ]

# Ejecuta cada script en orden
for script in scripts:
    print("\n\n\n###################Ejecutando", script)
    subprocess.run(['python3', script])
    
