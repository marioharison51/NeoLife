"""Backend Flask pour le calcul des dépenses de NeoLife."""

import ctypes

from flask import Flask, jsonify

app = Flask(__name__)

# Charger le module C compilé
lib = ctypes.CDLL("./libcalcul.so")


# --- Stockage simple en mémoire (à remplacer par une vraie base de données plus tard) ---
courses_liste = []
sante_entrees = []
agenda_rdv = []
notes_liste = []


@app.route("/courses", methods=["GET"])
def get_courses():
    """Retourne la liste de courses."""
    return jsonify(courses_liste)


@app.route("/courses", methods=["POST"])
def ajouter_course():
    """Ajoute un produit à la liste de courses."""
    data = request.get_json()
    courses_liste.append(data["produit"])
    return jsonify({"message": "Produit ajouté", "liste": courses_liste})


@app.route("/courses/<int:index>", methods=["DELETE"])
def supprimer_course(index):
    """Supprime un produit de la liste de courses."""
    if 0 <= index < len(courses_liste):
        courses_liste.pop(index)
    return jsonify({"message": "Produit supprimé", "liste": courses_liste})


@app.route("/sante", methods=["GET"])
def get_sante():
    """Retourne l'historique de santé."""
    return jsonify(sante_entrees)


@app.route("/sante", methods=["POST"])
def ajouter_sante():
    """Ajoute une entrée santé (activité ou repas)."""
    data = request.get_json()
    sante_entrees.append(data["description"])
    return jsonify({"message": "Entrée ajoutée", "liste": sante_entrees})


@app.route("/agenda", methods=["GET"])
def get_agenda():
    """Retourne les rendez-vous de l'agenda."""
    return jsonify(agenda_rdv)


@app.route("/agenda", methods=["POST"])
def ajouter_rdv():
    """Ajoute un rendez-vous à l'agenda."""
    data = request.get_json()
    agenda_rdv.append({"date": data["date"], "description": data["description"]})
    return jsonify({"message": "Rendez-vous ajouté", "liste": agenda_rdv})


@app.route("/notes", methods=["GET"])
def get_notes():
    """Retourne le carnet de notes."""
    return jsonify(notes_liste)


@app.route("/notes", methods=["POST"])
def ajouter_note():
    """Ajoute une note avec un tag."""
    data = request.get_json()
    notes_liste.append({"contenu": data["contenu"], "tag": data.get("tag", "")})
    return jsonify({"message": "Note ajoutée", "liste": notes_liste})

if __name__ == "__main__":
