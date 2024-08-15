from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)

# Cargar el modelo
model = joblib.load('models/recetas_diabetes_model.joblib')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    features = [
        data['Region'], data['TiempoPrep'], data['Calorias'],
        data['Grasas'], data['Proteinas'], data['Carbohidratos'],
        data['Glucosa'], data['Frutas'], data['Lacteos'],
        data['ProteinasIng'], data['Verduras'], data['Semillas'],
        data['TipoDiabetes']
    ]
    prediction = model.predict([features])[0]
    return jsonify({'prediction': int(prediction)})

if __name__ == '__main__':
    app.run(debug=True)