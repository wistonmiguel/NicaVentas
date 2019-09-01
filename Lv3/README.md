# MicroServicio Disponibilidad Lv3
Continuando vamos a agregar la funcionabilidad de un microservicio que además de acceder a una base de datos pueda guardar datos en caché. En este tercer nivel el objetivo será obtener una respuesta con datos desde la base de datos y almecenar contenido en caché usando Redis para optimizar el flujo de datos obteniendo contenido en caché en vez de usar siempre un acceso a base de datos. 
## Análisis del Caso y Funcionabilidad
Para empezar mantendrémos la misma estructura de directorios y ficheros que teníamos en niveles anteriores, solamente agregaremos el uso de Redis y la manipulación del código para realizar caché en nuestro ficher app.py.

## Desarrollo del MicroServicio

Procedemos a agregar el código necesario para manejar el contenido en caché importando redis a nuestro fichero de aplicación el cual se lista a continuación:

> app.py

    #!flask/bin/python
    from flask import Flask, jsonify, request, escape
    from flask_mysqldb import MySQL
    import os
    import redis
    from worklog import Worklog
    app = Flask(__name__)
    app.config['MYSQL_HOST'] = os.environ['DATABASE_HOST']
    app.config['MYSQL_USER'] = os.environ['DATABASE_USER']
    app.config['MYSQL_PASSWORD'] = os.environ['DATABASE_PASSWORD']
    app.config['MYSQL_DB'] = os.environ['DATABASE_NAME']
    mysql = MySQL(app)
    
    #INICIALIZANDO AMBIENTE REDIS
    redis_cli = redis.Redis(host=os.environ['REDIS_LOCATION'], port=os.environ['REDIS_PORT'], charset="utf-8", decode_responses=True)
    
    #DEFAULT SERVER REQUEST INFO
    @app.route('/')
    def info():
        info = {
        "id": "Servicio NicaVentas - Disponibilidad de Ventas",
        "version": "3.0",
        "status": "En Desarrollo",
        "Elaborado por": "Wiston Perez Narvaez"
        }
        return jsonify(info)
    
    #RUTA PARA CONSULTAR EL ESTADO DE LA VENTA EN LA CIUDAD DE UN PAIS
    @app.route('/active')
    def get_location():
        try:
            country = request.args.get('country')
            city = request.args.get('city')
            key = str(country) + '-' + str(city)
    
            active = redis_cli.get(escape(key))
    
            if active:
                cache = "hit"
                country = request.args.get('country')
                city = request.args.get('city')
                return jsonify({"active": eval(active), "country":country, "city":city, "redis_cache":cache})
            else:
                cache = "miss"
                country = request.args.get('country')
                city = request.args.get('city')
                wl = Worklog(mysql, app.logger)
                result = wl.obtain_location(escape(country), escape(city))
    
                if result[0][2].find("True") != -1:
                    active = True
                else:
                    active = False
    
                redis_cli.set(str(key),escape(active))
                return jsonify({"active": active, "country":result[0][0], "city":result[0][1], "redis_cache":cache})
        except:
            return jsonify({"message":"No existen datos Asociados"})
    
    #RUTA PARA ACTUALIZAR EL ESTADO EN LA TABLA
    @app.route('/active', methods=['PUT'])
    def put_location():
        try:
            payload = request.get_json()
            country = payload['country']
            city = payload['city']
            key = str(country) + '-' + str(city)
            auth = request.headers.get("Authorization", None)
    
            if not auth:
                return jsonify({"message":"No se ha enviado el Token"})
            elif auth != "Bearer 2234hj234h2kkjjh42kjj2b20asd6918":
                return jsonify({"message":"Token no Autorizado!"})
            else:
                wl = Worklog(mysql, app.logger)
                result = wl.update_location(**payload)
    
                if result == 1:
                    redis_cli.delete(escape(key))
                    return jsonify({'result':'Ok', 'update': payload})
                else:
                    return jsonify({'result':'Fail', 'message': 'No se detecto ningun cambio al Actualizar'})
        except:
            return jsonify({'result':'ERROR', 'message':'Ha ocurrido un error, verifique su request'})
    
    #RUTA PARA INSERTAR EN LA TABLA
    @app.route('/active', methods=['POST'])
    def post_location():
        try:
            payload = request.get_json()
            wl = Worklog(mysql, app.logger)
            wl.save_location(**payload)
            return jsonify({'result':'Ok', 'Insert': payload})
        except:
            return jsonify({'result':'ERROR', 'message':'Ha ocurrido un error, verifique su request'})
    
    #PUERTO POR DEFECTO 5000
    if __name__ == '__main__':
        app.run(debug=True, host='0.0.0.0')

Como podemos observar, ahora tenemos una versión de app.py más completa, Redis interviene para que cuando se realice una consulta sobre la autorización de una venta en una ciudad de un pais determinado no se realice 2 veces de forma innecesaria si los datos fuesen los mismos. Cuando se solicite esa información, nuestro servicio verificará primero si hay contenido en caché antes de abrir una conexión a la base de datos.

## Demostración y Resultados

Procedemos a realizar las pruebas necesarias para obtener los resultados desde una caché de Redis y demostrar el correcto funcionamiento del tercer nivel de NicaVentas.

 1 ) Construimos la Imagen previemente y desplegamos los servicios por medio de docker-compose
 
     docker-compose build
     docker-compose up

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/13.jpg)
 
 2 ) Realizamos las pruebas pertinentes de varias peticiones GET para verificar la autorización de venta en Managua, Nicaragua y si la caché está entrando en acción luego del primer fallo

`curl "localhost:8000/active?city=Managua&country=NI"`

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/14.jpg)

Como podemos observar, en la primer petición no hubo contenido en caché por lo tanto fué "miss" sin embargo al realizar nuevamente la consulta podemos ver que hay un acierto de caché "hit" debido a que el primer fallo provoca que el contenido se guarde y ahora el resultado es devuelto de inmediato por Redis sin acceder a la base de datos de forma innecesaria.

4 ) Finalmente tendriamos que verificar que la caché se anule cuando un Operador actualice el estado de disponibilidad de venta. Esto es necesario ya que si hubo una actualización en la base de datos y no anulamos la caché, Redis nos estaría devolviendo un resultado fijo inválido no actualizado.

    curl -d '{"city":"Managua", "country":"NI", "active":"False"}' -H "Content-Type: application/json" -H "Authorization: Bearer 2234hj234h2kkjjh42kjj2b20asd6918" -X PUT localhost:8000/active

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/15.jpg)

Comprobamos al final, que al actualizarse un dato de disponibilidad de venta de un estado a otro, la caché queda invalidada, por lo que si solicitamos el estado de disponibilidad de venta nuevamente se debe realizar la consulta desde la base de datos para ser nuevamente colocada en caché y reutilizada como se muestra en la imagen.
