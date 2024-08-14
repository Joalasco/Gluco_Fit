import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report
import joblib

# Cargar el dataset
df = pd.read_csv('../data/dataset_recetas_diabetes.csv')

# Separar features y target
X = df.drop('Apta', axis=1)
y = df['Apta']

# Dividir en conjunto de entrenamiento y prueba
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Crear y entrenar el modelo
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Evaluar el modelo
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
print(f"Accuracy: {accuracy}")
print("\nClassification Report:")
print(classification_report(y_test, y_pred))

# Guardar el modelo
joblib.dump(model, '../models/recetas_diabetes_model.joblib')

print("Modelo guardado como 'recetas_diabetes_model.joblib'")