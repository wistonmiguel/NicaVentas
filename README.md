# MicroServicios NicaVentas ASA2019

Una empresa nos solicita el desarrollo de un API rest para que una serie de aplicaciones puedan consultar si pueden o no realizarse ventas en una determinada localidad de un país, y de ser posible, qué variaciones deben aplicar sobre el precio de los servicios en función de una serie de reglas. 

## Con este fin se han desarrollado dos servicios:

 - **SERVICIO DE DISPONIBILIDAD DE VENTAS**

Servicio web se emplea para consultar si se está autorizada la venta de productos en general en una ciudad concreta de un país.

 - **SERVICIO DE CONDICIONES DE VENTAS**

El servicio de condiciones de venta permite consultar qué porcentaje de descuento se hará a un producto determinado.

## Desarrollo

En base a lo anterior expuesto se han realizaron  4 fases de  cumpliendo con los siguientes objetivos (Se adjuntan para corroborar el resultado solicitado):

### Nivel 1

#### Objetivos:

-   Desarrollar un microservicio en `flask` que implemente la llamada `[GET] /active` con una respuesta _dummy_ fija
-   Crear una imagen docker que contenga dicho microservicio y publicarla en `dockerhub`

#### Entregables:
-   [Documento explicativo del trabajo realizado](https://github.com/wistonmiguel/NicaVentas/tree/master/Lv1)
-   [URL de dockerhub para descargar la imagen](https://cloud.docker.com/u/wistonmiguel/repository/docker/wistonmiguel/nicaventas) 

`docker pull wistonmiguel/nicaventas:Lv1`
-   [Archivos necesarios para construir la imagen docker](https://drive.google.com/open?id=1babgBre5eauKAowPFIol4YZXVjcw2NYz)

### Nivel 2

#### Objetivos:

-   Ampliar el microservicio par que implemente la llamada `[POST] /active`. El estado, la ciudad y el país se deberá almacenar en una base de datos relacional.
-   Modificar el microservicio para que la llamada `[GET] /active` obtenga sus resultados desde la base de datos.
-   Orquestar el funcionamiento del microservicio con el de la base de datos haciendo uso de `docker-compose`. La base de datos en concreto es indiferente, pero se recomienda utilizar `postgres`, `mysql` o `mariadb`
-   Crear una imagen docker que contenga dicho microservicio y publicarla en `dockerhub`

#### Entregables:

-   [Documento explicativo del trabajo realizado](https://github.com/wistonmiguel/NicaVentas/tree/master/Lv2)
-  [Archivo docker-compose](https://drive.google.com/open?id=1oxbVAi7y7DjVIR57-H8Khj1pKjqQ4hUq)


`docker pull wistonmiguel/nicaventas:Lv2`

### Nivel 3

#### Objetivos:

-   Modificar el microservicio para que la respuesta de la llamada `[GET] /active` se haga desde una cache REDIS. La respuesta de este servicio ahora incluirá un campo `cache` que valdrá `miss` si la respuesta procede de la base de datos, y `hit` si la respuesta procede de caché.
-   Modificar el microservicio para que la respuesta de la llamada `[POST] /active` invalide el posible contenido cacheado en REDIS.
-   Añadir al archivo `docker-compose` el servicio de `redis`

#### Entregables:

-   [Documento explicativo del trabajo realizado](https://github.com/wistonmiguel/NicaVentas/tree/master/Lv3)
-   [Archivo docker-compose](https://drive.google.com/open?id=1evYfKTRUAD-pVPDIS91CMYC00WkGZ6G2)


`docker pull wistonmiguel/nicaventas:Lv3`

### Nivel 4

#### Objetivos:

-   Evolucionar la arquitectura existente para incluir un micro servicio que proporcione el API `[POST] /quote`, según lo especificado en el enunciado en Servicio de consulta de condiciones de venta
-   Añadir al archivo `docker-compose` el nuevo microservicio
-   Añadir políticas de cacheo de forma que si se solicita `[POST] /quote` con los mismos parámetros se responda desde la cache de REDIS en lugar de volver a realizar la consultas a OpenWeather y la BBDD. La valided de uno de estos datos cacheados será de 5 min. Con objeto de verificar que la cache funciona, incluir en la respuesta un campo `cache` como se hizo anteriormente.

#### Entregables:

-   [Documento explicativo del trabajo realizado](https://github.com/wistonmiguel/NicaVentas/tree/master/Lv4)
-   [Archivo docker-compose](https://drive.google.com/open?id=1ZNKx8mjF_2Q-sFQcvrBr3nFinEFE54B8)


`docker pull wistonmiguel/nicaventas:Lv4C
docker pull wistonmiguel/nicaventas:Lv4D`


-   [Script para hacer la carga inicial de los valores iniciales de las tablas de la base de datos.](https://drive.google.com/open?id=1ZNKx8mjF_2Q-sFQcvrBr3nFinEFE54B8)
