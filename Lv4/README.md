# MicroServicio Condiciones Lv4
Finalmente hemos llegado al penáculo de nuestros objetivos, en esta ocasión vamos a agregar a nuestro proyecto un nuevo microservicio que estará encargado de brindar información de las condiciones de venta para nuestros productos dependiento de ciertas reglas que abaraten o encarezcan su precio base en función de las condiciones metereológicas de la ciudad en un pais especificado. En este cuarto y último nivel el objetivo será consultar a travéz de un nuevo microservicio llamado Condiciones_NV precios de nuestros productos, así como descubrir si la venta de un determinado producto será más cara o barata cuando llueva o haga sol. 
## Análisis del Caso y Funcionabilidad
Para empezar mantendrémos la misma estructura de directorios y ficheros que teníamos en niveles anteriores, sin embargo, agregaremos un directorio nuevo con el nombre de Condiciones_NV en el cual amacenaremos los ficheros necesarios para la ejecución del microservicio Condiciones_NV. 

    Lv4
    ├── Condiciones_NV
    │   ├── Dockerfile
    │   └── app
    │       ├── app.py
    │       ├── dummy_res.py
    │       ├── requirements.txt
    │       └── worklog.py
    ├── Disponibilidad_NV
    │   ├── Dockerfile
    │   └── app
    │       ├── app.py
    │       ├── requirements.txt
    │       └── worklog.py
    ├── docker-compose.yml
    └── schema.sql

Podemos observar que mantenemos la misma estructura que en el nivel anterior de nuestra api (Lv3) a excepción del directorio agregado. Por ello vamos a tener inicialmente una réplica del microservicio Disponibilidad_NV con ciertas variaciones que se explicará a continuación.
## Desarrollo del MicroServicio

Procedemos a evolucionar el fichero sql que teníamos que inicializaba la base de datos, agregando nuevas líneas que se encarguen de agregar las tablas de productos y reglas que nos determinarán las Condiciones de Venta:

> schema.sql

    CREATE TABLE IF NOT EXISTS location(
        country varchar(2) NOT NULL,
        city varchar(52) NOT NULL,
        active ENUM('True', 'False') NOT NULL,
        PRIMARY KEY (country, city)
    ) ENGINE=innodb DEFAULT CHARSET=utf8 DEFAULT COLLATE utf8_unicode_ci;
    
    CREATE TABLE IF NOT EXISTS product(
        sku varchar (7) NOT NULL,
        description varchar(100) NOT NULL,
        price decimal(6,2) NOT NULL,
        PRIMARY KEY (sku)
    ) ENGINE=innodb DEFAULT CHARSET=utf8 DEFAULT COLLATE utf8_unicode_ci;
    
    CREATE TABLE IF NOT EXISTS rules(
        id INT NOT NULL AUTO_INCREMENT,
        country varchar(2) NOT NULL,
        city varchar(52) NOT NULL,
        sku varchar(7) NOT NULL,
        min_condition int(3) NOT NULL,
        max_condition int(3) NOT NULL,
        variation DECIMAL(2,1) NOT NULL,
        PRIMARY KEY (id), index (country), index(city),
        FOREIGN KEY (sku) REFERENCES product (sku),
        foreign key (country, city) REFERENCES location (country, city)
    ) ENGINE = innodb DEFAULT CHARSET=utf8 DEFAULT COLLATE utf8_unicode_ci;
    
    INSERT INTO product (sku, description, price) VALUES ('AZ00001', 'Paraguas de señora estampado', 10.0);
    INSERT INTO product (sku, description, price) VALUES ('AZ00002', 'Helado de sabor fresa', 10.0);
    
    INSERT INTO location (country, city, active) values ('NI', 'Managua', 'False');
    INSERT INTO location (country, city, active) values ('NI', 'Leon', 'False');
    INSERT INTO location (country, city, active) values ('NI', 'Rivas', 'False');
    INSERT INTO location (country, city, active) values ('NI', 'Jinotega', 'False');
    INSERT INTO location (country, city, active) values ('NI', 'Corn Island', 'False');
    INSERT INTO location (country, city, active) values ('ES', 'Madrid', 'False');
    INSERT INTO location (country, city, active) values ('ES', 'Barcelona', 'False');
    INSERT INTO location (country, city, active) values ('ES', 'Valencia', 'False');
    INSERT INTO location (country, city, active) values ('ES', 'Leon', 'False');
    INSERT INTO location (country, city, active) values ('ES', 'Alcala de Henares', 'False');
    
    INSERT INTO rules values(NULL, 'NI', 'Managua', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'NI', 'Managua', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Managua', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Managua', 'AZ00002', 800, 804, 1.5);
    INSERT INTO rules values(NULL, 'NI', 'Corn Island', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'NI', 'Corn Island', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Corn Island', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Corn Island', 'AZ00002', 800, 804, 1.5);
    INSERT INTO rules values(NULL, 'NI', 'Rivas', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'NI', 'Rivas', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Rivas', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Rivas', 'AZ00002', 800, 804, 1.5);
    INSERT INTO rules values(NULL, 'NI', 'Jinotega', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'NI', 'Jinotega', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Jinotega', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Jinotega', 'AZ00002', 800, 804, 1.5);
    INSERT INTO rules values(NULL, 'NI', 'Leon', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'NI', 'Leon', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Leon', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'NI', 'Leon', 'AZ00002', 800, 804, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Barcelona', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Barcelona', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Barcelona', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Barcelona', 'AZ00002', 800, 804, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Madrid', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Madrid', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Madrid', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Madrid', 'AZ00002', 800, 804, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Valencia', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Valencia', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Valencia', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Valencia', 'AZ00002', 800, 804, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Leon', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Leon', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Leon', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Leon', 'AZ00002', 800, 804, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Alcala de Henares', 'AZ00001', 500, 599, 1.5);
    INSERT INTO rules values(NULL, 'ES', 'Alcala de Henares', 'AZ00002', 500, 599, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Alcala de Henares', 'AZ00001', 800, 804, 0.5);
    INSERT INTO rules values(NULL, 'ES', 'Alcala de Henares', 'AZ00002', 800, 804, 1.5);

Este fichero sql se ha editado para incluir una tabla llamada product, esta tabla determinará los datos de productos a la venta. También se agrega la tabla rules en la cual guardamos las condiciones de venta según el clima (lluvioso o soleado) para determinar la variación sobre el precio base del producto. A nivel de ejemplo se han agregado dos productos y algunas reglas para sus condiciones de venta según el clima de ciudades de Nicaragua y España. Cabe mencionar que se utilizó integridad referencial para respetar que no existan reglas sin asociación de productos, ciudades y paises.

Habiendo entendido la lógica del entorno que vamos a utilizar procedemos a la creación del fichero Dockerfile correspondiente al servicio Condiciones_NV el cual se lista a continuación:

> Dockerfile

    FROM python
    COPY app /app
    RUN pip install -r /app/requirements.txt
    RUN pip install requests
    RUN pip install ftfy
    WORKDIR app
    CMD ["python", "app.py"]
    EXPOSE 5000

En esta ocasión podemos destacar que en nuestro Dockerfile se especifíca como gran importancia la instalación de la librería requests ya que es un pilar fundamental para el desarrollo de este microservicio. La librería requests está dotada de funciones que nos permiten realizar peticiones por medio de curl hacia un servidor local o remoto, obteniendo un resultado json que podemos maniobrar para lograr nuestros objetivos. También cabe recalcar que utilizamos como imagen base Python, replicando nuestra carpeta app dentro de la imagen, instalando los siguientes requerimientos:

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
    redis==3.2.1
    Werkzeug==0.15.5

Finalmente se ejecutá este microservicio con Python usando el fichero app.py exponiendo internamente en el su contenedor el puerto 5000 (Flask) vinculando el puerto 8001 exterior de todo contenedor creado a partir de esta imagen. El fichero app.py que se ejecutá de manera indeterminada junto con el servicio de Flask el cual consta del siguiente código:

    #!flask/bin/python
    from flask import Flask, jsonify, request, escape
    from flask_mysqldb import MySQL
    import os
    import ftfy
    import json
    import requests
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
        "id": "Servicio NicaVentas - Condiciones de Ventas",
        "version": "4.0",
        "status": "Finalizado",
        "Elaborado por": "Wiston Perez Narvaez"
        }
        return jsonify(info)
    
    #RUTA PARA CONSULTAR EL PRECIO DEL PRODUCTO
    @app.route('/price/<sku>')
    def get_product_price(sku):
    #    try:
            wl = Worklog(mysql, app.logger)
            result = wl.get_price(escape(sku))
            price = float(result[0][0])
            description = str(result[0][1])
    
            response = {
                "price": float(price),
                "sku": escape(sku),
                "description": ftfy.fix_text(description, uncurl_quotes=True)
            }
            return jsonify(response)
    #    except:
    #        return jsonify({"message":"No existen datos Asociados"})
    
    #RUTA PARA CONSULTAR LAS CONDICIONES DE VENTA SEGUN ESTADO DEL TIEMPO
    @app.route('/quote', methods=['POST'])
    def post_location():
        try:
            payload = request.get_json()
            country = payload['country']
            city = payload['city']
            sku = payload['sku']
    
            key = str(country) + '-' + str(city) + '-' + str(sku)
    
            info_cache = redis_cli.get(escape(key))
    
            if info_cache:
                cache = "hit"
                js = json.loads(info_cache)
                price = float(js['base_price'])
                description = str(js['description'])
                variation= float(js['variation'])
            else:
                cache = "miss"
                r = requests.get('https://api.openweathermap.org/data/2.5/weather?q='+str(city)+','+str(country)+'&appid=3225ae99d4c4cb46be4a2be004226918')
                weather = r.json()
                wl = Worklog(mysql, app.logger)
                result = wl.obtain_condition(country, city, sku, weather['weather'][0]['id'])
    
                if(result):
                    variation = float(result[0][0])
                    description = result[0][1].encode('unicode_escape').decode('unicode_escape')
                    price = float(result[0][2])
                else:
                    result2 = wl.obtain_product(**payload)
                    description = result2[0][0].encode('unicode_escape').decode('unicode_escape')
                    price = float(result2[0][1])
                    variation = float(1.0)
                redis_cli.set(str(key), str('{"base_price": '+str(price)+', "description":"'+str(description)+'", "variation": '+str(variation)+'}'))
                #5 MINUTOS DE CACHE POR VARIABLE
                redis_cli.expire(str(key),300)
    
            return jsonify({
                "sku": payload['sku'],
                "description": description,
                "country": payload['country'],
                "city": payload['city'],
                "base_price": price,
                "variation": variation,
                "redis_cache": cache})
        except:
            return jsonify({'message':'No existen datos Asociados'})
    
    #PUERTO POR DEFECTO 5000
    if __name__ == '__main__':
        app.run(debug=True, host='0.0.0.0')

Como podemos observar, ahora tendríamos una versión de app.py ejecutándose en un microservicio diferente que igualmente atenderá solicitudes y respondrá con datos provenientes de mysql. El puerto en escucha hacia el exterior habíamos dicho será el 8001 para que no las peticiones no interfieran con el servicio de Disponibilidad_NV que escucha en el puerto 8000. El fichero que ejecuta las solicitudes hacia la base de datos es worklog.py el cual se lista a continuación

    class Worklog:
    
        def __init__(self, dbcon, logger):
            self._dbcon=dbcon
            self._logger=logger
    
        def get_price(self, sku):
            sql = """
            select price, description from product where sku="{}";
            """.format(sku)
            cur = self._dbcon.connection.cursor()
            cur.execute(sql)
            rv = cur.fetchall()
            cur.close()
            self._logger.info(rv)
            return rv
    
        def obtain_product(self, **kwargs):
            sql = """
            select description, price from product
            inner join location on location.country='{}'
            and location.city='{}' and product.sku='{}'
            """.format(
                    kwargs['country'],
                    kwargs['city'],
                    kwargs['sku'])
            cur = self._dbcon.connection.cursor()
            cur.execute(sql)
            rv = cur.fetchall()
            cur.close()
            self._logger.info(rv)
            return rv
    
        def obtain_condition(self, country, city, sku, weather):
            sql = """
            select rules.variation, product.description, product.price from rules
            inner join product on product.sku=rules.sku
            where rules.country='{}'
            and rules.city='{}'
            and rules.sku='{}'
            and rules.max_condition >= '{}'
            and rules.min_condition <= '{}';
            """.format(country, city, sku, weather, weather)
            cur = self._dbcon.connection.cursor()
            cur.execute(sql)
            rv = cur.fetchall()
            cur.close()
            self._logger.info(sql)
            return rv

Para finalizar actualizaremos de nuestro proyecto el fichero docker-compose.yml agregando las entradas para la ejecución del microservicio en cuestión, obteniendo como resultado las operaciones necesarias para la ejecución de los servicios de forma conjunta:

    version: '3'
    services:
      Disponibilidad_NV:
        image: wistonmiguel/nicaventas:Lv4D
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
          - REDIS_LOCATION=redis
          - REDIS_PORT=6379
        command: flask run --host=0.0.0.0
      Condiciones_NV:
        image: wistonmiguel/nicaventas:Lv4C
        build:
          context: ./Condiciones_NV
          dockerfile: Dockerfile
        volumes:
          - ./Condiciones_NV/app:/app
        ports:
          - "8001:5000"
        environment:
          - FLASK_DEBUG=1
          - DATABASE_PASSWORD=nicaventaspass
          - DATABASE_NAME=nicaventasdb
          - DATABASE_USER=nicaventasuser
          - DATABASE_HOST=NicaVentas-DB
          - REDIS_LOCATION=redis
          - REDIS_PORT=6379
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
      redis:
        image: redis
        expose:
          - 6379

## Demostración y Resultados

Procedemos a realizar las pruebas necesarias para obtener los resultados desde este segundo microservicio Condiciones_NV, se omite la demostración del servicio Disponibilidad_NV ya que en niveles anteriores está documentado.

1 ) Construimos la Imagen desde la ruta del fichero docker-compose.yml.

`docker-compose build`

[![image](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/16.jpg)](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/16.jpg)

2 ) Desplegamos los servicios usando docker-compose.

`docker-compose up`

[![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/17.jpg)](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/17.jpg)

3 ) Realizamos las pruebas para acceder y verificar que tengamos ambos microservicios en ejecución 

    curl "localhost:8000/"
    curl "localhost:8001/"

[![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/18.jpg)](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/18.jpg)

Como podemos observar la respuesta resulta satisfactoria en ambos casos, Flask está corriendo en cada microservicio y responde peticiones desde los puertos 8000 (Disponibilidad_NV) y 8001 (Condiciones_NV).

4 ) Procedemos a probar de ahora en delante el microservicio de 
Condiciones_NV, solicitando el precio de un producto.

    curl localhost:8001/price/AZ00002
[![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/19.jpg)](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/19.jpg)

5 ) Consultaremos la variación del precio para la venta de helados en León, Nicaragua y Nueva Guinea, Nicaragua (Ciudades generalmente con clima Soleado y Lluvioso)

```
curl -d '{"city":"Leon", "country":"NI", "sku":"AZ00002"}' -H "Content-Type: application/json" -X POST localhost:8001/quote

curl -d '{"city":"Nueva Guinea", "country":"NI", "sku":"AZ00002"}' -H "Content-Type: application/json" -X POST localhost:8001/quote
```

Podemos observar que en efecto se ha detectado variación en la venta de helados, para León tenemos que su precio de venta sería de 15 (10x1.5) ya que no está lloviendo serían 50% más caros. En el caso de Nueva Guinea observamos que está lloviendo por lo que la venta de helados sería 50% más barata contando con un precio de venta de 5 (10x0.5). Finalmente se da por entendido que un producto que no tenga regla asociada mantiene su precio base como precio de venta sin importar las condiciones metereológicas.

[![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/22.jpg)](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/22.jpg)

5 ) Como último paso verificamos que las llamadas a nuestro microservicio Condiciones_NV sean guardadas en una caché de 5 minutos como políticas de optimización de recursos

```
curl -d '{"city":"Leon", "country":"NI", "sku":"AZ00002"}' -H "Content-Type: application/json" -X POST localhost:8001/quote

curl -d '{"city":"Nueva Guinea", "country":"NI", "sku":"AZ00002"}' -H "Content-Type: application/json" -X POST localhost:8001/quote
```

[![enter image description here](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/23.jpg)](https://raw.githubusercontent.com/wistonmiguel/NicaVentas-img/master/23.jpg)


En la imagen observamos que hemos vuelto a realizar las mismas consultas para las condiciones de venta de helados en León y Nueva Guinea de Nicaragua y como ya se habían realizado con anterioridad, Redis guardó estos registros y en esta ocasión nos devuelve los resultados desde la caché con un campo json con valor "hit"