# MicroServicio Disponibilidad Lv2
Continuando vamos a desarrollar un microservicio con datos reales. En este segundo nivel el objetivo será obtener una respuesta con datos reales desde una base de datos mysql de un microservicio corriendo flask. 
## Análisis del Caso y Funcionabilidad
Para empezar vamos a evolucionar un poco la estructura de directorios y ficheros que necesitamos para lanzar nuestro microservicio.
La estructura de nuestro entorno aumenta un poco agregando 3 ficheros nuevos, entre los cuales destacamos los ficheros docker-compose.yml, schema.sql y worlog.py organizados de la siguiente forma:

    Lv2
    ├── Disponibilidad_NV
    │   ├── app
    │   │   ├── app.py
    │   │   ├── requirements.txt
    │   │   └── worklog.py
    │   └── Dockerfile
    ├── docker-compose.yml
    └── schema.sql

Esta es la nueva estructura base que usaremos en nuestro entorno. Procedemos a analizar el papel que juega cada elemento para obtener la lógica necesaria que nos permita un desarrollo objetivo del presente caso.

**El fichero schema.sql** tiene como función la escritura de todas las ordenes necesarias para inicializar la base de datos mysql, tablas y registros asociados.

**El fichero worklog.py** almacena el código de instrucciones necesarias para realizar operaciones sobre la base de datos mysql, ingresar o retornar datos según sea el caso.

**El fichero docker-compose.yml** contiene la ejecución orquestadadel  comportamiento en conjunto los servicios del proyecto.


## Desarrollo del MicroServicio

Procedemos a evolucionar el que teníamos con la creación de nuestro fichero schema.sql el cual se lista a continuación:

> schema.sqlCREATE TABLE IF NOT EXISTS location(

        country varchar(2) NOT NULL,
        city varchar(52) NOT NULL,
        active ENUM('True', 'False') NOT NULL,
        PRIMARY KEY (country, city)
    ) ENGINE=innodb DEFAULT CHARSET=utf8 DEFAULT COLLATE utf8_unicode_ci; 
    
    INSERT INTO location (country, city, active) values ('NI', 'Managua', 'False');
    INSERT INTO location (country, city, active) values ('ES', 'Madrid', 'False');
    .
    .
    .
    INSERT INTO location (country, city, active) values ('AF', 'Kabul', 'False');

Este fichero sql crea para mysql una tabla llamada location, esta tabla determinará si en una determinada ciudad de un pais está autorizada la venta de articulos o no por medio del campo active. A nivel de ejemplo se han agregado en estado false las capitales a nivel mundial ya que una serie de operadores son los encargados de activar y desactivar las posibilidades de venta en las ciudades. A modo práctico los operadores podrán contar con este catálogo de capitales para su activación sin necesidad de agregarlas, se agregarían solamente las ciudades de paises que no estén registradas.

En este momento ya podemos realizar modificaciones al código de app.py para que en vez de devolver una respuesta dummy fija se atienda las solicitudes dirigidas al framework Flask hacia nuestra base de datos mysql. Listamos los cambios realizados al fichero en cuestión: 

> app.py

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
    from flask import Flask, jsonify, request, escape
    from flask_mysqldb import MySQL
    import os
    from worklog import Worklog
    app = Flask(__name__)
    app.config['MYSQL_HOST'] = os.environ['DATABASE_HOST']
    app.config['MYSQL_USER'] = os.environ['DATABASE_USER']
    app.config['MYSQL_PASSWORD'] = os.environ['DATABASE_PASSWORD']
    app.config['MYSQL_DB'] = os.environ['DATABASE_NAME']
    mysql = MySQL(app)
    
    #DEFAULT SERVER REQUEST INFO
    @app.route('/')
    def info():
        info = {
        "id": "Servicio NicaVentas - Disponibilidad de Ventas",
        "version": "2.0",
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
            wl = Worklog(mysql, app.logger)
            result = wl.obtain_location(escape(country), escape(city))
    
            if result[0][2].find("True") != -1:
                active = True
            else:
                active = False
    
            return jsonify({"active": active, "country":result[0][0], "city":result[0][1]})
        except:
            return jsonify({"message":"No existen datos Asociados"})
    
    #RUTA PARA ACTUALIZAR EL ESTADO EN LA TABLA
    @app.route('/active', methods=['PUT'])
    def put_location():
        try:
            payload = request.get_json()
            auth = request.headers.get("Authorization", None)
    
            if not auth:
                return jsonify({"message":"No se ha enviado el Token"})
            elif auth != "Bearer 2234hj234h2kkjjh42kjj2b20asd6918":
                return jsonify({"message":"Token no Autorizado!"})
            else:
                wl = Worklog(mysql, app.logger)
                result = wl.update_location(**payload)
                if result == 1:
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

Como podemos observar, ahora tenemos una versión de app.py más real ya que atendemos solicitudes y respondemos con datos provenientes de mysql. El fichero que ejecuta las solicitudes hacia la base de datos es worklog.py el cual se lista a continuación

> worklog.py


    class Worklog:
    def __init__(self, dbcon, logger):
        self._dbcon=dbcon
        self._logger=logger

    def save_location(self, **kwargs):
        sql = """
        insert into location
            (country, city, active)
            values ('{}','{}','{}')
        """.format(
                kwargs['country'],
                kwargs['city'],
                kwargs['active'])
        cur = self._dbcon.connection.cursor()
        cur.execute(sql)
        self._dbcon.connection.commit()
        cur.close()
        self._logger.info(sql)

    def update_location(self, **kwargs):
        sql = """
        update location set active='{}' where country='{}' and city='{}';
        """.format(
                kwargs['active'],
                kwargs['country'],
                kwargs['city'])
        cur = self._dbcon.connection.cursor()
        rv = cur.execute(sql)
        self._dbcon.connection.commit()
        cur.close()
        self._logger.info(sql)
        return rv

    def obtain_location(self, country, city):
        sql = """
        select * from location where country='{}' and city='{}';
        """.format(country, city)
        cur = self._dbcon.connection.cursor()
        cur.execute(sql)
        rv = cur.fetchall()
        cur.close()
        self._logger.info(rv)
        return rv  

Para finalizar agregamos a nuestro proyecto el fichero docker-compose.yml que nos va a realizar las operaciones necesarias para la ejecución de los servicios de forma conjunta:

> docker-compose.yml

    version: '3'
    services:
      NicaVentas:
        image: wistonmiguel/nicaventas:Lv2
        build:
          context: ./Disponibilidad_NV
          dockerfile: Dockerfile
        volumes:
          - ./Disponibilidad_NV/app:/app
        ports:
          - "8000:5000"
        environment:
          - FLASK_DEBUG=1
          - DATABASE_PASSWORD=nicaventaspass
          - DATABASE_NAME=nicaventasdb
          - DATABASE_USER=nicaventasuser
          - DATABASE_HOST=NicaVentas-DB
        command: flask run --host=0.0.0.0
      NicaVentas-DB:
        image: mysql:5
        environment:
          - MYSQL_ROOT_PASSWORD=nv123
          - MYSQL_DATABASE=nicaventasdb
          - MYSQL_USER=nicaventasuser
          - MYSQL_PASSWORD=nicaventaspass
        expose:
          - 3306
        volumes:
          - ./schema.sql:/docker-entrypoint-initdb.d/schema.sql

Al ejecutar el comando docker-compose up, obtendremos el despliegue total de los servicios de NicaVentas Lv2 y MySql.


## Demostración y Resultados

Procedemos a realizar las pruebas necesarias para obtener los resultados y demostrar el correcto funcionamiento del segundo nivel de NicaVentas.

 1 ) Construimos la Imagen desde la ruta del fichero docker-compose.yml.
 
 `docker-compose build`
 
![image](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/7.jpg)
 
 2 ) Desplegamos los servicios usando docker-compose.
  
`docker-compose up`

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/8.jpg)

3 ) Realizamos las pruebas pertinentes de peticiones GET para verificar la autorización de venta en Managua, Nicaragua

`curl "localhost:8000/active?city=Managua&country=NI"`

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/9.jpg)

Como podemos observar la respuesta fué una venta no autorizada debido a que la base de datos está apenas inicializada y ningún operador ha autorizado (actualizado) la venta en alguna ciudad de un pais.

4 ) Procedemos a probar el rol de Operador para actualizar la venta en Managua, Nicaragua por ejemplo. Cabe mencionar que como operador debemos enviar en las cabeceras de petición el token de autorización para poder realizar cambios en la base de datos, tabla location.

    curl -d '{"city":"Managua", "country":"NI", "active":"True"}' -H "Content-Type: application/json" -H "Authorization: Bearer 2234hj234h2kkjjh42kjj2b20asd6918" -X PUT localhost:8000/active

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/10.jpg)

Se ha realizado la actualización del estado de autorización en las ventas de Managua, Nicaragua. Consultando nuevamente si la venta está autorizada el servicio api nos devuelve un active: True.

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/11.jpg)
5 ) Finalmente si no existe una ciudad en el Pais donde necesitamos autorizar una venta la podemos agregar usando una solicitud POST

    curl -d '{"city":"Leon", "country":"NI", "active":"True"}' -H "Content-Type: application/json" -X POST localhost:8000/active

![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/12.jpg)
