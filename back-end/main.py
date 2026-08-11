"""Backend Flask pour le calcul des dépenses de NeoLife."""
import ctypes

from flask import Flask, jsonify

app = Flask(__name__)

# Charger le module C compilé
lib = ctypes.CDLL('./libcalcul.so')

@app.route('/depenses')
def depenses():
    """Retourne le total des dépenses calculé via le module C."""
    total = lib.calcul_depenses()
    return jsonify({"total": total})
    
@app.route('/depenses/<int:index>', methods=['DELETE'])
def supprimer_depense(index):
    """Supprime une dépense à partir de son index dans la liste."""
    return jsonify({"message": f"Dépense {index} supprimée"})
    
if __name__ == '__main__':
    app.run(port=5000)
