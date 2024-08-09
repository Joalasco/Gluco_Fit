import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import '../../controllers/recipe_controller.dart';
import 'package:uuid/uuid.dart';

class RecipeCreateView extends StatefulWidget {
  @override
  _RecipeCreateViewState createState() => _RecipeCreateViewState();
}

class _RecipeCreateViewState extends State<RecipeCreateView> {
  final _formKey = GlobalKey<FormState>();
  final RecipeController _controller = RecipeController();
  
  String _nombre = '';
  String _descripcionDetalle = '';
  String _descripcionRegion = '';
  int _tiempoPreparacion = 0;
  List<String> _instrucciones = [''];
  String _imagenURL = '';
  
  Map<String, List<Ingrediente>> _ingredientes = {
    'frutas': [],
    'lacteos': [],
    'proteinas': [],
    'verduras': [],
    'semillas': [],
  };

  void _addInstruction() {
    setState(() {
      _instrucciones.add('');
    });
  }

  void _addIngredient(String category) {
    setState(() {
      _ingredientes[category]!.add(Ingrediente(
        nombre: '',
        cantidad: 0,
        unidad: '',
        informacionNutricional: InformacionNutricional(
          calorias: 0,
          grasas: 0,
          proteinas: 0,
          carbohidratos: 0,
          glucosa: 0,
        ),
      ));
    });
  }

  Future<void> _createRecipe() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final newRecipe = Recipe(
        recetaID: Uuid().v4(),
        nombre: _nombre,
        descripcion: Descripcion(detalle: _descripcionDetalle, region: _descripcionRegion),
        tiempoPreparacion: _tiempoPreparacion,
        instrucciones: _instrucciones.where((i) => i.isNotEmpty).toList(),
        ingredientes: Ingredientes(
          frutas: _ingredientes['frutas']!.isNotEmpty ? _ingredientes['frutas'] : null,
          lacteos: _ingredientes['lacteos']!.isNotEmpty ? _ingredientes['lacteos'] : null,
          proteinas: _ingredientes['proteinas']!.isNotEmpty ? _ingredientes['proteinas'] : null,
          verduras: _ingredientes['verduras']!.isNotEmpty ? _ingredientes['verduras'] : null,
          semillas: _ingredientes['semillas']!.isNotEmpty ? _ingredientes['semillas'] : null,
        ),
        imagenURL: _imagenURL,
      );

      try {
        await _controller.createRecipe(newRecipe);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear la receta: $e')),
        );
      }
    }
  }

  Widget _buildIngredientFields(String category, int index) {
    final ingrediente = _ingredientes[category]![index];
    return ExpansionTile(
      title: Text(ingrediente.nombre.isEmpty ? 'Nuevo Ingrediente' : ingrediente.nombre),
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Nombre'),
          initialValue: ingrediente.nombre,
          onChanged: (value) {
            setState(() {
              _ingredientes[category]![index] = _updateIngrediente(ingrediente, nombre: value);
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Cantidad'),
          keyboardType: TextInputType.number,
          initialValue: ingrediente.cantidad.toString(),
          onChanged: (value) {
            setState(() {
              _ingredientes[category]![index] = _updateIngrediente(ingrediente, cantidad: int.tryParse(value) ?? 0);
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Unidad'),
          initialValue: ingrediente.unidad,
          onChanged: (value) {
            setState(() {
              _ingredientes[category]![index] = _updateIngrediente(ingrediente, unidad: value);
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Calorías'),
          keyboardType: TextInputType.number,
          initialValue: ingrediente.informacionNutricional.calorias.toString(),
          onChanged: (value) {
            setState(() {
              _ingredientes[category]![index] = _updateIngrediente(
                ingrediente,
                informacionNutricional: _updateInformacionNutricional(
                  ingrediente.informacionNutricional,
                  calorias: double.tryParse(value) ?? 0,
                ),
              );
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Grasas'),
          keyboardType: TextInputType.number,
          initialValue: ingrediente.informacionNutricional.grasas.toString(),
          onChanged: (value) {
            setState(() {
              _ingredientes[category]![index] = _updateIngrediente(
                ingrediente,
                informacionNutricional: _updateInformacionNutricional(
                  ingrediente.informacionNutricional,
                  grasas: double.tryParse(value) ?? 0,
                ),
              );
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Proteínas'),
          keyboardType: TextInputType.number,
          initialValue: ingrediente.informacionNutricional.proteinas.toString(),
          onChanged: (value) {
            setState(() {
              _ingredientes[category]![index] = _updateIngrediente(
                ingrediente,
                informacionNutricional: _updateInformacionNutricional(
                  ingrediente.informacionNutricional,
                  proteinas: double.tryParse(value) ?? 0,
                ),
              );
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Carbohidratos'),
          keyboardType: TextInputType.number,
          initialValue: ingrediente.informacionNutricional.carbohidratos.toString(),
          onChanged: (value) {
            setState(() {
              _ingredientes[category]![index] = _updateIngrediente(
                ingrediente,
                informacionNutricional: _updateInformacionNutricional(
                  ingrediente.informacionNutricional,
                  carbohidratos: double.tryParse(value) ?? 0,
                ),
              );
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Glucosa'),
          keyboardType: TextInputType.number,
          initialValue: ingrediente.informacionNutricional.glucosa.toString(),
          onChanged: (value) {
            setState(() {
              _ingredientes[category]![index] = _updateIngrediente(
                ingrediente,
                informacionNutricional: _updateInformacionNutricional(
                  ingrediente.informacionNutricional,
                  glucosa: double.tryParse(value) ?? 0,
                ),
              );
            });
          },
        ),
      ],
    );
  }

  Ingrediente _updateIngrediente(Ingrediente ingrediente, {
    String? nombre,
    int? cantidad,
    String? unidad,
    InformacionNutricional? informacionNutricional,
  }) {
    return Ingrediente(
      nombre: nombre ?? ingrediente.nombre,
      cantidad: cantidad ?? ingrediente.cantidad,
      unidad: unidad ?? ingrediente.unidad,
      informacionNutricional: informacionNutricional ?? ingrediente.informacionNutricional,
    );
  }

  InformacionNutricional _updateInformacionNutricional(
    InformacionNutricional info, {
    double? calorias,
    double? grasas,
    double? proteinas,
    double? carbohidratos,
    double? glucosa,
  }) {
    return InformacionNutricional(
      calorias: calorias ?? info.calorias,
      grasas: grasas ?? info.grasas,
      proteinas: proteinas ?? info.proteinas,
      carbohidratos: carbohidratos ?? info.carbohidratos,
      glucosa: glucosa ?? info.glucosa,
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Crear Nueva Receta')),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Nombre'),
            validator: (value) => value!.isEmpty ? 'Por favor ingrese un nombre' : null,
            onSaved: (value) => _nombre = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Descripción'),
            validator: (value) => value!.isEmpty ? 'Por favor ingrese una descripción' : null,
            onSaved: (value) => _descripcionDetalle = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Región'),
            onSaved: (value) => _descripcionRegion = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Tiempo de Preparación (minutos)'),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? 'Por favor ingrese el tiempo de preparación' : null,
            onSaved: (value) => _tiempoPreparacion = int.parse(value!),
          ),
          ..._instrucciones.asMap().entries.map(
            (entry) => TextFormField(
              decoration: InputDecoration(labelText: 'Instrucción ${entry.key + 1}'),
              onChanged: (value) => _instrucciones[entry.key] = value,
            ),
          ),
          ElevatedButton(
            onPressed: _addInstruction,
            child: Text('Agregar Instrucción'),
          ),
          ..._ingredientes.entries.map((entry) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.key.toUpperCase(), style: Theme.of(context).textTheme.titleLarge),
              ...entry.value.asMap().entries.map((ingredientEntry) => 
                _buildIngredientFields(entry.key, ingredientEntry.key)
              ),
              ElevatedButton(
                onPressed: () => _addIngredient(entry.key),
                child: Text('Agregar ${entry.key}'),
              ),
            ],
          )),
          TextFormField(
            decoration: InputDecoration(labelText: 'URL de la Imagen'),
            onSaved: (value) => _imagenURL = value!,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _createRecipe,
            child: Text('Crear Receta'),
          ),
        ],
      ),
    ),
  );
}
}