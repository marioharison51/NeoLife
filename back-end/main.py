"""Backend Flask pour le calcul des dépenses de NeoLife."""

import ctypes

from flask import Flask, jsonify

app = Flask(__name__)

# Charger le module C compilé
lib = ctypes.CDLL("./libcalcul.so")


@app.route("/depenses")
def depenses():
    """Retourne le total des dépenses calculé via le module C."""
    total = lib.calcul_depenses()
    return jsonify({"total": total})


if __name__ == "__main__":
    app.run(port=5000)
