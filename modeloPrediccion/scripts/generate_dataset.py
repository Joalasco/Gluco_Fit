import random
import csv
from collections import defaultdict


# Función para calcular totales nutricionales de una receta
def calcular_totales(ingredientes):
    totales = defaultdict(float)
    for categoria, items in ingredientes.items():
        if items:
            for item in items:
                info = item['informacionNutricional']
                for nutriente, valor in info.items():
                    totales[nutriente] += valor
    return totales


# Función para determinar si una receta es apta basada en reglas simples
def es_apta(tipo_diabetes, calorias, carbohidratos, glucosa):
    if tipo_diabetes == 0:  # No diabético
        return random.choice([0, 1])
    elif tipo_diabetes == 1:  # Diabetes tipo 1
        return 1 if carbohidratos < 30 and glucosa < 10 else 0
    elif tipo_diabetes == 2:  # Diabetes tipo 2
        return 1 if calorias < 500 and carbohidratos < 50 else 0
    else:  # Prediabetes
        return 1 if calorias < 600 and glucosa < 15 else 0


# Generar dataset
dataset = []
for _ in range(200000):
    region = random.choice([1, 2, 3])  # 1-Costa, 2-Sierra, 3-Oriente
    tiempo_prep = random.randint(20, 240)

    # Generar valores nutricionales aleatorios
    calorias = random.uniform(100, 1000)
    grasas = random.uniform(0, 50)
    proteinas = random.uniform(0, 60)
    carbohidratos = random.uniform(0, 100)
    glucosa = random.uniform(0, 30)

    # Presencia de tipos de ingredientes
    frutas = random.choice([0, 1])
    lacteos = random.choice([0, 1])
    proteinas_ing = random.choice([0, 1])
    verduras = random.choice([0, 1])
    semillas = random.choice([0, 1])

    tipo_diabetes = random.choice([0, 1, 2, 3])

    apta = es_apta(tipo_diabetes, calorias, carbohidratos, glucosa)

    dataset.append([
        region, tiempo_prep, round(calorias, 2), round(grasas, 2),
        round(proteinas, 2), round(carbohidratos, 2), round(glucosa, 2),
        frutas, lacteos, proteinas_ing, verduras, semillas,
        tipo_diabetes, apta
    ])

# Guardar dataset en CSV
with open('../data/dataset_recetas_diabetes.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow([
        'Region', 'TiempoPrep', 'Calorias', 'Grasas', 'Proteinas',
        'Carbohidratos', 'Glucosa', 'Frutas', 'Lacteos', 'ProteinasIng',
        'Verduras', 'Semillas', 'TipoDiabetes', 'Apta'
    ])
    writer.writerows(dataset)

print("Dataset generado y guardado en 'dataset_recetas_diabetes.csv'")