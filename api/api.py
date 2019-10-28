from flask import Flask, request, jsonify
from lib.marmiton import Marmiton

app = Flask(__name__)


@app.route('/')
def hello():
    return "hello world"


@app.route('/search/<query>', methods=["GET"])
def search(query):
    query_options = {
        "aqt": query,
        # Plate type : "entree", "platprincipal", "accompagnement", "amusegueule", "sauce" (optional)
        "dt": "platprincipal",
        "exp": 2,
        "dif": 1,
        "veg": 0,
    }

    return jsonify(Marmiton.search(query_options))


@app.route('/getDetails', methods=["POST"])
def getDetails():
    url = request.form["url"]
    return jsonify(Marmiton.get(url))


if (__name__) == '__main__':
    app.run(debug=True, host='0.0.0.0')
