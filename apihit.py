from flask import Flask, jsonify
import subprocess

 

app = Flask(__name__)

 

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"result": "Healthy", "error": False})

 

@app.route('/who', methods=['GET'])
def who():
    output = subprocess.check_output(["who"]).decode("utf-8")
    return jsonify({"result": output, "error": False})

 

@app.route('/create', methods=['POST'])
def create():
    subprocess.run(["./generate_numbers.sh"])
    return jsonify({"result": "test.txt created", "error": False})

 

@app.route('/read', methods=['GET'])
def read():
    try:
        with open('test.txt', 'r') as file:
            content = file.read()
            return jsonify({"result": content, "error": False})
    except FileNotFoundError:
        return jsonify({"result": "File not found", "error": True})

 

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
