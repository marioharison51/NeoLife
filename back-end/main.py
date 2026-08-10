from flask import Flask, jsonify
import ctypes

app = Flask(__name__)

# Charger le module C compilé
lib = ctypes.CDLL('./libcalcul.so')

@app.route('/depenses')
def depenses():
    total = lib.calcul_depenses()
    return jsonify({"total": total})

if __name__ == '__main__':
    app.run(port=5000)
