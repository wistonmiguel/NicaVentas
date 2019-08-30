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
