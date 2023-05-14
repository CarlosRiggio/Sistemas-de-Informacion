import mysql.connector
import imdb
import random

# Establecer la conexión a la base de datos MySQL
cnx = mysql.connector.connect(
    host='localhost',
    user='juan',
    password='1234',
    database='Taquilla'
)

# Crear instancia del objeto IMDb
ia = imdb.IMDb()

# Cantidad deseada de películas aleatorias
cantidad_peliculas = 1000000

# Tamaño del lote de películas
tamano_lote = 1000

# Insertar películas en la tabla utilizando el procedimiento almacenado
cursor = cnx.cursor()

for _ in range(cantidad_peliculas // tamano_lote):
    # Obtener películas aleatorias sin repeticiones en cada iteración
    random_movies = random.sample(range(1, 10000000), tamano_lote)  # Ajusta el rango según tus necesidades

    for movie_id in random_movies:
        try:
            # Obtener información de la película por su ID
            movie = ia.get_movie(movie_id)

            # Verificar si es una película válida
            if movie is not None:
                # Obtener información de la película
                nombre_espectaculo = movie['title']
                descripcion_espectaculo = movie.get('plot outline', '')[:50]
                participantes_espectaculo = ', '.join([actor['name'] for actor in movie.get('cast')[:3]])

                # Llamar al procedimiento almacenado para insertar la película
                cursor.callproc('crear_espectaculo', (nombre_espectaculo, descripcion_espectaculo, participantes_espectaculo))
                result = next(cursor.stored_results())
                mensaje = result.fetchone()[0]
                print(mensaje)
            else:
                print(f"No se encontró información válida para la película con ID {movie_id}")

        except imdb.IMDbError as e:
            print(f"Error al obtener información de la película con ID {movie_id}: {e}")

# Confirmar los cambios y cerrar el cursor
cnx.commit()
cursor.close()

# Cerrar la conexión a la base de datos
cnx.close()
