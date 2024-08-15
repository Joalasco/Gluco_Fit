# Predictor de Recetas para Diabéticos

Este proyecto utiliza machine learning para predecir si una receta es adecuada para personas con diferentes tipos de diabetes.

## Estructura del Proyecto

- `data/`: Contiene el dataset.
- `models/`: Almacena el modelo entrenado.
- `scripts/`: Scripts para generar el dataset y entrenar el modelo.
- `app.py`: API Flask para servir el modelo.

## Cómo usar

1. Genera el dataset: `python scripts/generate_dataset.py`
2. Entrena el modelo: `python scripts/train_model.py`
3. Ejecuta la API: `python app.py`

## Despliegue

Este proyecto está configurado para ser desplegado en Render.