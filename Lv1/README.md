# MicroServicio Disponibilidad Lv1
Inicialmente vamos a desarrollar un microservicio de prueba. En este primer nivel el objetivo será obtener una respuesta dummy fija de un microservicio corriendo flask. 
## Análisis del Caso y Funcionabilidad
Para empezar vamos a realizar la estructura de directorios y archivos que necesitamos para lanzar nuestro microservicio.
Se crearán las los siguientes directorios y archivos:

![imagen](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/1.jpg)

Esta es la estructura base que usaremos en nuestro entorno. Procedemos a analizar el papel que juega cada elemento para obtener la lógica necesaria que nos permita un desarrollo objetivo del presente caso.

**El directorio app** será replicado al momento de realizar el contenedor de nuestra aplicación, esta contendrá el código python asociado al comportamiento en ejecución de nuestro código en dicho contenedor.

**El fichero app.py** manejará peticiones requests por medio del framework flask y devolverá respuestas según solicitudes.

**El fichero dummy_res.py** contiene un contenido estático como respuesta de solicitud GET a la ruta /active

**El fichero requirements.txt** es utilizado para ejecutar en el momento de la creación del contenedor todas las dependencias necesarias para que el entorno programado de app.py se ejecute con normalidad.
Finalmente el fichero 

**Dockerfile** es el garante de ejecutar paso a paso la instalación de todos los ingredientes necesarios para creación de nuestra imagen necesaria para el uso de contenedores que deriven de ella.

## Desarrollo del MicroServicio

Habiendo entendido la lógica del entorno que vamos a utilizar procedemos a la creación de nuestro fichero Dockerfile el cual se lista a continuación:

> Dockerfile

    FROM python
    COPY app /app
    RUN pip install -r /app/requirements.txt
    WORKDIR app
    CMD ["python", "app.py"]
    EXPOSE 5000

Iniciaríamos a utilizar nuestro microservicio desde la imagen base Python, replicando nuestra carpeta app dentro de la imagen, instalando los siguientes requerimientos:

> requirements.txt

    Click==7.0
    Flask==1.1.1
    Flask-MySQL==1.4.0
    Flask-MySQLdb==0.2.0
    itsdangerous==1.1.0
    Jinja2==2.10.1
    MarkupSafe==1.1.1
    mysqlclient==1.4.2.post1
    PyMySQL==0.9.3

Finalmente ejecutamos con Python el fichero python.py exponiendo el puerto 5000 (Flask) al exterior de todo contenedor creado a partir de nuestra imagen.
El fichero que se ejecuta de manera indeterminada junto con el servicio de Flask es nuestra app.py la cual consta del siguiente código:

> app.py

    #!flask/bin/python
    from flask import Flask, jsonify, request
    import dummy_res
    import os
    app = Flask(__name__)
    
    @app.route('/')
    def info():
        info = {
        "id": "Servicio NicaVentas Dummy Response",
        "version": "1.0",
        "status": "En Desarrollo",
        "Elaborado por": "Wiston Perez Narvaez"
        }
        return jsonify(info)
    
    #RUTA DUMMY RESPONSE
    @app.route('/active')
    def get_dummy():
        return jsonify(dummy_res.dummy_ventas)
    
    #PUERTO POR DEFECTO 5000
    if __name__ == '__main__':
        app.run(debug=True, host='0.0.0.0')

Nuestro objetivo en este Nivel 1 del microservicio NicaVentas es demostrar que nuestro servicio Flask debe escuchar peticiones por el puerto 5000 y cuando detecte una petición GET con una url que finaliza con /active devuelva una respueseta dummy fija. 

Exactamente nuestro código anterior recibierá peticiones y por medio de la función get_dummy obtendrá la respuesta fija acordada, esta respuesta está almacenada en el fichero dummy_res.py y contiene lo siguiente:

> dummy_res.py

    dummy_ventas = [{
        "active": True,
        "country": "ni",
        "city": "Leon",
      }
    ]

Como observamos es un objeto json fijo el cual es devuelto cada vez que se cumple la petición GET,

## Demostración y Resultados

Procedemos a realizar las pruebas necesarias para obtener los resultados y demostrar el correcto funcionamiento del primer nivel de NicaVentas.

 1 ) Construimos la Imagen desde la ruta del fichero Dockerfile.
 
 `docker build -t wistonmiguel/nicaventas:Lv1`
 
![image](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/2.jpg)
 
 2 ) Creamos un contenedor a partir de nuestra imagen corriendo el servicio.
  
`docker run -p 8000:5000 wistonmiguel/nicaventas:Lv1`

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/3.jpg)

3 ) Realizamos las pruebas pertinentes de peticiones GET

`curl localhost:8000/active`

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/4.jpg)

Como podemos observar la respuesta a la petición GET se mantiene fija y con esta demostración se completa el objetivo buscado en este Nivel 1 del servicio NicaVentas.

4 ) Finalmente después de haber corroborado que nuestro servicio funciona correctamente procedemos a la publicación de nuestra imagen usando un repositorio personal en docker hub.

`docker push wistonmiguel/nicaventas:Lv1`

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/5.jpg)

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/6.jpg)

